## 5. Codd's 12 Rules

**Codd's rules**, numbered from **0 to 12**, describe the requirements a database system should satisfy to be considered genuinely relational.

The following table gives a short explanation of each rule and shows how it applies to our e-commerce database project.

| Rule   | Description                                                                                                                                  | How It Shows Up in Our Project                                                                                                       |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **0**  | **Foundation Rule:** The system must manage data purely through relational features.                                                         | All data access is performed through SQL on the project tables rather than directly accessing stored files.                          |
| **1**  | **Information Rule:** All data must be represented as values inside tables.                                                                  | Data such as `category_id`, `customer_id`, and `supplier_id` are stored as column values in relations.                               |
| **2**  | **Guaranteed Access:** Every individual value must be reachable using the table name, primary key, and column name.                          | Any product value can be accessed using `products`, its `product_id`, and the required column such as `unit_price`.                  |
| **3**  | **Systematic Handling of NULLs:** `NULL` values must be handled consistently throughout the system.                                          | Optional values such as `phone`, `contact_email`, or `review_text` can be `NULL` where permitted, and SQL handles them consistently. |
| **4**  | **Active Online Catalog:** The database catalog must itself use the relational model.                                                        | Metadata systems such as `INFORMATION_SCHEMA` can describe tables such as `customers`, `products`, `orders`, and `payments`.         |
| **5**  | **Comprehensive Data Sublanguage:** The system must provide a comprehensive language for defining and manipulating data.                     | SQL supports table creation, data modification, constraints, queries, views, and transactions.                                       |
| **6**  | **View Updating Rule:** Views that are theoretically updatable should be capable of being updated.                                           | A suitable view based on project tables can support updates when it satisfies the conditions for an updatable view.                  |
| **7**  | **High-Level Insert, Update, and Delete:** Operations should work on sets of rows rather than requiring one row at a time.                   | SQL can insert, update, or delete multiple `order_items`, `reviews`, or other rows using a single statement.                         |
| **8**  | **Physical Data Independence:** Changes to physical storage should not require changes to applications or queries.                           | Adding an index on `products.category_id` or `order_items.order_id` does not require changing existing SQL queries.                  |
| **9**  | **Logical Data Independence:** Changes to the logical structure should have minimal impact on existing applications and queries.             | Adding a new attribute or related relation, when properly managed, should minimize changes to existing queries.                      |
| **10** | **Integrity Independence:** Integrity constraints should be defined within the database rather than being scattered across application code. | Constraints such as `products.unit_price > 0`, `stock_quantity >= 0`, and foreign keys are defined and enforced by the database.     |
| **11** | **Distribution Independence:** Users should not need to know where data is physically distributed.                                           | Queries should continue to work even if the project tables are later distributed across different database servers.                  |
| **12** | **Non-Subversion Rule:** No low-level mechanism should bypass relational integrity rules.                                                    | Low-level access should not be allowed to bypass foreign-key, primary-key, or `CHECK` constraints.                                   |

### Quick Summary

```text
Codd's Rules
      │
      ├── Relational Data Representation
      │      ├── Rule 1: Information
      │      ├── Rule 2: Guaranteed Access
      │      └── Rule 3: NULL Handling
      │
      ├── Relational Operations
      │      ├── Rule 5: Comprehensive Language
      │      ├── Rule 6: View Updating
      │      └── Rule 7: Set-Level Operations
      │
      ├── Data Independence
      │      ├── Rule 8: Physical
      │      ├── Rule 9: Logical
      │      └── Rule 11: Distribution
      │
      └── Integrity & Foundation
             ├── Rule 0: Foundation
             ├── Rule 10: Integrity
             └── Rule 12: Non-Subversion
```
