import psycopg2

try:
    conn = psycopg2.connect(
        host="localhost",
        database="ventas_dw",
        user="postgres",
        password="qxnk26yp",
        port="5432"
    )

    cursor = conn.cursor()

    with open("ventas_2024_01.csv", "r") as f:
        cursor.copy_expert(
            """
            COPY raw.ventas_csv (fecha, cliente_id, producto_id, cantidad, precio_unitario)
            FROM STDIN
            WITH CSV HEADER
            """,
            f
        )

    conn.commit()
    print("Archivo cargado correctamente en raw.")

    cursor.close()
    conn.close()

except Exception as e:
    print("Error durante la carga:")
    print(e)
