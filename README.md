# E-Commerce / Online Shopping Database — DBMS Project

A relational database design and implementation for an online shopping platform, built as a DBMS course project. Covers ER modeling, relational schema design, normalization, SQL, PL/SQL.


# E-Commerce Database Management System

## Project Overview

This project implements an E-Commerce Database Management System to store, organize, and manage data related to an online shopping platform.

The database manages customers, products, categories, suppliers, orders, payments, shipments, reviews, and shopping cart information.

## Objectives

- Design a structured e-commerce database.
- Understand database design using the ER model.
- Implement tables and relationships.
- Apply SQL queries and database constraints.
- Use PL/SQL for database programming.
- Understand indexing, storage, and query processing.
- Perform database operations efficiently.

---

# Project Modules

## Module 1 – Database Design and ER Model

Topics covered:

- Database Overview
- Database Design
- ER Model
- Entities and Attributes
- Relationships
- Constraints
- ER Diagrams
- ERD Issues
- Weak Entity Sets
- Conversion of ER Diagram into Relational Schema

**Folder:** `Module-1/`

---

## Module 2 – Relational Model & Normalization

Topics covered:

- Domains and Relations
- Relational Schema Design
- Keys and Key Constraints
- Relational Integrity Rules
- Relational Algebra Operations
- Joins and Set Operations
- Relational Division
- Extended Relational Algebra
- Tuple Relational Calculus
- Codd's 12 Rules
- UML Class Diagram Mapping
- Normalization (UNF to 4NF)

**Folder:** `Module-2/`

---

## Module 3 – PL/SQL

Topics covered:

- PL/SQL Block Structure
- Variables and Constants
- Conditional Statements
- Loops
- Cursors
- Procedures
- Functions
- Triggers
- Packages
- Exception Handling

**Folder:** `Module-3/`

---

## Module 4 – Storage and Query Processing

Topics covered:

- File Organization
- Storage
- Indexing
- B-Tree
- B+ Tree
- Query Processing
- Query Optimization

**Folder:** `Module-4/`

---

# Database Entities

The main entities used in the project are:

- Customer
- Category
- Product
- Supplier
- Order
- Order_Item
- Payment
- Shipment
- Review
- Cart
- Product_Supplier

---

# Dataset

The `dataset/` folder contains the CSV files used for the project.

These files provide sample data for customers, products, orders, payments, shipments, reviews, suppliers, and other entities.

---

# Project Structure

```text
E-Commerce-Database-Management-System/
│
├── README.md
│
├── dataset/
│   ├── customers.csv
│   ├── categories.csv
│   ├── products.csv
│   ├── suppliers.csv
│   ├── product_supplier.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── payments.csv
│   ├── shipments.csv
│   ├── reviews.csv
│   └── cart.csv
│
├── Module-1/
│   ├── Database-Overview.md
│   ├── Entities-and-Attributes.md
│   ├── Relationships-and-Constraints.md
│   ├── Weak-Entity-Sets.md
│   ├── ERD-Issues.md
│   ├── ER-Diagram.png
│   └── ER-to-Relational-Schema.png
│
├── Module-2/
│   ├── 1-Relational-Model-and-Schema.md      
│   ├── 2-Keys-and-Integrity-Rules.md        
│   ├── 3-Relational-Algebra.md              
│   ├── 4-Tuple-Relational-Calculus.md       
│   ├── 5-Codds-Rules.md                     
│   ├── 6-UML-Class-Diagram.md               
│   └── 7-Normalization.md
│                   
├── Module-3/
│
└── Module-4/
    ├── 1-PLSQL-Basics.md
    ├── 2-Conditional-Statements.md
    ├── 3-Loops.md
    ├── 4-Cursors.md
    ├── 5-Exception-Handling.md
    ├── 6-Procedures-and-Functions.md
    ├── 7-Triggers.md
    ├── 8-Records-and-Transactions.md
    └── 9-ECommerce-PLSQL-Programs.md
```
---

