-- Databricks notebook source


-- COMMAND ----------

-- MAGIC %md
-- MAGIC # BookStore Lab
-- MAGIC ## 03 - Load Customers

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📖 Introdução
-- MAGIC
-- MAGIC Neste notebook realizaremos a carga inicial da tabela **customers**.
-- MAGIC
-- MAGIC Os clientes cadastrados serão utilizados durante todo o laboratório para simular pedidos, consultas, views e análises.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🎯 Objetivo
-- MAGIC
-- MAGIC Ao concluir este notebook você será capaz de:
-- MAGIC
-- MAGIC - Inserir registros em uma tabela Delta
-- MAGIC - Trabalhar com dados estruturados em JSON
-- MAGIC - Validar a carga realizada
-- MAGIC - Explorar os dados dos clientes

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧠 Conceito
-- MAGIC
-- MAGIC Após criar a estrutura das tabelas, o próximo passo é carregar os clientes.
-- MAGIC
-- MAGIC A coluna **profile** armazena informações em formato JSON, permitindo representar dados complexos em uma única coluna.

-- COMMAND ----------

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS bookstore_lab;

USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📝 Sintaxe
-- MAGIC
-- MAGIC ```sql
-- MAGIC INSERT INTO customers
-- MAGIC VALUES (...);
-- MAGIC ```

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 1 - Load Customers
-- MAGIC
-- MAGIC Carga inicial da tabela de clientes.

-- COMMAND ----------

USE CATALOG workspace;
USE SCHEMA bookstore_lab;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC REFRESH TABLE customers;
-- MAGIC
-- MAGIC [NOT_SUPPORTED_WITH_SERVERLESS] REFRESH TABLE is not supported on serverless compute. SQLSTATE: 0A000

-- COMMAND ----------

describe customers

-- COMMAND ----------

REFRESH TABLE customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC apos inserir 2 vezes, delete e insert novamente
-- MAGIC -- delete from customers

-- COMMAND ----------

INSERT INTO customers
(customer_id, email, created, updated, status, profile)
VALUES

('C001','thomas@gmail.com',
TIMESTAMP '2024-01-02 08:10:00',
TIMESTAMP '2024-05-10 09:15:00',
'ACTIVE',
'{"first_name":"Thomas","last_name":"Lane","gender":"Male","birth_date":"1986-02-18","phone":"+33 111111111","address":{"street":"Victor Hugo","number":"125","city":"Paris","state":"Ile-de-France","country":"France","zip_code":"75001"}}'),

('C002','ana.silva@gmail.com',
TIMESTAMP '2024-01-03 09:20:00',
TIMESTAMP '2024-05-11 10:00:00',
'ACTIVE',
'{"first_name":"Ana","last_name":"Silva","gender":"Female","birth_date":"1992-08-11","phone":"+55 11999990001","address":{"street":"Av Paulista","number":"1500","city":"Sao Paulo","state":"SP","country":"Brazil","zip_code":"01310-200"}}'),

('C003','john@company.com',
TIMESTAMP '2024-01-05 11:00:00',
TIMESTAMP '2024-05-15 16:40:00',
'ACTIVE',
'{"first_name":"John","last_name":"Smith","gender":"Male","birth_date":"1988-01-09","phone":"+1 2125551000","address":{"street":"5th Avenue","number":"510","city":"New York","state":"NY","country":"USA","zip_code":"10001"}}'),

('C004','maria@yahoo.com',
TIMESTAMP '2024-01-06 10:15:00',
TIMESTAMP '2024-05-16 13:20:00',
'ACTIVE',
'{"first_name":"Maria","last_name":"Costa","gender":"Female","birth_date":"1990-05-22","phone":"+351 910000001","address":{"street":"Rua Augusta","number":"25","city":"Lisboa","state":"Lisboa","country":"Portugal","zip_code":"1100-001"}}'),

('C005','pedro@outlook.com',
TIMESTAMP '2024-01-08 14:30:00',
TIMESTAMP '2024-05-20 08:50:00',
'ACTIVE',
'{"first_name":"Pedro","last_name":"Souza","gender":"Male","birth_date":"1985-09-17","phone":"+55 21988880001","address":{"street":"Copacabana","number":"900","city":"Rio de Janeiro","state":"RJ","country":"Brazil","zip_code":"22000-000"}}'),

('C006','lucas@gmail.com',
TIMESTAMP '2024-01-10 09:10:00',
TIMESTAMP '2024-05-21 11:30:00',
'ACTIVE',
'{"first_name":"Lucas","last_name":"Mendes","gender":"Male","birth_date":"1991-03-12","phone":"+55 48999990002","address":{"street":"Rua das Palmeiras","number":"120","city":"Florianopolis","state":"SC","country":"Brazil","zip_code":"88000-100"}}'),

