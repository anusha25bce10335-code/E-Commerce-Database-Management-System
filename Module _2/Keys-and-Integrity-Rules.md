# 2. Logical View of Data: Keys and Integrity Rules

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
| **Alternate Key**    | A candidate key that exists but was not selected as the primary key                                     |                                                                                                 |
