select 
	"Shipping Mode",
	count(*) as total_pedidos,
	sum(case when "Delivery Status"='Late delivery' then 1 else 0 end) as pedidos_tarde,
	round(100.0 * sum(case when "Delivery Status"='Late delivery' then 1 else 0 end)/count(*), 2) as porcentaje_tarde
from pedidos
group by "Shipping Mode"
order by porcentaje_tarde desc;
