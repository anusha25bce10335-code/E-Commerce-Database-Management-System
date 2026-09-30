## 4. Tuple Relational Calculus (TRC)

**Tuple Relational Calculus (TRC)** is a **declarative** query language used to describe what data we want rather than how to retrieve it.

This is different from **Relational Algebra**, which is procedural and describes the sequence of operations needed to obtain the result.

### Relational Algebra vs. TRC

* **Relational Algebra:** Procedural — tells the database **how to compute** the answer step by step.
* **Tuple Relational Calculus:** Declarative — describes **what the answer should look like**, while the system determines how to obtain it.

A TRC query generally has the form:

```text
{ t | P(t) }
```

It is read as:

> **"The set of all tuples `t` such that condition `P(t)` is true."**

TRC uses logical quantifiers such as:

* **∃ (there exists):** At least one tuple satisfies the condition.
* **∀ (for all):** Every tuple satisfies the condition.

These quantifiers allow us to express relationships such as **joins** and **"for every" conditions** without explicitly specifying the sequence of operations.

---

## 4.1 Example 1 — Payments Above ₹5000

The actual `orders` table does not contain a `total_amount` column. The project stores payment amounts in the `payments` table.

```text
{ p | p ∈ payments
    ∧ p.amount > 5000
}
```

### Meaning

Returns all payment tuples having an **amount greater than ₹5000**.

The query is expressed declaratively without specifying how the database should perform the retrieval.

### Equivalent Relational Algebra

```text
σ amount > 5000 (payments)
```

---

## 4.2 Example 2 — Bulk/Wholesale Purchases

```text
{ pr.product_name | pr ∈ products
    ∧ ∃ oi ∈ order_items
    (oi.product_id = pr.product_id
    ∧ oi.quantity > 10)
}
```

### Meaning

Returns the **names of products** that have been ordered in a single order line with a quantity greater than **10 units**.

This could represent a **bulk or wholesale purchase**.

---

## 4.3 Example 3 — Customers Who Bought Every Product in Category 1

```text
{ c.customer_id | c ∈ customers
    ∧ ∀ p ∈ products
    (p.category_id = 1
    → ∃ oi ∈ order_items
    ∃ o ∈ orders
    (o.customer_id = c.customer_id
    ∧ oi.order_id = o.order_id
    ∧ oi.product_id = p.product_id))
}
```

### Meaning

Returns customer IDs of customers who have purchased **every product belonging to category 1**.

The important part is the use of the universal quantifier:

```text
∀
```

which means **"for every"**.

This is the TRC equivalent of the **division operation (÷)** discussed in Section 3.6.

### Conceptual Flow

```text
Category 1 Products
        ↓
Check each product
        ↓
Does customer have an order item for it?
        ↓
      YES → Continue
        ↓
All products satisfied?
        ↓
      YES
        ↓
Return Customer
```

---

## 4.4 Example 4 — Customers Who Gave Low Ratings

```text
{ c.customer_name | c ∈ customers
    ∧ ∃ r ∈ reviews
    (r.customer_id = c.customer_id
    ∧ r.rating ≤ 2)
}
```

### Meaning

Returns the names of customers who have given a **rating of 2 or below**.

This demonstrates how TRC can express relationships between `customers` and `reviews`.

---

## 4.5 Relational Algebra and TRC — Expressive Power

**Relational Algebra** and **safe Tuple Relational Calculus** have the **same expressive power**.

This means that any query that can be expressed using relational algebra can also be expressed using safe TRC, and vice versa.

This equivalence is an important concept behind the term:

> **Relationally Complete**

### Codd's Theorem

**Codd's theorem** establishes the equivalence between relational algebra and relational calculus in terms of their expressive power.

Therefore, both approaches can express the same class of database queries, even though they use different ways of describing those queries.

### Quick Comparison

| Feature                  | Relational Algebra           | Tuple Relational Calculus               |
| ------------------------ | ---------------------------- | --------------------------------------- |
| Approach                 | Procedural                   | Declarative                             |
| Focus                    | **How** to obtain data       | **What** data is required               |
| Basic notation           | `σ`, `π`, `⋈`, `∪`, etc.     | `{t \| P(t)}`                           |
| Uses logical quantifiers | Not primarily                | `∃`, `∀`                                |
| Expressive power         | Relationally complete        | Relationally complete                   |
| Example                  | `σ amount > 5000 (payments)` | `{p \| p ∈ payments ∧ p.amount > 5000}` |
