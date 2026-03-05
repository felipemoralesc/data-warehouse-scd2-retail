INSERT INTO raw.clientes_csv (
    cliente_id,
    nombre,
    apellido,
    email,
    ciudad,
    fecha_registro
)
SELECT
    gs::text AS cliente_id,
    ('Nombre_' || gs)::text AS nombre,
    ('Apellido_' || gs)::text AS apellido,
    ('cliente' || gs || '@correo.com')::text AS email,
    (ARRAY['Bogotá','Medellín','Cali','Tunja','Barranquilla'])[floor(random()*5)+1]::text AS ciudad,
    (CURRENT_DATE - (random()*3650)::int)::text AS fecha_registro
FROM generate_series(1,5000) AS gs;
