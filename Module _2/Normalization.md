## 7. Normalization

Rather than simply stating the rules, this section demonstrates **normalization step by step**.

We begin with a single messy, unnormalized order table and progressively clean it until it reaches **Fourth Normal Form (4NF)**, as required by the project plan.

---

## 7.0 Starting Point — Unnormalized Table (UNF)

Imagine that instead of a proper database, someone logged every order into a single flat spreadsheet with **one row per order**.

The products are stored sideways in **repeating groups of columns**:

```text
FlatOrder(
    order_id,
    customer_name,
    customer_city,
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
* The structure is therefore not flexible or atomic.

---

## 7.1 First Normal Form (1NF)

### Rule

A relation is in **1NF** when:

* Every column contains a **single, atomic value**.
* There are **no repeating groups of columns**.

### Fix

Move the repeating `(product, quantity, price)` group into a separate table with **one row per order line**.

This is exactly the concept represented by the `OrderItem` table in our ER diagram.

### Result

```text
Order_1NF(
    order_id,
    customer_name,
    customer_city
)
```

```text
OrderItem_1NF(
    order_id,
    product_name,
    qty,
    price
)
```

**Composite Key:** `(order_id, product_name)`

### Resulting Structure

```text
Order
  │
  └── OrderItem
        ├── product_name
        ├── qty
        └── price
```

---

## 7.2 Second Normal Form (2NF)

### Rule

A relation must:

1. Already satisfy **1NF**.
2. Have every non-key attribute depend on the **whole composite key**.
3. Have no **partial dependency**.

### Problem

In:

```text
OrderItem_1NF(order_id, product_name, qty, price)
```

the key is:

```text
(order_id, product_name)
```

Suppose `price` represents the product's **general list price**, rather than the actual price charged for that order.

Then:

```text
product_name → price
```

The price depends only on `product_name`, not on the complete composite key:

```text
(order_id, product_name)
```

This is a **partial dependency**, which violates 2NF.

### Why This Is a Problem

A product's normal list price does not depend on which order it appears in.

Storing it repeatedly against different orders creates:

* Redundancy
* Wasted storage
* Potential update inconsistencies

### Fix

Move product-level information into a separate `Product` table.

```text
Product_2NF(
    product_name PK,
    list_price
)
```

```text
OrderItem_2NF(
    order_id FK,
    product_name FK,
    qty,
    unit_price
)
```

### Important Design Decision

`unit_price` remains inside `OrderItem`.

This is because `unit_price` represents the **actual price charged for that particular order line**.

For example, a festive discount could make:

```text
Product.price ≠ OrderItem.unit_price
```

Therefore, `unit_price` genuinely depends on the complete order-item key.

This is exactly why our real schema keeps:

```text
Product.price
```

separate from:

```text
OrderItem.unit_price
```

---

## 7.3 Third Normal Form (3NF)

### Rule

A relation must:

1. Already satisfy **2NF**.
2. Have no non-key attribute depending on another non-key attribute.
3. Eliminate **transitive dependencies**.

### Problem

Consider:

```text
Order_1NF(
    order_id,
    customer_name,
    customer_city
)
```

The dependencies are:

```text
order_id → customer_name
customer_name → customer_city
```

Therefore:

```text
order_id → customer_name → customer_city
```

This is a **transitive dependency**.

### Why This Is a Problem

The same customer's name and city would be repeated across every order that the customer places.

This causes:

* Data redundancy
* Wasted storage
* Update anomalies

For example, if a customer moves to another city, some old records might contain the old city while others contain the new city.

### Fix

Move customer information into a separate `Customer` table.

```text
Customer_3NF(
    customer_id PK,
    customer_name,
    customer_city
)
```

```text
Orders_3NF(
    order_id PK,
    customer_id FK,
    order_date,
    status,
    total_amount
)
```

This is exactly the **Customer / Orders separation** used in our project schema.

---

## 7.4 Boyce-Codd Normal Form (BCNF)

### Rule

For every **non-trivial functional dependency**:

```text
X → Y
```

`X` must be a **superkey**.

BCNF is a stricter version of 3NF because **every determinant must itself be a candidate key**.

### Example

Consider the hypothetical table:

```text
Shipment_Courier_Zone(
    order_id,
    courier,
    delivery_zone,
    eta_days
)
```

Suppose a business rule states that a particular courier always takes the same number of days to deliver within a particular zone.

Therefore:

```text
(courier, delivery_zone) → eta_days
```

However, if the actual primary key is:

```text
order_id
```

then `(courier, delivery_zone)` is **not a superkey**.

Therefore, this dependency violates **BCNF**.

### Fix

Separate the courier-zone delivery rule into its own table:

```text
CourierZoneETA(
    courier,
    delivery_zone,
    eta_days
)
```

**Primary Key:**

```text
(courier, delivery_zone)
```

Then create:

```text
Shipment_BCNF(
    shipment_id PK,
    order_id FK,
    courier FK,
    delivery_zone FK,
    tracking_no
)
```

### Design Choice in Our Project

Our actual `Shipment` table is:

```text
Shipment(
    shipment_id,
    order_id,
    courier,
    tracking_no,
    delivery_status,
    eta
)
```

It stores a **per-shipment ETA** rather than assuming that every courier-zone combination has a fixed delivery time.

This design avoids the hypothetical courier/zone/ETA dependency and is worth mentioning as part of the reasoning behind the `eta` column.

---

## 7.5 Multivalued Dependencies and Fourth Normal Form (4NF)

### Multivalued Dependency

A **multivalued dependency**, written as:

```text
X →→ Y
```

exists when, for a given value of `X`, there is a set of `Y` values that is independent of other attributes in the same relation.

A table can satisfy **BCNF** and still contain redundancy caused by storing **two independent multivalued facts together**.

### Example

Suppose a product can independently have:

* Several **tags**, such as `wireless` and `bestseller`.
* Several **available sizes**, such as `S`, `M`, and `L`.

These are two independent facts about the same product.

If both are stored in:

```text
ProductAttr(
    product_id,
    tag,
    size
)
```

then:

```text
product_id →→ tag
product_id →→ size
```

### Problem

Suppose a product has:

* **2 tags**
* **3 sizes**

The table would require:

```text
2 × 3 = 6 rows
```

to represent two independent facts.

Conceptually:

```text
Product
   │
   ├── Tags:  wireless, bestseller
   │
   └── Sizes: S, M, L
