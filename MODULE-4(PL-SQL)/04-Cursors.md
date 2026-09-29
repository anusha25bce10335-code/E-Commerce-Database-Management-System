# 04 — Cursors

## 1. What is a Cursor?

A cursor allows PL/SQL to process the rows returned by a query one row at a time.

## 2. Explicit Cursor

Display all products.

```sql
DECLARE
    CURSOR c_products IS
        SELECT product_id, product_name, unit_price
        FROM PRODUCT
        ORDER BY product_id;

    v_id PRODUCT.product_id%TYPE;
    v_name PRODUCT.product_name%TYPE;
    v_price PRODUCT.unit_price%TYPE;
BEGIN
    OPEN c_products;

    LOOP
        FETCH c_products INTO v_id, v_name, v_price;
        EXIT WHEN c_products%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            v_id || ' | ' || v_name || ' | ' || v_price
        );
    END LOOP;

    CLOSE c_products;
END;
/
```

## 3. Cursor FOR Loop

```sql
DECLARE
    CURSOR c_orders IS
        SELECT order_id, customer_id, order_status
        FROM ORDERS;
BEGIN
    FOR r IN c_orders LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Order ' || r.order_id ||
            ' Customer ' || r.customer_id ||
            ' Status ' || r.order_status
        );
    END LOOP;
END;
/
```

## 4. Parameterized Cursor

Find orders for a particular customer.

```sql
DECLARE
    CURSOR c_customer_orders(p_customer_id CUSTOMER.customer_id%TYPE) IS
        SELECT order_id, order_date, order_status
        FROM ORDERS
        WHERE customer_id = p_customer_id;

BEGIN
    FOR r IN c_customer_orders(1) LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.order_id || ' | ' ||
            r.order_date || ' | ' ||
            r.order_status
        );
    END LOOP;
END;
/
```

## 5. Cursor Attributes

Common attributes:

- `%FOUND`
- `%NOTFOUND`
- `%ROWCOUNT`
- `%ISOPEN`

Example:

```sql
DECLARE
    CURSOR c_product IS
        SELECT product_id, product_name FROM PRODUCT;
BEGIN
    OPEN c_product;

    LOOP
        FETCH c_product INTO :id, :name;
        EXIT WHEN c_product%NOTFOUND;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Rows processed = ' || c_product%ROWCOUNT);

    CLOSE c_product;
END;
/
```

> If bind variables are not configured in your SQL Developer worksheet, use a normal local-variable version instead.
