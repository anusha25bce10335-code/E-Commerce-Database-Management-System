# Relational Model and Schema

## 1. Structure of Relational Databases

### 1.1 Domains
A domain is the set of allowed values for an attribute (column), serving as the rulebook for permissible data in a relation.

| Column in Schema | Domain (Allowed Values) |
| :--- | :--- |
| `Customer.email` | Valid email format strings; must be unique across all customers. |
| `Product.price` | Decimal numbers greater than 0 ($price > 0$). |
| `Orders.status` | Fixed enumeration: `PLACED`, `CONFIRMED`, `SHIPPED`, `DELIVERED`, `CANCELLED`. |
| `Payment.method` | Fixed enumeration: `CARD`, `UPI`, `NETBANKING`, `COD`, `WALLET`. |
| `Product.stock_qty` | Non-negative integers ($stock\_qty \ge 0$). |

> **Significance:** Domains guarantee data validity at entry time and are mandatory for relational operations like `UNION` and `SET DIFFERENCE`, which require union-compatible attributes originating from the same underlying domain.

---

### 1.2 Relations
A relation is the formal mathematical representation of a database table.

* **Relation Schema:** The structural blueprint of the relation.
  * *Example:* `Product (product_id, name, description, price, stock_qty, category_id, seller_id)`.
* **Relation Instance:** The collection of actual tuples (rows) present in the table at a specific point in time.
* **Tuple:** A single record/row in a relation (e.g., an individual product entry)[cite: 1].
* **Attribute:** A named property or column of a relation (e.g., `price`)[cite: 1].
* **Degree:** The total count of attributes in a relation schema[cite: 1].
  * *Example:* The `Product` relation has 7 attributes, so its degree is **7**[cite: 1].
* **Cardinality:** The total number of tuples currently stored in a relation instance[cite: 1].

#### Relational Constraints
1. **Atomicity:** Every cell must hold a single indivisible value; multi-valued fields are disallowed (enforced by 1NF)[cite: 1].
2. **Uniqueness:** A relation cannot contain duplicate tuples, guaranteed by primary key enforcement[cite: 1].

---

## 2. Project Relational Schema

Below is the complete relational schema mapping the conceptual ER design into 12 normalized tables[cite: 1].

### 1. Customer
Stores registered shopper profile data[cite: 1].
```text
Customer (
    customer_id [PK],
    name,
    email,
    phone,
    password
)
