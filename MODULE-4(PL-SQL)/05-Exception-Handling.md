# 05 — Exception Handling

## 1. Predefined Exception — NO_DATA_FOUND

```sql
DECLARE
    v_name CUSTOMER.customer_name%TYPE;
BEGIN
    SELECT customer_name
    INTO v_name
    FROM CUSTOMER
    WHERE customer_id = -1;

    DBMS_OUTPUT.PUT_LINE(v_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Customer not found.');
END;
/
```

## 2. TOO_MANY_ROWS

```sql
DECLARE
    v_name CUSTOMER.customer_name%TYPE;
BEGIN
    SELECT customer_name
    INTO v_name
    FROM CUSTOMER;

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Query returned more than one customer.');
END;
/
```

## 3. ZERO_DIVIDE

```sql
DECLARE
    v_result NUMBER;
BEGIN
    v_result := 100 / 0;

EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Cannot divide by zero.');
END;
/
```

## 4. User-Defined Exception

Prevent a product from being ordered when stock is insufficient.

```sql
DECLARE
    e_insufficient_stock EXCEPTION;

    v_stock PRODUCT.stock_quantity%TYPE;
    v_required NUMBER := 10;
BEGIN
    SELECT stock_quantity
    INTO v_stock
    FROM PRODUCT
    WHERE product_id = 101;

    IF v_stock < v_required THEN
        RAISE e_insufficient_stock;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Stock is sufficient.');

EXCEPTION
    WHEN e_insufficient_stock THEN
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient stock.');
END;
/
```

## 5. OTHERS

```sql
BEGIN
    -- executable statement
    NULL;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
```

`WHEN OTHERS` should normally be the final exception handler.
