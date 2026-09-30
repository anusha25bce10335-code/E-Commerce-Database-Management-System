/* =====================================================================
   MODULE 3 : SQL                                    FILE 1 of 6
   DDL - Creating the tables of our E-Commerce database
   =====================================================================

   WHAT YOU WILL LEARN
   - DDL (Data Definition Language) = commands that build/change the
     STRUCTURE of the database:  CREATE, ALTER, TRUNCATE, DROP
   - Constraints = rules the data must follow
   - Data dictionary views = tables Oracle keeps about YOUR tables

   HOW TO RUN THE WHOLE MODULE (in this order)
     01 -> 02 -> 03 -> 04 -> 05 -> 06

   QUICK GLOSSARY
   - Primary key (PK)  : uniquely identifies a row (no duplicates, no NULL)
   - Foreign key (FK)  : a column that points to a PK in another table
   - NOT NULL          : the column must have a value
   - UNIQUE            : no two rows can have the same value
   - CHECK             : value must satisfy a condition
   - DEFAULT           : value used when you don't supply one
   - NUMBER(10,2)      : up to 10 digits, 2 of them after the decimal point
   - VARCHAR2(60)      : text of up to 60 characters
   - Atomic domain     : each column holds ONE simple value (e.g. one phone
                         number, not a list of phones) - this is 1NF.
   ===================================================================== */


/* ---------------------------------------------------------------------
   STEP 1: Create PARENT tables first.
   Rule: a table that is pointed to by a foreign key must exist BEFORE
   the table that points to it.
   --------------------------------------------------------------------- */

-- Customers of the shop
CREATE TABLE customers (
    customer_id        NUMBER(5)      CONSTRAINT pk_customers PRIMARY KEY,
    customer_name      VARCHAR2(60)   NOT NULL,
    email              VARCHAR2(80)   NOT NULL CONSTRAINT uq_cust_email UNIQUE,
    phone              VARCHAR2(15),
    city               VARCHAR2(40),
    state              VARCHAR2(40),
    registration_date  DATE
);

-- Product categories (Electronics, Fashion, ...)
CREATE TABLE categories (
    category_id    NUMBER(3)     CONSTRAINT pk_categories PRIMARY KEY,
    category_name  VARCHAR2(50)  NOT NULL CONSTRAINT uq_cat_name UNIQUE
);

-- Suppliers who provide products
CREATE TABLE suppliers (
    supplier_id    NUMBER(4)     CONSTRAINT pk_suppliers PRIMARY KEY,
    supplier_name  VARCHAR2(80)  NOT NULL,
    city           VARCHAR2(40),
    contact_email  VARCHAR2(80)
);


/* ---------------------------------------------------------------------
   STEP 2: Create CHILD tables (they contain foreign keys)
   --------------------------------------------------------------------- */

