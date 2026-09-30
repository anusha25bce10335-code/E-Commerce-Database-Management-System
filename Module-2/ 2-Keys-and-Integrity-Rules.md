# 2. Logical View of Data: Keys and Integrity Rules

## 2.1 Relational Schema

The logical view of our e-commerce database can be represented using the following relational schemas based on the actual project dataset.

### Customers

`customers (customer_id [PK], customer_name, email, phone, city, state, registration_date)`

### Categories

`categories (category_id [PK], category_name)`

### Products

`products (product_id [PK], product_name, category_id [FK → categories], unit_price, stock_quantity)`

### Suppliers

`suppliers (supplier_id [PK], supplier_name, city, contact_email)`

### Product Supplier

`product_supplier (product_id [FK → products], supplier_id [FK → suppliers])`

**Composite Primary Key:** `(product_id, supplier_id)`

### Cart

`cart (cart_id [PK], customer_id [FK → customers], product_id [FK → products], quantity)`

### Orders

`orders (order_id [PK], customer_id [FK → customers], order_date, order_status)`

### Order Items

`order_items (order_id [FK → orders], product_id [FK → products], quantity, unit_price)`

**Composite Primary Key:** `(order_id, product_id)`

### Payments

`payments (payment_id [PK], order_id [FK → orders], payment_method, amount, payment_status)`

### Shipments

`shipments (shipment_id [PK], order_id [FK → orders], courier_name, tracking_number, delivery_status)`

### Reviews

`reviews (review_id [PK], customer_id [FK → customers], product_id [FK → products], rating, review_text)`

---

## 2.2 Keys

A **key** is a column or set of columns used to uniquely identify a row in a relation.

Different types of keys provide different levels of uniqueness and constraints.

| Key Type             | What It Means                                                                                           | Example from Our Schema                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| **Super Key**        | Any set of columns that can uniquely identify a row. It may contain extra, unnecessary columns.         | `{order_id, order_date}` in `orders`. `order_id` alone is sufficient, so `order_date` is extra. |
| **Candidate Key**    | A super key with no redundant column — the minimum set of attributes needed to uniquely identify a row. | `{order_id}` in `orders`; `{order_id, product_id}` in `order_items`                             |
| **Primary Key (PK)** | The candidate key selected to uniquely identify rows in a table.                                        | `product_id` in `products`                                                                      |
| **Alternate Key**    | A candidate key that exists but was not selected as the primary key.                                    | `email` in `customers`, assuming it is unique                                                   |
| **Foreign Key (FK)** | A column or set of columns that references a primary key in another table.                              | `products.category_id` → `categories.category_id`                                               |
| **Composite Key**    | A key consisting of more than one column used together to uniquely identify a row.                      | `{order_id, product_id}` in `order_items`                                                       |

### Composite Keys in the Dataset

Two important bridge/transaction tables use composite primary keys:

```text
order_items
PK = (order_id, product_id)

product_supplier
PK = (product_id, supplier_id)
```

These combinations ensure that the same product is not unnecessarily repeated within the same order or supplier relationship.

---

## 2.3 Integrity Rules

Integrity rules ensure that the database remains **accurate, consistent, and valid**.

### 1. Entity Integrity

* No column that is part of a **primary key** can contain `NULL`.
* Every row must have a valid primary key value.
* For a composite primary key, **all components** must be present.

**Example:**

Every row in `orders` must have an `order_id`.

Similarly, every row in `order_items` must have both:

```text
order_id + product_id
```

An order item without a product ID would not make sense.

The same principle applies to `product_supplier`:

```text
product_id + supplier_id
```

---

### 2. Referential Integrity

A non-null **foreign key** value must match an existing primary key value in the referenced table.

**Example:**

If:

```text
order_items.product_id = 87
```

then a product with:

```text
products.product_id = 87
```

must actually exist in the `products` table.

Similarly:

```text
orders.customer_id → customers.customer_id
```

Therefore, the database should not allow an order to reference a customer that does not exist.

---

### 3. Domain Integrity

Every value stored in a column must follow the **domain rules** defined for that column.

**Examples:**

* `products.unit_price` must be greater than `0`.
* `products.stock_quantity` cannot be negative.
* `orders.order_status` must use an allowed status such as:

  * `Delivered`
  * `Cancelled`
  * `Pending`
* `payments.payment_method` can use values such as:

  * `Cash on Delivery`
  * `Credit Card`
  * `UPI`
  * `Net Banking`

---

### 4. Key Constraint

No two rows in the same table can have identical values for all columns that form a key.

This ensures that the database cannot accidentally store the **same uniquely identified record twice**.

**Example:**

Two different rows cannot have the same:

```text
order_id
```

in the `orders` table.

For `order_items`, the combination:

```text
(order_id, product_id)
```

must be unique.

For `product_supplier`:

```text
(product_id, supplier_id)
```

must also be unique.

---

## 2.4 Why This Matters for Module 3

These four integrity rules are not just theoretical concepts. They are directly implemented in SQL using constraints such as:

| Integrity Requirement                  | SQL Constraint |
| -------------------------------------- | -------------- |
| Unique row identification              | `PRIMARY KEY`  |
| Relationship between tables            | `FOREIGN KEY`  |
| Prevent missing required values        | `NOT NULL`     |
| Restrict allowed values                | `CHECK`        |
| Prevent duplicate alternate-key values | `UNIQUE`       |

Therefore, this section provides the **logical reasoning behind the SQL constraints** that will be implemented later in the DDL scripts of Module 3.
