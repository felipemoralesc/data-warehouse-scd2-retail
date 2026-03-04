-- Table: staging.clientes_clean

-- DROP TABLE IF EXISTS staging.clientes_clean;

CREATE TABLE IF NOT EXISTS staging.clientes_clean
(
    cliente_id integer,
    email character varying(150) COLLATE pg_catalog."default",
    nombre character varying(100) COLLATE pg_catalog."default",
    apellido character varying(100) COLLATE pg_catalog."default",
    ciudad character varying(100) COLLATE pg_catalog."default",
    fecha_registro date
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.clientes_clean
    OWNER to postgres;
-----------------------------------------------------------------------------
-- Table: staging.productos_clean

-- DROP TABLE IF EXISTS staging.productos_clean;

CREATE TABLE IF NOT EXISTS staging.productos_clean
(
    producto_id integer,
    nombre_producto character varying(150) COLLATE pg_catalog."default",
    categoria character varying(100) COLLATE pg_catalog."default",
    precio_lista numeric(12,2),
    activo boolean
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.productos_clean
    OWNER to postgres;
-------------------------------------------------------------------------------------
-- Table: staging.ventas_clean

-- DROP TABLE IF EXISTS staging.ventas_clean;

CREATE TABLE IF NOT EXISTS staging.ventas_clean
(
    fecha date,
    cliente_id integer,
    producto_id integer,
    cantidad integer,
    precio_unitario numeric(10,2),
    total numeric(12,2)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.ventas_clean
    OWNER to postgres;
