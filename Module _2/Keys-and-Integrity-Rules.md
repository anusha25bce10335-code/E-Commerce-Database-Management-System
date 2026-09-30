# 2. Logical View of Data Keys and Integrity Rules

## 2.1 Relational Schema

The logical view of our e-commerce database can be represented using the following relational schemas.

### Customer

`Customer (customer_id [PK], name, email, phone, password)`

### Address

`Address (address_id [PK], customer_id [FK → Customer], street, city, state, pincode, type)`

### Category

`Category (category_id [PK], category_name, parent_category_id [FK → Category])`

### Seller

`Seller (seller_id [PK], name, rating, gst_number)`

### Product

`Product (product_id [PK], name, description, price, stock_qty, category_id [FK → Category], seller_id [FK → Seller])`

### Cart

`Cart (cart_id [PK], customer_id [FK → Customer])`

### CartItem

`CartItem (cart_id [FK → Cart], product_id [FK → Product], quantity)`

**Composite Primary Key:** `(cart_id, product_id)`

### Orders

`Orders (order_id [PK], customer_id [FK → Customer], order_date, status, total_amount)`

### OrderItem

`OrderItem (order_id [FK → Orders], product_id [FK → Product], quantity, unit_price)`

**Composite Primary Key:** `(order_id, product_id)`

### Payment

`Payment (payment_id [PK], order_id [FK → Orders], amount, method, status, payment_date)`

### Shipment

`Shipment (shipment_id [PK], order_id [FK → Orders], courier, tracking_no, delivery_status, eta)`

### Review

`Review (review_id [PK], customer_id [FK → Customer], product_id [FK → Product], rating, comment, date)`

---

## 2.2 Keys

A **key** is a column or set of columns used to uniquely identify a row in a relation.

Different types of keys provide different levels of uniqueness and constraints.

| Key Type             | What It Means                                                                                           | Example from Our Schema                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| **Super Key**        | Any set of columns that can uniquely identify a row. It may contain extra, unnecessary columns.         | `{order_id, order_date}` in `Orders`. `order_id` alone is sufficient, so `order_date` is extra. |
| **Candidate Key**    | A super key with no redundant column — the minimum set of attributes needed to uniquely identify a row. | `{order_id}` in `Orders`; `{cart_id, product_id}` in `CartItem`                                 |
| **Primary Key (PK)** | The candidate key selected to uniquely identify rows in a table.                                        | `product_id` in `Product`                                                                       |
| **Alternate Key**    | A candidate key that exists but was not selected as the primary key.                                    | `email` in `Customer`, since `customer_id` is chosen as the PK                                  |
| **Foreign Key (FK)** | A column or set of columns that references a primary key in another table or the same table.            | `Product.category_id` → `Category.category_id`                                                  |
| **Composite Key**    | A key consisting of more than one column used together to uniquely identify a row.                      | `{order_id, product_id}` in `OrderItem`                                                         |

### Self-Referencing Foreign Key

An interesting case in our schema is:

`Category.parent_category_id → Category.category_id`

This is a **self-referencing (unary) foreign key** because the foreign key points to the primary key of the **same table**.

It is used to represent **subcategories**.

For example:

```text
Fashion
   ↓
Footwear
   ↓
Running Shoes
```

Here:

* `Running Shoes` can have `parent_category_id` pointing to `Footwear`.
* `Footwear` can have `parent_category_id` pointing to `Fashion`.

---

## 2.3 Integrity Rules

Integrity rules ensure that the database remains **accurate, consistent, and valid**.

### 1. Entity Integrity

* No column that is part of a **primary key** can contain `NULL`.
* Every row must have a valid primary key value.
* For a composite primary key, **all components** must be present.

**Example:**

Every row in `Orders` must have an `order_id`.

Similarly, every row in `OrderItem` must have both:

```text
order_id + product_id
```

An order item without a product ID would not make sense.

---

### 2. Referential Integrity

A non-null **foreign key** value must match an existing primary key value in the referenced table.

**Example:**

If:

```text
OrderItem.product_id = 87
```

then a product with:

```text
Product.product_id = 87
```

must actually exist in the `Product` table.

Therefore, the database should not allow an order item to reference a product that does not exist.

---

### 3. Domain Integrity

Every value stored in a column must follow the **domain rules** defined for that column.

**Examples:**

* `Product.price` cannot be `-500`.
* `Product.stock_qty` cannot be negative.
* `Orders.status` must be one of the allowed values:

  * `PLACED`
  * `CONFIRMED`
  * `SHIPPED`
  * `DELIVERED`
  * `CANCELLED`

---

### 4. Key Constraint

No two rows in the same table can have identical values for all columns that form a key.

This ensures that the database cannot accidentally store the **same uniquely identified record twice**.

**Example:**

Two different rows cannot have the same:

```text
order_id
```

in the `Orders` table.

For `OrderItem`, the combination:

```text
(order_id, product_id)
```

must be unique.

---

## 2.4 Why This Matters for Module 3

These four integrity rules are not just theoretical concepts. They are directly implemented in SQL using constraints such as:

| Integrity Requirement           | SQL Constraint |
| ------------------------------- | -------------- |
| Unique row identification       | `PRIMARY KEY`  |
| Relationship between tables     | `FOREIGN KEY`  |
| Prevent missing required values | `NOT NULL`     |
| Restrict allowed values         | `CHECK`        |

Therefore, this section provides the **logical reasoning behind the SQL constraints** that will be implemented later in the DDL scripts of Module 3.
lemented later in the DDL scripts of Module 3.