('C007','sophia@yahoo.com',
TIMESTAMP '2024-01-12 15:20:00',
TIMESTAMP '2024-05-22 14:10:00',
'ACTIVE',
'{"first_name":"Sophia","last_name":"Brown","gender":"Female","birth_date":"1989-07-25","phone":"+1 4165551003","address":{"street":"Queen Street","number":"80","city":"Toronto","state":"ON","country":"Canada","zip_code":"M5H-001"}}'),

('C008','carlos@outlook.com',
TIMESTAMP '2024-01-14 08:45:00',
TIMESTAMP '2024-05-23 09:40:00',
'ACTIVE',
'{"first_name":"Carlos","last_name":"Garcia","gender":"Male","birth_date":"1987-11-03","phone":"+34 910000004","address":{"street":"Gran Via","number":"45","city":"Madrid","state":"Madrid","country":"Spain","zip_code":"28013"}}'),

('C009','emma@hotmail.com',
TIMESTAMP '2024-01-16 13:25:00',
TIMESTAMP '2024-05-24 16:20:00',
'ACTIVE',
'{"first_name":"Emma","last_name":"Wilson","gender":"Female","birth_date":"1993-02-14","phone":"+44 207000005","address":{"street":"Baker Street","number":"221","city":"London","state":"England","country":"England","zip_code":"NW1-001"}}'),

('C010','robert@company.com',
TIMESTAMP '2024-01-18 10:05:00',
TIMESTAMP '2024-05-25 12:15:00',
'ACTIVE',
'{"first_name":"Robert","last_name":"Miller","gender":"Male","birth_date":"1982-06-30","phone":"+1 6175551006","address":{"street":"Beacon Street","number":"40","city":"Boston","state":"MA","country":"USA","zip_code":"02108"}}'),

('C011','juliana@gmail.com',
TIMESTAMP '2024-01-20 09:35:00',
TIMESTAMP '2024-05-26 10:50:00',
'ACTIVE',
'{"first_name":"Juliana","last_name":"Oliveira","gender":"Female","birth_date":"1995-04-19","phone":"+55 1133330007","address":{"street":"Rua Oscar Freire","number":"300","city":"Sao Paulo","state":"SP","country":"Brazil","zip_code":"01426-000"}}'),

('C012','marc@unicef.org',
TIMESTAMP '2024-01-22 16:00:00',
TIMESTAMP '2024-05-27 15:25:00',
'ACTIVE',
'{"first_name":"Marc","last_name":"Dubois","gender":"Male","birth_date":"1984-12-08","phone":"+33 140000008","address":{"street":"Rue de Rivoli","number":"60","city":"Paris","state":"Ile-de-France","country":"France","zip_code":"75004"}}'),

('C013','beatriz@usp.edu',
TIMESTAMP '2024-01-24 11:40:00',
TIMESTAMP '2024-05-28 09:05:00',
'ACTIVE',
'{"first_name":"Beatriz","last_name":"Lima","gender":"Female","birth_date":"1991-10-27","phone":"+55 1133330009","address":{"street":"Rua Consolacao","number":"700","city":"Sao Paulo","state":"SP","country":"Brazil","zip_code":"01302-000"}}'),

('C014','daniel@gmail.com',
TIMESTAMP '2024-01-26 08:25:00',
TIMESTAMP '2024-05-29 13:30:00',
'ACTIVE',
'{"first_name":"Daniel","last_name":"Johnson","gender":"Male","birth_date":"1986-08-16","phone":"+1 3055551010","address":{"street":"Ocean Drive","number":"100","city":"Miami","state":"FL","country":"USA","zip_code":"33139"}}'),

('C015','claire@yahoo.com',
TIMESTAMP '2024-01-28 14:15:00',
TIMESTAMP '2024-05-30 11:45:00',
'ACTIVE',
'{"first_name":"Claire","last_name":"Martin","gender":"Female","birth_date":"1990-01-21","phone":"+33 160000011","address":{"street":"Rue Lafayette","number":"18","city":"Paris","state":"Ile-de-France","country":"France","zip_code":"75009"}}'),

('C016','henrique@outlook.com',
TIMESTAMP '2024-01-30 10:50:00',
TIMESTAMP '2024-05-31 16:10:00',
'ACTIVE',
'{"first_name":"Henrique","last_name":"Alves","gender":"Male","birth_date":"1988-09-05","phone":"+55 4833330012","address":{"street":"Rua Bocaiuva","number":"450","city":"Florianopolis","state":"SC","country":"Brazil","zip_code":"88015-530"}}'),

