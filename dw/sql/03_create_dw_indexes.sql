-- Índices para joins en fact table

CREATE INDEX IF NOT EXISTS idx_fact_cliente
ON dw.fact_ventas_detalle (clave_cliente);

CREATE INDEX IF NOT EXISTS idx_fact_producto
ON dw.fact_ventas_detalle (clave_producto);

CREATE INDEX IF NOT EXISTS idx_fact_fecha
ON dw.fact_ventas_detalle (clave_fecha);
