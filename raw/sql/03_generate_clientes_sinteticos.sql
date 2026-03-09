INSERT INTO raw.clientes_csv (
    cliente_id,
    email,
	nombre,
    apellido,
    ciudad,
    fecha_registro
)
SELECT
    gs::text AS cliente_id,
	('cliente' || gs || '@correo.com')::text AS email,
    ('Nombre_' || gs)::text AS nombre,
    ('Apellido_' || gs)::text AS apellido,
    (ARRAY['Bogotá','Medellín','Cali','Tunja','Barranquilla'])[floor(random()*5)+1]::text AS ciudad,
    (CURRENT_DATE - (random()*3650)::int)::text AS fecha_registro
FROM generate_series(1,5000) AS gs;

