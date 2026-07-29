-- =============================================================================
-- PARTE 5
-- ORDERS_UPDATES
-- VIEWS
-- VALIDAÇÕES
-- =============================================================================

INSERT INTO orders_updates VALUES

(
'O0003',
'C003',
TIMESTAMP '2024-01-25 10:00:00',
DATE '2024-01-25',
3,
204.70,
'DELIVERED',

array(

named_struct(
'book_id','B002',
'quantity',1,
'unit_price',69.90,
'discount',0.00,
'subtotal',69.90
),

named_struct(
'book_id','B014',
'quantity',1,
'unit_price',65.90,
'discount',0.00,
'subtotal',65.90
),

named_struct(
'book_id','B035',
'quantity',1,
'unit_price',68.90,
'discount',0.00,
'subtotal',68.90
)

)
),

(
'O0011',
'C001',
TIMESTAMP '2024-02-01 09:20:00',
DATE '2024-02-01',
2,
149.80,
'NEW',

array(

named_struct(
'book_id','B003',
'quantity',1,
'unit_price',72.90,
'discount',0.00,
'subtotal',72.90
),

named_struct(
'book_id','B013',
'quantity',1,
'unit_price',76.90,
'discount',0.00,
'subtotal',76.90
)

)
),

(
'O0012',
'C006',
TIMESTAMP '2024-02-03 13:40:00',
DATE '2024-02-03',
1,
109.90,
'NEW',

array(

named_struct(
'book_id','B015',
'quantity',1,
'unit_price',109.90,
'discount',0.00,
'subtotal',109.90
)

)
),

(
'O0013',
'C008',
TIMESTAMP '2024-02-04 17:00:00',
DATE '2024-02-04',
2,
166.80,
'NEW',

array(

named_struct(
'book_id','B020',
'quantity',1,
'unit_price',82.90,
'discount',0.00,
'subtotal',82.90
),

named_struct(
'book_id','B029',
'quantity',1,
'unit_price',83.90,
'discount',0.00,
'subtotal',83.90
)

)
);

-- =============================================================================
-- VIEW CUSTOMER DETAILS
-- =============================================================================

CREATE OR REPLACE VIEW customers_details AS

SELECT

customer_id,

email,

status,

profile:first_name AS first_name,

profile:last_name AS last_name,

profile:gender AS gender,

profile:birth_date AS birth_date,

profile:address:city AS city,

profile:address:state AS state,

profile:address:country AS country

FROM customers;

-- =============================================================================
-- VIEW ORDER ITEMS
-- =============================================================================

CREATE OR REPLACE VIEW order_items AS

SELECT

o.order_id,

o.customer_id,

o.order_timestamp,

o.status,

b.book_id,

b.quantity,

b.unit_price,

b.discount,

b.subtotal

FROM orders o

LATERAL VIEW explode(o.books) t AS b;

-- =============================================================================
-- VIEW CUSTOMER BOOKS
-- =============================================================================

CREATE OR REPLACE VIEW customer_books AS

SELECT

c.customer_id,

c.first_name,

c.last_name,

o.order_id,

i.book_id,

bk.title,

bk.category,

i.quantity,

i.subtotal

FROM customers_details c

JOIN orders o

ON c.customer_id=o.customer_id

JOIN order_items i

ON o.order_id=i.order_id

JOIN books bk

ON i.book_id=bk.book_id;

-- =============================================================================
-- VIEW ORDERS EXPLODED
-- =============================================================================

CREATE OR REPLACE VIEW orders_exploded AS

SELECT

order_id,

customer_id,

explode(books) AS item

FROM orders;

-- =============================================================================
-- VALIDAÇÕES
-- =============================================================================

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM books;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM orders_updates;

SELECT * FROM customers_details;

SELECT * FROM order_items;

SELECT * FROM customer_books;

SELECT * FROM orders_exploded;

-- =============================================================================
-- EXPLODE
-- =============================================================================

SELECT

order_id,

explode(books)

FROM orders;

-- =============================================================================
-- TRANSFORM
-- =============================================================================

SELECT

order_id,

transform(

books,

x -> x.book_id

) AS books_ids

FROM orders;

-- =============================================================================
-- FILTER
-- =============================================================================

SELECT

order_id,

filter(

books,

x -> x.quantity >= 1

)

FROM orders;

-- =============================================================================
-- EXISTS
-- =============================================================================

SELECT

order_id

FROM orders

WHERE exists(

books,

x -> x.discount > 0

);

-- =============================================================================
-- AGGREGATE
-- =============================================================================

SELECT

order_id,

aggregate(

books,

CAST(0 AS DECIMAL(12,2)),

(acc,x) -> acc + x.subtotal

) AS total

FROM orders;

-- =============================================================================
-- SIZE
-- =============================================================================

SELECT

order_id,

size(books)

FROM orders;

-- =============================================================================
-- ARRAYS
-- =============================================================================

SELECT

collect_set(category)

FROM books;

-- =============================================================================
-- RESUMO FINAL
-- =============================================================================

SELECT

(SELECT COUNT(*) FROM customers) customers,

(SELECT COUNT(*) FROM books) books,

(SELECT COUNT(*) FROM orders) orders,

(SELECT COUNT(*) FROM orders_updates) updates;

-- =============================================================================
-- FIM DA PARTE 5
-- =============================================================================