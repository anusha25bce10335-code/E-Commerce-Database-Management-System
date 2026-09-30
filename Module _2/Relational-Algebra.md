
## 3. Relational Algebra

**Relational algebra** is a set of building-block operations for asking questions from a database.

Each operation takes one or two tables as input and produces a new table as output. Since the output is itself a table, operations can be **chained together**, with one operation feeding into the next to build more complex queries.

This is conceptually what happens when we write SQL queries using clauses such as `WHERE`, `JOIN`, or `GROUP BY`.

---

## 3.1 Selection (σ) — Picking Rows

**Selection** filters rows based on a condition, similar to the `WHERE` clause in SQL.

### Example 1

```text
σ stock_qty < 10 (Product)
```

**Meaning:** Selects every product that is running low on stock.

**Use:** Useful for a **"restock alert"** feature on the seller dashboard.

### Example 2

```text
σ status = 'DELIVERED' AND order_date >= '2026-01-01' (Orders)
```

**Meaning:** Selects all orders delivered so far in the year 2026.

---

## 3.2 Projection (π) — Picking Columns

**Projection** keeps only the columns we are interested in.

Since a relation cannot contain duplicate rows, repeated rows in the result are automatically removed.

### Example 1

```text
π name, email (Customer)
```

**Meaning:** Returns only customer names and email addresses.

**Use:** Useful for sending a newsletter.

### Example 2

```text
π category_id (Product)
```

**Meaning:** Returns the distinct list of categories that currently have at least one product listed.

---

## 3.3 Rename (ρ) — Giving a Table a New Label

The **Rename** operation allows us to give a table or its columns a new name.

It becomes especially useful when a table needs to be joined with itself.

Our `Category` table is a good example because it refers to itself through `parent_category_id`.

### Example

```text
ρ Sub(Category)
```

Here, `Sub` is treated as a second, independent reference to the `Category` relation.

This allows us to compare a category with its own subcategories.

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
Orders ⋈ OrderItem ⋈ Product
```

This chains three tables together to build complete **order-line details**, including:

```text
order_id
customer_id
order_date
status
total_amount
product_id
quantity
unit_price
name
price
stock_qty
category_id
seller_id
```

**Use:** Provides the information required for an **order receipt**.

### Example 2 — Self-Join

```text
Category ⋈ (category_id = parent_category_id) ρ Sub(Category)
```

This is a **self-join** that pairs every category with its subcategories.

For example:

```text
Footwear
├── Running Shoes
├── Sandals
└── ...
```

### Example 3 — Left Outer Join

```text
Customer LEFT OUTER JOIN Review
```

**Meaning:** Returns every customer, including customers who have never written a review.

For customers without reviews, the corresponding `Review` columns contain `NULL`.

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
π customer_id (Orders) − π customer_id (Review)
```

**Meaning:** Finds customers who have placed at least one order but have never left a review.

**Use:** Useful for a **"Please review your purchase"** email campaign.

### Example 2 — Products Never Ordered

```text
π product_id (Product) − π product_id (OrderItem)
```

**Meaning:** Finds products that have never been ordered.

**Use:** Useful for identifying **dead stock**.

### Example 3 — Union

```text
π customer_id (σ city = 'Pune' (Address))
∪
π customer_id (σ city = 'Mumbai' (Address))
```

**Meaning:** Finds customers who have at least one address in **Pune or Mumbai**.

**Use:** Could be used to target a regional flash-sale notification.

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
R = π customer_id, product_id (Orders ⋈ OrderItem)
```

Then define relation `S`:

```text
S = π product_id (σ category_id = 5 (Product))
```

Now perform division:

```text
Result = R ÷ S
```

### Meaning

The result contains customers whose set of ordered products covers **every product in category 5**.

In other words:

> Customers who have bought everything in category 5.

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
category_id γ SUM(quantity × unit_price) AS revenue
(OrderItem ⋈ Product)
```

**Meaning:** Calculates the total revenue earned by each category.

**Use:** A seller dashboard could display information such as:

```text
Electronics → ₹4,50,000
```

for the selected period.

### Example 2 — Orders per Customer

```text
customer_id γ COUNT(order_id) AS order_count (Orders)
```

**Meaning:** Calculates how many orders each customer has placed.

**Use:** Useful for identifying customers who order frequently, such as potential **VIP customers**.

### Ungrouping

**Ungrouping** is not a separate relational algebra operator.

It simply means moving back from grouped results to the original or detailed data using operations such as:

* Projection
* Joins
* Joining a grouped result back with the original table

For example, a category-revenue result containing only `category_id` can be joined with `Category` to obtain the readable `category_name`.

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
