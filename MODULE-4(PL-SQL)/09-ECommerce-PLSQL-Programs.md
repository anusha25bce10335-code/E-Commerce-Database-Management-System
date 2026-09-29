# 09 — E-Commerce PL/SQL Programs

These programs combine the PL/SQL concepts with the e-commerce entities from Module-1.

## Program 1 — Display Customer Details

```sql
DECLARE
    v_customer CUSTOMER%ROWTYPE;
BEGIN
    SELECT *
    INTO v_customer
    FROM CUSTOMER
    WHERE customer_id = 1;

    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer.customer_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_customer.customer_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_customer.email);
    DBMS_OUTPUT.PUT_LINE('City: ' || v_customer.city);
END;
/
```

## Program 2 — Calculate Order Total

```sql
DECLARE
    v_order_id ORDER_ITEM.order_id%TYPE := 1001;
    v_total NUMBER(12,2);
BEGIN
    SELECT NVL(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM ORDER_ITEM
    WHERE order_id = v_order_id;

    DBMS_OUTPUT.PUT_LINE('Order Total = ' || v_total);
END;
/
```

## Program 3 — Product Stock Classification

```sql
DECLARE
    v_stock PRODUCT.stock_quantity%TYPE;

BEGIN
    SELECT stock_quantity
    INTO v_stock
    FROM PRODUCT
    WHERE product_id = 101;

    IF v_stock = 0 THEN
        DBMS_OUTPUT.PUT_LINE('OUT OF STOCK');
    ELSIF v_stock <= 10 THEN
        DBMS_OUTPUT.PUT_LINE('LOW STOCK');
    ELSE
        DBMS_OUTPUT.PUT_LINE('AVAILABLE');
    END IF;
END;
/
```

## Program 4 — Customer Order Count

```sql
DECLARE
    v_customer_id CUSTOMER.customer_id%TYPE := 1;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM ORDERS
    WHERE customer_id = v_customer_id;

    DBMS_OUTPUT.PUT_LINE(
        'Number of orders = ' || v_count
    );
END;
/
```

## Program 5 — Display All Orders of a Customer

```sql
DECLARE
    CURSOR c_orders(p_customer_id NUMBER) IS
        SELECT order_id, order_date, order_status
        FROM ORDERS
        WHERE customer_id = p_customer_id
        ORDER BY order_date;

BEGIN
    FOR r IN c_orders(1) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Order ID: ' || r.order_id ||
            ', Date: ' || r.order_date ||
            ', Status: ' || r.order_status
        );
    END LOOP;
END;
/
```

## Program 6 — Calculate Product Revenue

```sql
DECLARE
    v_product_id ORDER_ITEM.product_id%TYPE := 101;
    v_revenue NUMBER(12,2);
BEGIN
    SELECT NVL(SUM(quantity * unit_price), 0)
    INTO v_revenue
    FROM ORDER_ITEM
    WHERE product_id = v_product_id;

    DBMS_OUTPUT.PUT_LINE(
        'Product Revenue = ' || v_revenue
    );
END;
/
```

## Program 7 — Find Highest Rated Product

```sql
DECLARE
    v_product_id PRODUCT.product_id%TYPE;
    v_rating NUMBER;
BEGIN
    SELECT product_id, rating
    INTO v_product_id, v_rating
    FROM (
        SELECT product_id, rating
        FROM REVIEW
        ORDER BY rating DESC
    )
    WHERE ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE(
        'Product ID: ' || v_product_id ||
        ', Rating: ' || v_rating
    );
END;
/
```

## Program 8 — Payment Status Check

```sql
DECLARE
    v_status PAYMENT.payment_status%TYPE;
BEGIN
    SELECT payment_status
    INTO v_status
    FROM PAYMENT
    WHERE payment_id = 501;

    CASE v_status
        WHEN 'PAID' THEN
            DBMS_OUTPUT.PUT_LINE('Payment successful.');
        WHEN 'PENDING' THEN
            DBMS_OUTPUT.PUT_LINE('Payment is pending.');
        WHEN 'FAILED' THEN
            DBMS_OUTPUT.PUT_LINE('Payment failed.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown payment status.');
    END CASE;
END;
/
```

