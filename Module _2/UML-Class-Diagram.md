## 6. Introduction to UML (for the Data Model)

**UML (Unified Modeling Language)** class diagrams are another way of representing the same type of structural information shown by an **ER diagram**.

UML class diagrams are widely used in the software industry, so understanding how to translate an ER diagram into a UML class diagram is useful.

Our **Module 1 ERD** could also be represented as a UML class diagram.

---

## 6.1 ER Concepts and UML Equivalents

| ER Concept                    | UML Equivalent                                                                     |
| ----------------------------- | ---------------------------------------------------------------------------------- |
| **Entity** (e.g., `Product`)  | A **class**, with one section for attributes and another section for operations.   |
| **Attribute**                 | A class attribute written as `name: type`, e.g., `price: Decimal`.                 |
| **Relationship** (1:M, M:N)   | An **association**, with multiplicity such as `1..*` or `0..1` marked at each end. |
| **Weak Entity** (`OrderItem`) | An **association class**, attached to the `Orders–Product` association.            |
| **ISA / Specialization**      | A **generalization arrow** with a hollow triangle drawn between classes.           |
| **Key Attribute**             | An attribute marked `{PK}` or shown **underlined**, by convention.                 |

---

## 6.2 UML Representation in Our Project

For our e-commerce project, a UML class diagram would represent the relationships between the major classes and their multiplicities.

### Product–Category Relationship

`Product` is connected to `Category` with the following multiplicities:

```text id="9b9j8r"
Category 1 ───────── 0..* Product
```

This means:

* A **Category** can contain **many Products**.
* Each **Product** belongs to **exactly one Category**.

### OrderItem as an Association Class

`OrderItem` is represented as an **association class** connecting `Orders` and `Product`.

Conceptually:

```text id="5b1z9k"
Orders ───────────── Product
             │
             │
         OrderItem
    (Association Class)
```

`OrderItem` resolves the **many-to-many relationship** between `Orders` and `Product`.

It also represents the same **weak-entity resolution concept** used in our ER diagram.

---

## 6.3 Key Points

* **ER Diagram** → commonly used for database conceptual modelling.
* **UML Class Diagram** → commonly used for software and system modelling.
* An **Entity** in an ER diagram corresponds roughly to a **Class** in UML.
* An ER **relationship** corresponds to a UML **association**.
* **Cardinality** in ER modelling is represented by **multiplicity** in UML.
* A **weak entity** such as `OrderItem` can be represented as an **association class**.
* **Primary keys** can be marked using `{PK}` or by underlining the attribute.
