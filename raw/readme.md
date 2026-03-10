# 📥 CAPA RAW — Ingestión de data Fuente

### 🎯 Objetivo

La capa RAW simula el sistema transaccional de una empresa retail y almacena los datos en su estado original dentro del esquema raw en PostgreSQL.

Esta capa:
* Réplica de los archivos CSV fuente
* Sin aplicar transformaciones
* No se definen claves primarias ni foráneas
* No se realiza tipado estricto
* No contiene lógica de negocio
* Es la representación más cercana al sistema origen.

### 🏗 Estructura de la carpeta
```texto
/raw
 /data
  clientes.csv
  productos.csv
  ventas_2024_01.csv

 /sql
  01_create_raw_schema.sql
  02_create_raw_tables.sql
  03_generate_clientes_sinteticos.sql
  04_generate_productos_sinteticos.sql
  05_generate_ventas_sinteticos.sql

 /scripts
  load_one_file.py
  load_multiple_files.py

 README.md
```
### 🗄 Base de data

* **Motor:** PostgreSQL
* **Base de data:** ventas_dw
* **Esquema:** raw

### 📜 Scripts SQL


**1️⃣ Creación del esquema**
* Archivo: 01_create_raw_schema.sql

Crea el esquema raw:
```texto
CREATE SCHEMA IF NOT EXISTS raw
AUTHORIZATION postgres;
```
**2️⃣ Creación de Tablas**

* Archivo: 02_create_raw_tables.sql

Se crean las siguientes tablas:
* raw.clientes_csv
* raw.productos_csv
* raw.ventas_csv

Todas las columnas están definidas como TEXTO, ya que en la capa raw no se aplica tipado fuerte ni validaciones estructurales.

 No se realiza tipado estricto

### 🎯 Objetivo
* Evitar errores de carga por formatos inconsistentes
* Delegar limpieza y tipado a la capa staging

### 🐍 Scripts de Ingestión en Python


**1️⃣ cargar_un_archivo.py**

Guía inicial para probar la carga de un solo archivo usando:

* psycopg2
* Método COPIA
* Carga directa a raw.ventas_csv
* Este script permite conectar y funcionamiento del proceso de carga.

**2️⃣ load_multiple_files.py**

Script mejorado para carga múltiple usando:
* pandas
* SQLAlchemy
* Función reutilizable cargar_csv_a_raw()
* Permite cargar dinámicamente:

`clientes.csv` → `raw.clientes_csv`
`productos.csv` → `raw.productos_csv`

Características:
* Validación de existencia de archivo
* Conteo de registros
* Manejo básico de errores
* Carga mediante to_sql() con if_exists="agregar"
* Esta guía representa una evolución hasta un proceso de ingesta más automatizado.

**🔄 Flujo de Ejecución**
* Ejecutar 01_create_raw_schema.sql
* Ejecutar 02_create_raw_tables.sql
* Ejecutar load_multiple_files.py

Opcionalmente:

* Ejecutar load_one_file.py para pruebas individuales


### 🧠 Rol de la Capa RAW en la Arquitectura

Flujo general del proyecto:

`CSV` → `RAW` → `STAGING` → `DATA WAREHOUSE`

La capa raw:
* Actúa como zona de aterrizaje
* Preserva los datos originales
* Separa ingestión de transformación
* Permite trazabilidad completa del pipeline


### Generación de data de Prueba

Para simular un entorno con mayor volumen de información se generaron data de prueba directamente en PostgreSQL.
Los data sintéticos se generan mediante scripts SQL versionados dentro de la carpeta `raw/sql`, los cuales insertan registros
aleatorios directamente en las tablas RAW utilizando funciones de PostgreSQL como `generate_series()` y `random()`.

Volumen actual utilizado en el proyecto:

- 5.000 clientes
- 1.000 productos
- 100.000 ventas

  
El objetivo de este volumen es:

- simular cargas realistas
- validar joins en el Data Warehouse
- probar comportamiento del SCD Tipo 2
- analizar uso de índices con `EXPLAIN ANALYZE`

### 🔄 Flujo de generación de datos sintéticos

1. 03_generate_clientes_sinteticos.sql
2. 04_generate_productos_sinteticos.sql
3. 05_generate_ventas_sinteticos.sql
