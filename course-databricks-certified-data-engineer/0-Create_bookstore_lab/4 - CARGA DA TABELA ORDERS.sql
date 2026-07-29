-- =============================================================================
-- PARTE 4
-- CARGA DA TABELA ORDERS
-- =============================================================================

INSERT INTO orders VALUES
(
'O0001',
'C001',
TIMESTAMP '2024-01-10 09:10:00',
DATE '2024-01-10',
2,
129.80,
'DELIVERED',

array(

named_struct(
'book_id','B001',
'quantity',1,
'unit_price',59.90,
'discount',0.00,
'subtotal',59.90
),

named_struct(
'book_id','B010',
'quantity',1,
'unit_price',69.90,
'discount',0.00,
'subtotal',69.90
)

)
),

(
'O0002',
'C002',
TIMESTAMP '2024-01-11 10:15:00',
DATE '2024-01-11',
1,
99.90,
'DELIVERED',

array(

named_struct(
'book_id','B005',
'quantity',1,
'unit_price',99.90,
'discount',0.00,
'subtotal',99.90
)

)
),

(
'O0003',
'C003',
TIMESTAMP '2024-01-12 11:00:00',
DATE '2024-01-12',
3,
204.70,
'PROCESSING',

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
'O0004',
'C004',
TIMESTAMP '2024-01-13 08:40:00',
DATE '2024-01-13',
2,
171.80,
'SHIPPED',

array(

named_struct(
'book_id','B018',
'quantity',1,
'unit_price',119.90,
'discount',10.00,
'subtotal',109.90
),

named_struct(
'book_id','B016',
'quantity',1,
'unit_price',61.90,
'discount',0.00,
'subtotal',61.90
)

)
),

(
'O0005',
'C005',
TIMESTAMP '2024-01-15 14:00:00',
DATE '2024-01-15',
4,
282.60,
'DELIVERED',

array(

named_struct(
'book_id','B020',
'quantity',1,
'unit_price',82.90,
'discount',0.00,
'subtotal',82.90
),

named_struct(
'book_id','B021',
'quantity',1,
'unit_price',68.90,
'discount',0.00,
'subtotal',68.90
),

named_struct(
'book_id','B022',
'quantity',1,
'unit_price',66.90,
'discount',0.00,
'subtotal',66.90
),

named_struct(
'book_id','B037',
'quantity',1,
'unit_price',69.90,
'discount',5.00,
'subtotal',64.90
)

)
),

(
'O0006',
'C006',
TIMESTAMP '2024-01-16 13:15:00',
DATE '2024-01-16',
2,
154.80,
'NEW',

array(

named_struct(
'book_id','B029',
'quantity',1,
'unit_price',86.90,
'discount',10.00,
'subtotal',76.90
),

named_struct(
'book_id','B030',
'quantity',1,
'unit_price',77.90,
'discount',0.00,
'subtotal',77.90
)

)
),

(
'O0007',
'C007',
TIMESTAMP '2024-01-17 09:00:00',
DATE '2024-01-17',
2,
163.80,
'PROCESSING',

array(

named_struct(
'book_id','B024',
'quantity',1,
'unit_price',76.90,
'discount',0.00,
'subtotal',76.90
),

named_struct(
'book_id','B033',
'quantity',1,
'unit_price',86.90,
'discount',0.00,
'subtotal',86.90
)

)
),

(
'O0008',
'C008',
TIMESTAMP '2024-01-18 18:20:00',
DATE '2024-01-18',
1,
104.90,
'DELIVERED',

array(

named_struct(
'book_id','B039',
'quantity',1,
'unit_price',104.90,
'discount',0.00,
'subtotal',104.90
)

)
),

(
'O0009',
'C009',
TIMESTAMP '2024-01-19 12:30:00',
DATE '2024-01-19',
2,
147.80,
'CANCELLED',

array(

named_struct(
'book_id','B026',
'quantity',1,
'unit_price',72.90,
'discount',0.00,
'subtotal',72.90
),

named_struct(
'book_id','B027',
'quantity',1,
'unit_price',74.90,
'discount',0.00,
'subtotal',74.90
)

)
),

(
'O0010',
'C010',
TIMESTAMP '2024-01-20 08:45:00',
DATE '2024-01-20',
3,
239.70,
'SHIPPED',

array(

named_struct(
'book_id','B004',
'quantity',1,
'unit_price',89.90,
'discount',0.00,
'subtotal',89.90
),

named_struct(
'book_id','B006',
'quantity',1,
'unit_price',92.50,
'discount',0.00,
'subtotal',92.50
),

named_struct(
'book_id','B011',
'quantity',1,
'unit_price',57.30,
'discount',0.00,
'subtotal',57.30
)

)
);

-- =============================================================================
-- VALIDAÇÕES
-- =============================================================================

SELECT *
FROM orders;

SELECT
COUNT(*) AS TOTAL_ORDERS
FROM orders;

SELECT
status,
COUNT(*)
FROM orders
GROUP BY status;

SELECT
order_id,
explode(books)
FROM orders;