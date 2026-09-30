## 3. Relational Algebra

**Relational algebra** is a set of building-block operations for asking questions from a database.

Each operation takes one or two tables as input and produces a new table as output. Since the output is itself a table, operations can be **chained together**, with one operation feeding into the next to build more complex queries.

This is conceptually what happens when we write SQL queries using clauses such as `WHERE`, `JOIN`, or `GROUP BY`.

---

## 3.1 Selection (σ) — Picking Rows

**Selection** filters rows based on a condition, similar to the `WHERE` clause in SQL.

### Example 1

```text
σ stock_quantity < 10 (products)
```

**Meaning:** Selects every product that is running low on stock.

**Use:** Useful for a **restock alert** feature.

### Example 2

```text
σ order_status = 'Delivered' AND order_date >= '2026-01-01' (orders)
```

**Meaning:** Selects all orders delivered so far in the year 2026.

---

## 3.2 Projection (π) — Picking Columns

**Projection** keeps only the columns we are interested in.

Since a relation cannot contain duplicate rows, repeated rows in the result are automatically removed.

### Example 1

```text
π customer_name, email (customers)
```

**Meaning:** Returns only customer names and email addresses.

**Use:** Useful for customer communication or newsletters.

### Example 2

```text
π category_id (products)
```

**Meaning:** Returns the distinct list of category IDs that currently have at least one product listed.

---

## 3.3 Rename (ρ) — Giving a Table a New Label

The **Rename** operation allows us to give a table or its columns a new name.

It is especially useful when a table needs to be referenced more than once, such as in a **self-join**.

> **Note:** The actual `categories` table does not contain `parent_category_id`, so category hierarchy/self-join is not used in this project.

### Example

```text
ρ P(products)
```

Here, `P` is treated as a renamed reference to the `products` relation.

---

## 3.4 Joins — Combining Tables

A **join** combines rows from two or more tables based on a specified condition.

### Types of Joins

* **Theta Join:** A general join where rows from two tables are combined based on any condition.
* **Equi-Join:** A theta join where the condition specifically uses equality (`=`).
* **Natural Join (⋈):** An equi-join performed automatically using columns that have the same name. Duplicate join columns are removed.
* **Outer Joins:** `LEFT`, `RIGHT`, and `FULL OUTER JOIN` preserve unmatched rows from one or both sides and fill missing values with `NULL`.

### Example 1 — Multiple Table Join

```text
orders ⋈ order_items ⋈ products
```

This chains three tables together to build complete **order-line details**, including:

```text
order_id
customer_id
order_date
order_status
product_id
quantity
unit_price
product_name
category_id
stock_quantity
```

**Use:** Provides the information required for an **order receipt**.

### Example 2 — Product-Supplier Join

```text
products ⋈ product_supplier ⋈ suppliers
```

**Meaning:** Combines products with their associated suppliers through the `product_supplier` bridge table.

**Use:** Useful for viewing **product sourcing and supplier details**.

### Example 3 — Left Outer Join

```text
customers LEFT OUTER JOIN reviews
```

**Meaning:** Returns every customer, including customers who have never written a review.

For customers without reviews, the corresponding `reviews` columns contain `NULL`.

---

## 3.5 Set Operations

The major set operations are:

* **Union (∪)**
* **Intersection (∩)**
* **Set Difference (−)**

These operations work only between **union-compatible relations**.

Two relations are union-compatible when:

1. They have the **same number of columns**.
2. Corresponding columns have compatible **domains**.

### Example 1 — Set Difference

```text
π customer_id (orders) − π customer_id (reviews)
```

**Meaning:** Finds customers who have placed at least one order but have never left a review.

**Use:** Useful for a **"Please review your purchase"** email campaign.

### Example 2 — Products Never Ordered

```text
π product_id (products) − π product_id (order_items)
```

**Meaning:** Finds products that have never been ordered.

**Use:** Useful for identifying **dead stock**.

### Example 3 — Union

```text
π customer_id (σ city = 'Pune' (customers))
∪
π customer_id (σ city = 'Mumbai' (customers))
```

**Meaning:** Finds customers registered in **Pune or Mumbai**.

**Use:** Could be used to target a regional notification or promotion.

---

### Cartesian Product (×)

The **Cartesian product** is another fundamental relational algebra operator.

```text
R × S
```

It pairs **every row of relation R with every row of relation S**.

Although it is rarely useful by itself, the Cartesian product is an important building block for formally defining operations such as **joins and division**.

---

## 3.6 Division (÷) — "For Every" Queries

**Division** is used to answer questions of the form:

> **Find X that is related to every single Y.**

### Example

Suppose we want to find customers who have purchased **every product in a particular category**.

First, define relation `R`:

```text
R = π customer_id, product_id (orders ⋈ order_items)
```

Then define relation `S`:

```text
S = π product_id (σ category_id = 1 (products))
```

Now perform division:

```text
Result = R ÷ S
```

### Meaning

The result contains customers whose set of ordered products covers **every product in category 1**.

In other words:

> Customers who have bought everything in category 1.

### Formal Derivation

The division operation can also be expressed as:

```text
R ÷ S = πX(R) − πX((πX(R) × S) − R)
```

where **X** represents the columns of `R` that are **not present in `S`**.

This derivation is useful because division tests whether we understand the **"for every" logic** rather than simply memorizing the division symbol.

---

## 3.7 Grouping and Aggregation — Extended Relational Algebra

Basic relational algebra does not have built-in operations for functions such as:

* `SUM`
* `COUNT`
* `AVG`
* `MIN`
* `MAX`

**Extended relational algebra** adds the **grouping operator (γ)** to handle grouping and aggregation.

It is the relational algebra equivalent of `GROUP BY` in SQL.

### General Form

```text
γ grouping_columns, aggregate_function (Table)
```

### Example 1 — Revenue by Category

```text
γ category_id; SUM(quantity × unit_price) AS revenue
(order_items ⋈ products)
```

**Meaning:** Calculates the total revenue earned for each category.

**Use:** A dashboard could display revenue generated by each product category.

### Example 2 — Orders per Customer

```text
γ customer_id; COUNT(order_id) AS order_count (orders)
```

**Meaning:** Calculates how many orders each customer has placed.

**Use:** Useful for identifying customers who order frequently.

### Ungrouping

**Ungrouping** is not a separate relational algebra operator.

It simply means moving back from grouped results to detailed data using operations such as:

* Projection
* Joins
* Joining a grouped result back with the original table

For example, a category-revenue result containing only `category_id` can be joined with `categories` to obtain the readable `category_name`.

---

## 3.8 Relational Comparison

Two relations or query results are considered **equal as sets**, regardless of the order in which their rows appear.

Two relations `R` and `S` are equal when:

```text
R = S
```

if and only if:

```text
R ⊆ S
```

and

```text
S ⊆ R
```

Therefore:

```text
R = S  ⇔  R ⊆ S ∧ S ⊆ R
```

### Key Point

Relational algebra treats relations as **unordered sets of rows**.

Therefore:

* The order of rows does not matter.
* A relation cannot contain the same row twice.
* Projection automatically removes duplicate rows.

This is why relational algebra results are treated as **sets rather than ordered lists**.