# E-Commerce Database Management System — PL/SQL

## 📌 Overview

This module implements **PL/SQL programming concepts** for the **E-Commerce Database Management System**.

The PL/SQL programs are connected with the **entities, attributes, relationships, and constraints** defined in Module-1.

The main purpose of this module is to implement database programming and business logic using PL/SQL, including:

- Business logic
- Data validation
- Calculations
- Exception handling
- Procedures
- Functions
- Triggers
- Cursors
- Transactions



## 🗂️ Module-1 Schema Connection

The PL/SQL programs are based on the e-commerce database schema developed in Module-1.

### Main Entities

- Customer
- Category
- Product
- Supplier
- Orders
- Order_Item
- Payment
- Shipment
- Review
- Cart
- Product_Supplier

### Main Relationships

```text
Customer 1 ─── N Orders
Category 1 ─── N Product
Orders 1 ─── N Order_Item
Product 1 ─── N Order_Item
Product M ─── N Supplier
             through Product_Supplier
Customer 1 ─── N Review
Product 1 ─── N Review
Customer 1 ─── N Cart
```

**Note:** `Order_Item` uses `order_id + product_id` for identification, consistent with the Module-1 database design.

---


## 📁 Module 2: Relational Model, Algebra & Normalization

```text
Module-2/
│
├── 1-Relational-Model-and-Schema.md
├── 2-Keys-and-Integrity-Rules.md
├── 3-Relational-Algebra.md
├── 4-Tuple-Relational-Calculus.md
├── 5-Codds-Rules.md
├── 6-UML-Class-Diagram.md
└── 7-Normalization.md
```

---

## 📚 Topics Covered

### 1. Relational Model & Schema

Covers the structure and foundation of the project's relational database:

* Attribute domains and value restrictions
* Schema, instance, tuples, and attributes
* Degree, cardinality, and atomicity
* Complete **11-table relational schema**
* Composite/association tables for M:N relationships

**Examples:** validation of `customers.email`, `products.unit_price`, `products.stock_quantity`, `orders.order_status`, and `payments.payment_method`.

---

### 2. Keys & Integrity Rules

Covers record uniqueness and data integrity:

* Super Key
* Candidate Key
* Primary Key (PK)
* Alternate Key
* Foreign Key (FK)
* Composite Key

**Integrity Rules:**

* Entity Integrity
* Referential Integrity
* Domain Integrity
* Key Constraints

