SELECT
    "Category Name",
    COUNT(*) AS total_pedidos,
    ROUND(AVG("Days for shipping (real)"), 2) AS promedio_dias_real,
    ROUND(AVG("Days for shipment (scheduled)"), 2) AS promedio_dias_programado,
    ROUND(AVG("Days for shipping (real)") - AVG("Days for shipment (scheduled)"), 2) AS diferencia_promedio
FROM pedidos
GROUP BY "Category Name"
having count(*)>5000
ORDER BY diferencia_promedio DESC
LIMIT 15;
