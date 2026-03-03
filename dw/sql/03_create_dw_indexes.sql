-- Índices para joins en fact table

CREATE INDEX IF NOT EXISTS idx_fact_cliente
ON dw.fact_ventas_detalle (clave_cliente);

CREATE INDEX IF NOT EXISTS idx_fact_producto
ON dw.fact_ventas_detalle (clave_producto);

CREATE INDEX IF NOT EXISTS idx_fact_fecha
ON dw.fact_ventas_detalle (clave_fecha);
---------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_dim_cliente_actual
ON dw.dim_cliente (cliente_id, es_actual);

CREATE INDEX IF NOT EXISTS idx_dim_producto_actual
ON dw.dim_producto (producto_id, es_actual);
-----------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_dim_cliente_vigencia
ON dw.dim_cliente (cliente_id, fecha_inicio_vigencia, fecha_fin_vigencia);

CREATE INDEX IF NOT EXISTS idx_dim_producto_vigencia
ON dw.dim_producto (producto_id, fecha_inicio_vigencia, fecha_fin_vigencia);
-----------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_dim_fecha_fecha
ON dw.dim_fecha (fecha_completa);
CREATE INDEX IF NOT EXISTS idx_dim_producto_vigencia
ON dw.dim_producto (id_producto_natural, fecha_inicio_vigencia, fecha_fin_vigencia);
-----------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_dim_fecha_fecha
ON dw.dim_fecha (fecha);
