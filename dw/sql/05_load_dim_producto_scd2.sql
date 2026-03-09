/* =========================================================
   FASE 1 — Cerrar vigencia de productos que cambiaron
========================================================= */
UPDATE dw.dim_producto d
SET 
    fecha_fin_vigencia = CURRENT_DATE,
    es_actual = FALSE
FROM staging.productos_clean s
WHERE d.producto_id = s.producto_id
AND d.es_actual = TRUE
AND (
       d.nombre_producto IS DISTINCT FROM s.nombre_producto
    OR d.categoria IS DISTINCT FROM s.categoria
    OR d.precio IS DISTINCT FROM s.precio_lista
);

/* =========================================================
   FASE 2 - Insertar nuevos productos
========================================================= */

INSERT INTO dw.dim_producto (
    producto_id,
    nombre_producto,
    categoria,
    precio,
    fecha_inicio_vigencia,
    fecha_fin_vigencia,
    es_actual
)

SELECT
    s.producto_id,
    s.nombre_producto,
    s.categoria,
    s.precio_lista,
    CURRENT_DATE,
    NULL,
    TRUE
FROM staging.productos_clean s
LEFT JOIN dw.dim_producto d
    ON s.producto_id = d.producto_id
WHERE d.producto_id IS NULL;

/* ==============================================================
   FASE 3 - Insertar nuevas versiones de clientes modificados
============================================================== */

INSERT INTO dw.dim_cliente (
    cliente_id,
    email_cliente,
    nombre,
    apellido,
    ciudad,
    fecha_inicio_vigencia,
    fecha_fin_vigencia,
    es_actual
)
SELECT
    s.cliente_id,
    s.email,
    s.nombre,
    s.apellido,
    s.ciudad,
    CURRENT_DATE,
    NULL,
    TRUE
FROM staging.clientes_clean s
LEFT JOIN dw.dim_cliente d
    ON s.cliente_id = d.cliente_id
    AND d.es_actual = TRUE
WHERE d.cliente_id IS NULL
OR (
       d.email_cliente IS DISTINCT FROM s.email
    OR d.nombre IS DISTINCT FROM s.nombre
    OR d.apellido IS DISTINCT FROM s.apellido
    OR d.ciudad IS DISTINCT FROM s.ciudad
);
