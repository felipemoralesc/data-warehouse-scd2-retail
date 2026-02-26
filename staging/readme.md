STAGING LAYER — Transformación y Tipado de Datos
🎯 Objetivo

La capa staging actúa como zona intermedia entre la capa raw y el data warehouse.

Su función principal es:

Aplicar tipado fuerte

Limpiar datos básicos

Estandarizar formatos

Preparar la información para el modelo dimensional

Aquí comienzan las transformaciones estructurales, pero aún no se implementa lógica histórica ni modelo estrella.

🏗 Rol dentro de la arquitectura

Flujo general del proyecto:

CSV → RAW → STAGING → DATA WAREHOUSE

RAW → Datos tal como llegan del sistema fuente (sin validación).

STAGING → Datos tipados, limpios y estructurados.

DW → Modelo dimensional optimizado para análisis.

📂 Estructura de la Carpeta
/staging
   01_create_staging_schema.sql
   02_create_staging_tables.sql
   03_load_staging_tables.sql
   README.md
🗄 Base de Datos

Motor: PostgreSQL

Base: ventas_dw

Schema: staging

📜 Scripts SQL
1️⃣ Creación del Schema

Archivo: 01_create_staging_schema.sql

Crea el schema staging dentro de la base de datos.

2️⃣ Creación de Tablas

Archivo: 02_create_staging_tables.sql

Se crean las siguientes tablas:

staging.clientes_clean

staging.productos_clean

staging.ventas_clean

Características:

✔ Tipos de datos definidos correctamente (INTEGER, DATE, NUMERIC, BOOLEAN)
✔ Columnas estructuradas para análisis
✔ Separación clara respecto a la capa raw

3️⃣ Carga desde RAW

Archivo: 03_load_staging_tables.sql

Realiza:

Inserción desde raw.*

Conversión de tipos (CAST, ::)

Limpieza básica (TRIM, LOWER, INITCAP)

Conversión de fechas (TO_DATE)

Cálculo de columna derivada (total en ventas)

Ejemplo conceptual:

INSERT INTO staging.ventas_clean (...)
SELECT
    fecha::DATE,
    cliente_id::INTEGER,
    ...
FROM raw.ventas_csv;
🔄 Transformaciones Aplicadas
Tabla	Transformaciones
clientes_clean	Tipado de ID y fecha, normalización de texto
productos_clean	Conversión a boolean, tipado de precio
ventas_clean	Tipado completo y cálculo de total
🚫 Qué NO hace la capa STAGING

No implementa SCD Tipo 2

No genera claves sustitutas

No define modelo estrella

No contiene tablas de hechos

Eso pertenece a la capa dw.

🧠 Beneficios de esta capa

✔ Aísla datos sucios
✔ Reduce riesgo de errores en DW
✔ Permite auditoría y trazabilidad
✔ Mejora calidad de datos
✔ Facilita transformaciones posteriores
