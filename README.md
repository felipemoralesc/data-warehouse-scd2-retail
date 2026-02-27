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

Buenas prácticas de ingeniería de datos


🏗 Arquitectura

Fuentes CSV
↓
Raw Layer
↓
Staging Layer
↓
Data Warehouse (Modelo Estrella)


🔹 Raw Layer

Almacena datos fuente sin transformación.

Tablas espejo de los archivos CSV.

Scripts Python para carga automatizada.

Uso de variables de entorno (.env).

Estructura:

raw/
   data/
   sql/
   scripts/

🔹 Staging Layer

Conversión de tipos

Normalización de datos

Limpieza básica

Preparación para modelo dimensional


Estructura:

staging/
   sql/

🔹 Data Warehouse Layer

Modelo estrella compuesto por:

Dimensiones

dim_cliente (SCD Tipo 2)

dim_producto (SCD Tipo 2)

dim_fecha (generada automáticamente)

Tabla de Hechos

fact_ventas_detalle

Incluye:

Claves sustitutas

Columna generada total_venta

Control de vigencia histórica

Indicador es_actual

🔁 Implementación SCD Tipo 2

Cada cambio relevante genera:

Cierre del registro anterior

Inserción de nueva versión

Control de fechas de vigencia

Preservación total del historial

🛠 Stack Tecnológico

PostgreSQL

SQL

Python

pandas

SQLAlchemy

psycopg2

python-dotenv

Modelado Dimensional

📂 Estructura del Repositorio
data-warehouse-scd2-retail/
│
├── raw/
│   ├── data/
│   ├── sql/
│   ├── scripts/
│   └── README.md
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
│
├── .gitignore
├── requirements.txt
└── README.md

⚙ Cómo Ejecutar el Proyecto

1️⃣ Clonar el repositorio

2️⃣ Crear archivo .env en la raíz:

DB_HOST=localhost
DB_NAME=ventas_dw
DB_USER=postgres
DB_PASSWORD=tu_password
DB_PORT=5432

3️⃣ Instalar dependencias
pip install -r requirements.txt

4️⃣ Ejecutar en orden:

Crear base de datos

Ejecutar SQL de Raw

Ejecutar scripts de carga Raw

Ejecutar SQL de Staging

Ejecutar SQL de DW

Ejecutar script de dim_fecha

Poblar tabla de hechos


🔐 Seguridad

Las credenciales de conexión no están almacenadas en el código.
Se gestionan mediante variables de entorno y .env.


🚀 Posibles Mejoras Futuras

Orquestación del pipeline

Validaciones de calidad de datos

Índices y optimización

Particionamiento

Dockerización

CI/CD


🎯 Objetivo Profesional

Este proyecto demuestra:

Diseño de arquitectura de datos

Implementación SCD Tipo 2

Modelado estrella

Separación por capas

Buenas prácticas de ingeniería

Gestión segura de credenciales
