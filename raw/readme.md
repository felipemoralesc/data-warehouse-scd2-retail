# 📥 RAW LAYER — Ingestión de Datos Fuente

### 🎯 Objetivo

La capa raw simula el sistema transaccional de una empresa retail y almacena los datos en su estado original dentro del schema raw en PostgreSQL.

Esta capa:
* Replica los archivos CSV fuente
* No aplica transformaciones
* No define llaves primarias ni foráneas
* No realiza tipado estricto
* No contiene lógica de negocio
* Es la representación más cercana al sistema origen.

### 🏗 Estructura de la carpeta
```text
/raw
   /data
      clientes.csv
      productos.csv
      ventas_2024_01.csv
   /sql
      01_create_raw_schema.sql
      02_create_raw_tables.sql
   /scripts
      load_one_file.py
      load_multiple_files.py
   README.md
```
### 🗄 Base de Datos

* **Motor:** PostgreSQL
* **Base de datos:** ventas_dw
* **Schema:** raw

### 📜 Scripts SQL


**1️⃣ Creación del Schema**
* Archivo: 01_create_raw_schema.sql

Crea el schema raw:
```text
CREATE SCHEMA IF NOT EXISTS "raw"
AUTHORIZATION postgres;
```
**2️⃣ Creación de Tablas**

* Archivo: 02_create_raw_tables.sql

Se crean las siguientes tablas:
* raw.clientes_csv
* raw.productos_csv
* raw.ventas_csv

Todas las columnas están definidas como TEXT, ya que en la capa raw no se aplica tipado fuerte ni validaciones estructurales.

Esto permite:

* Mantener fidelidad al sistema fuente
* Evitar errores de carga por formatos inconsistentes
* Delegar limpieza y tipado a la capa staging

### 🐍 Scripts de Ingestión en Python

**1️⃣ load_one_file.py**

Script inicial para probar la carga de un solo archivo usando:

* psycopg2
* Método COPY
* Carga directa a raw.ventas_csv
* Este script permitió validar conectividad y funcionamiento del proceso de carga.

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
* Carga mediante to_sql() con if_exists="append"
* Este script representa una evolución hacia un proceso de ingestión más automatizado.

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
* Preserva datos originales
* Separa ingestión de transformación
* Permite trazabilidad completa del pipeline

### ⚙ Tecnologías Utilizadas
* PostgreSQL
* Python
* psycopg2
* pandas
* SQLAlchemy
