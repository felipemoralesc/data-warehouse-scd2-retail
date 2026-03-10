# Validación de Performance

Este documento describe las pruebas realizadas para validar el comportamiento
y rendimiento del Data Warehouse ante consultas analíticas.

---

## 1. Tamaño del Dataset

El Data Warehouse fue probado utilizando datos sintéticos generados en la capa RAW.

Volumen de datos utilizado:

| Tabla | Registros |
|------|------|
| raw.clientes | ~5.000 |
| raw.productos | ~1.000 |
| raw.ventas | ~100.000 |

Después del proceso ETL (`RAW` → `STAGING` → `DATA WAREHOUSE`), la tabla de hechos contiene aproximadamente:

`dw.fact_ventas_detalle ≈ 100.000 registros`

Este volumen permite simular consultas analíticas sobre un modelo dimensional.

---

## 2. Consultas Analíticas

Se ejecutaron consultas analíticas típicas para validar el comportamiento del modelo estrella.

### Ventas por Mes

```sql
EXPLAIN ANALYZE
SELECT
    df.anio,
    df.mes,
    SUM(f.total_venta) AS ventas_totales
FROM dw.fact_ventas_detalle f
JOIN dw.dim_fecha df
    ON f.clave_fecha = df.clave_fecha
GROUP BY
    df.anio,
    df.mes;
