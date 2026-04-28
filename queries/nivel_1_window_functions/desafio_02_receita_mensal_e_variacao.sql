-- Desafio 2
-- Para cada mês, mostre a receita total e a receita do mês anterior.
-- Calcule a variação percentual entre os dois.

WITH receita_mensal AS (
    SELECT
        DATE_TRUNC('month', shipping_limit_date) AS mes,
        SUM(price + freight_value)               AS receita_total
    FROM order_items
    GROUP BY DATE_TRUNC('month', shipping_limit_date)
),
receita_com_lag AS (
    SELECT
        mes,
        receita_total,
        LAG(receita_total) OVER (ORDER BY mes) AS receita_mes_anterior,
        ROUND(((receita_total - LAG(receita_total) OVER (ORDER BY mes)) / LAG(receita_total) OVER (ORDER BY mes)) * 100, 2) AS variacao_percentual
    FROM receita_mensal
)
SELECT *
FROM receita_com_lag
ORDER BY mes;