-- Desafio 01 — Ranking de vendedores por receita dentro de cada estado
-- Técnica: 3 CTEs encadeadas + RANK() com PARTITION BY seller_state
-- Lógica: calcula receita por vendedor → enriquece com estado via JOIN → rankeia por estado → filtra top 3
-- Detalhe: receita = price + freight_value (produto + frete)
-- Dataset: Olist | PostgreSQL

WITH receita_por_vendedor AS (
    SELECT 
        seller_id,
        SUM(price + freight_value) AS total_por_vendedor
    FROM order_items
    GROUP BY seller_id
),
com_estado AS (
    SELECT 
        r.seller_id,
        r.total_por_vendedor,
        s.seller_state
    FROM receita_por_vendedor r
    INNER JOIN sellers s ON r.seller_id = s.seller_id
),
ranqueado AS (
    SELECT 
        *,
        RANK() OVER(PARTITION BY seller_state ORDER BY total_por_vendedor DESC) AS ranking
    FROM com_estado
)
SELECT *
FROM ranqueado
WHERE ranking <= 3