('C017','olivia@hotmail.com',
TIMESTAMP '2024-02-01 09:05:00',
TIMESTAMP '2024-06-01 10:20:00',
'ACTIVE',
'{"first_name":"Olivia","last_name":"Taylor","gender":"Female","birth_date":"1994-06-11","phone":"+44 2070000013","address":{"street":"Oxford Street","number":"150","city":"London","state":"England","country":"England","zip_code":"W1-001"}}'),

('C018','peter@company.com',
TIMESTAMP '2024-02-03 12:35:00',
TIMESTAMP '2024-06-02 14:40:00',
'ACTIVE',
'{"first_name":"Peter","last_name":"Anderson","gender":"Male","birth_date":"1983-03-29","phone":"+1 2125551014","address":{"street":"Madison Avenue","number":"300","city":"New York","state":"NY","country":"USA","zip_code":"10017"}}'),

('C019','camila@gmail.com',
TIMESTAMP '2024-02-05 15:10:00',
TIMESTAMP '2024-06-03 09:55:00',
'ACTIVE',
'{"first_name":"Camila","last_name":"Rossi","gender":"Female","birth_date":"1992-11-18","phone":"+55 2133330015","address":{"street":"Ipanema","number":"500","city":"Rio de Janeiro","state":"RJ","country":"Brazil","zip_code":"22410-000"}}'),

('C020','frank@mit.edu',
TIMESTAMP '2024-02-07 08:55:00',
TIMESTAMP '2024-06-04 12:05:00',
'ACTIVE',
'{"first_name":"Frank","last_name":"Moore","gender":"Male","birth_date":"1980-05-07","phone":"+1 6175551016","address":{"street":"Massachusetts Avenue","number":"77","city":"Cambridge","state":"MA","country":"USA","zip_code":"02139"}}'),

('C021','ines@yahoo.com',
TIMESTAMP '2024-02-09 13:45:00',
TIMESTAMP '2024-06-05 15:15:00',
'ACTIVE',
'{"first_name":"Ines","last_name":"Santos","gender":"Female","birth_date":"1996-02-23","phone":"+351 910000017","address":{"street":"Rua Santa Catarina","number":"90","city":"Porto","state":"Porto","country":"Portugal","zip_code":"4000-001"}}'),

('C022','george@unicef.org',
TIMESTAMP '2024-02-11 10:30:00',
TIMESTAMP '2024-06-06 11:25:00',
'ACTIVE',
'{"first_name":"George","last_name":"Clark","gender":"Male","birth_date":"1985-07-14","phone":"+44 2070000018","address":{"street":"Fleet Street","number":"30","city":"London","state":"England","country":"England","zip_code":"EC4-001"}}'),

('C023','laura@outlook.com',
TIMESTAMP '2024-02-13 16:20:00',
TIMESTAMP '2024-06-07 13:35:00',
'ACTIVE',
'{"first_name":"Laura","last_name":"Fernandez","gender":"Female","birth_date":"1993-09-09","phone":"+34 910000019","address":{"street":"Calle Mayor","number":"55","city":"Madrid","state":"Madrid","country":"Spain","zip_code":"28013"}}'),

('C024','kevin@gmail.com',
TIMESTAMP '2024-02-15 09:15:00',
TIMESTAMP '2024-06-08 10:45:00',
'ACTIVE',
'{"first_name":"Kevin","last_name":"Wilson","gender":"Male","birth_date":"1989-02-02","phone":"+1 4165551020","address":{"street":"King Street","number":"120","city":"Toronto","state":"ON","country":"Canada","zip_code":"M5V-001"}}'),

('C025','marina@usp.edu',
TIMESTAMP '2024-02-17 11:05:00',
TIMESTAMP '2024-06-09 16:00:00',
'ACTIVE',
'{"first_name":"Marina","last_name":"Barbosa","gender":"Female","birth_date":"1990-12-15","phone":"+55 1133330021","address":{"street":"Rua Haddock Lobo","number":"210","city":"Sao Paulo","state":"SP","country":"Brazil","zip_code":"01414-001"}}'),

('C026','andre@company.com',
TIMESTAMP '2024-02-19 14:40:00',
TIMESTAMP '2024-06-10 09:20:00',
'ACTIVE',
'{"first_name":"Andre","last_name":"Pereira","gender":"Male","birth_date":"1987-04-26","phone":"+55 4833330022","address":{"street":"Rua Felipe Schmidt","number":"180","city":"Florianopolis","state":"SC","country":"Brazil","zip_code":"88010-000"}}'),

