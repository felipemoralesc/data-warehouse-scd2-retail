INSERT INTO raw.ventas_csv (
    fecha,
    cliente_id,
    producto_id,
    cantidad,
    precio_unitario
)

SELECT
    (CURRENT_DATE - (RANDOM()*365)::INT)::text AS fecha,
    FLOOR(RANDOM()*5000 + 1)::INT::text AS cliente_id,
    FLOOR(RANDOM()*1000 + 1)::INT::text AS producto_id,
    FLOOR(RANDOM()*5 + 1)::INT::text AS cantidad,
    ROUND((RANDOM()*90 + 10)::numeric,2)::text AS precio_unitario
FROM generate_series(1,100000);
