import pandas as pd

from sqlalchemy import create_engine



# ----------------------------

# 1. Configuración conexión

# ----------------------------



usuario = "postgres"

password = "qxnk26yp"

host = "localhost"

puerto = "5432"

base_datos = "ventas_dw"



engine = create_engine(

    f"postgresql+psycopg2://{usuario}:{password}@{host}:{puerto}/{base_datos}"

)



# ----------------------------

# 2. Generar rango de fechas

# ----------------------------



fecha_inicio = "2020-01-01"

fecha_fin = "2030-12-31"



fechas = pd.date_range(start=fecha_inicio, end=fecha_fin, freq="D")



# Diccionarios en español

meses_es = {

    1: "Enero", 2: "Febrero", 3: "Marzo", 4: "Abril",

    5: "Mayo", 6: "Junio", 7: "Julio", 8: "Agosto",

    9: "Septiembre", 10: "Octubre", 11: "Noviembre", 12: "Diciembre"

}



dias_es = {

    0: "Lunes", 1: "Martes", 2: "Miércoles", 3: "Jueves",

    4: "Viernes", 5: "Sábado", 6: "Domingo"

}



df = pd.DataFrame({

    "fecha_completa": fechas

})



df["clave_fecha"] = df["fecha_completa"].dt.strftime("%Y%m%d").astype(int)

df["anio"] = df["fecha_completa"].dt.year

df["trimestre"] = df["fecha_completa"].dt.quarter

df["mes"] = df["fecha_completa"].dt.month

df["nombre_mes"] = df["mes"].map(meses_es)

df["dia"] = df["fecha_completa"].dt.day

df["nombre_dia_semana"] = df["fecha_completa"].dt.weekday.map(dias_es)

df["es_fin_de_semana"] = df["fecha_completa"].dt.weekday >= 5



# Reordenar columnas según tabla

df = df[

    [

        "clave_fecha",

        "fecha_completa",

        "anio",

        "trimestre",

        "mes",

        "nombre_mes",

        "dia",

        "nombre_dia_semana",

        "es_fin_de_semana"

    ]

]



# ----------------------------

# 3. Insertar en PostgreSQL

# ----------------------------



df.to_sql(

    name="dim_fecha",

    schema="dw",

    con=engine,

    if_exists="append",   # ⚠️ importante

    index=False

)



print("Dimensión fecha cargada correctamente en dw.dim_fecha.")

