# 08 — Records and Transactions

## 1. User-Defined Record

```sql
DECLARE
    TYPE customer_record IS RECORD (
        id    CUSTOMER.customer_id%TYPE,
        name  CUSTOMER.customer_name%TYPE,
        email CUSTOMER.email%TYPE
    );

    v_customer customer_record;
BEGIN
    SELECT customer_id, customer_name, email
    INTO v_customer.id, v_customer.name, v_customer.email
    FROM CUSTOMER
    WHERE customer_id = 1;

    DBMS_OUTPUT.PUT_LINE('ID: ' || v_customer.id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_customer.name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_customer.email);
END;
/
```

## 2. Transaction Control

Place an order and commit:

```sql
INSERT INTO ORDERS
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 1, SYSDATE, 'PLACED');

COMMIT;
```

Undo uncommitted changes:

```sql
ROLLBACK;
```

Create a savepoint:

```sql
SAVEPOINT before_payment;
```

Rollback to it:

```sql
ROLLBACK TO before_payment;
```

## 3. Order + Payment Transaction

```sql
BEGIN
    INSERT INTO ORDERS
    (order_id, customer_id, order_date, order_status)
    VALUES
    (1002, 1, SYSDATE, 'PLACED');

    INSERT INTO PAYMENT
    (payment_id, order_id, payment_method, amount, payment_status)
    VALUES
    (501, 1002, 'UPI', 2500, 'PAID');

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Order and payment committed.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction failed: ' || SQLERRM);
END;
/
```

Both operations succeed together or the transaction is rolled back.
