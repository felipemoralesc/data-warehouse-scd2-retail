-- Tabla: dw.dim_cliente

-- ELIMINAR TABLA SI EXISTE dw.dim_cliente;

CREAR TABLA SI NO EXISTE dw.dim_cliente
(
 clave_cliente entero NO NULO GENERADO SIEMPRE COMO IDENTIDAD ( INCREMENTO 1 INICIO 1 VALOR MÍNIMO 1 VALOR MÁXIMO 2147483647 CACHÉ 1 ),1 INICIO 1 VALOR MÍNIMO 1 VALOR MÁXIMO 2147483647 CACHÉ 1 ),
 cliente_id entero NO NULO,
 carácter email_cliente variable (150) COTEJAR pg_catalog."predeterminado",
 nombre carácter variable(100) COTEJAR pg_catalog."predeterminado",
 variable carácter apellido (100) COTEJAR pg_catalog."predeterminado",100) COTEJAR pg_catalog."predeterminado",
 variable de cochecter de ciudad (100) COTEJAR pg_catalog."predeterminado",
 fecha de fecha_inicio_vigilancia NO NULA,
 fecha de fecha_fin_vigilancia,
 es_actual booleano NO NULO,
 RESTRICCIÓN dim_cliente_pkey CLAVE PRIMARIA (clave_cliente),
 RESTRICCIÓN uq_cliente_version ÚNICA (cliente_id, fecha_inicio_vigilancia)
)

ESPACIO DE TABLAS pg_default;

ALTERAR TABLA SI EXISTE dw.dim_cliente
 PROPIETARIO de postgres;
------------------

-- Tabla: dw.dim_fecha

-- ELIMINAR TABLA SI EXISTE dw.dim_fecha;

CREAR TABLA SI NO EXISTE dw.dim_fecha
(
 clave_fecha entero NO NULO PREDETERMINADO nextval('dw.dim_fecha_clave_fecha_seq'::regclass),
 fecha de fecha_completa NO NULA,
 entero anio NO NULO,
 trimestre entero NO NULO,
 mes entero NO NULO,
    nombre_mes character varying(20) COLLATE pg_catalog."default" NOT NULL,
    dia integer NOT NULL,
    nombre_dia_semana character varying(20) COLLATE pg_catalog."default" NOT NULL,
    es_fin_de_semana boolean NOT NULL,
    CONSTRAINT dim_fecha_pkey PRIMARY KEY (clave_fecha)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw.dim_fecha
    OWNER to postgres;
--------------------------------------------------------------------------------------------------------------

-- Table: dw.dim_producto

-- DROP TABLE IF EXISTS dw.dim_producto;

CREATE TABLE IF NOT EXISTS dw.dim_producto
(
    clave_producto integer NOT NULL DEFAULT nextval('dw.dim_producto_clave_producto_seq'::regclass),
    producto_id integer NOT NULL,
    nombre_producto character varying(100) COLLATE pg_catalog."default",
    categoria character varying(50) COLLATE pg_catalog."default",
    precio numeric(10,2),
    fecha_inicio_vigencia date NOT NULL,
    fecha_fin_vigencia date,
    es_actual boolean NOT NULL,
    CONSTRAINT dim_producto_pkey PRIMARY KEY (clave_producto),
    CONSTRAINT uq_producto_version UNIQUE (producto_id, fecha_inicio_vigencia)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw.dim_producto
    OWNER to postgres;
-------------------------------------------------------------------------------------------------------------
-- Table: dw.fact_ventas_detalle

-- DROP TABLE IF EXISTS dw.fact_ventas_detalle;

CREATE TABLE IF NOT EXISTS dw.fact_ventas_detalle
(
    id_venta_detalle integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    clave_producto integer NOT NULL,
    clave_cliente integer NOT NULL,
    clave_fecha integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    total_venta numeric(12,2) GENERATED ALWAYS AS (((cantidad)::numeric * precio_unitario)) STORED,
    CONSTRAINT fact_ventas_detalle_pkey PRIMARY KEY (id_venta_detalle),
    CONSTRAINT fk_cliente FOREIGN KEY (clave_cliente)
        REFERENCES dw.dim_cliente (clave_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_fecha FOREIGN KEY (clave_fecha)
        REFERENCES dw.dim_fecha (clave_fecha) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_producto FOREIGN KEY (clave_producto)
        REFERENCES dw.dim_producto (clave_producto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dw.fact_ventas_detalle
    OWNER to postgres;
