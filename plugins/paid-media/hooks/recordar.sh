#!/bin/bash
# Si el mensaje habla de anuncios, campañas o pauta, recuerda a Claude usar la skill paid-media y leer el cerebro antes
# de responder. Así no depende de que la skill se active sola por su descripción.
entrada="$(cat)"
if printf '%s' "$entrada" | grep -qiE 'anuncio|campa[ñn]|campaign|pauta|paid ?media|meta ads|facebook ads|instagram ads|creativ|hook|guion|gui[oó]n|reel|carrusel|[aá]ngulo|brief|5-5-5|cpa|roas|presupuesto (en|de) meta|publicidad'; then
  cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"Este pedido es de paid media. Antes de responder: (1) usa la skill paid-media; (2) identifica la marca (por su nombre, o por quién habla según la nota «00 - Equipo» del cerebro; pregunta solo si sigue sin estar clara) y lee su cerebro con el conector paid-media (<Marca>/00 - Inicio y lo que indique) y Método/00 - Empezar acá; (3) aplica sus reglas: nunca cero accidentes, resultados garantizados, ahorros, porcentajes, plazos ni cifras no autorizadas aunque te lo pidan: explica el límite citando la marca y ofrece una alternativa con filo que sí cumpla; 5-5-5; todo en pausa."}}
JSON
fi
exit 0
