# Module 3 — Practice Questions and Mini Exercises

This file is for revision and hands-on SQL practice using the e-commerce dataset.

## Part A — Basic SELECT

### Q1
Display all customers.

### Q2
Display the names and cities of all customers.

### Q3
Display products with a price greater than 1000.

### Q4
Display products from highest to lowest price.

### Q5
Display unique customer cities.

---

## Part B — WHERE, NULL and Sorting

### Q6
Find customers from a particular city.

### Q7
Find products whose price is between 500 and 2000.

### Q8
Find products whose names start with the letter `S`.

### Q9
Find customers whose city is either Delhi or Jaipur.

### Q10
Find records where a selected column is NULL.

**Hint:** Use `IS NULL`.

---

## Part C — Aggregate Functions

### Q11
Find the total number of products.

**Hint:**

```sql
COUNT(*)
```

### Q12
Find the average product price.

### Q13
Find the minimum and maximum product price.

### Q14
Find the total quantity sold from `order_items`.

**Hint:** Use `SUM()`.

---

## Part D — GROUP BY and HAVING

### Q15
Find the number of products in each category.

### Q16
Find the average price for each category.

### Q17
Display only categories containing more than 3 products.

**Hint:** Use `HAVING`.

### Q18
Find total quantity sold for each product.

---

## Part E — Joins

### Q19
Display customer names along with their order IDs.

**Hint:** Join `customers` and `orders`.

### Q20
Display order IDs and product IDs from `order_items`.

### Q21
Display product names and their category IDs.

### Q22
Find customers who have not placed any order.

**Hint:** Try a `LEFT JOIN` and `IS NULL`.

---

## Part F — Nested / Subqueries

### Q23
Find products whose price is greater than the average product price.

### Q24
Find customers who have placed at least one order.

### Q25
Find products that have never been ordered.

### Q26
Find customers who have placed more than 3 orders.

---

## Part G — Set Operators

### Q27
Use `UNION` to display cities appearing in both customers and suppliers.

### Q28
Demonstrate the difference between `UNION` and `UNION ALL`.

### Q29
If supported by your DBMS, practice `INTERSECT`.

### Q30
If using Oracle, practice `MINUS`.

---

## Part H — DML and TCL

### Q31
Insert one new customer.

### Q32
Update the city of that customer.

### Q33
Create a savepoint before deleting a row.

### Q34
Rollback to the savepoint.

### Q35
Commit a safe transaction.

---

## Part I — Views and Indexes

### Q36
Create a view showing customer names and order IDs.

### Q37
Retrieve data from the view.

### Q38
Create an index on `orders.customer_id`.

### Q39
Explain why an index can improve search performance.

### Q40
Compare a table and a view.

---

## Part J — Exam-Style Application Questions

### Q41
An online store wants a report showing the number of products and average price for every category. Which SQL clauses/functions would you use?

**Expected concepts:** `COUNT`, `AVG`, `GROUP BY`.

### Q42
The database administrator wants to find customers who have never ordered anything. Which type of join is useful?

**Expected concept:** `LEFT JOIN` + `IS NULL`.

### Q43
A manager wants products costing more than the average product price. Should you use a join or a subquery?

**Expected concept:** nested/subquery with `AVG()`.

### Q44
A frequently searched foreign key is slowing down query access. What database object could be considered?

**Expected concept:** index.

### Q45
A company wants users to see customer order information without giving them direct access to every underlying column. Which database object could help?

**Expected concept:** view.

---

## Mini Project Exercise

Create a small SQL report containing:

1. Total number of customers.
2. Total number of products.
3. Average product price.
4. Total number of orders.
5. Top-selling products.
6. Sales grouped by category.
7. Customers with no orders.
8. A view for customer order summary.
9. An index on a frequently searched foreign key.
10. One transaction using `SAVEPOINT` and `ROLLBACK`.

This exercise combines the major Module 3 concepts.
