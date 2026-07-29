-- Databricks notebook source

-- COMMAND ----------
%md
# BookStore Lab
## 02 - Load Books

-- COMMAND ----------
%md
# 📖 Introdução

Neste notebook realizaremos a carga inicial da tabela **books** com os livros que serão utilizados durante todo o BookStore Lab.

-- COMMAND ----------
%md
# 🎯 Objetivo

Ao concluir este notebook você será capaz de:

- Carregar dados em uma tabela Delta
- Executar instruções INSERT
- Validar a carga realizada
- Explorar os dados carregados

-- COMMAND ----------
%md
# 🧠 Conceito

Após a criação da estrutura do banco de dados, o próximo passo é popular a tabela de livros.

Todos os notebooks posteriores utilizarão estes dados.

-- COMMAND ----------
USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------
%md
# 📝 Sintaxe

```sql
INSERT INTO books
VALUES (...);
```

-- COMMAND ----------
%md
# 💡 Exemplo 1 - Load Books

Carga inicial da tabela de livros.

-- COMMAND ----------

INSERT INTO books
VALUES

-- (TODOS OS 40 LIVROS EXATAMENTE COMO ESTÃO NO ARQUIVO)

;

-- COMMAND ----------
%md
# ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_books
FROM books;

-- COMMAND ----------
%md
# 💡 Exemplo 2 - Books by Category

-- COMMAND ----------

SELECT
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category
ORDER BY category;

-- COMMAND ----------
%md
# 💡 Exemplo 3 - Books by Author

-- COMMAND ----------

SELECT
    author,
    COUNT(*) AS total_books
FROM books
GROUP BY author
ORDER BY total_books DESC,
         author;

-- COMMAND ----------
%md
# 💡 Exemplo 4 - Price Statistics

-- COMMAND ----------

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    ROUND(AVG(price),2) AS avg_price
FROM books;

-- COMMAND ----------
%md
# 💡 Exemplo 5 - Browse Data

-- COMMAND ----------

SELECT *
FROM books
ORDER BY book_id;

-- COMMAND ----------
%md
# 🧪 Exercícios

1. Execute a carga da tabela books.
2. Conte a quantidade de livros.
3. Liste os livros por categoria.
4. Liste os autores com maior quantidade de livros.
5. Calcule preço mínimo, máximo e médio.

-- COMMAND ----------
%md
# ✅ Solução

-- COMMAND ----------

SELECT
    COUNT(*) AS total_books
FROM books;

SELECT
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category
ORDER BY category;

SELECT
    author,
    COUNT(*) AS total_books
FROM books
GROUP BY author
ORDER BY total_books DESC;

-- COMMAND ----------
%md
# 📌 Resumo

Neste notebook aprendemos a:

- Inserir registros em tabelas Delta.
- Validar a carga realizada.
- Explorar os dados utilizando consultas SQL.

-- COMMAND ----------
%md
# 🚀 Desafio

Adicione um novo livro à tabela **books** utilizando um comando INSERT.

Depois valide:

- Quantidade total de livros.
- Categoria do novo livro.
- Estatísticas de preço.
