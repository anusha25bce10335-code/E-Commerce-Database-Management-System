# Module 2: Relational Model & Schema

## 1. Structure of Relational Databases

### 1.1 Domains

A **domain** is simply the set of allowed values for a column. Think of it as the **"rulebook"** for what can go into a particular cell of a table.

For example, a `Payment.method` column in our project should never contain a random word like `"maybe"`. It should only contain one of a fixed set of values because that is what its domain allows.

| Column in Our Schema | Its Domain (Allowed Values)                                                   |
| -------------------- | ----------------------------------------------------------------------------- |
| `Customer.email`     | Valid email-shaped text strings, and must be unique across all customers      |
| `Product.price`      | Decimal numbers greater than 0 (a product can't cost ₹0 or a negative amount) |
| `Orders.status`      | One of: `PLACED`, `CONFIRMED`, `SHIPPED`, `DELIVERED`, `CANCELLED`            |
| `Payment.method`     | One of: `CARD`, `UPI`, `NETBANKING`, `COD`, `WALLET`                          |
| `Product.stock_qty`  | Whole numbers that are zero or positive (you can't have `-5` items in stock)  |

Domains matter beyond just data entry. Later in **Section 3.5**, we will see that operations like **UNION** and **SET DIFFERENCE** only make sense when we compare columns that share the same domain.

For example, it would be meaningless to take the union of a list of `customer_ids` and a list of product prices because they represent different types of values.

---

### 1.2 Relations

A **relation** is the formal name for what we casually call a **table**.

The following terms are used throughout this report, explained using our `Product` table:

* **Relation Schema:** The blueprint or structure of a table.

  Example:

  `Product (product_id, name, description, price, stock_qty, category_id, seller_id)`

* **Relation Instance:** The actual rows currently present in the `Product` table at a particular moment.

* **Tuple:** A single row in a relation.
  For example, one tuple in `Product` represents one specific product, such as a pair of headphones.

* **Attribute:** A single column in a relation.
  Example: `price`.

* **Degree:** The number of columns in a table.
  Our `Product` table has **7 columns**, so its degree is **7**.

* **Cardinality:** The number of rows currently present in a table.
  If our shop has **1,240 products** listed, the cardinality of `Product` is **1,240**.

#### Properties of a Proper Relation

Two important properties separate a proper relation from a plain spreadsheet:

1. **Atomic Values**

   Every value must be **atomic**, meaning each cell contains a single value.

   For example, a single `Product` row cannot contain two prices in one cell. This is the fundamental idea enforced by **First Normal Form (1NF)**, discussed later in **Section 7.1**.

2. **No Duplicate Tuples**

   No two rows can be complete duplicates of each other. This is ensured when a **primary key** is properly defined for the relation.

---

### 1.3 Relational Schema for the Project

Putting everything together, the **relational schema** represents the complete structure of our e-commerce project .

It is essentially the **ER diagram from Module 1 translated into relational tables**.

The project contains several relations representing entities and their relationships.

> **Note:** `CartItem` and `OrderItem` are examples of **weak entities**. They do not have a natural single-column identity of their own. Therefore, their **primary keys are formed by combining the keys of the tables they depend on**.

The relational schema provides the foundation for implementing the e-commerce database using the **relational model**.
