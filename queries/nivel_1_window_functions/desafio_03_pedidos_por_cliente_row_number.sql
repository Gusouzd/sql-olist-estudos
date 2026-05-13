-- Desafio 03 — Numeração cronológica de pedidos por cliente (apenas clientes com mais de 1 pedido)
-- Técnica: COUNT() OVER para filtrar antes + RANK() OVER para numerar cronologicamente
-- Lógica: JOIN entre orders e customers para obter customer_unique_id → conta pedidos por cliente via window
--         → filtra total > 1 na CTE intermediária → aplica RANK() por ordem de compra
-- Detalhe: usa customer_unique_id (não customer_id) para identificar o cliente real entre múltiplos registros
-- Dataset: Olist | PostgreSQL

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