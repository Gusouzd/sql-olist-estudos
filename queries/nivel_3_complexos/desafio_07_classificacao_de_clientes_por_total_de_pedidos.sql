-- Desafio 07 — Classificação de clientes em novo, recorrente ou fiel + receita média por categoria
-- Técnica: 3 CTEs encadeadas + CASE WHEN para classificação + COUNT DISTINCT para pedidos únicos
-- Lógica: monta base com order_id, customer_unique_id e valor pago → agrega por cliente contando pedidos
--         e somando receita → classifica por volume → agrupa por categoria para contagem e média
-- Detalhe: LEFT JOIN com order_payments para não perder pedidos sem pagamento registrado
--          COUNT(DISTINCT order_id) evita duplicação quando há múltiplas formas de pagamento no mesmo pedido
-- Dataset: Olist | PostgreSQL

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