-- =============================================================================
-- PARTE 2
-- CARGA DA TABELA BOOKS
-- INSERT INTO books (40 livros realistas).
-- =============================================================================

INSERT INTO books VALUES
('B001','Learning Spark','Jules Damji','Spark','EN','O''Reilly',DATE '2024-01-10',420,59.90),
('B002','Spark in Action','Jean-Georges Perrin','Spark','EN','Manning',DATE '2023-03-15',520,69.90),
('B003','High Performance Spark','Holden Karau','Spark','EN','O''Reilly',DATE '2023-05-20',390,72.90),
('B004','Spark Definitive Guide','Bill Chambers','Spark','EN','O''Reilly',DATE '2024-02-15',610,89.90),

('B005','Designing Data Intensive Applications','Martin Kleppmann','Data Engineering','EN','O''Reilly',DATE '2022-06-10',616,99.90),
('B006','Fundamentals of Data Engineering','Joe Reis','Data Engineering','EN','O''Reilly',DATE '2023-07-18',470,92.50),
('B007','Data Pipelines Pocket Reference','James Densmore','Data Engineering','EN','O''Reilly',DATE '2022-09-02',280,49.90),
('B008','Streaming Systems','Tyler Akidau','Streaming','EN','O''Reilly',DATE '2021-10-08',530,94.90),

('B009','SQL Cookbook','Anthony Molinaro','SQL','EN','O''Reilly',DATE '2021-04-14',640,84.90),
('B010','Learning SQL','Alan Beaulieu','SQL','EN','O''Reilly',DATE '2023-01-10',420,54.90),
('B011','SQL Queries for Mere Mortals','John Viescas','SQL','EN','Pearson',DATE '2022-08-12',310,44.90),
('B012','T SQL Fundamentals','Itzik Ben Gan','SQL','EN','Microsoft Press',DATE '2023-09-18',560,79.90),

('B013','Python for Data Analysis','Wes McKinney','Python','EN','O''Reilly',DATE '2024-01-20',580,85.90),
('B014','Effective Python','Brett Slatkin','Python','EN','Pearson',DATE '2022-11-14',390,65.90),
('B015','Fluent Python','Luciano Ramalho','Python','EN','O''Reilly',DATE '2023-12-11',820,109.90),
('B016','Automate the Boring Stuff','Al Sweigart','Python','EN','No Starch',DATE '2021-09-30',590,55.90),

('B017','Machine Learning with Spark','Nick Pentreath','Machine Learning','EN','Packt',DATE '2022-04-01',450,74.90),
('B018','Hands On Machine Learning','Aurelien Geron','Machine Learning','EN','O''Reilly',DATE '2024-03-11',850,119.90),
('B019','Practical Statistics for Data Scientists','Peter Bruce','Machine Learning','EN','O''Reilly',DATE '2023-02-18',380,63.90),

('B020','Azure Databricks Cookbook','Packt','Databricks','EN','Packt',DATE '2024-04-01',520,82.90),
('B021','Databricks Essentials','Packt','Databricks','EN','Packt',DATE '2024-05-10',430,68.90),
('B022','Delta Lake Up and Running','O''Reilly','Delta Lake','EN','O''Reilly',DATE '2024-06-20',310,66.90),

('B023','AWS Data Engineering','Packt','Cloud','EN','Packt',DATE '2023-06-22',450,71.90),
('B024','Google Cloud Data Engineering','Packt','Cloud','EN','Packt',DATE '2024-01-18',510,76.90),
('B025','Azure Data Engineering','Packt','Cloud','EN','Packt',DATE '2023-08-14',470,74.90),

('B026','Kafka The Definitive Guide','Gwen Shapira','Streaming','EN','O''Reilly',DATE '2023-10-01',390,72.90),
('B027','Streaming Data','Andrew Psaltis','Streaming','EN','Manning',DATE '2022-12-11',410,69.90),

('B028','Docker Deep Dive','Nigel Poulton','DevOps','EN','Independently Published',DATE '2023-03-01',340,61.90),
('B029','Kubernetes Up and Running','Brendan Burns','DevOps','EN','O''Reilly',DATE '2024-02-12',480,86.90),
('B030','Terraform Up and Running','Yevgeniy Brikman','DevOps','EN','O''Reilly',DATE '2023-07-04',360,73.90),

('B031','Apache Iceberg The Definitive Guide','Packt','Lakehouse','EN','Packt',DATE '2024-04-12',420,79.90),
('B032','Apache Hudi Essentials','Packt','Lakehouse','EN','Packt',DATE '2023-11-08',390,75.90),

('B033','BigQuery The Definitive Guide','Packt','BigQuery','EN','Packt',DATE '2024-02-01',450,82.90),
('B034','Mastering BigQuery','Packt','BigQuery','EN','Packt',DATE '2023-12-15',510,88.90),

('B035','Git Pocket Guide','Richard Silverman','Git','EN','O''Reilly',DATE '2021-07-17',260,42.90),
('B036','Pro Git','Scott Chacon','Git','EN','Apress',DATE '2022-01-25',490,59.90),

('B037','dbt in Action','Packt','dbt','EN','Packt',DATE '2024-03-22',370,69.90),
('B038','Analytics Engineering','Packt','dbt','EN','Packt',DATE '2023-10-30',430,74.90),

('B039','Data Warehouse Toolkit','Ralph Kimball','Data Warehouse','EN','Wiley',DATE '2022-09-15',640,104.90),
('B040','Building the Data Warehouse','William Inmon','Data Warehouse','EN','Wiley',DATE '2021-05-21',610,101.90);

-- =============================================================================
-- VALIDAÇÕES
-- =============================================================================

SELECT COUNT(*) AS TOTAL_BOOKS
FROM books;

SELECT
    category,
    COUNT(*) AS TOTAL
FROM books
GROUP BY category
ORDER BY category;

SELECT
    author,
    COUNT(*) AS TOTAL_BOOKS
FROM books
GROUP BY author
ORDER BY TOTAL_BOOKS DESC;

SELECT
    MIN(price) AS MIN_PRICE,
    MAX(price) AS MAX_PRICE,
    AVG(price) AS AVG_PRICE
FROM books;

SELECT *
FROM books
ORDER BY title;