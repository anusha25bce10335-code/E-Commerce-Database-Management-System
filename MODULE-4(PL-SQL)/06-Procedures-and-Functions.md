# 06 — Procedures and Functions

## 1. Procedure

A procedure performs an operation.

### Update Order Status

```sql
CREATE OR REPLACE PROCEDURE update_order_status (
    p_order_id IN ORDERS.order_id%TYPE,
    p_status   IN ORDERS.order_status%TYPE
)
IS
BEGIN
    UPDATE ORDERS
    SET order_status = p_status
    WHERE order_id = p_order_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Order not found.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Order status updated.');
    END IF;
END;
/
```

Execute:

```sql
BEGIN
    update_order_status(1001, 'SHIPPED');
END;
/
```

## 2. Function

Calculate total amount of an order.

```sql
CREATE OR REPLACE FUNCTION get_order_total (
    p_order_id IN ORDER_ITEM.order_id%TYPE
)
RETURN NUMBER
IS
    v_total NUMBER(12,2);
BEGIN
    SELECT NVL(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM ORDER_ITEM
    WHERE order_id = p_order_id;

    RETURN v_total;
END;
/
```

Execute:

```sql
DECLARE
    v_total NUMBER;
BEGIN
    v_total := get_order_total(1001);
    DBMS_OUTPUT.PUT_LINE('Order total = ' || v_total);
END;
/
```

## 3. Procedure with Validation

```sql
CREATE OR REPLACE PROCEDURE add_review (
    p_review_id  IN REVIEW.review_id%TYPE,
    p_customer_id IN REVIEW.customer_id%TYPE,
    p_product_id  IN REVIEW.product_id%TYPE,
    p_rating      IN REVIEW.rating%TYPE,
    p_text        IN REVIEW.review_text%TYPE
)
IS
BEGIN
    IF p_rating < 1 OR p_rating > 5 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Rating must be between 1 and 5.');
    END IF;

    INSERT INTO REVIEW
    (
        review_id,
        customer_id,
        product_id,
        rating,
        review_text
    )
    VALUES
    (
        p_review_id,
        p_customer_id,
        p_product_id,
        p_rating,
        p_text
    );

    DBMS_OUTPUT.PUT_LINE('Review added successfully.');
END;
/
```

## 4. Procedure vs Function

| Procedure | Function |
|---|---|
| Mainly performs an action | Mainly returns a value |
| Return value is not compulsory | Must return a value |
| Called using PL/SQL statement | Can be used in expressions when appropriate |
| Example: update order status | Example: calculate order total |
