INSERT INTO dw.fact_ventas_detalle (
    clave_producto,
    clave_cliente,
    clave_fecha,
    cantidad,
    precio_unitario
)

SELECT
    dp.clave_producto,
    dc.clave_cliente,
    df.clave_fecha,
    s.cantidad,
    s.precio_unitario

FROM staging.ventas_clean s

JOIN dw.dim_producto dp
    ON s.producto_id = dp.producto_id
    AND dp.es_actual = TRUE

JOIN dw.dim_cliente dc
    ON s.cliente_id = dc.cliente_id
    AND dc.es_actual = TRUE

JOIN dw.dim_fecha df
    ON s.fecha = df.fecha_completa;
