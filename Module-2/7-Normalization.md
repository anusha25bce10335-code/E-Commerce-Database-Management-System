## 7. Normalization

Rather than simply stating the rules, this section demonstrates **normalization step by step**.

We begin with a single messy, unnormalized order table and progressively clean it until it reaches **Fourth Normal Form (4NF)**, as required by the project plan.

---

## 7.0 Starting Point — Unnormalized Table (UNF)

Imagine that instead of a proper database, someone logged every order into a single flat spreadsheet with **one row per order**.

The products are stored sideways in **repeating groups of columns**:

```text id="y2f4jz"
FlatOrder(
    order_id,
    customer_name,
    city,
    product_name_1,
    qty_1,
    price_1,
    product_name_2,
    qty_2,
    price_2
)
```

### Problem

This table violates **1NF** because:

* The `(product, quantity, price)` group is repeated.
* The number of columns required changes depending on how many products are present in an order.
* The structure is therefore not flexible and does not properly represent atomic order-line data.

---

## 7.1 First Normal Form (1NF)

### Rule

A relation is in **1NF** when:

* Every column contains a **single, atomic value**.
* There are **no repeating groups of columns**.

### Fix

Move the repeating `(product, quantity, price)` group into a separate table with **one row per order line**.

This is exactly the concept represented by the `order_items` table in our project.

### Result

```text id="j4lq4v"
orders_1NF(
    order_id,
    customer_name,
    city
)
```

```text id="r7o1ht"
order_items_1NF(
    order_id,
    product_id,
    quantity,
    unit_price
)
```

**Composite Key:** `(order_id, product_id)`

### Resulting Structure

```text id="jq8vkv"
orders
  │
  └── order_items
        ├── product_id
        ├── quantity
        └── unit_price
```

The actual project uses `product_id` rather than repeating the product name in every order line.

---

## 7.2 Second Normal Form (2NF)

### Rule

A relation must:

1. Already satisfy **1NF**.
2. Have every non-key attribute depend on the **whole composite key**.
3. Have no **partial dependency**.

### Problem

In:

```text id="f6w9ae"
order_items_1NF(
    order_id,
    product_id,
    quantity,
    unit_price
)
```

the key is:

```text id="k7j4z1"
(order_id, product_id)
```

Transactional `quantity` and `unit_price` belong to a particular order-product combination.

However, product-level information such as:

```text
product_id → product_name
product_id → category_id
```

depends only on `product_id`, not on the complete composite key.

If product information were stored repeatedly inside `order_items`, it would create **partial dependency and redundancy**.

### Fix

Move product-level information into the separate `products` relation.

```text id="9z2p1v"
products(
    product_id PK,
    product_name,
    category_id FK,
    unit_price,
    stock_quantity
)
```

```text id="8qv7tj"
order_items(
    order_id FK,
    product_id FK,
    quantity,
    unit_price
)
```

### Important Design Decision

`order_items.unit_price` remains inside `order_items`.

This is because it represents the **actual price charged for that particular order line**.

For example, a product may have a current catalog price while an earlier order was placed at a different price.

Therefore:

```text id="5e9h7c"
products.unit_price
```

and

```text id="7h1p3m"
order_items.unit_price
```

can represent different values.

This preserves the **historical transaction price** while keeping the current product price in `products`.

---

## 7.3 Third Normal Form (3NF)

### Rule

A relation must:

1. Already satisfy **2NF**.
2. Have no non-key attribute depending on another non-key attribute.
3. Eliminate **transitive dependencies**.

### Problem

Consider the order information:

```text id="w5m9kg"
orders(
    order_id,
    customer_id,
    customer_name,
    city,
    order_date,
    order_status
)
```

The dependencies include:

```text id="y1v8ca"
order_id → customer_id
customer_id → customer_name, city
```

Therefore:

```text id="a8h2qk"
order_id → customer_id → customer_name, city
```

This is a **transitive dependency**.

### Why This Is a Problem

The same customer's details would be repeated across every order that the customer places.

This causes:

* Data redundancy
* Wasted storage
* Update anomalies

For example, if a customer's city changes, the information would need to be updated in multiple order records.

### Fix

Move customer information into the separate `customers` table.

```text id="h6u3xq"
customers(
    customer_id PK,
    customer_name,
    email,
    phone,
    city,
    state,
    registration_date
)
```

```text id="c2m8wd"
orders(
    order_id PK,
    customer_id FK,
    order_date,
    order_status
)
```

Now:

```text id="0g7k1p"
orders.customer_id → customers.customer_id
```

This is the **Customer / Orders separation** used in our actual project schema.

---

## 7.4 Boyce-Codd Normal Form (BCNF)

### Rule

For every **non-trivial functional dependency**:

```text id="6u3bqm"
X → Y
```

`X` must be a **superkey**.

