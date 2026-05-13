-- Desafio 02 — Receita mensal com variação percentual em relação ao mês anterior
-- Técnica: DATE_TRUNC para agrupar por mês + LAG() para buscar valor do mês anterior
-- Lógica: agrupa receita por mês → aplica LAG na mesma query para calcular variação percentual
-- Detalhe: LAG() é chamada duas vezes na mesma CTE para evitar subquery extra
-- Dataset: Olist | PostgreSQL

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