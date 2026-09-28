# Relationships and Constraints

## 1. Relationships

A relationship shows how two or more entities are connected in a database.

### Customer – Order
- One customer can place many orders.
- Each order belongs to one customer.
- Cardinality: **1 : N**

### Category – Product
- One category can contain many products.
- Each product belongs to one category.
- Cardinality: **1 : N**

### Order – Order_Item
- One order can contain many order items.
- Each order item belongs to one order.
- Cardinality: **1 : N**

### Product – Order_Item
- One product can appear in many order items.
- Each order item refers to one product.
- Cardinality: **1 : N**

### Product – Supplier
- One product can have multiple suppliers.
- One supplier can supply multiple products.
- Cardinality: **M : N**
- This relationship is handled using the `Product_Supplier` entity.

### Customer – Review
- One customer can write many reviews.
- Each review is written by one customer.
- Cardinality: **1 : N**

### Product – Review
- One product can have many reviews.
- Each review belongs to one product.
- Cardinality: **1 : N**

### Customer – Cart
- One customer can have multiple cart items.
- Each cart item belongs to one customer.
- Cardinality: **1 : N**

### Product – Cart
- One product can appear in multiple carts.
- Each cart item refers to one product.
- Cardinality: **1 : N**

---

# 2. Constraints

Constraints are rules applied to data in a database to maintain accuracy and consistency.

## Primary Key Constraint

A primary key uniquely identifies each record in a table.

Examples:

- `customer_id` in Customer
- `product_id` in Product
- `order_id` in Order
- `payment_id` in Payment

A primary key cannot contain NULL values and must be unique.

## Foreign Key Constraint

A foreign key connects one table with another table.

Examples:

- `customer_id` in Order references Customer.
- `category_id` in Product references Category.
- `product_id` in Order_Item references Product.
- `order_id` in Payment references Order.

## NOT NULL Constraint

A NOT NULL constraint ensures that a value cannot be left empty.

For example, a product should have a product name.

## UNIQUE Constraint

A UNIQUE constraint ensures that duplicate values are not allowed.

For example, customer email addresses can be kept unique.

## CHECK Constraint

A CHECK constraint ensures that values satisfy a specific condition.

Examples:

- Product price must be greater than 0.
- Stock quantity must be greater than or equal to 0.
- Review rating must be between 1 and 5.
