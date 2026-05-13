-- Desafio 08 — Evolução da receita acumulada mês a mês ao longo de 2017
-- Técnica: SUM() OVER (ORDER BY mes) — window function de acumulado (running total)
-- Lógica: filtra pedidos de 2017 → formata mês como YYYY-MM com TO_CHAR → agrega receita mensal
--         → aplica SUM acumulada ordenada pelo mês na query final
-- Detalhe: TO_CHAR retorna texto, mas a ordenação funciona corretamente no formato YYYY-MM por ser lexicográfica
-- Dataset: Olist | PostgreSQL

WITH filtro AS (
	SELECT 
		o.order_purchase_timestamp AS data_compra,
		op.payment_value AS valor_pago
	FROM orders o
	LEFT JOIN order_payments op ON o.order_id = op.order_id
	WHERE DATE_PART('year', o.order_purchase_timestamp) = 2017
),
agrupamento AS (
	SELECT 
		TO_CHAR(DATE_TRUNC('month', data_compra), 'YYYY-MM') AS mes,
		SUM(valor_pago) AS total_mensal
	FROM filtro
	GROUP BY mes
)
SELECT 
	*,
	SUM(total_mensal) OVER(ORDER BY mes) AS receita_acumulada
FROM agrupamento
