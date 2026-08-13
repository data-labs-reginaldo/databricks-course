-- Databricks notebook source
select * from books

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # BookStore Lab
-- MAGIC ## 02 - Load Books

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📖 Introdução
-- MAGIC
-- MAGIC Neste notebook realizaremos a carga inicial da tabela **books** com os livros que serão utilizados durante todo o BookStore Lab.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🎯 Objetivo
-- MAGIC
-- MAGIC Ao concluir este notebook você será capaz de:
-- MAGIC
-- MAGIC - Carregar dados em uma tabela Delta
-- MAGIC - Executar instruções INSERT
-- MAGIC - Validar a carga realizada
-- MAGIC - Explorar os dados carregados

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧠 Conceito
-- MAGIC
-- MAGIC Após a criação da estrutura do banco de dados, o próximo passo é popular a tabela de livros.
-- MAGIC
-- MAGIC Todos os notebooks posteriores utilizarão estes dados.

-- COMMAND ----------

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📝 Sintaxe
-- MAGIC
-- MAGIC ```sql
-- MAGIC INSERT INTO books
-- MAGIC VALUES (...);
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 1 - Load Books
-- MAGIC
-- MAGIC Carga inicial da tabela de livros.

-- COMMAND ----------

INSERT INTO books (book_id, title, author, category, price)
VALUES
('B001','Learning Spark','Jules Damji','Spark',59.90),
('B002','Spark in Action','Jean-Georges Perrin','Spark',69.90),
('B003','High Performance Spark','Holden Karau','Spark',72.90),
('B004','Spark Definitive Guide','Bill Chambers','Spark',89.90),
('B005','Designing Data Intensive Applications','Martin Kleppmann','Data Engineering',99.90),
('B006','Fundamentals of Data Engineering','Joe Reis','Data Engineering',92.50),
('B007','Data Pipelines Pocket Reference','James Densmore','Data Engineering',49.90),
('B008','Streaming Systems','Tyler Akidau','Streaming',94.90),
('B009','SQL Cookbook','Anthony Molinaro','SQL',84.90),
('B010','Learning SQL','Alan Beaulieu','SQL',54.90),
('B011','SQL Queries for Mere Mortals','John Viescas','SQL',44.90),
('B012','T SQL Fundamentals','Itzik Ben Gan','SQL',79.90),
('B013','Python for Data Analysis','Wes McKinney','Python',85.90),
('B014','Effective Python','Brett Slatkin','Python',65.90),
('B015','Fluent Python','Luciano Ramalho','Python',109.90),
('B016','Automate the Boring Stuff','Al Sweigart','Python',55.90),
('B017','Machine Learning with Spark','Nick Pentreath','Machine Learning',74.90),
('B018','Hands On Machine Learning','Aurelien Geron','Machine Learning',119.90),
('B019','Practical Statistics for Data Scientists','Peter Bruce','Machine Learning',63.90),
('B020','Azure Databricks Cookbook','Packt','Databricks',82.90),
('B021','Databricks Essentials','Packt','Databricks',68.90),
('B022','Delta Lake Up and Running','O''Reilly','Delta Lake',66.90),
('B023','AWS Data Engineering','Packt','Cloud',71.90),
('B024','Google Cloud Data Engineering','Packt','Cloud',76.90),
('B025','Azure Data Engineering','Packt','Cloud',74.90),
('B026','Kafka The Definitive Guide','Gwen Shapira','Streaming',72.90),
('B027','Streaming Data','Andrew Psaltis','Streaming',69.90),
('B028','Docker Deep Dive','Nigel Poulton','DevOps',61.90),
('B029','Kubernetes Up and Running','Brendan Burns','DevOps',86.90),
('B030','Terraform Up and Running','Yevgeniy Brikman','DevOps',73.90),
('B031','Apache Iceberg The Definitive Guide','Packt','Lakehouse',79.90),
('B032','Apache Hudi Essentials','Packt','Lakehouse',75.90),
('B033','BigQuery The Definitive Guide','Packt','BigQuery',82.90),
('B034','Mastering BigQuery','Packt','BigQuery',88.90),
('B035','Git Pocket Guide','Richard Silverman','Git',42.90),
('B036','Pro Git','Scott Chacon','Git',59.90),
('B037','dbt in Action','Packt','dbt',69.90),
('B038','Analytics Engineering','Packt','dbt',74.90),
('B039','Data Warehouse Toolkit','Ralph Kimball','Data Warehouse',104.90),
('B040','Building the Data Warehouse','William Inmon','Data Warehouse',101.90);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_books
FROM books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 2 - Books by Category

-- COMMAND ----------

SELECT
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category
ORDER BY category;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 3 - Books by Author

-- COMMAND ----------

SELECT
    author,
    COUNT(*) AS total_books
FROM books
GROUP BY author
ORDER BY total_books DESC,
         author;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 4 - Price Statistics

-- COMMAND ----------

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    ROUND(AVG(price),2) AS avg_price
FROM books;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 5 - Browse Data

-- COMMAND ----------

SELECT *
FROM books
ORDER BY book_id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercícios
-- MAGIC
-- MAGIC 1. Execute a carga da tabela books.
-- MAGIC 2. Conte a quantidade de livros.
-- MAGIC 3. Liste os livros por categoria.
-- MAGIC 4. Liste os autores com maior quantidade de livros.
-- MAGIC 5. Calcule preço mínimo, máximo e médio.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

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

-- MAGIC %md
-- MAGIC # 💡 Exemplo 6 - Novo Registro
-- MAGIC
-- MAGIC Após a carga inicial, podemos inserir um novo livro individualmente.

-- COMMAND ----------

INSERT INTO books (book_id, title, author, category, price)
VALUES (
    'B041',
    'Data Engineering with Databricks',
    'Databricks Learning',
    'Databricks',
    89.90
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Validação do novo registro

-- COMMAND ----------

SELECT *
FROM books
WHERE book_id = 'B041';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📌 Resumo
-- MAGIC
-- MAGIC Neste notebook aprendemos a:
-- MAGIC
-- MAGIC - Inserir registros em tabelas Delta.
-- MAGIC - Validar a carga realizada.
-- MAGIC - Explorar os dados utilizando consultas SQL.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio
-- MAGIC
-- MAGIC Adicione um novo livro à tabela **books** utilizando um comando INSERT.
-- MAGIC
-- MAGIC Depois valide:
-- MAGIC
-- MAGIC - Quantidade total de livros.
-- MAGIC - Categoria do novo livro.
-- MAGIC - Estatísticas de preço.
