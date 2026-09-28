# E-Commerce / Online Shopping DBMS Dataset

This synthetic dataset is designed around a single E-Commerce database and is suitable for DBMS Modules 1-4:
ER modeling, relational algebra/calculus, normalization, SQL, PL/SQL, indexing, B+ trees, hashing, query processing and optimization.

## Tables
- customers: customer master data
- categories: product categories
- products: product master data and stock
- suppliers: supplier master data
- product_supplier: many-to-many relationship between products and suppliers
- orders: customer orders
- order_items: products inside each order
- payments: payment information for orders
- shipments: shipment/delivery information
- reviews: customer reviews and ratings
- cart: current shopping-cart items

## Suggested primary keys
customers(customer_id)
categories(category_id)
products(product_id)
suppliers(supplier_id)
product_supplier(product_id, supplier_id)
orders(order_id)
order_items(order_id, product_id)
payments(payment_id)
shipments(shipment_id)
reviews(review_id)
cart(cart_id)

## Main foreign keys
products.category_id -> categories.category_id
product_supplier.product_id -> products.product_id
product_supplier.supplier_id -> suppliers.supplier_id
orders.customer_id -> customers.customer_id
order_items.order_id -> orders.order_id
order_items.product_id -> products.product_id
payments.order_id -> orders.order_id
shipments.order_id -> orders.order_id
reviews.customer_id -> customers.customer_id
reviews.product_id -> products.product_id
cart.customer_id -> customers.customer_id
cart.product_id -> products.product_id

## Good practice questions
1. Find all customers from a particular city.
2. List products costing more than the average product price.
3. Find customers who have placed more than 3 orders.
4. Find the top-selling products.
5. Find customers who bought every product in a category (Division).
6. Find products that have never been ordered.
7. Find total sales by category using GROUP BY.
8. Find customers with no orders using an OUTER JOIN.
9. Create views for customer order summary and product sales.
10. Create indexes on foreign keys and frequently searched columns.
11. Use PL/SQL procedures/functions to calculate order totals.
12. Use an explicit cursor to process delivered orders.
13. Create triggers for stock updates after inserting order_items.
14. Compare query plans before/after indexing.
15. Practice B+ tree and hashing concepts using product_id, customer_id, and order_id.

## Normalization practice
The separate tables intentionally give you material to discuss 1NF, 2NF, 3NF and BCNF. 
For example, order_items separates repeating product groups from orders, while product_supplier resolves the many-to-many supplier relationship.