Mapped to SQL using `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, and `CHECK`.

---

### 3. Relational Algebra

Covers procedural query operations:

* Selection (`σ`)
* Projection (`π`)
* Rename (`ρ`)
* Natural, Theta, Equi & Left Outer Joins (`⟕`)
* Cartesian Product (`×`)
* Union (`∪`), Intersection (`∩`), Difference (`−`)
* Union compatibility
* Relational Division (`÷`)
* Aggregation & Grouping (`γ`)

**Examples:** low-stock products, order details, customers without reviews, products not ordered, category-based customers, revenue, and order counts.

---

### 4. Tuple Relational Calculus (TRC)

Covers declarative query formulation:

* `{ t | P(t) }` notation
* Existential quantifier (`∃`)
* Universal quantifier (`∀`)
* Codd's Theorem
* Relational completeness

**Examples:** high-value payments, products appearing in bulk order items, low-rated customer reviews, and customers purchasing every product in a category.

---

### 5. Codd's 12 Rules

Evaluation of the database against Codd's relational database criteria:

* Rules **0–12**
* Information representation
* Guaranteed access
* `NULL` handling
* Online catalog
* Comprehensive SQL sublanguage
* View updating
* Set-level operations
* Physical & logical data independence
* Integrity independence
* Distribution independence
* Non-subversion

---

### 6. Introduction to UML

Maps the relational database design to UML Class Diagrams:

* Classes and attributes
* Associations and multiplicities (`0..*`, `1..1`)
* Association/bridge structures
* Composite keys and foreign-key relationships

**Examples:** `Product–Category` association, `Order–Product` relationship through `order_items`, and `Product–Supplier` relationship through `product_supplier`.

---

### 7. Normalization (UNF → 4NF)

Step-by-step decomposition to reduce redundancy and modification anomalies:

| Form     | Main Concept               | Project Example                          |
| -------- | -------------------------- | ---------------------------------------- |
| **UNF**  | Repeating groups           | Flat order spreadsheet                   |
| **1NF**  | Atomic values              | Separate `order_items` rows              |
| **2NF**  | No partial dependency      | Separate product-level information       |
| **3NF**  | No transitive dependency   | Separate customer details                |
| **BCNF** | Determinants are superkeys | Key-based dependencies                   |
| **4NF**  | No unwanted MVDs           | Separate `product_supplier` relationship |

---

# 🔗 Module-2 Schema Connection

The Module-2 concepts are applied to the **e-commerce entities developed in Module 1** and the actual project dataset.

## 🗃️ Main Relations

| # | Relation           
| - | ------------------ |
| 1 | `customers`        |
| 2 | `categories`       | 
| 3 | `products`         |
| 4 | `suppliers`        | 
| 5 | `product_supplier` | 
| 6 | `orders`           |   
| 7 | `order_items`      |
| 8 | `payments`         |
| 9 | `cart`             |
| 10| `reviews`          |
| 11| `shipments`        |
|                        |

---

## 📋 Actual Relational Schema

```text
customers(
    customer_id PK,
    customer_name,
    email,
    phone,
    city,
    state,
    registration_date
)

categories(
    category_id PK,
    category_name
)

products(
    product_id PK,
    product_name,
    category_id FK,
    unit_price,
    stock_quantity
)

suppliers(
    supplier_id PK,
    supplier_name,
    city,
    contact_email
)

product_supplier(
    product_id FK,
    supplier_id FK,
    PK(product_id, supplier_id)
)

orders(
    order_id PK,
    customer_id FK,
    order_date,
    order_status
)

order_items(
    order_id FK,
    product_id FK,
    quantity,
    unit_price,
    PK(order_id, product_id)
)

payments(
    payment_id PK,
    order_id FK,
    payment_method,
    amount,
    payment_status
)

cart(
    cart_id PK,
    customer_id FK,
    product_id FK,
    quantity
)

reviews(
    review_id PK,
    customer_id FK,
    product_id FK,
    rating,
    review_text
)

shipments(
    shipment_id PK,
    order_id FK,
    courier_name,
    tracking_number,
    delivery_status
)
```

---

## 🔗 Entity Relationships & Cardinality

```text
customers  1 ──── N  orders
customers  1 ──── 1  cart
customers  1 ──── N  reviews

categories 1 ──── N  products

products   M ──── N  suppliers
              │
              ▼
       product_supplier

orders     1 ──── N  order_items
products   1 ──── N  order_items

orders     1 ──── 1  payments
orders     1 ──── 1  shipments

products   1 ──── N  reviews
```

### Relationship Summary

| Entity   | Relationship | Entity      | Cardinality |
| -------- | ------------ | ----------- | ----------- |
| Customer | places       | Orders      | `1:N`       |
| Customer | owns         | Cart        | `1:1`       |
| Customer | writes       | Review      | `1:N`       |
| Category | contains     | Product     | `1:N`       |
| Product  | supplied by  | Supplier    | `M:N`       |
| Orders   | contains     | Order Items | `1:N`       |
| Product  | appears in   | Order Items | `1:N`       |
| Orders   | has          | Payment     | `1:1`       |
| Orders   | has          | Shipment    | `1:1`       |
| Product  | receives     | Review      | `1:N`       |

---

## 🔑 Key Relationship Details

### Product–Supplier Relationship

The `M:N` relationship between products and suppliers is resolved through the bridge table `product_supplier`:

```text
Product  M ──── N  Supplier
             │
             ▼
      product_supplier
