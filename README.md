# 📊 SQL Studies — Dataset Olist

Repositório de estudos práticos em SQL utilizando o [Dataset Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), um conjunto de dados reais de e-commerce brasileiro com mais de 100 mil pedidos.

O objetivo é praticar consultas do nível básico ao avançado, cobrindo window functions, CTEs, agregações, JOINs e análises de negócio reais.

---

## 🗄️ Sobre o Dataset

O dataset Olist contém dados anonimizados de pedidos realizados entre 2016 e 2018 em múltiplos marketplaces do Brasil.

Principais tabelas utilizadas:

- `orders` — pedidos e status de entrega
- `order_items` — itens de cada pedido
- `order_reviews` — avaliações dos clientes
- `order_payments` — formas e valores de pagamento
- `customers` — dados dos clientes por estado
- `sellers` — dados dos vendedores por estado
- `products` — categorias e dimensões dos produtos

---

## 🛠️ Tecnologias

- PostgreSQL 16
- PgAdmin 4
- Git / GitHub

---

## 📁 Estrutura do Repositório

```
sql-olist-estudos/
├── README.md
└── queries/
    ├── nivel_1_window_functions/
    │   ├── desafio_01_rank_vendedores_por_estado.sql
    │   ├── desafio_02_receita_mensal_e_variacao.sql
    │   └── desafio_03_pedidos_por_cliente_row_number.sql
    ├── nivel_2_perguntas_de_negocio/
    │   ├── desafio_04_categoria_maior_taxa_negativa.sql
    │   ├── desafio_05_tempo_medio_entrega_por_estado.sql
    │   └── desafio_06_percentual_pedidos_atrasados.sql
    └── nivel_3_complexos/
        ├── desafio_07_classificacao_clientes.sql
        ├── desafio_08_receita_acumulada_2017.sql
        └── desafio_09_ranking_vendedores_indice.sql
```

---

## 📝 Desafios

### Nível 1 — Window Functions

| # | Descrição | Funções | Status |
|---|-----------|---------|--------|
| 01 | Ranking de vendedores por receita dentro de cada estado (top 3) | `RANK()`, `CTE` | ✅ Resolvido |
| 02 | Receita mensal com variação percentual em relação ao mês anterior | `LAG()`, `DATE_TRUNC` | ✅ Resolvido |
| 03 | Numeração de pedidos por cliente em ordem cronológica | `ROW_NUMBER()`, `CTE` | ✅ Resolvido |

### Nível 2 — Perguntas de Negócio Reais

| # | Descrição | Funções | Status |
|---|-----------|---------|--------|
| 04 | Categoria com maior taxa de avaliação negativa (score ≤ 2) | `JOIN`, `CASE WHEN` | ✅ Resolvido |
| 05 | Tempo médio de entrega em dias por estado do cliente | `AVG`, datas | 🔄 Em andamento |
| 06 | Percentual de pedidos atrasados por mês | `CASE WHEN`, `DATE_TRUNC` | 🔄 Em andamento |

### Nível 3 — Consultas Complexas

| # | Descrição | Funções | Status |
|---|-----------|---------|--------|
| 07 | Classificação de clientes: novo, recorrente ou fiel | `CTE`, `CASE WHEN` | ⏳ Pendente |
| 08 | Receita acumulada mês a mês em 2017 | `SUM() OVER` | ⏳ Pendente |
| 09 | Ranking de vendedores por índice receita × nota média (top 10) | `CTE`, múltiplos `JOIN` | ⏳ Pendente |

---

## 📈 Progresso

![Resolvidos](https://img.shields.io/badge/Resolvidos-4%2F9-4CAF50)
![Em andamento](https://img.shields.io/badge/Em%20andamento-2%2F9-FFA726)
![Pendentes](https://img.shields.io/badge/Pendentes-3%2F9-9E9E9E)

---

## 🚀 Como executar

1. Instale o PostgreSQL e o PgAdmin 4
2. Faça o download do dataset Olist no [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
3. Importe os arquivos CSV nas respectivas tabelas
4. Abra os arquivos `.sql` no PgAdmin e execute

---

## 👤 Autor

**Gustavo** — estudante de Data Analytics em transição de carreira para Engenharia/Análise de Dados.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/gustavorafael09/)
[![GitHub](https://img.shields.io/badge/GitHub-black?style=flat&logo=github)](https://github.com/Gusouzd)
