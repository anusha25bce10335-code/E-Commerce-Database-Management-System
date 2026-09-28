# Entities and Attributes

## 1. Customer
- customer_id (Primary Key)
- customer_name
- email
- phone
- city
- state
- registration_date

## 2. Category
- category_id (Primary Key)
- category_name

## 3. Product
- product_id (Primary Key)
- category_id (Foreign Key)
- product_name
- unit_price
- stock_quantity

## 4. Supplier
- supplier_id (Primary Key)
- supplier_name
- city
- contact_email

## 5. Order
- order_id (Primary Key)
- customer_id (Foreign Key)
- order_date
- order_status

## 6. Order_Item
- order_id (Primary Key, Foreign Key)
- product_id (Primary Key, Foreign Key)
- quantity
- unit_price

## 7. Payment
- payment_id (Primary Key)
- order_id (Foreign Key)
- payment_method
- amount
- payment_status

## 8. Shipment
- shipment_id (Primary Key)
- order_id (Foreign Key)
- courier
- shipment_status
- shipping_date
- delivery_date

## 9. Review
- review_id (Primary Key)
- customer_id (Foreign Key)
- product_id (Foreign Key)
- rating
- review_text

## 10. Cart
- cart_id (Primary Key)
- customer_id (Foreign Key)
- product_id (Foreign Key)
- quantity

## 11. Product_Supplier
- product_id (Primary Key, Foreign Key)
- supplier_id (Primary Key, Foreign Key)
