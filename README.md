# E-Commerce / Online Shopping Database — DBMS Project

A relational database design and implementation for an online shopping platform, built as a DBMS course project. Covers ER modeling, relational schema design, normalization, SQL, PL/SQL.

## Project Structure

```
ecommerce-dbms-project/
├── README.md
├── docs/
│   └── ecommerce_dbms_project_plan.md   # ER design, normalization notes, unit-wise mapping
├── schema/
│   └── ecommerce_schema.sql             # DDL — table creation, constraints, indexes
├── sample_data/
│   └── insert_sample_data.sql           # Sample rows for all tables
├── queries/
│   └── dml_queries.sql                  # Joins, aggregates, subqueries, views, triggers
└── plsql/
    └── procedures_functions.sql         # Stored procedures, functions, cursors
```

## Entities

Customer, Address, Category, Seller, Product, Cart, CartItem, Orders, OrderItem, Payment, Shipment, Review

## How to Run

1. Create a database (MySQL/PostgreSQL/Oracle) and select it.
2. Run `schema/ecommerce_schema.sql` to create all tables.
3. Run `sample_data/insert_sample_data.sql` to populate sample rows.
4. Run `queries/dml_queries.sql` for the query showcase (joins, aggregates, views, triggers).
5. Run `plsql/procedures_functions.sql` for stored procedures/functions (Oracle PL/SQL syntax — adjust for your DBMS if needed).

## Key Design Points

- **Weak entities**: `CartItem` and `OrderItem` use composite primary keys tied to their owning entity (`Cart`/`Orders`).
- **Normalization**: schema is normalized to BCNF — see `docs/` for the UNF → BCNF walkthrough.
- **Transactions**: `place_order` procedure demonstrates ACID properties — atomicity via rollback on insufficient stock, consistency via `CHECK` constraints, and a discussion of isolation levels for the classic "last item in stock" race condition.
- **Indexing**: indexes on foreign key columns used in frequent joins/filters (`Product.category_id`, `Orders.customer_id`, etc.).