BCNF is a stricter version of 3NF because **every determinant must itself be a candidate key**.

### Application to Our Project

After the 3NF decomposition, the major relations use determinants that are keys:

```text id="z0v9c4"
customer_id → customer_name, email, phone, city, state, registration_date

product_id → product_name, category_id, unit_price, stock_quantity

order_id → customer_id, order_date, order_status

payment_id → order_id, payment_method, amount, payment_status

shipment_id → order_id, courier_name, tracking_number, delivery_status
```

Here, the determinants are the primary keys of their respective relations.

For the bridge tables:

```text id="e5k2r8"
(order_id, product_id) → quantity, unit_price
```

and

```text id="n8p4qs"
(product_id, supplier_id) → relationship between product and supplier
```

the composite determinants are the keys of those relations.

Thus, the project schema is designed to avoid the type of non-key determinant that causes a BCNF violation.

---

## 7.5 Multivalued Dependencies and Fourth Normal Form (4NF)

### Multivalued Dependency

A **multivalued dependency**, written as:

```text id="z4d2ws"
X →→ Y
```

exists when, for a given value of `X`, there is a set of `Y` values that is independent of other attributes in the same relation.

A table can satisfy **BCNF** and still contain redundancy caused by storing **independent multi-valued facts together**.

### Application to Our Project — Product and Suppliers

A product can be associated with **multiple suppliers**, and a supplier can provide **multiple products**.

If this relationship were stored directly inside the `products` table as repeated supplier values, it could create unnecessary repetition.

Instead, the project uses a separate bridge relation:

```text id="5kq1vz"
product_supplier(
    product_id FK,
    supplier_id FK
)
```

**Composite Primary Key:**

```text id="2r6m8x"
(product_id, supplier_id)
```

Conceptually:

```text
             Product
                │
        ┌───────┼───────┐
        ↓       ↓       ↓
     Supplier Supplier Supplier
```

The relationship is separated into:

```text id="b3w7jc"
products
   │
   │ M:N
   │
product_supplier
   │
   │ M:N
   ↓
suppliers
```

This avoids storing multiple supplier values in a single product record and removes unnecessary relationship redundancy.

### 4NF Rule

A relation must:

1. Already satisfy **BCNF**.
2. Have no non-trivial multivalued dependency unless the determinant is a **superkey**.

### Fix

Instead of storing supplier information repeatedly with product attributes, use the separate relation:

```text id="x9n2hf"
product_supplier(
    product_id,
    supplier_id
)
```

This independently records each **Product–Supplier association**.

The same principle can be applied to other independent multi-valued relationships in a relational design.

---

## 7.6 Normalization Summary

| Normal Form | Problem It Removes                               | How We Applied It in This Project                                                                   |
| ----------- | ------------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| **1NF**     | Repeating groups / non-atomic values             | Split the flat order's repeated product columns into separate `order_items` rows.                   |
| **2NF**     | Partial dependency on part of a composite key    | Kept product-level information in `products` and transaction-specific information in `order_items`. |
| **3NF**     | Transitive dependency through a non-key column   | Moved customer details from order data into the `customers` table.                                  |
| **BCNF**    | A determinant that is not itself a candidate key | Ensured major functional dependencies are based on primary/composite keys.                          |
| **4NF**     | Independent multivalued facts stored together    | Separated the Product–Supplier M:N relationship into `product_supplier`.                            |

---

## 7.7 Normalization Flow

```text id="0q3k7n"
Unnormalized Form (UNF)
        │
        │ Remove repeating groups
        ↓
First Normal Form (1NF)
        │
        │ Remove partial dependencies
        ↓
Second Normal Form (2NF)
        │
        │ Remove transitive dependencies
        ↓
Third Normal Form (3NF)
        │
        │ Ensure every determinant is a superkey
        ↓
Boyce-Codd Normal Form (BCNF)
        │
        │ Remove independent multivalued dependencies
        ↓
Fourth Normal Form (4NF)
```

### Final Normalized Project Structure

```text id="u4y8px"
UNF
 │
 ↓
1NF
 │
 ├── customers
 ├── orders
 └── order_items
 │
 ↓
2NF
 │
 ├── products
 └── order_items
 │
 ↓
3NF
 │
 ├── customers
 └── orders
 │
 ↓
BCNF
 │
 └── Key-based relations
 │
 ↓
4NF
 │
 └── product_supplier
```

### Final Idea

```text id="k8f3mv"
UNF → 1NF → 2NF → 3NF → BCNF → 4NF
```

Each step reduces **redundancy** and helps prevent **insertion, deletion, and update anomalies**, resulting in a cleaner and more consistent relational database design.

### Final Relations After Normalization

```text id="q7n2xa"
customers
categories
products
suppliers
product_supplier
cart
orders
order_items
payments
reviews
shipments
```

These relations together form the normalized relational structure used by the project.
