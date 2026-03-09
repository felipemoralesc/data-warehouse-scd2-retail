INSERT INTO raw.productos_csv (
    producto_id,
    nombre_producto,
    categoria,
    precio_lista,
    activo
)

SELECT
    gs::text AS producto_id,
    'Producto ' || gs AS nombre_producto,
    categorias.categoria,
    ROUND((RANDOM() * 90 + 10)::numeric, 2)::text AS precio_lista,
    CASE 
        WHEN RANDOM() < 0.9 THEN 'true'
        ELSE 'false'
    END AS activo
FROM generate_series(1,1000) gs
CROSS JOIN LATERAL (
    SELECT categoria
    FROM (
        VALUES
        ('Electrónica'),
        ('Hogar'),
        ('Deportes'),
        ('Ropa'),
        ('Libros'),
        ('Juguetes')
    ) AS categorias(categoria)
    ORDER BY RANDOM()
    LIMIT 1
) categorias;
