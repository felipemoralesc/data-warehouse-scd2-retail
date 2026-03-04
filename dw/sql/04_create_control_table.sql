CREATE TABLE dw.control_cargas (
    id_ejecucion SERIAL PRIMARY KEY,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    estado VARCHAR(20),
    registros_dim_cliente INT DEFAULT 0,
    registros_dim_producto INT DEFAULT 0,
    registros_fact INT DEFAULT 0,
    mensaje_error TEXT
);
