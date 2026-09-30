# Module 3 — SQL SELECT and Data Retrieval

## 1. What is SQL?

**SQL (Structured Query Language)** is used to work with relational databases.

Major SQL categories include:

- **DDL** — Data Definition Language
- **DML** — Data Manipulation Language
- **DQL** — Data Query Language
- **TCL** — Transaction Control Language

## 2. Basic SELECT

The basic form is:

```sql
SELECT column1, column2
FROM table_name;
```

Example:

```sql
SELECT customer_id, name, city
FROM customers;
```

To retrieve all columns:

```sql
SELECT *
FROM products;
```

## 3. DISTINCT

`DISTINCT` removes duplicate results.

```sql
SELECT DISTINCT city
FROM customers;
```

## 4. Restricting Rows with WHERE

```sql
SELECT *
FROM products
WHERE price > 1000;
```

Common operators:

- `=`
- `<>`
- `>`
- `<`
- `>=`
- `<=`

### Logical Operators

```sql
SELECT *
FROM products
WHERE price > 1000 AND stock > 0;
```

```sql
SELECT *
FROM customers
WHERE city = 'Delhi' OR city = 'Jaipur';
```

```sql
SELECT *
FROM products
WHERE NOT stock = 0;
```

## 5. BETWEEN

```sql
SELECT *
FROM products
WHERE price BETWEEN 500 AND 2000;
```

## 6. IN

```sql
SELECT *
FROM customers
WHERE city IN ('Delhi', 'Jaipur', 'Mumbai');
```

## 7. LIKE

Used for pattern matching.

```sql
SELECT *
FROM products
WHERE product_name LIKE 'S%';
```

`S%` means the value starts with S.

```sql
SELECT *
FROM products
WHERE product_name LIKE '%phone%';
```

## 8. Sorting with ORDER BY

Ascending:

```sql
SELECT *
FROM products
ORDER BY price ASC;
```

Descending:

```sql
SELECT *
FROM products
ORDER BY price DESC;
```

Multiple columns can also be used:

```sql
SELECT *
FROM customers
ORDER BY city ASC, name ASC;
```

## 9. Column Aliases

An alias gives a temporary name to a column.

```sql
SELECT product_name AS Product,
       price AS Price
FROM products;
```

## 10. DDL Basics

DDL changes the structure of database objects.

```sql
CREATE TABLE test (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
```

Other important DDL commands:

```sql
ALTER TABLE test ADD email VARCHAR(100);

DROP TABLE test;

TRUNCATE TABLE test;
```

## 11. Quick Practice

1. Display all products.
2. Display products costing more than 1000.
3. Display customers from a particular city.
4. Display products from highest to lowest price.
5. Display unique customer cities.
6. Display products whose names start with `A`.
