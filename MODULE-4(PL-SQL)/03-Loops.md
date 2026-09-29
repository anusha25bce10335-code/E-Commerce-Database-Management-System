# 03 — Loops

## 1. Simple FOR Loop

```sql
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('Number = ' || i);
    END LOOP;
END;
/
```

## 2. WHILE Loop

```sql
DECLARE
    i NUMBER := 1;
BEGIN
    WHILE i <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE('Number = ' || i);
        i := i + 1;
    END LOOP;
END;
/
```

## 3. Reverse Loop

```sql
BEGIN
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
```

## 4. Loop Through Products

```sql
BEGIN
    FOR r IN (
        SELECT product_id, product_name, stock_quantity
        FROM PRODUCT
        ORDER BY product_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.product_id || ' - ' ||
            r.product_name || ' - Stock: ' ||
            r.stock_quantity
        );
    END LOOP;
END;
/
```

This is a cursor FOR loop. Oracle automatically opens, fetches and closes the implicit cursor.
