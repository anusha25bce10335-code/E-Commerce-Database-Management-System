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
│
├── Module-3/
│
└── Module-4/
