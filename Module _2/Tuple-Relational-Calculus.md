## 4. Tuple Relational Calculus (TRC)

**Tuple Relational Calculus (TRC)** is a **declarative** query language used to describe what data we want rather than how to retrieve it.

This is different from **Relational Algebra**, which is procedural and describes the sequence of operations needed to obtain the result.

### Relational Algebra vs. TRC

* **Relational Algebra:** Procedural — tells the database **how to compute** the answer step by step.
* **Tuple Relational Calculus:** Declarative — describes **what the answer should look like**, while the system determines how to obtain it.

A TRC query generally has the form:

```text id="i4n4f5"
{ t | P(t) }
```

It is read as:

> **"The set of all tuples `t` such that condition `P(t)` is true."**

TRC uses logical quantifiers such as:

* **∃ (there exists):** At least one tuple satisfies the condition.
* **∀ (for all):** Every tuple satisfies the condition.

These quantifiers allow us to express relationships such as **joins** and **"for every" conditions** without explicitly specifying the sequence of operations.

---

## 4.1 Example 1 — Orders Above ₹5000

```text id="7d5v3z"
{ t | ∃ c ∈ Customer
    (c.customer_id = t.customer_id
    ∧ t ∈ Orders
    ∧ t.total_amount > 5000)
}
```

### Meaning

Returns all orders having a **total amount greater than ₹5000**.

The query is expressed declaratively without specifying how the database should perform the retrieval.

### Equivalent Relational Algebra

```text id="8qv2yt"
σ total_amount > 5000 (Orders)
```

---

## 4.2 Example 2 — Bulk/Wholesale Purchases

```text id="p0t3h6"
{ p.name | p ∈ Product
    ∧ ∃ o ∈ OrderItem
    (o.product_id = p.product_id
    ∧ o.quantity > 100)
}
```

### Meaning

Returns the **names of products** that have been ordered in a single order line with a quantity greater than **100 units**.

This could represent a **bulk or wholesale purchase**.

---

## 4.3 Example 3 — Customers Who Bought Every Product in Category 5

```text id="k6w4pz"
{ c | c ∈ Customer
    ∧ ∀ p ∈ (σ category_id = 5 (Product))
    ∃ o ∈ OrderItem
    (... p.product_id = o.product_id ...)
}
```

### Meaning

Returns customers who have purchased **every product belonging to category 5**.

The important part is the use of the universal quantifier:

```text
∀
```

which means **"for every"**.

This is the TRC equivalent of the **division operation (÷)** discussed in Section 3.6.

### Conceptual Flow

```text
Category 5 Products
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

## 4.4 Relational Algebra and TRC — Expressive Power

**Relational Algebra** and **safe Tuple Relational Calculus** have the **same expressive power**.

This means that any query that can be expressed using relational algebra can also be expressed using safe TRC, and vice versa.

This equivalence is an important concept behind the term:

> **Relationally Complete**

### Codd's Theorem

**Codd's theorem** establishes the equivalence between relational algebra and relational calculus in terms of their expressive power.

Therefore, both approaches can express the same class of database queries, even though they use different ways of describing those queries.

### Quick Comparison

| Feature                  | Relational Algebra               | Tuple Relational Calculus                   |
| ------------------------ | -------------------------------- | ------------------------------------------- |
| Approach                 | Procedural                       | Declarative                                 |
| Focus                    | **How** to obtain data           | **What** data is required                   |
| Basic notation           | `σ`, `π`, `⋈`, `∪`, etc.         | `{t \| P(t)}`                               |
| Uses logical quantifiers | Not primarily                    | `∃`, `∀`                                    |
| Expressive power         | Relationally complete            | Relationally complete                       |
| Example                  | `σ total_amount > 5000 (Orders)` | `{t \| t ∈ Orders ∧ t.total_amount > 5000}` |
