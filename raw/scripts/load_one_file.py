import psycopg2
import os
from dotenv import load_dotenv

# ----------------------------
# 1️⃣ Cargar variables de entorno
# ----------------------------

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_PORT = os.getenv("DB_PORT")

try:
    # ----------------------------
    # 2️⃣ Conexión a PostgreSQL
    # ----------------------------
    
    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        port=DB_PORT
    )

    cursor = conn.cursor()

    # ----------------------------
    # 3️⃣ Carga del archivo CSV
    # ----------------------------

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
