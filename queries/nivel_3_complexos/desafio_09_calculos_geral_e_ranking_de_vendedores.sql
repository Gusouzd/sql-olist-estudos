-- Desafio 09 — Ranking de vendedores pelo índice (receita_total × nota_média) — top 10
-- Técnica: múltiplos JOINs + 3 CTEs encadeadas + DENSE_RANK() para ranking sem lacunas
-- Lógica: une order_items com order_reviews por order_id → agrega por vendedor calculando total de pedidos,
--         receita total, ticket médio e nota média → calcula índice e aplica DENSE_RANK → filtra top 10
-- Detalhe: HAVING AVG(avaliacao) IS NOT NULL exclui vendedores sem nenhuma avaliação registrada
--          DENSE_RANK ao invés de RANK evita lacunas no ranking quando há empate no índice
-- Dataset: Olist | PostgreSQL

WITH informacoes AS (
	SELECT 
		oi.seller_id,
		oi.price + oi.freight_value AS receita_pedido,
		re.review_score AS avaliacao
	FROM order_items oi
	LEFT JOIN order_reviews re ON oi.order_id = re.order_id
), 
agrupamento AS (
	SELECT 
		seller_id,
		COUNT(*) AS total_pedidos,
		ROUND(SUM(receita_pedido), 2) AS receita_total,
		ROUND(AVG(receita_pedido), 2) AS ticket_medio,
		ROUND(AVG(avaliacao), 2) AS nota_media
	FROM informacoes
	GROUP BY seller_id
	HAVING AVG(avaliacao) IS NOT NULL
), 
indice AS (
	SELECT 
		*,
		ROUND(receita_total * nota_media, 2) AS indice,
		DENSE_RANK() OVER(ORDER BY ROUND(receita_total * nota_media, 2) DESC) AS ranking
	FROM agrupamento
)
SELECT *
FROM indice
WHERE ranking <= 10