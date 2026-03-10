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

---

### 3. Consideraciones de Indexación

El modelo del Data Warehouse ya incorpora indexación estratégica
sobre las claves foráneas de la tabla de hechos y sobre columnas
utilizadas en consultas analíticas.

La definición completa de los índices puede consultarse en la
documentación principal del proyecto.

Durante las pruebas de performance se verificó el comportamiento
de las consultas utilizando `EXPLAIN ANALYZE` para analizar el
plan de ejecución y el uso de estos índices.


## 4. Análisis del Execution Plan

Los planes de ejecución fueron analizados utilizando:

EXPLAIN ANALYZE

Se observaron principalmente los siguientes componentes:

Seq Scan en la tabla de hechos para agregaciones completas

Hash Join entre tabla de hechos y dimensiones

HashAggregate para operaciones de agrupación

Sort para ordenamiento de resultados

En consultas que procesan grandes porciones de la tabla, PostgreSQL prefiere Seq Scan, ya que el dataset (~100k registros) es relativamente pequeño.


### 5. Resultados

Las pruebas realizadas permitieron validar que:

El modelo estrella soporta correctamente consultas analíticas.

Los joins entre tabla de hechos y dimensiones funcionan de forma eficiente.

Los índices están correctamente implementados.

El Data Warehouse responde adecuadamente a consultas analíticas típicas.
