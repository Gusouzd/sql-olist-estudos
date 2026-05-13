-- Desafio 04 — Categoria de produto com maior taxa de avaliação negativa (score <= 2)
-- Técnica: CASE WHEN para classificar avaliação + divisão agregada para calcular percentual
-- Lógica: JOIN entre order_items, products e order_reviews → marca cada avaliação como negativa (1) ou não (0)
--         → agrupa por categoria e calcula taxa = soma negativas / total de avaliações
-- Detalhe: cast ::NUMERIC necessário para o ROUND funcionar corretamente na divisão inteira
-- Dataset: Olist | PostgreSQL

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

