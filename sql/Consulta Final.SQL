select 
	"Shipping Mode",
	count(*) as total_pedidos,
	sum(case when "Delivery Status"='Late delivery' then 1 else 0 end) as pedidos_tarde,
	round(100.0 * sum(case when "Delivery Status"='Late delivery' then 1 else 0 end)/count(*), 2) as porcentaje_tarde,
	ROUND(AVG("Days for shipment (scheduled)"), 2) AS promedio_dias_programado,
	ROUND(AVG("Days for shipping (real)"), 2) AS promedio_dias_real,
	ROUND(AVG("Days for shipping (real)") - AVG("Days for shipment (scheduled)"), 2) AS diferencia_promedio
from pedidos
group by "Shipping Mode"
order by diferencia_promedio desc;
