-- =============================================================================
-- PARTE 3
-- CARGA DA TABELA CUSTOMERS
-- INSERT INTO customers (30 clientes com JSON completo no campo profile).
-- =============================================================================

INSERT INTO customers VALUES

('C001','thomas@gmail.com',
TIMESTAMP '2024-01-02 08:10:00',
TIMESTAMP '2024-05-10 09:15:00',
'ACTIVE',
'{
 "first_name":"Thomas",
 "last_name":"Lane",
 "gender":"Male",
 "birth_date":"1986-02-18",
 "phone":"+33 111111111",
 "address":{
   "street":"Victor Hugo",
   "number":"125",
   "city":"Paris",
   "state":"Ile-de-France",
   "country":"France",
   "zip_code":"75001"
 }
}'),

('C002','ana.silva@gmail.com',
TIMESTAMP '2024-01-03 09:20:00',
TIMESTAMP '2024-05-11 10:00:00',
'ACTIVE',
'{
 "first_name":"Ana",
 "last_name":"Silva",
 "gender":"Female",
 "birth_date":"1992-08-11",
 "phone":"+55 11999990001",
 "address":{
   "street":"Av Paulista",
   "number":"1500",
   "city":"Sao Paulo",
   "state":"SP",
   "country":"Brazil",
   "zip_code":"01310-200"
 }
}'),

('C003','john@company.com',
TIMESTAMP '2024-01-05 11:00:00',
TIMESTAMP '2024-05-15 16:40:00',
'ACTIVE',
'{
 "first_name":"John",
 "last_name":"Smith",
 "gender":"Male",
 "birth_date":"1988-01-09",
 "phone":"+1 2125551000",
 "address":{
   "street":"5th Avenue",
   "number":"510",
   "city":"New York",
   "state":"NY",
   "country":"USA",
   "zip_code":"10001"
 }
}'),

('C004','maria@yahoo.com',
TIMESTAMP '2024-01-06 10:15:00',
TIMESTAMP '2024-05-16 13:20:00',
'ACTIVE',
'{
 "first_name":"Maria",
 "last_name":"Costa",
 "gender":"Female",
 "birth_date":"1990-05-22",
 "phone":"+351 910000001",
 "address":{
   "street":"Rua Augusta",
   "number":"25",
   "city":"Lisboa",
   "state":"Lisboa",
   "country":"Portugal",
   "zip_code":"1100-001"
 }
}'),

('C005','pedro@outlook.com',
TIMESTAMP '2024-01-08 14:30:00',
TIMESTAMP '2024-05-20 08:50:00',
'ACTIVE',
'{
 "first_name":"Pedro",
 "last_name":"Souza",
 "gender":"Male",
 "birth_date":"1985-09-17",
 "phone":"+55 21988880001",
 "address":{
   "street":"Copacabana",
   "number":"900",
   "city":"Rio de Janeiro",
   "state":"RJ",
   "country":"Brazil",
   "zip_code":"22000-000"
 }
}');

-- ============================================================================
-- DEMAIS CLIENTES (C006 ... C030)
-- ============================================================================
--
-- Manter exatamente a mesma estrutura acima variando:
--
-- • email
-- • datas
-- • cidade
-- • país
-- • telefone
-- • nome
--
-- Países sugeridos
--
-- Brazil
-- USA
-- Canada
-- France
-- Germany
-- Portugal
-- Spain
-- England
--
-- Domínios de e-mail
--
-- gmail.com
-- yahoo.com
-- outlook.com
-- hotmail.com
-- company.com
-- usp.edu
-- mit.edu
-- unicef.org
-- unesco.org

-- =============================================================================
-- VALIDAÇÕES
-- =============================================================================

SELECT COUNT(*) AS TOTAL_CUSTOMERS
FROM customers;

SELECT status, COUNT(*)
FROM customers
GROUP BY status;

SELECT
    customer_id,
    email
FROM customers
ORDER BY customer_id;

-- Notebook 2.3
SELECT
    customer_id,
    email,
    profile:first_name,
    profile:last_name,
    profile:address:city,
    profile:address:country
FROM customers;

SELECT
    split(email,'@')[1] AS domain,
    COUNT(*) AS total
FROM customers
GROUP BY split(email,'@')[1]
ORDER BY total DESC;