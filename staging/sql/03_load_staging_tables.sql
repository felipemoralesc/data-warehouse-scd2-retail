/* =========================================================
   FASE 1 — Carga inicial desde CSV (dataset pequeño)
   Objetivo: probar el pipeline RAW → STAGING
========================================================= */
-- ventas_clean
INSERT INTO staging.ventas_clean (
    fecha,
    cliente_id,
    producto_id,
    cantidad,
    precio_unitario,
    total
)
SELECT
    TO_DATE(fecha, 'YYYY-MM-DD') AS fecha,
    cliente_id::INTEGER AS cliente_id,
    producto_id::INTEGER AS producto_id,
    cantidad::INTEGER AS cantidad,
    precio_unitario::NUMERIC(10,2) AS precio_unitario,
    (cantidad::NUMERIC * precio_unitario::NUMERIC) AS total
FROM raw.ventas_csv;
-----------------------------------------------------------------------
-- Productos_clean
INSERT INTO staging.productos_clean (
    producto_id,
    nombre_producto,
    categoria,
    precio_lista,
    activo
)
SELECT
    producto_id::INTEGER,
    TRIM(nombre_producto),
    TRIM(categoria),
    precio_lista::NUMERIC(12,2),
    CASE 
        WHEN LOWER(TRIM(activo)) IN ('true','t','1','yes','si') THEN TRUE
        ELSE FALSE
    END
FROM raw.productos_csv;
-----------------------------------------------------------------------------
-- clientes_clean
INSERT INTO staging.clientes_clean (
    cliente_id,
    email,
    nombre,
    apellido,
    ciudad,
    fecha_registro
)
SELECT
    cliente_id::INTEGER,
    LOWER(TRIM(email)),
    INITCAP(TRIM(nombre)),
    INITCAP(TRIM(apellido)),
    INITCAP(TRIM(ciudad)),
    TO_DATE(fecha_registro, 'YYYY-MM-DD')
FROM raw.clientes_csv;
------------------------------------------------------------------------------------
/* =========================================================
   FASE 2 — Carga con dataset ampliado (datos sintéticos)
   Objetivo: simular volumen real para pruebas de DW
========================================================= */

/* =====================================================
   RAW → STAGING
   Transformación de clientes
   Conversión de tipos y limpieza básica
===================================================== */

-- clientes (5.000 registros generados en RAW)
INSERT INTO staging.clientes_clean (
    cliente_id,
	email,
    nombre,
	apellido,
    ciudad,
    fecha_registro
)
SELECT
    cliente_id::INTEGER,
	email::character varying(150),
    INITCAP(TRIM(nombre)),
	INITCAP(TRIM(apellido)),
    INITCAP(TRIM(ciudad)),
    TO_DATE(fecha_registro, 'YYYY-MM-DD')
FROM raw.clientes_csv;
------------------------------------------------------------
-- productos (1.000 productos generados en RAW)
INSERT INTO staging.productos_clean (
    producto_id,
    nombre_producto,
	categoria,
    precio_lista,
    activo
)
SELECT
    producto_id::INTEGER,
    INITCAP(TRIM(nombre_producto)),
	INITCAP(TRIM(categoria)),
    precio_lista::NUMERIC(10,2),
	activo::BOOLEAN
FROM raw.productos_csv;
----------------------------------------------------------------



