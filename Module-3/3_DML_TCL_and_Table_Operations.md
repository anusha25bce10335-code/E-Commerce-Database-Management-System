# Module 3 — DML, TCL and Table Operations

## 1. DML

**DML (Data Manipulation Language)** is used to work with the data stored inside tables.

Main commands:

- `INSERT`
- `UPDATE`
- `DELETE`

## 2. INSERT

Insert one row:

```sql
INSERT INTO customers (customer_id, name, city)
VALUES (101, 'Aarav', 'Delhi');
```

Insert values into selected columns:

```sql
INSERT INTO customers (customer_id, name)
VALUES (102, 'Riya');
```

## 3. UPDATE

Used to modify existing records.

```sql
UPDATE products
SET price = 1500
WHERE product_id = 10;
```

Always be careful with `UPDATE`.

Without a `WHERE` condition:

```sql
UPDATE products
SET price = 1500;
```

the command can modify every row.

## 4. DELETE

Deletes rows.

```sql
DELETE FROM customers
WHERE customer_id = 102;
```

Again, be careful with the `WHERE` clause.

## 5. DML vs DDL

| DML | DDL |
|---|---|
| Works mainly with data | Works with database structure |
| INSERT | CREATE |
| UPDATE | ALTER |
| DELETE | DROP |
|  | TRUNCATE |

## 6. TCL

**TCL (Transaction Control Language)** manages transactions.

Important commands:

- `COMMIT`
- `ROLLBACK`
- `SAVEPOINT`

### COMMIT

Makes the changes permanent.

```sql
COMMIT;
```

### ROLLBACK

Undoes uncommitted changes.

```sql
ROLLBACK;
```

### SAVEPOINT

Creates a point to which we can roll back.

```sql
SAVEPOINT before_update;

UPDATE products
SET price = price + 100
WHERE category_id = 2;

ROLLBACK TO before_update;
```

## 7. Transaction Example

```sql
UPDATE products
SET price = price + 100
WHERE product_id = 5;

SAVEPOINT p1;

DELETE FROM cart
WHERE cart_id = 10;

ROLLBACK TO p1;

COMMIT;
```

After the rollback, the deletion after `p1` is undone, while earlier changes can still be committed.

## 8. Data Dictionary

A **data dictionary** contains metadata — information about database objects.

Depending on the database system, data dictionary views can be used to inspect:

- tables
- columns
- constraints
- indexes
- views
- users and privileges

For example, in Oracle, common views include:

```sql
USER_TABLES
USER_TAB_COLUMNS
USER_CONSTRAINTS
USER_INDEXES
USER_VIEWS
```

## 9. Quick Revision

**DML = change the data**

**DDL = change the structure**

**TCL = control transactions**

A simple memory trick:

> INSERT / UPDATE / DELETE → DML  
> CREATE / ALTER / DROP → DDL  
> COMMIT / ROLLBACK / SAVEPOINT → TCL
