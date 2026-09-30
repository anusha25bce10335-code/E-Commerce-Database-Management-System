# Module 3 — Joins, Nested Queries and Set Operators

## 1. Why Do We Need Joins?

Database information is often stored in multiple tables.

For example:

`orders.customer_id` connects to `customers.customer_id`.

A join allows us to retrieve related information from both tables.

## 2. INNER JOIN

Returns matching rows from both tables.

```sql
SELECT c.name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;
```

This shows customers who have matching orders.

## 3. LEFT JOIN

Returns all rows from the left table and matching rows from the right table.

```sql
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
```

This can be used to find customers who have no orders.

```sql
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

## 4. Joining More Than Two Tables

```sql
SELECT c.name, o.order_id, oi.product_id
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
JOIN order_items oi
  ON o.order_id = oi.order_id;
```

## 5. Subqueries / Nested Queries

A subquery is a query inside another query.

Example: products costing more than the average product price.

```sql
SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

The inner query runs to calculate the average, and the outer query uses that result.

## 6. IN with a Subquery

```sql
SELECT name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
```

## 7. EXISTS

`EXISTS` checks whether the subquery returns at least one row.

```sql
SELECT c.name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

## 8. Set Operators

Set operators combine results from two queries.

Common operators:

- `UNION`
- `UNION ALL`
- `INTERSECT`
- `MINUS` (Oracle)

Example:

```sql
SELECT city FROM customers
UNION
SELECT city FROM suppliers;
```

### UNION vs UNION ALL

`UNION` removes duplicate rows.

`UNION ALL` keeps duplicates.

## 9. Important Rule

Queries combined with set operators should have compatible numbers and types of columns.

## 10. Dataset Relationships to Remember

```text
customers
    |
    | customer_id
    v
orders
    |
    | order_id
    v
order_items
    |
    | product_id
    v
products
```

Other important relationships:

```text
products <-> product_supplier <-> suppliers
products -> categories
orders -> payments
orders -> shipments
customers -> reviews
products -> reviews
customers -> cart
products -> cart
```

## 11. Practice Questions

1. Display customer names with their order IDs.
2. Find customers who have never placed an order.
3. Find products costing more than the average price.
4. Find products that have never been ordered.
5. Use `UNION` to combine customer and supplier cities.
