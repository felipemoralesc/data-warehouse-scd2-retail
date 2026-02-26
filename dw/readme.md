dw/README.md
# 🏛 Data Warehouse Layer (DW)

## 📌 Descripción

La carpeta `dw` contiene la capa dimensional del proyecto **data-warehouse-scd2-retail**.

Aquí se implementa el modelo estrella (Star Schema), el cual consolida los datos limpios provenientes de `staging` en estructuras optimizadas para análisis.

Esta capa incluye:

- Creación del schema `dw`
- Creación de dimensiones
- Creación de tabla de hechos
- Cálculo automático de métricas
- Script para generación y carga de la dimensión fecha

---

## 🗂 Estructura de la carpeta


dw/
│
├── sql/
│ ├── 01_create_dw_schema.sql
│ └── 02_create_dw_tables.sql
│
├── script/
│ └── script para cargar dim_fecha.py
│
└── README.md


---

## 🗄 Carpeta `/sql`

Contiene los scripts DDL necesarios para crear la estructura del Data Warehouse.

### 1️⃣ `01_create_dw_schema.sql`

Crea el schema:

```sql
CREATE SCHEMA IF NOT EXISTS dw;
2️⃣ 02_create_dw_tables.sql

Incluye:

Dimensiones:

dim_cliente

dim_producto

dim_fecha

Tabla de hechos:

fact_ventas_detalle

La tabla de hechos implementa una columna calculada:

total_venta NUMERIC(12,2)
GENERATED ALWAYS AS ((cantidad::NUMERIC * precio_unitario)) STORED

🔎 Esto garantiza:

Integridad de datos

Eliminación de redundancia

Cálculo automático a nivel de base de datos

📅 Dimensión Fecha (dim_fecha)

La dimensión fecha se genera mediante un script en Python ubicado en:

dw/script/script para cargar dim_fecha.py
🔧 Características del script

Genera fechas desde 2020-01-01 hasta 2030-12-31

Crea clave surrogate en formato YYYYMMDD

Incluye:

Año

Trimestre

Mes

Nombre del mes (en español)

Día

Nombre del día de la semana (en español)

Indicador de fin de semana

📥 Método de carga

Utiliza:

pandas

SQLAlchemy

Conexión a PostgreSQL

Método to_sql() con if_exists="append"

⭐ Modelo Dimensional

El diseño implementado corresponde a un Modelo Estrella (Star Schema):

                dim_cliente
                      |
                      |
dim_fecha ---- fact_ventas_detalle ---- dim_producto
🔁 SCD (Slowly Changing Dimension)

Las dimensiones del modelo pueden implementar estrategia SCD Tipo 2 para mantener historial de cambios (según diseño del proyecto).

▶️ Orden de ejecución

Ejecutar 01_create_dw_schema.sql

Ejecutar 02_create_dw_tables.sql

Ejecutar el script Python para poblar dim_fecha

Cargar dimensiones desde staging

Poblar la tabla de hechos

🎯 Objetivo de la capa DW

Optimizar consultas analíticas

Separar procesamiento OLTP de análisis OLAP

Permitir métricas confiables y consistentes

Mantener historial de cambios (SCD2)

🧠 Arquitectura del Proyecto
RAW      → Datos crudos
STAGING  → Limpieza y tipado
DW       → Modelo dimensional analítico
