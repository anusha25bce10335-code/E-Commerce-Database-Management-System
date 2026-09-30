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

## Module 2 – SQL

Topics covered:

- DDL Commands
- DML Commands
- TCL Commands
- SELECT Statements
- Aggregate Functions
- NULL Values
- GROUP BY and ORDER BY
- Subqueries
- Joins
- Set Operators
- SQL Functions
- Multiple Table Queries
- Views
- Indexes
- Sequences
- Synonyms
- Data Dictionary
- Triggers

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
│   ├── Relational-Model-and-Schema.md      
│   ├── Keys-and-Integrity-Rules.md        
│   ├── Relational-Algebra.md              
│   ├── Tuple-Relational-Calculus.md       
│   ├── Codds-Rules.md                     
│   ├── UML-Class-Diagram.md               
│   └── Normalization.md
│                   
├── Module-3/
│
└── Module-4/
    ├── 01-PLSQL-Basics.md
    ├── 02-Conditional-Statements.md
    ├── 03-Loops.md
    ├── 04-Cursors.md
    ├── 05-Exception-Handling.md
    ├── 06-Procedures-and-Functions.md
    ├── 07-Triggers.md
    ├── 08-Records-and-Transactions.md
    └── 09-ECommerce-PLSQL-Programs.md
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

# 📁 PL/SQL Module Structure

```text
PL-SQL/
│
├── README.md
├── 01-PLSQL-Basics.md
├── 02-Conditional-Statements.md
├── 03-Loops.md
├── 04-Cursors.md
├── 05-Exception-Handling.md
├── 06-Procedures-and-Functions.md
├── 07-Triggers.md
├── 08-Records-and-Transactions.md
└── 09-ECommerce-PLSQL-Programs.md
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
