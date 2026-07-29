-- =============================================================================
-- PROJECT.......: BookStore Lab
-- FILE..........: 00_create_bookstore_lab.sql
-- VERSION.......: 2.0
-- AUTHOR........: Reginaldo + ChatGPT
--
-- DESCRIPTION
-- -----------------------------------------------------------------------------
-- Laboratório independente baseado no curso
-- Databricks Certified Data Engineer Associate.
--
-- Objetivos
-- -----------------------------------------------------------------------------
-- * SQL
-- * Spark SQL
-- * Delta Lake
-- * PySpark
-- * Streaming
-- * Auto Loader
-- * Higher Order Functions
-- * Window Functions
-- * MERGE
-- * Time Travel
-- * OPTIMIZE
-- * VACUUM
--
-- Compatível com os notebooks:
--
-- 2.1 Querying Files
-- 2.2 Writing to Tables
-- 2.3 Advanced Transformations
-- 2.4 Higher Order Functions
-- 2.5 Data Transformations with PySpark
-- 3.1 Structured Streaming
-- 3.2 Auto Loader
-- 3.3 Multi-Hop Architecture
--
-- =============================================================================
-- CONFIGURAÇÕES
-- =============================================================================

USE CATALOG workspace;

CREATE SCHEMA IF NOT EXISTS default;

USE SCHEMA default;

-- =============================================================================
-- LIMPEZA DO AMBIENTE
-- =============================================================================

DROP VIEW IF EXISTS customers_details;

DROP VIEW IF EXISTS orders_exploded;

DROP VIEW IF EXISTS customer_books;

DROP VIEW IF EXISTS order_items;

DROP TABLE IF EXISTS orders_updates;

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS books;

DROP TABLE IF EXISTS customers;

-- =============================================================================
-- CUSTOMERS
-- =============================================================================

CREATE TABLE customers
(
    customer_id            STRING,
    email                  STRING,

    created                TIMESTAMP,

    updated                TIMESTAMP,

    status                 STRING,

    profile                STRING

)
USING DELTA;

COMMENT ON TABLE customers IS
'Customers used in the BookStore Lab';

-- =============================================================================
-- BOOKS
-- =============================================================================

CREATE TABLE books
(
    book_id                STRING,

    title                  STRING,

    author                 STRING,

    category               STRING,

    language               STRING,

    publisher              STRING,

    publish_date           DATE,

    pages                  INT,

    price                  DECIMAL(10,2)

)
USING DELTA;

COMMENT ON TABLE books IS
'Books available in the BookStore Lab';

-- =============================================================================
-- ORDERS
-- =============================================================================

CREATE TABLE orders
(
    order_id               STRING,

    customer_id            STRING,

    order_timestamp        TIMESTAMP,

    order_date             DATE,

    quantity               INT,

    order_total            DECIMAL(12,2),

    status                 STRING,

    books ARRAY
    <
        STRUCT
        <
            book_id:STRING,

            quantity:INT,

            unit_price:DECIMAL(10,2),

            discount:DECIMAL(10,2),

            subtotal:DECIMAL(10,2)
        >
    >

)
USING DELTA;

COMMENT ON TABLE orders IS
'Customer orders';

-- =============================================================================
-- ORDERS UPDATES
-- =============================================================================

CREATE TABLE orders_updates
(
    order_id               STRING,

    customer_id            STRING,

    order_timestamp        TIMESTAMP,

    order_date             DATE,

    quantity               INT,

    order_total            DECIMAL(12,2),

    status                 STRING,

    books ARRAY
    <
        STRUCT
        <
            book_id:STRING,

            quantity:INT,

            unit_price:DECIMAL(10,2),

            discount:DECIMAL(10,2),

            subtotal:DECIMAL(10,2)
        >
    >

)
USING DELTA;

COMMENT ON TABLE orders_updates IS
'Incremental updates used for MERGE examples';

-- =============================================================================
-- VALIDAÇÃO DA ESTRUTURA
-- =============================================================================

SHOW TABLES;

DESCRIBE customers;

DESCRIBE books;

DESCRIBE orders;

DESCRIBE orders_updates;

DESCRIBE DETAIL customers;

DESCRIBE DETAIL books;

DESCRIBE DETAIL orders;

DESCRIBE DETAIL orders_updates;

-- =============================================================================
-- ESTATÍSTICAS
-- =============================================================================

SELECT
    current_catalog() AS catalog_name,
    current_schema()  AS schema_name;

-- =============================================================================
-- FIM DA PARTE 1
-- =============================================================================