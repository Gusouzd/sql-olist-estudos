-- Desafio 7
-- Classifica cada cliente em: novo (1 pedido), recorrente (2-4 pedidos)
-- ou fiel (5+ pedidos). Mostra quantos clientes em cada categoria
-- e a receita média por categoria.

WITH inicial AS (
	SELECT
		o.order_id,
        c.customer_unique_id,
        op.payment_value
    FROM orders o
    LEFT JOIN order_payments op ON o.order_id = op.order_id
    INNER JOIN customers c ON o.customer_id = c.customer_id
), 
contagem AS (
	SELECT 
		customer_unique_id,
		COUNT(DISTINCT order_id) AS total_pedidos,
		SUM(payment_value) AS valor_total
	FROM inicial
	GROUP BY customer_unique_id	
), 
classificacao AS (
	SELECT 
		*,
		CASE WHEN total_pedidos = 1 THEN 'Novo'
		WHEN total_pedidos BETWEEN 2 AND 4 THEN 'Recorrente'
		ELSE 'Fiel' END AS classes
	FROM contagem
)
SELECT 
	classes,
	COUNT(*) AS total_por_categoria,
	ROUND(AVG(valor_total), 2) AS media_por_categoria
FROM classificacao
GROUP BY classes