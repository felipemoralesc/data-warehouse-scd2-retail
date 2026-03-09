/* =========================================================
   FASE 1 — Cerrar vigencia de registros que cambiaron
========================================================= */
UPDATE dw.dim_cliente d
SET
    fecha_fin_vigencia = CURRENT_DATE - INTERVAL '1 day',
    es_actual = FALSE
FROM staging.clientes_clean s
WHERE d.cliente_id = s.cliente_id
AND d.es_actual = TRUE
AND (
        d.email_cliente IS DISTINCT FROM s.email
     OR d.nombre IS DISTINCT FROM s.nombre
     OR d.apellido IS DISTINCT FROM s.apellido
     OR d.ciudad IS DISTINCT FROM s.ciudad
);


/* =========================================================
   FASE 2 - Insertar nuevos clientes
========================================================= */

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
WHERE d.cliente_id IS NULL;

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
JOIN dw.dim_cliente d
    ON s.cliente_id = d.cliente_id
WHERE d.es_actual = FALSE
AND d.fecha_fin_vigencia = CURRENT_DATE - INTERVAL '1 day';

