-- Table: raw.clientes_csv

-- DROP TABLE IF EXISTS "raw".clientes_csv;

CREATE TABLE IF NOT EXISTS "raw".clientes_csv
(
    cliente_id text COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    nombre text COLLATE pg_catalog."default",
    apellido text COLLATE pg_catalog."default",
    ciudad text COLLATE pg_catalog."default",
    fecha_registro text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".clientes_csv
    OWNER to postgres;
--------------------------------------------------------------------------------------------------------

-- Table: raw.productos_csv

-- DROP TABLE IF EXISTS "raw".productos_csv;

CREATE TABLE IF NOT EXISTS "raw".productos_csv
(
    producto_id text COLLATE pg_catalog."default",
    nombre_producto text COLLATE pg_catalog."default",
    categoria text COLLATE pg_catalog."default",
    precio_lista text COLLATE pg_catalog."default",
    activo text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".productos_csv
    OWNER to postgres;
------------------------------------------------------------------------------------------------------------

-- Table: raw.ventas_csv

-- DROP TABLE IF EXISTS "raw".ventas_csv;

CREATE TABLE IF NOT EXISTS "raw".ventas_csv
(
    fecha text COLLATE pg_catalog."default",
    cliente_id text COLLATE pg_catalog."default",
    producto_id text COLLATE pg_catalog."default",
    cantidad text COLLATE pg_catalog."default",
    precio_unitario text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".ventas_csv
    OWNER to postgres;-- Table: raw.ventas_csv

-- DROP TABLE IF EXISTS "raw".ventas_csv;

CREATE TABLE IF NOT EXISTS "raw".ventas_csv
(
    fecha text COLLATE pg_catalog."default",
    cliente_id text COLLATE pg_catalog."default",
    producto_id text COLLATE pg_catalog."default",
    cantidad text COLLATE pg_catalog."default",
    precio_unitario text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".ventas_csv
    OWNER to postgres;
