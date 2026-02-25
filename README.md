# data-warehouse-scd2-retail
Proyecto de almacén de datos de extremo a extremo con implementación SCD tipo 2 utilizando PostgreSQL.
# Data Warehouse Retail – Implementación SCD Tipo 2

## 📌 Visión General

Este proyecto implementa un Data Warehouse en PostgreSQL simulando un entorno de ventas retail.

Se diseña un pipeline de datos estructurado por capas (Raw → Staging → DW), aplicando modelado dimensional y gestión histórica mediante Slowly Changing Dimensions (SCD Tipo 2).

El objetivo es garantizar:

- Consistencia histórica
- Separación de responsabilidades por capa
- Integridad de métricas
- Escalabilidad analítica

---

## 🏗 Arquitectura de Datos

El proyecto sigue una arquitectura clásica de Data Warehousing:


Fuentes (CSV)
↓
Raw Layer
↓
Staging Layer
↓
Data Warehouse (Star Schema)


### 🔹 Raw
Almacena archivos fuente sin transformación.

### 🔹 Staging
Normaliza, tipifica y prepara los datos para su modelado dimensional.

### 🔹 Data Warehouse
Implementa modelo estrella con:

- Dimensiones históricas (SCD Tipo 2)
- Tabla de hechos granular
- Claves sustitutas

---

## ⭐ Modelo Dimensional

### Dimensiones

- `dim_producto` → SCD Tipo 2
- `dim_cliente` → SCD Tipo 2
- `dim_fecha` → Dimensión calendario

Características:

- Uso de surrogate keys
- Control de vigencia con:
  - `fecha_inicio_vigencia`
  - `fecha_fin_vigencia`
  - `es_actual`
- Preservación total de historial

---

## 📊 Tabla de Hechos – `fact_ventas_detalle`

Nivel de granularidad:

Una fila por producto vendido en una transacción.

Campos principales:

- clave_producto
- clave_cliente
- clave_fecha
- cantidad
- precio_unitario
- total_venta (columna generada)

### 🧮 Decisión de diseño

`total_venta` se define como columna generada:

cantidad * precio_unitario

Esto garantiza:

- Integridad matemática
- Eliminación de inconsistencias
- Simplificación del ETL

---

## 🔁 Implementación SCD Tipo 2

Cada cambio en atributos relevantes de producto o cliente genera:

1. Cierre del registro anterior (`fecha_fin_vigencia`)
2. Inserción de nueva versión
3. Actualización de indicador `es_actual`

Esto permite análisis históricos coherentes incluso ante cambios de precio o atributos del cliente.

---

## 🛠 Stack Tecnológico

- PostgreSQL
- SQL
- Python (carga de datos desde Raw)
- Modelado Dimensional
- Slowly Changing Dimensions

El script en Python automatiza la carga inicial desde archivos CSV hacia la base de datos.

---

## 📂 Estructura del Repositorio


data-warehouse-scd2-retail/
│
├── README.md
├── raw/
├── staging/
│ └── staging_tables.sql
├── dw/
│ ├── dim_producto.sql
│ ├── dim_cliente.sql
│ ├── dim_fecha.sql
│ ├── fact_ventas_detalle.sql
│ └── scd2_logic.sql
└── docs/
└── star_schema.png


---

## ⚙ Cómo Ejecutar el Proyecto

1. Crear base de datos en PostgreSQL
2. Ejecutar scripts de Staging
3. Ejecutar scripts de Dimensiones
4. Ejecutar lógica SCD Tipo 2
5. Cargar tabla de hechos
6. Ejecutar consultas analíticas

---

## 🚀 Posibles Mejoras Futuras

- Automatización completa del pipeline
- Orquestación (Airflow o similar)
- Implementación de pruebas de calidad de datos
- Indexación avanzada
- Particionamiento de tabla de hechos

---

## 🎯 Objetivo Profesional

Este proyecto demuestra:

- Conocimiento de arquitectura de datos
- Implementación de SCD Tipo 2
- Diseño de modelo estrella
- Buenas prácticas de modelado
- Separación clara de capas
