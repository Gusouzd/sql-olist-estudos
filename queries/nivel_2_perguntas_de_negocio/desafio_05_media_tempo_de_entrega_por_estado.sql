-- Desafio 05 — Tempo médio de entrega em dias por estado do cliente (do mais lento ao mais rápido)
-- Técnica: subtração direta entre timestamps + DATE_PART para extrair dias + AVG para média por estado
-- Lógica: subtrai order_purchase_timestamp de order_delivered_customer_date → extrai a parte em dias
--         → agrupa por estado e calcula média arredondada
-- Detalhe: subtração entre timestamps no PostgreSQL retorna um interval — DATE_PART extrai os dias desse interval
-- Dataset: Olist | PostgreSQL

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