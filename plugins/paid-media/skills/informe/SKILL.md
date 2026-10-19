---
name: informe
description: Lee resultados de anuncios (Meta o un export) y arma un informe con lectura por pieza y decisiones propuestas
argument-hint: <marca> <período> [archivo de export]
---

# /informe

Pedido: $ARGUMENTS

1. Aplica la skill `paid-media`. Lee `Método/41`, `42`, `50`, `51` y la nota de medición de la marca.
2. Fuente de datos, en orden: la app de campañas de Optimizo si su conector está disponible (métricas de Meta, CRM,
   Shopify, Google, TikTok) → el conector de la marca en Medula (cabeza de Meta Ads, si está conectada) → un export que
   entregue la persona → lo que la persona pegue. Nunca una cifra de memoria.
3. Usa `Método/80 - Plantillas/Informe de resultados.md`: atribuido (Meta) separado de real (CRM o tienda); por pieza;
   muestras chicas marcadas «insuficiente».
4. Las decisiones (escalar, pausar, mover plata) van como **propuesta con umbral, fecha de revisión y cómo revertir**.
   No ejecutes ninguna.
5. Cierra con 1–3 aprendizajes propuestos para `/aprender`.