('C027','sarah@gmail.com',
TIMESTAMP '2024-02-21 08:35:00',
TIMESTAMP '2024-06-11 12:30:00',
'ACTIVE',
'{"first_name":"Sarah","last_name":"Davis","gender":"Female","birth_date":"1995-08-30","phone":"+1 3055551023","address":{"street":"Brickell Avenue","number":"200","city":"Miami","state":"FL","country":"USA","zip_code":"33131"}}'),

('C028','miguel@yahoo.com',
TIMESTAMP '2024-02-23 12:10:00',
TIMESTAMP '2024-06-12 14:55:00',
'ACTIVE',
'{"first_name":"Miguel","last_name":"Martinez","gender":"Male","birth_date":"1986-10-10","phone":"+34 910000024","address":{"street":"Calle Serrano","number":"90","city":"Madrid","state":"Madrid","country":"Spain","zip_code":"28006"}}'),

('C029','anna@unesco.org',
TIMESTAMP '2024-02-25 15:35:00',
TIMESTAMP '2024-06-13 11:10:00',
'ACTIVE',
'{"first_name":"Anna","last_name":"Schmidt","gender":"Female","birth_date":"1988-03-17","phone":"+49 300000025","address":{"street":"Unter den Linden","number":"40","city":"Berlin","state":"Berlin","country":"Germany","zip_code":"10117"}}'),

('C030','james@outlook.com',
TIMESTAMP '2024-02-27 10:20:00',
TIMESTAMP '2024-06-14 15:40:00',
'ACTIVE',
'{"first_name":"James","last_name":"Harris","gender":"Male","birth_date":"1984-01-28","phone":"+44 2070000026","address":{"street":"Kings Road","number":"75","city":"London","state":"England","country":"England","zip_code":"SW3-001"}}');


-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ▶️ Execução

-- COMMAND ----------

SELECT COUNT(*) AS total_customers
FROM customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 2 - Customers by Status

-- COMMAND ----------

SELECT
    status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY status
ORDER BY status;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 3 - Customers by Country

-- COMMAND ----------

SELECT
    profile:address:country AS country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY profile:address:country
ORDER BY country;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 4 - Customers by City

-- COMMAND ----------

SELECT
    profile:address:city AS city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY profile:address:city
ORDER BY city;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 💡 Exemplo 5 - Browse Customers

-- COMMAND ----------

SELECT
    customer_id,
    email,
    status,
    profile:first_name AS first_name,
    profile:last_name AS last_name
FROM customers
ORDER BY customer_id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🧪 Exercícios
-- MAGIC
-- MAGIC 1. Execute a carga da tabela customers.
-- MAGIC 2. Conte a quantidade de clientes.
-- MAGIC 3. Liste os clientes por status.
-- MAGIC 4. Liste os clientes por país.
-- MAGIC 5. Consulte nome e sobrenome dos clientes.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Solução

-- COMMAND ----------

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT
    status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY status;

SELECT
    profile:address:country AS country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY profile:address:country;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 📌 Resumo
-- MAGIC
-- MAGIC Neste notebook aprendemos a:
-- MAGIC
-- MAGIC - Inserir registros em tabelas Delta.
-- MAGIC - Trabalhar com colunas JSON.
-- MAGIC - Validar a carga dos clientes.
-- MAGIC - Explorar dados utilizando SQL.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio
-- MAGIC
-- MAGIC Adicione um novo cliente à tabela **customers**.
-- MAGIC
-- MAGIC Depois valide:
-- MAGIC
-- MAGIC - Quantidade total de clientes.
-- MAGIC - País do novo cliente.
-- MAGIC - Cidade do novo cliente.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 🚀 Desafio Prático - Novo Cliente
-- MAGIC
-- MAGIC Adicione um novo cliente utilizando um `INSERT` individual.
-- MAGIC

-- COMMAND ----------


INSERT INTO customers
(customer_id, email, created, updated, status, profile)
VALUES
(
    'C031',
    'novo.cliente@gmail.com',
    TIMESTAMP '2024-03-01 09:00:00',
    TIMESTAMP '2024-06-15 10:00:00',
    'ACTIVE',
    '{
      "first_name":"Reginaldo",
      "last_name":"Silva",
      "gender":"Male",
      "birth_date":"1987-06-15",
      "phone":"+55 48999990031",
      "address":{
        "street":"Avenida Beira Mar",
        "number":"1000",
        "city":"Florianopolis",
        "state":"SC",
        "country":"Brazil",
        "zip_code":"88000-000"
      }
    }'
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # ✅ Validação do Novo Cliente

-- COMMAND ----------

SELECT
    customer_id,
    email,
    status,
    profile:first_name AS first_name,
    profile:last_name AS last_name,
    profile:address:city AS city,
    profile:address:country AS country
FROM customers
WHERE customer_id = 'C031';
