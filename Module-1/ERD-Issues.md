# ERD Issues

ERD (Entity-Relationship Diagram) design may have several issues that can affect the correctness and clarity of a database.

## 1. Incorrect Cardinality

Cardinality describes how many instances of one entity can be associated with another entity.

For example:

- One Customer can place many Orders.
- Therefore, the relationship is **1:N**.

Incorrect cardinality can lead to incorrect database design.

---

## 2. Many-to-Many Relationships

A many-to-many (M:N) relationship occurs when many records of one entity can be related to many records of another entity.

For example:

- One Product can have many Suppliers.
- One Supplier can supply many Products.

This M:N relationship is resolved using an intermediate entity:

**Product_Supplier**

---

## 3. Data Redundancy

Data redundancy means storing the same information unnecessarily in multiple places.

For example, storing the complete customer information repeatedly for every order can cause duplication.

Using separate entities such as `Customer` and `Order` helps reduce redundancy.

---

## 4. Incorrect Attribute Placement

Attributes should be associated with the entity to which they belong.

For example:

- `customer_name` belongs to Customer.
- `product_name` belongs to Product.
- `order_date` belongs to Order.

Placing attributes in the wrong entity can make the database difficult to manage.

---

## 5. Missing Relationships

Every required connection between entities should be represented.

For example:

`Order` must be connected to `Customer` because every order is associated with a customer.

Missing relationships can cause problems when retrieving or maintaining data.

---

## 6. Weak Entity Identification

A weak entity depends on another entity for its identification.

In our database, `Order_Item` depends on `Order`.

The combination of `order_id` and `product_id` helps identify an order item.

---

## 7. Conclusion

Careful ERD design helps avoid redundancy, incorrect relationships, incorrect cardinality, and identification problems. A properly designed ERD provides a clear structure for converting the design into relational tables.