```

The bridge table uses a composite primary key:

```text
(product_id, supplier_id)
```

This uniquely identifies each Product–Supplier association.

---

### Orders–Product Relationship

The `M:N` relationship between orders and products is resolved through `order_items`:

```text
Orders  1 ──── N  order_items  N ──── 1  Products
```

`order_items` stores transaction-specific information:

```text
order_id
product_id
quantity
unit_price
```

The composite key is:

```text
(order_id, product_id)
```

---

### Cart–Product Relationship

The project stores cart contents directly in the `cart` relation:

```text
Customer  1 ──── 1  Cart
Cart      ────────  Products
```

The `cart` table contains:

```text
cart_id
customer_id
product_id
quantity
```

There is **no separate `CartItem` table** in the actual dataset.

---

## 🔄 Overall Module Flow

```text
ER Model
   ↓
Relational Schema
   ↓
Keys & Integrity Rules
   ↓
Relational Algebra
   ↓
Tuple Relational Calculus
   ↓
Codd's Rules
   ↓
UML Data Model
   ↓
Normalization
   ↓
UNF → 1NF → 2NF → 3NF → BCNF → 4NF
   ↓
Final Relational Database Design
```

---

## 🎯 Module Objective

To transform the **Module-1 ER model** into a structured, constraint-aware, queryable, and normalized relational database using:

**Relational Model → Keys & Integrity → Relational Algebra → TRC → Codd's Rules → UML → Normalization**

The final design is based on the project's actual e-commerce relations and demonstrates how relational database concepts are applied to real structured data.


# 📁 PL/SQL Module Structure

```text
PL-SQL/
│
├── README.md
├── 1-PLSQL-Basics.md
├── 2-Conditional-Statements.md
├── 3-Loops.md
├── 4-Cursors.md
├── 5-Exception-Handling.md
├── 6-Procedures-and-Functions.md
├── 7-Triggers.md
├── 8-Records-and-Transactions.md
└── 9-ECommerce-PLSQL-Programs.md
```

---

# 📚 Topics Covered

## 1. PL/SQL Basics

Covers the fundamental structure of PL/SQL programs:

- PL/SQL block structure
- Variables
- Constants
- `SELECT INTO`
- `%TYPE`
- `%ROWTYPE`
- `DBMS_OUTPUT.PUT_LINE`

---

## 2. Conditional Statements

Covers decision-making statements used in e-commerce operations:

- `IF`
- `IF-ELSE`
- `IF-ELSIF-ELSE`
- `CASE`

Examples include:

- Checking order status
- Classifying product stock
- Validating product values

---

## 3. Loops

Covers repetitive execution in PL/SQL:

- Simple `LOOP`
- `WHILE LOOP`
- `FOR LOOP`
- Reverse loops
- Cursor `FOR LOOP`

Examples are connected with products, customers, and orders.

---

## 4. Cursors

Cursors are used to process multiple rows returned from database queries.

This module covers:

- Explicit cursors
- Cursor declaration
- `OPEN`
- `FETCH`
- `CLOSE`
- Cursor attributes
- Parameterized cursors
- Cursor `FOR LOOP`

Examples use the e-commerce tables such as `PRODUCT`, `ORDERS`, and `CUSTOMER`.

---

## ⚠️ 5. Exception Handling

Exception handling is used to handle runtime errors safely.

Covered exceptions include:

- `NO_DATA_FOUND`
- `TOO_MANY_ROWS`
- `ZERO_DIVIDE`
- User-defined exceptions
- `OTHERS`

The examples demonstrate how errors can be handled during e-commerce database operations.

---

# 🔧 6. Procedures

Procedures are used to perform specific database operations.

Examples include:

- Updating order status
- Adding customer reviews
- Performing database validations
- Updating product information

---

# 🔢 7. Functions

Functions return a value after performing a particular operation.

E-commerce examples include:

- Calculating order total
- Counting customer orders
- Calculating product-related values

---

# ⚡ 8. Triggers

Triggers automatically execute when specified database events occur.

Examples include:

- Product stock validation
- Review rating validation
- Order status validation
- Product price validation
- Using `:OLD` and `:NEW`

Triggers help maintain database integrity and enforce business rules.

---

# 🧾 9. Records

Records allow multiple related values to be grouped into a single structure.

This module covers:

- User-defined records
- `%ROWTYPE`
- Processing customer and order information using records

---

# 🔄 10. Transactions

Transactions are used to maintain consistency during database operations.

Covered concepts include:

- `COMMIT`
- `ROLLBACK`
- `SAVEPOINT`

E-commerce examples include performing order and payment operations as part of a transaction.

---

# 🛒 E-Commerce PL/SQL Applications

The final PL/SQL programs connect the concepts directly with the E-Commerce Database Management System.

Applications include:

- Displaying customer details
- Calculating order totals
- Classifying product stock
- Counting customer orders
- Processing customer orders using cursors
- Calculating product revenue
- Finding highly rated products
- Checking payment status
- Checking shipment status
- Generating complete order summaries
- Reducing product stock
- Handling stock-related exceptions
- Generating customer order summaries
- Creating customer order count functions
- Applying product stock triggers
- Applying review rating validation triggers

---

# ▶️ How to Run

### Step 1 — Open Oracle SQL Developer

Connect to the Oracle database containing the existing e-commerce schema.

### Step 2 — Enable Output

Run:

```sql
SET SERVEROUTPUT ON;
```

This allows output from:

```sql
DBMS_OUTPUT.PUT_LINE
```

to be displayed.

### Step 3 — Ensure Module-1 Tables Exist

Make sure the tables from the Module-1 database design are available in the current schema.

The PL/SQL programs use tables such as:

```text
CUSTOMER
CATEGORY
PRODUCT
SUPPLIER
ORDERS
ORDER_ITEM
PAYMENT
SHIPMENT
REVIEW
CART
PRODUCT_SUPPLIER
```

### Step 4 — Run the PL/SQL Files

Run the files in the following order:

```text
01 → PL/SQL Basics
02 → Conditional Statements
03 → Loops
04 → Cursors
05 → Exception Handling
06 → Procedures & Functions
07 → Triggers
08 → Records & Transactions
09 → E-Commerce PL/SQL Programs
```

---

# 🎯 Learning Objectives

After completing this module, the learner should be able to:

- Understand the structure of PL/SQL programs.
- Declare and use variables and constants.
- Apply conditional statements.
- Use different types of loops.
- Work with explicit and parameterized cursors.
- Handle runtime exceptions.
- Create procedures and functions.
- Create and use database triggers.
- Work with records.
- Manage database transactions.
- Apply PL/SQL concepts to an e-commerce database.
- Implement business rules using database programming.

---

# 🔗 Connection With ERD and Database Design

The PL/SQL module is directly connected with the ERD and relational schema created in Module-1.

```text
Module-1
   ↓
ER Diagram
   ↓
Entities + Attributes
   ↓
Relationships + Constraints
   ↓
Relational Database Tables
   ↓
PL/SQL Programs
   ↓
Business Logic + Validation
   ↓
E-Commerce Database System
```

This ensures that the PL/SQL programs are not independent examples but are implemented according to the actual **E-Commerce Database Management System** design.

---

# 👨‍💻 Project Context

**Project:** E-Commerce Database Management System

**Module:** PL/SQL

**Purpose:**  
To implement database programming and business logic for an e-commerce application using PL/SQL.

The module demonstrates how PL/SQL can be used to perform calculations, process records, handle exceptions, enforce business rules, and automate database operations within the e-commerce system.