-- Products.  category_id is a FOREIGN KEY -> every product must belong to
-- a category that really exists.
CREATE TABLE products (
    product_id      NUMBER(5)     CONSTRAINT pk_products PRIMARY KEY,
    product_name    VARCHAR2(80)  NOT NULL,
    category_id     NUMBER(3)     NOT NULL,
    unit_price      NUMBER(10,2)  NOT NULL
                    CONSTRAINT ck_prod_price CHECK (unit_price > 0),      -- price must be positive
    stock_quantity  NUMBER(6)     DEFAULT 0
                    CONSTRAINT ck_prod_stock CHECK (stock_quantity >= 0), -- stock can't go negative
    CONSTRAINT fk_prod_cat FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

-- Many-to-many link: one product can have many suppliers and one supplier
-- can supply many products.  The PK is made of TWO columns (composite key).
CREATE TABLE product_supplier (
    product_id   NUMBER(5),
    supplier_id  NUMBER(4),
    CONSTRAINT pk_prod_sup PRIMARY KEY (product_id, supplier_id),
    CONSTRAINT fk_ps_prod  FOREIGN KEY (product_id)  REFERENCES products(product_id),
    CONSTRAINT fk_ps_sup   FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Orders.  The CHECK limits order_status to the 5 allowed words.
CREATE TABLE orders (
    order_id      NUMBER(6)    CONSTRAINT pk_orders PRIMARY KEY,
    customer_id   NUMBER(5)    NOT NULL,
    order_date    DATE         NOT NULL,
    order_status  VARCHAR2(20) NOT NULL
        CONSTRAINT ck_order_status CHECK (order_status IN
            ('Placed','Confirmed','Shipped','Delivered','Cancelled')),
    CONSTRAINT fk_ord_cust FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Order items = the products inside an order.
-- One order can have many products, so these lines live in their own table
-- (this is what 1NF asks for: no repeating groups inside "orders").
CREATE TABLE order_items (
    order_id    NUMBER(6),
    product_id  NUMBER(5),
    quantity    NUMBER(4)     NOT NULL CONSTRAINT ck_oi_qty CHECK (quantity > 0),
    unit_price  NUMBER(10,2)  NOT NULL,   -- price at the time of buying
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_oi_order    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    CONSTRAINT fk_oi_product  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments made for orders
CREATE TABLE payments (
    payment_id      NUMBER(6)     CONSTRAINT pk_payments PRIMARY KEY,
    order_id        NUMBER(6)     NOT NULL,
    payment_method  VARCHAR2(30)  NOT NULL,
    amount          NUMBER(10,2)  NOT NULL,
    payment_status  VARCHAR2(15)  NOT NULL
        CONSTRAINT ck_pay_status CHECK (payment_status IN ('Paid','Pending')),
    CONSTRAINT fk_pay_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Shipments.  delivery_date is allowed to be NULL: a parcel that is still
-- "In Transit" has no delivery date yet.  (Good example of a NULL value!)
CREATE TABLE shipments (
    shipment_id      NUMBER(6)    CONSTRAINT pk_shipments PRIMARY KEY,
    order_id         NUMBER(6)    NOT NULL,
    courier          VARCHAR2(30),
    shipment_status  VARCHAR2(20),
    shipping_date    DATE,
    delivery_date    DATE,
    CONSTRAINT fk_ship_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Reviews: rating must be between 1 and 5
CREATE TABLE reviews (
    review_id    NUMBER(6)     CONSTRAINT pk_reviews PRIMARY KEY,
    customer_id  NUMBER(5)     NOT NULL,
    product_id   NUMBER(5)     NOT NULL,
    rating       NUMBER(1)     CONSTRAINT ck_rating CHECK (rating BETWEEN 1 AND 5),
    review_text  VARCHAR2(200),
    CONSTRAINT fk_rev_cust FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_rev_prod FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

-- Shopping cart.  DEFAULT 1 -> if no quantity is given, assume 1.
CREATE TABLE cart (
    cart_id      NUMBER(6)  CONSTRAINT pk_cart PRIMARY KEY,
    customer_id  NUMBER(5)  NOT NULL,
    product_id   NUMBER(5)  NOT NULL,
    quantity     NUMBER(4)  DEFAULT 1 NOT NULL,
    CONSTRAINT fk_cart_cust FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_cart_prod FOREIGN KEY (product_id)  REFERENCES products(product_id)
);


/* ---------------------------------------------------------------------
   STEP 3: ALTER TABLE - changing a table AFTER it was created
   (we add a column, change it, rename it, and drop it again so your
    tables end up exactly as they were)
   --------------------------------------------------------------------- */

-- Add a new column
ALTER TABLE customers ADD (loyalty_points NUMBER(6) DEFAULT 0);

-- Make the phone column wider
ALTER TABLE customers MODIFY (phone VARCHAR2(20));

-- Rename a column
ALTER TABLE customers RENAME COLUMN loyalty_points TO reward_points;

-- Remove the column again
ALTER TABLE customers DROP COLUMN reward_points;

-- Temporarily switch a rule off and on
ALTER TABLE products DISABLE CONSTRAINT ck_prod_stock;
ALTER TABLE products ENABLE  CONSTRAINT ck_prod_stock;


/* ---------------------------------------------------------------------
   STEP 4: DATA DICTIONARY VIEWS
   Oracle stores information ABOUT your database in special read-only
   views.  Names starting with USER_ show things YOU own.
   Note: Oracle stores names in UPPERCASE, so write 'PRODUCTS' not 'products'.
   --------------------------------------------------------------------- */

-- 1) Which tables do I have?
SELECT table_name FROM user_tables ORDER BY table_name;

-- 2) What columns does PRODUCTS have, and what are their data types?
SELECT column_name, data_type, data_length, nullable
FROM   user_tab_columns
WHERE  table_name = 'PRODUCTS'
ORDER  BY column_id;

-- 3) Which constraints exist?  (P = primary key, R = foreign key,
--    U = unique, C = check / not null)
SELECT constraint_name, constraint_type, table_name
FROM   user_constraints
WHERE  table_name IN ('ORDERS','ORDER_ITEMS','PRODUCTS')
ORDER  BY table_name, constraint_type;

-- 4) Which columns does a constraint cover?
SELECT constraint_name, table_name, column_name
FROM   user_cons_columns
WHERE  table_name = 'ORDER_ITEMS';


/* ---------------------------------------------------------------------
   STEP 5: DROP vs TRUNCATE vs DELETE  (very common viva question!)
   - DELETE   : removes rows, can be rolled back, table stays   (DML)
   - TRUNCATE : removes ALL rows quickly, cannot be rolled back (DDL)
   - DROP     : removes the whole table (structure + data)      (DDL)
   Try them on a safe practice copy, never on the real table:
   --------------------------------------------------------------------- */
CREATE TABLE cart_backup AS SELECT * FROM cart;   -- make a copy
TRUNCATE TABLE cart_backup;                       -- empty the copy
DROP TABLE cart_backup;                           -- delete the copy
