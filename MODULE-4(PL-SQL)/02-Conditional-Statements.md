# 02 — Conditional Statements

## 1. IF-ELSIF-ELSE

Display a product stock status.

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
    ELSIF v_stock < 10 THEN
        DBMS_OUTPUT.PUT_LINE('LOW STOCK');
    ELSE
        DBMS_OUTPUT.PUT_LINE('STOCK AVAILABLE');
    END IF;
END;
/
```

## 2. CASE Statement

Classify a product based on price.

```sql
DECLARE
    v_price PRODUCT.unit_price%TYPE;
    v_category VARCHAR2(20);
BEGIN
    SELECT unit_price
    INTO v_price
    FROM PRODUCT
    WHERE product_id = 101;

    v_category :=
        CASE
            WHEN v_price >= 50000 THEN 'PREMIUM'
            WHEN v_price >= 10000 THEN 'MID-RANGE'
            ELSE 'BUDGET'
        END;

    DBMS_OUTPUT.PUT_LINE('Price category = ' || v_category);
END;
/
```

## 3. CASE with Order Status

```sql
DECLARE
    v_status ORDERS.order_status%TYPE;
BEGIN
    SELECT order_status
    INTO v_status
    FROM ORDERS
    WHERE order_id = 1001;

    CASE v_status
        WHEN 'PLACED' THEN
            DBMS_OUTPUT.PUT_LINE('Order has been placed.');
        WHEN 'SHIPPED' THEN
            DBMS_OUTPUT.PUT_LINE('Order is on the way.');
        WHEN 'DELIVERED' THEN
            DBMS_OUTPUT.PUT_LINE('Order delivered.');
        WHEN 'CANCELLED' THEN
            DBMS_OUTPUT.PUT_LINE('Order cancelled.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown status.');
    END CASE;
END;
/
```
