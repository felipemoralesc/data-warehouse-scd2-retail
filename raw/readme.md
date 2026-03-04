# 📥 CAPA CRUDA — Ingestión de Datos Fuente

### 🎯 Objetivo

La capa raw simula el sistema transaccional de una empresa retail y almacena los datos en su estado original dentro del esquema raw en PostgreSQL.

Esta capa:
* Réplica de los archivos CSV fuente
* Sin aplicación transformaciones
* No se definen hojas primarias ni foráneas
* No se realiza tipado estro
* No contiene lógica de negocio
* Es la representación más cercana al sistema origen.

### 🏗 Estructura de la alfombra
```texto
/crudo
 /datos
 clientes.csv
 productos.csv
 ventas_2024_01.csv
 /sql
 01_create_raw_schema.sql
 02_create_raw_tables.sql
 /guiones
 cargar_un_archivo.py
 cargar_archivos_múltiples.py
 README.md
```
### 🗄 Base de Datos

* **Motor:** PostgreSQL
* **Base de datos:** ventas_dw
* **Esquema:** crudo

### 📜 Scripts SQL


**1️⃣ Creación del esquema**
* Archivo: 01_create_raw_schema.sql

Crea el esquema crudo:
```texto
CREAR ESQUEMA SI NO EXISTE "crudo"
AUTORIZACIÓN postgres;
```
**2️⃣ Creación de Tablas**

* Archivo: 02_create_raw_tables.sql

Se crea las señales tablas:
* raw.clientes_csv
* raw.productos_csv
* raw.ventas_csv

Todas las columnas están definidas como TEXTO, ya que en la capa raw no se aplica tipado fuerte ni validaciones estructurales.

 No se realiza tipado estro

### 🎯 Objetivo
* Evitar errores de carga por formatos inconsistentes
* Delegar limpieza y tipado a la capa puta en escena

### 🐍 Scripts de Ingestión en Python


**1️⃣ cargar_un_archivo.py**

Guía inicial para probar la carga de un solo archivo usando:

* psycopg2
* Método COPIA
* Carga directa a raw.ventas_csv
* Este script permite conectar y funcionamiento del proceso de carga.

**2️⃣ cargar_archivos_múltiples.py**

Guía mejorado para carga múltiple usando:
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
* Preserva datos originales
* Separa ingestión de transformación
* Permite trazabilidad completa del pipeline

### ⚙ Tecnologías Utilizadas
* PostgreSQL
* Python
* psycopg2
* pandas
* SQLAlchemy
