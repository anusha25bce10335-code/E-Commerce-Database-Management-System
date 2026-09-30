# Module 3 — Aggregate, Group By and SQL Functions

## 1. Aggregate Functions

Aggregate functions work on multiple rows and return a single result.

Important functions:

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

## 2. COUNT

Count products:

```sql
SELECT COUNT(*)
FROM products;
```

Count non-NULL values in a column:

```sql
SELECT COUNT(category_id)
FROM products;
```

## 3. SUM

```sql
SELECT SUM(price)
FROM products;
```

## 4. AVG

```sql
SELECT AVG(price)
FROM products;
```

## 5. MIN and MAX

```sql
SELECT MIN(price), MAX(price)
FROM products;
```

## 6. GROUP BY

`GROUP BY` creates groups of rows.

Example:

```sql
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id;
```

This counts products in each category.

## 7. HAVING

`HAVING` filters groups after aggregation.

```sql
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;
```

### WHERE vs HAVING

- `WHERE` filters individual rows before grouping.
- `HAVING` filters groups after grouping.

## 8. Aggregate Data Across Multiple Tables

Example:

```sql
SELECT p.category_id, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category_id;
```

## 9. Single-Row Functions

Single-row functions return one result for each input row.

Common categories:

- character functions
- number functions
- date functions
- conversion functions
- conditional expressions

Examples:

```sql
SELECT UPPER(name)
FROM customers;
```

```sql
SELECT LOWER(name)
FROM customers;
```

## 10. Conversion Functions

Conversion functions change a value from one data type to another.

In Oracle, common functions include:

```sql
TO_CHAR()
TO_DATE()
TO_NUMBER()
```

Example:

```sql
SELECT TO_CHAR(order_date, 'DD-MM-YYYY')
FROM orders;
```

Syntax can vary between database systems, so always check the SQL dialect being used in the lab.

## 11. Conditional Expressions

`CASE` can be used to create conditions inside a query.

```sql
SELECT product_name,
       price,
       CASE
           WHEN price < 500 THEN 'Budget'
           WHEN price < 2000 THEN 'Medium'
           ELSE 'Premium'
       END AS price_category
FROM products;
```

## 12. NULL and Aggregate Functions

Most aggregate functions ignore `NULL` values.

For example:

```sql
AVG(price)
```

calculates the average of available non-NULL prices.

## 13. Reporting Query Example

```sql
SELECT category_id,
       COUNT(*) AS number_of_products,
       AVG(price) AS average_price,
       MIN(price) AS minimum_price,
       MAX(price) AS maximum_price
FROM products
GROUP BY category_id
ORDER BY average_price DESC;
```

## 14. Quick Practice

1. Find the total number of products.
2. Find the average product price.
3. Find the highest and lowest product price.
4. Count products in every category.
5. Find categories having more than 3 products.
6. Create a `CASE` expression that labels products as Budget, Medium or Premium.