```

Combining them creates unnecessary combinations:

```text
wireless     S
wireless     M
wireless     L
bestseller   S
bestseller   M
bestseller   L
```

This is redundancy that **BCNF alone cannot detect**.

### 4NF Rule

A relation must:

1. Already satisfy **BCNF**.
2. Have no non-trivial multivalued dependency unless the determinant is a **superkey**.

### Fix

Separate the two independent multivalued facts into different relations.

#### ProductTag

```text
ProductTag(
    product_id FK,
    tag
)
```

**Primary Key:**

```text
(product_id, tag)
```

#### ProductSize

```text
ProductSize(
    product_id FK,
    size
)
```

**Primary Key:**

```text
(product_id, size)
```

Now each independent fact is stored separately, removing unnecessary combinations and satisfying **4NF**.

---

## 7.6 Normalization Summary

| Normal Form | Problem It Removes                                | How We Applied It in This Project                                      |
| ----------- | ------------------------------------------------- | ---------------------------------------------------------------------- |
| **1NF**     | Repeating groups / non-atomic values              | Split the flat order's product columns into separate `OrderItem` rows. |
| **2NF**     | Partial dependency on part of a composite key     | Moved a product's list price out of `OrderItem` and into `Product`.    |
| **3NF**     | Transitive dependency through a non-key column    | Moved `customer_city` out of `Orders` and into the `Customer` table.   |
| **BCNF**    | A determinant that is not itself a candidate key  | Moved the courier/zone/ETA business rule into its own table.           |
| **4NF**     | Two independent multivalued facts stored together | Split product tags and sizes into `ProductTag` and `ProductSize`.      |

---

## 7.7 Normalization Flow

```text
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

### Final Idea

```text
UNF → 1NF → 2NF → 3NF → BCNF → 4NF
```

Each step reduces **redundancy** and helps prevent **insertion, deletion, and update anomalies**, resulting in a cleaner and more consistent relational database design.
