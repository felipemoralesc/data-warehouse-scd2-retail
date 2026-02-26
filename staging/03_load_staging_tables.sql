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
