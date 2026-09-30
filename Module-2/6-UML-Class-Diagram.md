## 6. Introduction to UML (for the Data Model)

**UML (Unified Modeling Language)** class diagrams are another way of representing the same type of structural information shown by an **ER diagram**.

UML class diagrams are widely used in the software industry, so understanding how to translate an ER diagram into a UML class diagram is useful.

Our **Module 1 ERD** can also be represented as a UML class diagram using the actual entities and relationships of our e-commerce database.

---

## 6.1 ER Concepts and UML Equivalents

| ER Concept                             | UML Equivalent                                                                                                             |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Entity** (e.g., `products`)          | A **class**, with attributes and optionally operations.                                                                    |
| **Attribute**                          | A class attribute written as `name: type`, e.g., `unit_price: Decimal`.                                                    |
| **Relationship** (1:M, M:N)            | An **association**, with multiplicity such as `1`, `0..*`, or `1..*` marked at each end.                                   |
| **Associative Entity** (`order_items`) | An **association class** or bridge structure connecting `orders` and `products`.                                           |
| **M:N Relationship**                   | Represented using an association and, in the relational model, resolved through a bridge table such as `product_supplier`. |
| **Key Attribute**                      | An attribute marked `{PK}` or shown **underlined**, by convention.                                                         |

---

## 6.2 UML Representation in Our Project

For our e-commerce project, a UML class diagram would represent the major classes, their attributes, relationships, and multiplicities.

### Customer–Order Relationship

```text
customers 1 ───────── 0..* orders
```

This means:

* A **customer** can place **many orders**.
* Each **order** belongs to **one customer**.

### Category–Product Relationship

```text
categories 1 ───────── 0..* products
```

This means:

* A **category** can contain **many products**.
* Each **product** belongs to **one category** through `category_id`.

### Product–Supplier Relationship

Products and suppliers have a **many-to-many (M:N)** relationship.

```text
products 0..* ─────── 0..* suppliers
                │
                │
        product_supplier
          (Bridge Table)
```

This means:

* A product can have **multiple suppliers**.
* A supplier can supply **multiple products**.
* `product_supplier(product_id, supplier_id)` resolves the M:N relationship.

### OrderItem as an Association Class

`order_items` connects `orders` and `products`.

```text
orders 1 ─────── 0..* order_items 0..* ─────── 1 products
```

`order_items` contains:

```text
order_id
product_id
quantity
unit_price
```

It resolves the **many-to-many relationship** between `orders` and `products`.

The composite key is:

```text
(order_id, product_id)
```

---

## 6.3 Other Important UML Relationships

The remaining major relationships in the project can be represented as:

```text
customers 1 ───── 1 cart
customers 1 ───── 0..* reviews

categories 1 ───── 0..* products

products 1 ───── 0..* reviews

orders 1 ───── 1 payments
orders 1 ───── 1 shipments
```

The `cart` table stores the customer, product, and quantity information for products currently associated with a customer's cart.

---

## 6.4 Key Points

* **ER Diagram** → commonly used for database conceptual modelling.
* **UML Class Diagram** → commonly used for software and system modelling.
* An **Entity** in an ER diagram corresponds roughly to a **Class** in UML.
* An ER **relationship** corresponds to a UML **association**.
* **Cardinality** in ER modelling is represented by **multiplicity** in UML.
* `order_items` acts as an **associative structure** between `orders` and `products`.
* `product_supplier` resolves the **M:N relationship** between `products` and `suppliers`.
* **Primary keys** can be marked using `{PK}` or by underlining the attribute.
* Foreign keys can be shown as attributes with `{FK}` in the UML representation.

### Actual Project Mapping

```text
Database Table          → UML Class
Column                  → UML Attribute
Primary Key             → {PK}
Foreign Key             → {FK}
Relationship            → Association
Cardinality             → Multiplicity
M:N Relationship        → Association / Bridge
order_items             → Order–Product Association
product_supplier        → Product–Supplier Bridge
```
