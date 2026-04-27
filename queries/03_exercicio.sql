-- Desafio 3
-- Numere os pedidos de cada cliente em ordem cronológica.
-- Mostre só os clientes que fizeram mais de 1 pedido.

WITH contagem_compras AS (
	SELECT 
		o.order_id,
		o.customer_id,
		o.order_purchase_timestamp,
		c.customer_unique_id,
		COUNT(*) OVER(PARTITION BY c.customer_unique_id) AS TOTAL_PEDIDOS
	FROM orders o
	INNER JOIN customers c ON o.customer_id = c.customer_id
),
ranqueado AS (
	SELECT 
		*,
		RANK() OVER(PARTITION BY customer_unique_id ORDER BY order_purchase_timestamp ASC) AS ranking
	FROM contagem_compras
	WHERE TOTAL_PEDIDOS > 1
)
SELECT *
FROM ranqueado