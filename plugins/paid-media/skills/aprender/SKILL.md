---
name: aprender
description: Convierte feedback y resultados en reglas aprendidas y, con aprobación, las guarda en el cerebro de la marca
argument-hint: <marca> <feedback, motivos de descarte o resultados>
---

# /aprender

Pedido: $ARGUMENTS

1. Aplica la skill `paid-media`. Lee `<Marca>/70 - Reglas aprendidas/` para no repetir ni contradecir reglas vigentes.
2. Propón reglas candidatas, cada una con: la regla en una frase · cuándo aplica y cuándo no · evidencia (qué piezas,
   qué motivos, qué números y su tamaño de muestra) · si contradice algo del cerebro.
3. **No escribas nada hasta que la persona apruebe cada regla.**
4. Con la aprobación, guarda cada una con `vault_escribir` en `<Marca>/70 - Reglas aprendidas/<slug>.md` (o en
   `Método/70 - Reglas aprendidas/` si vale para todas las marcas), con este encabezado:
   ```
   ---
   tipo: regla
   marca: <marca o general>
   origen: conversacion | resultados | campaigns
   fecha: AAAA-MM-DD
   evidencia: <resumen>
   aprobada_por: <persona>
   ---
   ```
5. Confirma la ruta de cada regla guardada.
