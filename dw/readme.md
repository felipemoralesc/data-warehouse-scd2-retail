🏛 Data Warehouse Layer (DW)
📌 Descripción
La carpeta dw contiene la capa dimensional del proyecto data-warehouse-scd2-retail.

Aquí se implementa el Modelo Estrella (Star Schema), el cual consolida los datos limpios provenientes de staging en estructuras optimizadas para análisis.

Esta capa incluye:

Creación del schema dw
Creación de dimensiones
Creación de tabla de hechos
Cálculo automático de métricas
Generación y carga de la dimensión fecha
Optimización de performance mediante indexación estratégica
🗂 Estructura de la carpeta
dw/
│
├── sql/
│   ├── 01_create_dw_schema.sql
│   ├── 02_create_dw_tables.sql
│   └── 03_create_dw_indexes.sql
│
├── script/
│   └── script_para_cargar_dim_fecha.py
│
└── README.md
🗄 Carpeta /sql
Contiene los scripts DDL necesarios para crear y optimizar la estructura del Data Warehouse.

1️⃣ 01_create_dw_schema.sql

Crea el schema del Data Warehouse:

CREATE SCHEMA IF NOT EXISTS dw;
2️⃣ 02_create_dw_tables.sql

Incluye la creación de:

📌 Dimensiones
dim_cliente
dim_producto
dim_fecha
📌 Tabla de hechos
fact_ventas_detalle
La tabla de hechos implementa una columna calculada:

total_venta NUMERIC(12,2)
GENERATED ALWAYS AS ((cantidad::NUMERIC * precio_unitario)) STORED
🔎 Esto garantiza:
Integridad de datos
Eliminación de redundancia
Cálculo automático a nivel de base de datos
3️⃣ 03_create_dw_indexes.sql

Define los índices estratégicos para optimizar el rendimiento del modelo dimensional.

🎯 Objetivo de la indexación
Mejorar el rendimiento en:

Joins entre tabla de hechos y dimensiones
Filtros analíticos por cliente, producto y fecha
Consultas SCD Tipo 2 (registro actual e histórico)
Consultas por rango de fechas
📌 Índices en tabla de hechos
Se crean índices sobre las claves foráneas:

clave_cliente
clave_producto
clave_fecha
Estos índices optimizan consultas como:

SELECT *
FROM dw.fact_ventas_detalle f
JOIN dw.dim_cliente c 
  ON f.clave_cliente = c.clave_cliente;
📌 Índices en dimensiones SCD Tipo 2
Se implementan índices compuestos para optimizar:

Búsqueda del registro actual
Consultas históricas por vigencia
Ejemplo conceptual:

(id_cliente_natural, es_actual)
(id_producto_natural, es_actual)
Optimiza consultas del tipo:

WHERE id_cliente_natural = 1001
AND es_actual = true;
📌 Índice en dimensión fecha
Se crea índice sobre:

fecha
Optimiza filtros por rango:

WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';
📅 Dimensión Fecha (dim_fecha)
La dimensión fecha se genera mediante un script en Python ubicado en:

dw/script/script_para_cargar_dim_fecha.py

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
Las dimensiones dim_cliente y dim_producto pueden implementar estrategia SCD Tipo 2 para mantener historial de cambios.

Esto permite:

Preservar versiones históricas
Consultar estado actual (es_actual = true)
Analizar cambios en el tiempo
⚡ Optimización de Performance
El modelo incorpora una capa de optimización física mediante indexación estratégica.

Beneficios:

Reducción en tiempos de ejecución de consultas analíticas
Mejora en joins de alto volumen
Optimización en búsquedas por rango
Soporte eficiente para consultas históricas SCD2
▶️ Orden de ejecución
1️⃣ Ejecutar 01_create_dw_schema.sql

2️⃣ Ejecutar 02_create_dw_tables.sql

3️⃣ Ejecutar 03_create_dw_indexes.sql

4️⃣ Ejecutar script Python para poblar dim_fecha

5️⃣ Cargar dimensiones desde staging

6️⃣ Poblar tabla de hechos


Nota:
Actualmente en el proyecto solo se ha implementado la estructura del Data Warehouse.
La carga de dimensiones y de la tabla de hechos se realizará en fases posteriores del proyecto.

🎯 Objetivo de la capa DW
Optimizar consultas analíticas
Separar procesamiento OLTP de análisis OLAP
Permitir métricas confiables y consistentes
Mantener historial de cambios (SCD Tipo 2)
Aplicar buenas prácticas de modelado dimensional y optimización
🧠 Arquitectura del Proyecto
RAW → Datos crudos

STAGING → Limpieza y tipado

DW → Modelo dimensional analítico optimizado
