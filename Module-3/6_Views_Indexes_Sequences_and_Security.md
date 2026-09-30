# Module 3 — Views, Indexes, Sequences and Security

## 1. What is a View?

A **view** is a virtual table based on a SQL query.

It generally stores the query definition rather than a separate copy of the underlying table data.

## 2. Creating a View

Example:

```sql
CREATE VIEW customer_order_summary AS
SELECT c.customer_id,
       c.name,
       o.order_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;
```

Use the view like a table:

```sql
SELECT *
FROM customer_order_summary;
```

## 3. Why Use Views?

Views can help with:

- simplifying complex queries
- presenting selected information
- controlling which columns users can see
- providing a consistent interface to data
- supporting data security

## 4. Updating a View

Some views can be updated, while others cannot.

Simple views based on one table are more likely to be updatable.

Views involving joins, grouping, aggregate functions or other complex operations may have restrictions.

Always check the rules of the database system being used.

## 5. Table vs View

| Table | View |
|---|---|
| Stores data | Usually stores a query definition |
| Physical database object | Virtual representation of data |
| Can contain rows directly | Gets data from underlying table(s) |
| Used to permanently store records | Often used for abstraction and controlled access |

## 6. Index

An **index** is a database structure that can make searching for rows faster.

Example:

```sql
CREATE INDEX idx_orders_customer
ON orders(customer_id);
```

Indexes are useful on columns that are frequently searched, joined or sorted, but they also have storage and update costs.

## 7. Dropping an Index

Syntax depends on the database system. In Oracle:

```sql
DROP INDEX idx_orders_customer;
```

## 8. Sequences

A sequence generates numeric values, commonly used for identifiers.

Oracle example:

```sql
CREATE SEQUENCE customer_seq
START WITH 1
INCREMENT BY 1;
```

Use it:

```sql
INSERT INTO customers (customer_id, name)
VALUES (customer_seq.NEXTVAL, 'Aarav');
```

Check the next value:

```sql
SELECT customer_seq.NEXTVAL
FROM dual;
```

Sequence syntax differs between database systems.

## 9. Synonyms

A synonym provides an alternative name for a database object.

Oracle example:

```sql
CREATE SYNONYM cust
FOR customers;
```

Then:

```sql
SELECT *
FROM cust;
```

## 10. Data Independence

Data independence means changes at one level of the database should have minimal effect on other levels.

### Physical Data Independence

Changes to physical storage should not require changes to the logical structure.

### Logical Data Independence

Changes to the logical schema should have minimal effect on external views or applications.

## 11. Database Security

Security controls who can access which database objects.

Typical ideas include:

- authentication
- authorization
- roles
- privileges
- views for restricted access
- protecting sensitive information

The exact commands depend on the DBMS.

## 12. Quick Revision

> View → virtual representation  
> Index → faster access/search support  
> Sequence → generates numeric values  
> Synonym → alternate object name  
> Security → controls access  
> Data independence → reduces impact of changes
