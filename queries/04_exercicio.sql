-- Desafio 4
-- Qual categoria de produto tem a maior taxa de avaliação negativa?
-- (considere negativa: review_score <= 2)

WITH base AS (
    SELECT 
        p.product_category_name,
        CASE WHEN r.review_score <= 2 THEN 1 ELSE 0 END AS negativa
    FROM order_items oi
    INNER JOIN products p ON oi.product_id = p.product_id
    INNER JOIN order_reviews r ON oi.order_id = r.order_id
)
SELECT 
    product_category_name,
    ROUND(SUM(negativa)::NUMERIC / COUNT(*) * 100, 2) AS taxa_negativa
FROM base
GROUP BY product_category_name
ORDER BY taxa_negativa DESC

