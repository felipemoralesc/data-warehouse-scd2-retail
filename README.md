# data-warehouse-scd2-retail

Proyecto de Data Warehouse end-to-end con implementación de Slowly Changing Dimensions (SCD Tipo 2) utilizando PostgreSQL y Python.

### 📌 Visión General

Este proyecto implementa un Data Warehouse simulando un entorno de ventas retail.

Se construye un pipeline estructurado por capas:

`RAW` → `STAGING` → `DATA WAREHOUSE`

Aplicando:
* Modelado dimensional
* Gestión histórica (SCD Tipo 2)
* Separación clara de responsabilidades
* Optimización física mediante indexación
* Buenas prácticas de ingeniería de datos

### 🏗 Arquitectura
```text
Fuentes CSV / Datos Sintéticos
            ↓
        Raw Layer
            ↓
      Staging Layer
            ↓
  Data Warehouse (Star Schema)
            ↓
  Consultas Analíticas / BI
```

### 📊 Generación de Datos Sintéticos

Además del dataset inicial cargado desde archivos CSV, el proyecto incorpora
generación de datos sintéticos directamente en PostgreSQL para simular un
escenario de mayor volumen de información.

Esto permite validar el comportamiento del modelo dimensional bajo cargas
más realistas y analizar el rendimiento de consultas analíticas.

La generación de datos se implementa mediante scripts SQL versionados en la
capa RAW utilizando funciones nativas de PostgreSQL como:

- generate_series()
- random()

Volumen de datos utilizado:

- 5.000 clientes
- 1.000 productos
- 100.000 ventas

Estos datos se cargan inicialmente en las tablas RAW y posteriormente pasan
por las transformaciones hacia STAGING y el modelo dimensional en DW.

**🔹 Raw Layer**

* Almacena datos fuente sin transformación.
* Tablas espejo de los archivos CSV
* Scripts Python para carga automatizada
* Uso de variables de entorno (.env)

Estructura:
```text
raw/
 ├── data/
 ├── sql/
 └── scripts/
```
**🔹 Staging Layer**

* Capa intermedia de transformación.
* Conversión de tipos
* Normalización de datos
* Limpieza básica
* Preparación para modelo dimensional

Estructura:
```text
staging/
 ├── sql/
 └── README.md
```
**🔹 Data Warehouse Layer**

* Implementa un Modelo Estrella (Star Schema) optimizado para análisis.

### 📌 Dimensiones

* **dim_cliente** — Implementa Slowly Changing Dimension Tipo 2
* **dim_producto** — Implementa Slowly Changing Dimension Tipo 2
* **dim_fecha** — Dimensión calendario generada automáticamente mediante script Python


### 📌 Tabla de Hechos

* fact_ventas_detalle

Incluye:

* Claves sustitutas (Surrogate Keys)
* Claves foráneas hacia dimensiones
* Columna generada `total_venta`

  
### ⚡ Optimización de Performance

El modelo incorpora una capa de optimización física mediante indexación estratégica.

## 📌 Índices implementados
**🔹 En tabla de hechos**

Índices sobre claves foráneas para optimizar joins:

* clave_cliente
* clave_producto
* clave_fecha

**🔹 En dimensiones SCD Tipo 2**

Índices compuestos para optimizar:

* Búsqueda de registro actual
(cliente_id, es_actual)

* Consultas históricas por vigencia
(cliente_id, fecha_inicio_vigencia, fecha_fin_vigencia)

* Equivalente para producto_id

**🔹 En dimensión fecha**

Índice sobre:

* fecha_completa
* Optimiza consultas por rango:
```text
WHERE fecha_completa 
BETWEEN '2024-01-01' AND '2024-12-31';
```
### 🔎 Validación de Performance

La correcta utilización de los índices fue validada mediante:

* EXPLAIN ANALYZE

Se verificó:

* Uso de `Index Scan` en consultas analíticas
* Uso de índices compuestos en búsquedas SCD Tipo 2
* Reducción de `Seq Scan` en joins de alto volumen
* Mejora en costos estimados y tiempos de ejecución

  
**🔁 Implementación SCD Tipo 2**

Cada cambio relevante en dimensiones genera:
* Cierre del registro anterior
* Inserción de nueva versión
* Control de fechas de vigencia
* Preservación total del historial

Permite:

* Consultar estado actual (es_actual = true)
* Consultar estado histórico por fecha

### 🛠 Stack Tecnológico

**Tecnologías**

* PostgreSQL
* Python
* pandas
* SQLAlchemy
* psycopg2
* python-dotenv

**Conceptos de Ingeniería de Datos**

* Modelado Dimensional
* Slowly Changing Dimensions (SCD Tipo 2)
* Arquitectura por capas (`RAW` → `STAGING` → `DATA WAREHOUSE`)
* Optimización con índices compuestos

### 📂 Estructura del Repositorio
```text
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
│   ├── script/
│   └── README.md
│
├── docs/
│   ├── performance_testing.md
│   ├──star_schema.png
│   ├──calidacion_scd2_dim_cliente.md
│
├── .gitignore
├── requirements.txt
└── README.md
```
### ⚙ Cómo Ejecutar el Proyecto

**1️⃣ Clonar el repositorio**


**2️⃣ Crear archivo .env en la raíz**
```text
DB_HOST=localhost
DB_NAME=ventas_dw
DB_USER=postgres
DB_PASSWORD=tu_password
DB_PORT=5432
```
**3️⃣ Instalar dependencias**
* pip install -r requirements.txt
  
**4️⃣ Ejecutar en orden**

1. Crear base de datos
2. Ejecutar scripts SQL de creación de tablas en RAW
3. Ejecutar scripts Python de carga de datos en RAW
4. Ejecutar transformaciones en STAGING
5. Crear estructuras del Data Warehouse
6. Generar dim_fecha
7. Poblar dimensiones
8. Poblar tabla de hechos
9. Validar performance con EXPLAIN ANALYZE

### 🔐 Seguridad

Las credenciales de conexión no están almacenadas en el código.
Se gestionan mediante variables de entorno y archivo .env.

### 🚀 Posibles Mejoras Futuras
* Orquestación del pipeline (Airflow / Prefect)
* Validaciones de calidad de datos
* Particionamiento en tabla de hechos
* Automatización incremental
* Dockerización
* CI/CD
* Monitoreo y logging

### 🎯 Objetivo Profesional

Este proyecto demuestra habilidades en:

* Diseño de arquitectura de datos por capas
* Implementación de Slowly Changing Dimensions (SCD Tipo 2)
* Modelado dimensional (Star Schema)
* Construcción de pipelines SQL para transformación de datos
* Optimización de consultas analíticas mediante indexación
* Validación de rendimiento utilizando `EXPLAIN ANALYZE`
* Buenas prácticas de organización de repositorios de datos
* Gestión segura de credenciales mediante variables de entorno

## 🧠 Habilidades Demostradas

Este proyecto evidencia experiencia práctica en:

**Data Engineering**

- Diseño de pipelines de datos por capas
- Modelado dimensional (Star Schema)
- Implementación de Slowly Changing Dimensions (SCD Tipo 2)
- Transformaciones SQL para ETL

**Data Warehousing**

- Diseño de tablas de hechos y dimensiones
- Uso de claves sustitutas (Surrogate Keys)
- Gestión de historial en dimensiones

**Optimización de consultas**

- Indexación estratégica
- Análisis de ejecución con EXPLAIN ANALYZE

**Herramientas**

- PostgreSQL
- Python
- pandas
- SQLAlchemy
- psycopg2
