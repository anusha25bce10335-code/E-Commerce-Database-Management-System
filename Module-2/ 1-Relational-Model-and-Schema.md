## 1. Structure of Relational Databases

### 1.1 Domains

A **domain** is simply the set of allowed values for a column. Think of it as the **"rulebook"** for what can go into a particular cell of a table.

For example, a `payments.payment_method` column in our project should not contain a random value such as `"maybe"`. It should contain a valid payment method defined by the database design.

| Column in Our Schema      | Its Domain (Allowed Values)                                                           |
| ------------------------- | ------------------------------------------------------------------------------------- |
| `customers.email`         | Valid email-shaped text strings; it can be constrained to be unique across customers. |
| `products.unit_price`     | Decimal numbers greater than 0.                                                       |
| `orders.order_status`     | Valid order-status values such as `Pending`, `Delivered`, `Cancelled`, etc.           |
| `payments.payment_method` | Values such as `Cash on Delivery`, `Credit Card`, `UPI`, and `Net Banking`.           |
| `products.stock_quantity` | Whole numbers that are zero or positive.                                              |

Domains matter beyond just data entry. Later in **Section 3.5**, we will see that operations like **UNION** and **SET DIFFERENCE** only make sense when we compare columns that share compatible domains.

For example, it would be meaningless to take the union of a list of `customer_id` values and a list of product prices because they represent different types of values.

---

### 1.2 Relations

A **relation** is the formal name for what we casually call a **table**.

The following terms are used throughout this report, explained using our `products` table:

* **Relation Schema:** The blueprint or structure of a table.

  Example:

  ```text id="m3x8ka"
  products (
      product_id,
      product_name,
      category_id,
      unit_price,
      stock_quantity
  )
  ```

* **Relation Instance:** The actual rows currently present in the `products` table at a particular moment.

* **Tuple:** A single row in a relation.
  For example, one tuple in `products` represents one specific product.

* **Attribute:** A single column in a relation.
  Example: `unit_price`.

* **Degree:** The number of columns in a table.
  Our `products` table has **5 columns**, so its degree is **5**.

* **Cardinality:** The number of rows currently present in a table.
  If the database currently contains **1,240 products**, the cardinality of `products` is **1,240**.

#### Properties of a Proper Relation

Two important properties separate a proper relation from a plain spreadsheet:

1. **Atomic Values**

   Every value must be **atomic**, meaning each cell contains a single value.

   For example, a single `products` row cannot contain multiple prices in one cell. This is the fundamental idea enforced by **First Normal Form (1NF)**, discussed later in **Section 7.1**.

2. **No Duplicate Tuples**

   In the relational model, a relation is treated as a **set of tuples**, so duplicate tuples are not considered distinct. In the project database, **primary keys** are used to uniquely identify records.

---

### 1.3 Relational Schema for the Project

Putting everything together, the **relational schema** represents the complete structure of our e-commerce project.

It is essentially the **ER diagram from Module 1 translated into relational tables**.

The project contains the following relations:

```text id="6v3q8p"
customers (
    customer_id [PK],
    customer_name,
    email,
    phone,
    city,
    state,
    registration_date
)

categories (
    category_id [PK],
    category_name
)

products (
    product_id [PK],
    product_name,
    category_id [FK],
    unit_price,
    stock_quantity
)

suppliers (
    supplier_id [PK],
    supplier_name,
    city,
    contact_email
)

product_supplier (
    product_id [FK],
    supplier_id [FK],
    PRIMARY KEY (product_id, supplier_id)
)

cart (
    cart_id [PK],
    customer_id [FK],
    product_id [FK],
    quantity
)

orders (
    order_id [PK],
    customer_id [FK],
    order_date,
    order_status
)

order_items (
    order_id [FK],
    product_id [FK],
    quantity,
    unit_price,
    PRIMARY KEY (order_id, product_id)
)

payments (
    payment_id [PK],
    order_id [FK],
    payment_method,
    amount,
    payment_status
)

reviews (
    review_id [PK],
    customer_id [FK],
    product_id [FK],
    rating,
    review_text
)

shipments (
    shipment_id [PK],
    order_id [FK],
    courier_name,
    tracking_number,
    delivery_status
)
```

### Key Relationships

The main relationships represented by these relations are:

```text id="j8c4ns"
customers  1 ───── N orders
customers  1 ───── 1 cart
customers  1 ───── N reviews

categories 1 ───── N products

products   M ───── N suppliers
                 │
                 └── product_supplier

orders     1 ───── N order_items
products   1 ───── N order_items

orders     1 ───── 1 payments
orders     1 ───── 1 shipments

products   1 ───── N reviews
```

The `product_supplier` relation resolves the **many-to-many relationship** between products and suppliers.

Similarly, `order_items` represents the association between orders and products, with `(order_id, product_id)` as its composite primary key.

The relational schema provides the foundation for implementing the e-commerce database using the **relational model**.
