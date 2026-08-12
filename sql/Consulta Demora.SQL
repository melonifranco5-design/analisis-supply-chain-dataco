Select 
	"Order Region",
	count(*) as total_pedidos,
	sum("Late_delivery_risk") as pedidos_con_demora,
	ROUND(100.0 * sum("Late_delivery_risk")/count(*), 2) as porcentaje_demora
from pedidos
group by "Order Region"
order by porcentaje_demora desc;
