# 07 — Triggers

## 1. What is a Trigger?

A trigger is a stored PL/SQL program that automatically executes when a specified database event occurs.

## 2. Product Stock Validation Trigger

The Module-1 constraints state that product stock should not be negative. This trigger prevents negative stock values.

```sql
CREATE OR REPLACE TRIGGER trg_product_stock_check
BEFORE INSERT OR UPDATE OF stock_quantity
ON PRODUCT
FOR EACH ROW
BEGIN
    IF :NEW.stock_quantity < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Stock quantity cannot be negative.'
        );
    END IF;
END;
/
```

## 3. Review Rating Validation Trigger

The linked constraints specify a rating range of 1 to 5.

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

## 4. Order Status Validation Trigger

```sql
CREATE OR REPLACE TRIGGER trg_order_status_check
BEFORE INSERT OR UPDATE OF order_status
ON ORDERS
FOR EACH ROW
BEGIN
    IF :NEW.order_status NOT IN
       ('PLACED', 'SHIPPED', 'DELIVERED', 'CANCELLED') THEN

        RAISE_APPLICATION_ERROR(
            -20004,
            'Invalid order status.'
        );
    END IF;
END;
/
```

## 5. :OLD and :NEW

For row-level triggers:

- `:OLD` = old value
- `:NEW` = new value

Example:

```sql
CREATE OR REPLACE TRIGGER trg_product_price_check
BEFORE UPDATE OF unit_price
ON PRODUCT
FOR EACH ROW
BEGIN
    IF :NEW.unit_price <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Product price must be greater than zero.'
        );
    END IF;
END;
/
```
