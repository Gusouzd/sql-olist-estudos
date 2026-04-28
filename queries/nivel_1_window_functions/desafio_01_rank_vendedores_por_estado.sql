-- Desafio 1 
-- Rankeia os vendedores por receita total dentro de cada estado. 
-- Mostre só os 3 primeiros de cada estado. 

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