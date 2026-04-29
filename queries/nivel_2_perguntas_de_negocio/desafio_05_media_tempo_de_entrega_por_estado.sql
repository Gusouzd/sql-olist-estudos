WITH estado AS (
	SELECT 
		c.customer_state,
		o.order_delivered_customer_date - o.order_purchase_timestamp AS DIAS_TOTAL
	FROM orders o
	INNER JOIN customers c ON o.customer_id = c.customer_id
) 
SELECT 
	customer_state,
	ROUND(AVG(DATE_PART('day', DIAS_TOTAL))::NUMERIC) AS MEDIA
FROM estado
GROUP BY customer_state
ORDER BY MEDIA DESC