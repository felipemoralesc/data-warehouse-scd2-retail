# data-warehouse-scd2-retail
Proyecto de almacén de datos de extremo a extremo con implementación SCD tipo 2 utilizando PostgreSQL.
# Proyecto Data Warehouse – Implementación SCD Tipo 2

## 📌 Descripción del Proyecto

Este proyecto implementa un Data Warehouse en PostgreSQL simulando un entorno de ventas retail.

Se desarrolla un pipeline básico de datos desde la capa Raw hasta el Data Warehouse (DW), aplicando modelado dimensional y gestión histórica mediante Slowly Changing Dimensions (SCD Tipo 2).

---

## 🏗 Arquitectura del Proyecto

El proyecto sigue una arquitectura por capas:

- **Raw** → Archivos CSV originales
- **Staging** → Limpieza y estructuración de datos
- **Data Warehouse (DW)** → Modelo dimensional tipo Star Schema

---

## 🔄 Flujo de Datos (Pipeline)

1. Los datos fuente se almacenan en la capa **Raw**
2. Un script en **Python** carga los datos hacia la base de datos
3. La capa **Staging** normaliza y prepara la información
4. El **Data Warehouse** implementa modelo dimensional con SCD Tipo 2
5. La tabla de hechos almacena métricas listas para análisis

---

## ⭐ Modelo Dimensional

### Dimensiones

- `dim_producto` → SCD Tipo 2
- `dim_cliente` → SCD Tipo 2
- `dim_fecha` → Dimensión estática

### Tabla de Hechos

- `fact_ventas_detalle`
  - Usa claves sustitutas
  - Preserva consistencia histórica
  - Implementa columna generada para cálculo automático del total

---

## 🔁 Implementación SCD Tipo 2

Las dimensiones de producto y cliente incluyen:

- Clave sustituta (surrogate key)
- Clave natural del negocio
- `fecha_inicio_vigencia`
- `fecha_fin_vigencia`
- `es_actual`

Cada cambio relevante genera una nueva versión del registro, preservando el historial.

---

## 🧮 Diseño de la Tabla de Hechos

Campos principales:

- `cantidad`
- `precio_unitario`
- `total_venta` (columna generada)

El total se calcula automáticamente:

cantidad * precio_unitario

Esto evita inconsistencias y asegura integridad de datos.

---

## 🛠 Tecnologías Utilizadas

- PostgreSQL
- SQL
- Python
- Modelado Dimensional
- Slowly Changing Dimensions (SCD Tipo 2)

---

## 📊 Capacidades Analíticas

El modelo permite:

- Análisis histórico de ventas
- Seguimiento de cambios de precios
- Seguimiento de cambios de clientes
- Agregaciones por fecha, producto y cliente

---

## 🚀 Próximos Pasos

- Automatización completa del ETL
- Implementación de control de calidad de datos
- Indexación y optimización de consultas
- Creación de vistas analíticas
