# 01 — PL/SQL Basics

## 1. Basic Structure

```sql
SET SERVEROUTPUT ON;

DECLARE
    v_name VARCHAR2(50);
BEGIN
    v_name := 'Customer';
    DBMS_OUTPUT.PUT_LINE('Hello ' || v_name);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

### Structure

```text
DECLARE       -- optional declarations
BEGIN         -- executable statements
EXCEPTION     -- optional error handling
END;
/
```

## 2. Variables

```sql
DECLARE
    v_price NUMBER(10,2);
    v_quantity NUMBER;
    v_total NUMBER(10,2);
BEGIN
    v_price := 500;
    v_quantity := 3;

    v_total := v_price * v_quantity;

    DBMS_OUTPUT.PUT_LINE('Total = ' || v_total);
END;
/
```

## 3. Constants

```sql
DECLARE
    c_tax_rate CONSTANT NUMBER := 0.18;
    v_amount NUMBER := 1000;
    v_tax NUMBER;
BEGIN
    v_tax := v_amount * c_tax_rate;
    DBMS_OUTPUT.PUT_LINE('Tax = ' || v_tax);
END;
/
```

## 4. SELECT INTO

Find a customer's name from the Customer table.

```sql
DECLARE
    v_customer_name CUSTOMER.customer_name%TYPE;
BEGIN
    SELECT customer_name
    INTO v_customer_name
    FROM CUSTOMER
    WHERE customer_id = 1;

    DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer_name);
END;
/
```

`SELECT INTO` must normally return exactly one row.

## 5. %TYPE

```sql
DECLARE
    v_product_name PRODUCT.product_name%TYPE;
    v_price PRODUCT.unit_price%TYPE;
BEGIN
    SELECT product_name, unit_price
    INTO v_product_name, v_price
    FROM PRODUCT
    WHERE product_id = 101;

    DBMS_OUTPUT.PUT_LINE(v_product_name || ' = ' || v_price);
END;
/
```

`%TYPE` makes a variable use the datatype of an existing column.

## 6. %ROWTYPE

```sql
DECLARE
    v_product PRODUCT%ROWTYPE;
BEGIN
    SELECT *
    INTO v_product
    FROM PRODUCT
    WHERE product_id = 101;

    DBMS_OUTPUT.PUT_LINE('Product: ' || v_product.product_name);
    DBMS_OUTPUT.PUT_LINE('Price: ' || v_product.unit_price);
    DBMS_OUTPUT.PUT_LINE('Stock: ' || v_product.stock_quantity);
END;
/
```

`%ROWTYPE` stores an entire row.
