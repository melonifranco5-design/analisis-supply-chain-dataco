Análisis de Supply Chain – DataCo

Análisis del rendimiento de entregas de una cadena de suministro real (180.000+ pedidos), usando Power BI, SQL y Python sobre el mismo dataset para responder una pregunta central: ¿por qué llegan tarde los pedidos, y a qué se debe?

Dataset

DataCo Smart Supply Chain — pedidos, productos, envíos, entregas y datos financieros.

1. Power BI — Vista general

Dashboard con KPIs, comparación de tiempos reales vs. programados, pedidos por región, producto y estado de entrega.

<img width="742" height="367" alt="Resumen Pedidos" src="https://github.com/user-attachments/assets/b867ab8e-5c66-4114-b916-2d7d0a7eae15" />


Hallazgo: el 54,8% de los pedidos presentan demora en la entrega, con un promedio de 3,5 días reales contra 2,9 días programados.

2. SQL — ¿Dónde está el problema?

Consultas en PostgreSQL para localizar la causa de la demora (ver archivo completo).

Por región: entre 55% y 58% de demora en todas las regiones, sin excepción marcada → no es un problema geográfico.
Por categoría de producto: entre 0,55 y 0,58 días de sobretiempo en todas las categorías de alto volumen → no es un problema del tipo de producto.
Por modo de envío: acá sí aparece una diferencia real:
<img width="771" height="418" alt="Consulta final" src="https://github.com/user-attachments/assets/50100e8d-cf28-4d2d-a661-3ac38e5e8fdb" />

<img width="683" height="152" alt="Resultado Final" src="https://github.com/user-attachments/assets/63377962-a1a2-45a2-9fcd-2778da0bd042" />


Hallazgo: la demora no depende de dónde se envía ni qué se envía, sino de qué tan ajustado es el compromiso de entrega. Cuanto más rápido promete el modo de envío, más falla.

3. Python (Pandas) — ¿Qué esconde el promedio?

Cálculo de la demora por pedido individual y su variabilidad (ver notebook completo).

<img width="517" height="346" alt="Pandas 3" src="https://github.com/user-attachments/assets/5b9a41bb-92a8-48b4-bc03-a6d6b91512b3" />


<img width="881" height="244" alt="Pandas 4" src="https://github.com/user-attachments/assets/650eb05d-6a80-4bd0-b865-533193a2e51f" />


Hallazgo: First Class tiene desvío 0 — todos los pedidos demoran exactamente 1 día, siempre. Es 100% predecible, aunque siempre incumple. Standard Class, en cambio, promedia casi 0 días (parece cumplir), pero su desvío de 1,42 revela que en realidad mezcla pedidos muy adelantados con otros muy atrasados — el promedio esconde un proceso errático.

Conclusión general

La empresa no tiene un problema geográfico ni de producto, sino de gestión de promesas de envío: los modos más rápidos prometen tiempos que la operación no sostiene de forma consistente, y el modo que "cumple en promedio" (Standard Class) en realidad es el más impredecible pedido por pedido.
