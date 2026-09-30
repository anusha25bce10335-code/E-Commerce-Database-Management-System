# Module 3 — Relational Database Design

## 1. What is a Relational Database?

A relational database stores data in **tables**. A table contains rows (records) and columns (attributes).

Example from our e-commerce dataset:

- `customers` → customer information
- `products` → product information
- `orders` → customer orders
- `order_items` → products included in each order
- `payments` → payment information
- `shipments` → delivery information

The dataset is a synthetic e-commerce database prepared for DBMS practice.

## 2. Features of the Relational Model

- Data is organized into tables.
- Each row represents one record.
- Each column represents one attribute.
- Tables can be connected using keys.
- SQL is used to create, retrieve and modify data.
- Constraints help maintain data accuracy and integrity.

## 3. Keys

### Primary Key

A primary key uniquely identifies every row.

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);
```

In our dataset, examples include:

- `customers(customer_id)`
- `products(product_id)`
- `orders(order_id)`

### Composite Primary Key

A key can contain more than one column.

```sql
PRIMARY KEY (order_id, product_id)
```

`order_items(order_id, product_id)` is an example of a composite key in the dataset.

### Foreign Key

A foreign key connects one table to another.

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
```

For example, `orders.customer_id` refers to `customers.customer_id`.

## 4. Atomic Domain / Atomic Values

A value is **atomic** when it cannot be meaningfully divided into smaller values for the purpose of the database.

Bad example:

| customer_id | phone_numbers |
|---|---|
| 101 | 9876..., 8765... |

Better design:

| customer_id | phone |
|---|---|
| 101 | 9876... |
| 101 | 8765... |

Atomic values are an important idea behind **First Normal Form (1NF)**.

## 5. NULL Values

`NULL` means that a value is missing, unknown or not applicable.

It is different from:

- `0`
- an empty string
- `FALSE`

Example:

```sql
SELECT *
FROM customers
WHERE phone IS NULL;
```

Use `IS NULL` or `IS NOT NULL`, not `= NULL`.

## 6. Basic Integrity Constraints

Common constraints are:

- `PRIMARY KEY`
- `FOREIGN KEY`
- `NOT NULL`
- `UNIQUE`
- `CHECK`
- `DEFAULT`

Example:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price >= 0)
);
```

## 7. Quick Revision

**Remember:**

> Table → Rows + Columns → Keys → Relationships → Constraints

The dataset contains separate tables such as `order_items` and `product_supplier`, which also provide material for normalization and relationship practice.