## Program 9 — Shipment Status

```sql
DECLARE
    v_status SHIPMENT.shipment_status%TYPE;
BEGIN
    SELECT shipment_status
    INTO v_status
    FROM SHIPMENT
    WHERE shipment_id = 701;

    IF v_status = 'DELIVERED' THEN
        DBMS_OUTPUT.PUT_LINE('Shipment delivered.');
    ELSIF v_status = 'SHIPPED' THEN
        DBMS_OUTPUT.PUT_LINE('Shipment is in transit.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Shipment status: ' || v_status);
    END IF;
END;
/
```

## Program 10 — Complete Order Summary

```sql
DECLARE
    v_order_id ORDERS.order_id%TYPE := 1001;
    v_customer CUSTOMER.customer_name%TYPE;
    v_status ORDERS.order_status%TYPE;
    v_total NUMBER(12,2);
BEGIN
    SELECT c.customer_name, o.order_status
    INTO v_customer, v_status
    FROM ORDERS o
    JOIN CUSTOMER c
      ON c.customer_id = o.customer_id
    WHERE o.order_id = v_order_id;

    SELECT NVL(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM ORDER_ITEM
    WHERE order_id = v_order_id;

    DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer);
    DBMS_OUTPUT.PUT_LINE('Order Status: ' || v_status);
    DBMS_OUTPUT.PUT_LINE('Order Total: ' || v_total);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Order not found.');
END;
/
```

## Program 11 — Reduce Product Stock After an Order Item

```sql
DECLARE
    v_product_id ORDER_ITEM.product_id%TYPE := 101;
    v_quantity ORDER_ITEM.quantity%TYPE := 2;
    v_stock PRODUCT.stock_quantity%TYPE;

    e_insufficient_stock EXCEPTION;
BEGIN
    SELECT stock_quantity
    INTO v_stock
    FROM PRODUCT
    WHERE product_id = v_product_id
    FOR UPDATE;

    IF v_stock < v_quantity THEN
        RAISE e_insufficient_stock;
    END IF;

    UPDATE PRODUCT
    SET stock_quantity = stock_quantity - v_quantity
    WHERE product_id = v_product_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Stock updated successfully.');

EXCEPTION
    WHEN e_insufficient_stock THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Insufficient stock.');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Product not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

## Program 12 — Customer Order Summary Using Cursor

```sql
DECLARE
    CURSOR c_summary IS
        SELECT c.customer_id,
               c.customer_name,
               COUNT(o.order_id) AS total_orders
        FROM CUSTOMER c
        LEFT JOIN ORDERS o
          ON c.customer_id = o.customer_id
        GROUP BY c.customer_id, c.customer_name
        ORDER BY c.customer_id;

BEGIN
    FOR r IN c_summary LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.customer_id || ' | ' ||
            r.customer_name || ' | Orders: ' ||
            r.total_orders
        );
    END LOOP;
END;
/
```

## Program 13 — Function for Customer Order Count

```sql
CREATE OR REPLACE FUNCTION get_customer_order_count (
    p_customer_id IN CUSTOMER.customer_id%TYPE
)
RETURN NUMBER
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM ORDERS
    WHERE customer_id = p_customer_id;

    RETURN v_count;
END;
/
```

Test:

```sql
SELECT get_customer_order_count(1)
FROM dual;
```

## Program 14 — Trigger for Product Stock

```sql
CREATE OR REPLACE TRIGGER trg_product_stock_check
BEFORE INSERT OR UPDATE OF stock_quantity
ON PRODUCT
FOR EACH ROW
BEGIN
    IF :NEW.stock_quantity < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Stock cannot be negative.'
        );
    END IF;
END;
/
```

## Program 15 — Trigger for Review Rating

```sql
CREATE OR REPLACE TRIGGER trg_review_rating_check
BEFORE INSERT OR UPDATE OF rating
ON REVIEW
FOR EACH ROW
BEGIN
    IF :NEW.rating < 1 OR :NEW.rating > 5 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Rating must be between 1 and 5.'
        );
    END IF;
END;
/
```
