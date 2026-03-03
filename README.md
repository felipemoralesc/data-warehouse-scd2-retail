data-warehouse-scd2-retail

Proyecto de Data Warehouse end-to-end con implementación de Slowly Changing Dimensions (SCD Tipo 2) utilizando PostgreSQL y Python.

📌 Visión General

Este proyecto implementa un Data Warehouse simulando un entorno de ventas retail.

Se construye un pipeline estructurado por capas:

Raw → Staging → Data Warehouse

Aplicando:

Modelado dimensional

Gestión histórica (SCD Tipo 2)

Separación clara de responsabilidades

Optimización física mediante indexación

Buenas prácticas de ingeniería de datos

🏗 Arquitectura
Fuentes CSV
      ↓
Raw Layer
      ↓
Staging Layer
      ↓
Data Warehouse (Modelo Estrella optimizado)
🔹 Raw Layer

Almacena datos fuente sin transformación.

Tablas espejo de los archivos CSV

Scripts Python para carga automatizada

Uso de variables de entorno (.env)

Estructura:
raw/
 ├── data/
 ├── sql/
 └── scripts/
🔹 Staging Layer

Capa intermedia de transformación.

Conversión de tipos

Normalización de datos

Limpieza básica

Preparación para modelo dimensional

Estructura:
staging/
 ├── sql/
 └── README.md
🔹 Data Warehouse Layer

Implementa un Modelo Estrella (Star Schema) optimizado para análisis.

📌 Dimensiones

dim_cliente (SCD Tipo 2)

dim_producto (SCD Tipo 2)

dim_fecha (generada automáticamente)

📌 Tabla de Hechos

fact_ventas_detalle

Incluye:

Claves sustitutas (Surrogate Keys)

Claves naturales

Columna generada total_venta

Control de vigencia histórica

Indicador es_actual

⚡ Optimización de Performance

El modelo incorpora una capa de optimización física mediante indexación estratégica.

📌 Índices implementados
🔹 En tabla de hechos

Índices sobre claves foráneas para optimizar joins:

clave_cliente

clave_producto

clave_fecha

🔹 En dimensiones SCD Tipo 2

Índices compuestos para optimizar:

Búsqueda de registro actual
(cliente_id, es_actual)

Consultas históricas por vigencia
(cliente_id, fecha_inicio_vigencia, fecha_fin_vigencia)

Equivalente para producto_id

🔹 En dimensión fecha

Índice sobre:

fecha_completa

Optimiza consultas por rango:

WHERE fecha_completa 
BETWEEN '2024-01-01' AND '2024-12-31';
🔎 Validación de Performance

La correcta utilización de los índices fue validada mediante:

EXPLAIN ANALYZE

Se verificó:

Uso de Index Scan

Uso de índices compuestos en consultas SCD2

Eliminación de Seq Scan innecesarios

Mejora en costos estimados y tiempos de ejecución

Esto confirma que el modelo está optimizado para cargas analíticas.

🔁 Implementación SCD Tipo 2

Cada cambio relevante en dimensiones genera:

Cierre del registro anterior

Inserción de nueva versión

Control de fechas de vigencia

Preservación total del historial

Permite:

Consultar estado actual (es_actual = true)

Consultar estado histórico por fecha

🛠 Stack Tecnológico

PostgreSQL

SQL

Python

pandas

SQLAlchemy

psycopg2

python-dotenv

Modelado Dimensional

Optimización con índices compuestos

📂 Estructura del Repositorio
data-warehouse-scd2-retail/
│
├── raw/
│   ├── data/
│   ├── sql/
│   └── scripts/
│
├── staging/
│   ├── sql/
│   └── README.md
│
├── dw/
│   ├── sql/
│   ├── scripts/
│   └── README.md
│
├── docs/
├── .gitignore
├── requirements.txt
└── README.md
⚙ Cómo Ejecutar el Proyecto
1️⃣ Clonar el repositorio
2️⃣ Crear archivo .env en la raíz
DB_HOST=localhost
DB_NAME=ventas_dw
DB_USER=postgres
DB_PASSWORD=tu_password
DB_PORT=5432
3️⃣ Instalar dependencias
pip install -r requirements.txt
4️⃣ Ejecutar en orden

Crear base de datos

Ejecutar SQL de Raw

Ejecutar scripts de carga Raw

Ejecutar SQL de Staging

Ejecutar SQL de DW

Ejecutar script de dim_fecha

Poblar dimensiones

Poblar tabla de hechos

Validar con EXPLAIN ANALYZE

🔐 Seguridad

Las credenciales de conexión no están almacenadas en el código.
Se gestionan mediante variables de entorno y archivo .env.

🚀 Posibles Mejoras Futuras

Orquestación del pipeline (Airflow / Prefect)

Validaciones de calidad de datos

Particionamiento en tabla de hechos

Automatización incremental

Dockerización

CI/CD

Monitoreo y logging

🎯 Objetivo Profesional

Este proyecto demuestra:

Diseño de arquitectura de datos

Implementación SCD Tipo 2

Modelado estrella

Separación por capas

Optimización física con índices

Validación de performance con EXPLAIN

Buenas prácticas de ingeniería de datos

Gestión segura de credenciales
