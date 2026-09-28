# Weak Entity Sets

## 1. What is a Weak Entity?

A weak entity is an entity that cannot be uniquely identified using its own attributes alone.

It depends on another entity, called the **strong entity**, for its identification.

A weak entity is usually represented using a **double rectangle** in an ER diagram.

---

## 2. Characteristics of a Weak Entity

- It does not have a complete primary key of its own.
- It depends on a strong entity.
- It has a partial key that helps identify its records.
- It has an identifying relationship with the strong entity.
- Its existence depends on the strong entity.

---

## 3. Weak Entity in Our E-Commerce Database

In our e-commerce database, `Order_Item` represents the details of products included in an order.

An `Order_Item` is dependent on an `Order`.

The `Order_Item` is identified using:

- `order_id`
- `product_id`

Together, these attributes identify a particular product within a particular order.

### Example

Suppose:

- `order_id = O101`
- `product_id = P15`

The combination `(O101, P15)` identifies the order item.

---

## 4. Strong Entity

`Order` acts as the strong/owner entity because an order can exist independently.

## 5. Dependent Entity

`Order_Item` depends on the `Order` because an order item cannot exist without an associated order.

---

## 6. Identifying Relationship

The relationship between `Order` and `Order_Item` is an identifying relationship.

```text
Order  ─────── contains ─────── Order_Item
