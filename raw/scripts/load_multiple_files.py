import os
import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path
from dotenv import load_dotenv

# ==================================
# 🔐 CARGAR VARIABLES DE ENTORNO
# ==================================

load_dotenv()  # Lee el archivo .env en la misma carpeta

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# Validación básica
if not all([DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME]):
    raise ValueError("❌ Faltan variables de entorno en el archivo .env")

# ==================================
# 🔌 CREAR ENGINE SQLALCHEMY
# ==================================

engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# ==================================
# 📂 RUTA BASE DEL PROYECTO
# ==================================

BASE_PATH = Path(__file__).resolve().parent

# ==================================
# 📥 FUNCIÓN DE CARGA REUTILIZABLE
# ==================================

def cargar_csv_a_raw(ruta_csv, nombre_tabla):
    try:
        if not ruta_csv.exists():
            print(f"❌ Archivo no encontrado: {ruta_csv}")
            return

        print(f"\n📂 Cargando archivo: {ruta_csv.name}")

        df = pd.read_csv(ruta_csv)

        print(f"🔎 Registros encontrados: {len(df)}")

        df.to_sql(
            nombre_tabla,
            engine,
            schema="raw",
            if_exists="append",
            index=False
        )

        print(f"✅ Tabla raw.{nombre_tabla} cargada correctamente.")

    except Exception as e:
        print(f"❌ Error cargando {nombre_tabla}: {e}")


# ==================================
# 🚀 BLOQUE PRINCIPAL
# ==================================

if __name__ == "__main__":

    archivos = {
        "clientes_csv": BASE_PATH / "clientes.csv",
        "productos_csv": BASE_PATH / "productos.csv"
    }

    print("🚀 Iniciando proceso de carga RAW...")

    for tabla, ruta in archivos.items():
        cargar_csv_a_raw(ruta, tabla)

    print("\n🎯 Proceso de carga RAW finalizado.")