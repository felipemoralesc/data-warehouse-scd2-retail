# 🔬 Validación Técnica – SCD Tipo 2 (Dimensión Cliente)

### 🎯 Objetivo

Validar el correcto funcionamiento de la lógica SCD2 antes de integrarla al pipeline final.

**🧪 Escenario de prueba**
* Se detectaron duplicados en raw.clientes_csv.
* Se decidió no modificar RAW.
* Se implementó deduplicación usando SELECT DISTINCT.
* Se detectó inconsistencia de tipos (TEXT vs INTEGER).
* Se resolvió usando CAST() en la transformación.

**🔄 Simulación de cambio**

Se ejecutó:
```text
UPDATE raw.clientes_csv
SET ciudad = 'Bogotá'
WHERE cliente_id = '3';
```
**✅ Resultado esperado**
* Registro anterior cerrado (es_actual = FALSE)
* Nueva versión insertada (es_actual = TRUE)
* Histórico preservado correctamente

**🧠 Conclusión**

La lógica SCD2 funciona correctamente y está lista para integrarse en el proceso automatizado de carga incremental.
