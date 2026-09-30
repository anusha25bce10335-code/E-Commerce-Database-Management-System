## 5. Codd's 12 Rules

**Codd's rules**, numbered from **0 to 12**, describe the requirements a database system should satisfy to be considered genuinely relational.

The following table gives a short explanation of each rule and shows how it applies to our e-commerce database project.

|   Rule | Description                                                                                                                                  | How It Shows Up in Our Project                                                                                                 |
| -----: | -------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
|  **0** | **Foundation Rule:** The system must manage data purely through relational features.                                                         | All access happens through SQL on our tables; nothing reads the underlying files directly.                                     |
|  **1** | **Information Rule:** All data must be represented as values inside tables.                                                                  | Even a link such as `category_id` is stored as a plain column value, not as a pointer or memory address.                       |
|  **2** | **Guaranteed Access:** Every individual value must be reachable using the table name, primary key, and column name.                          | Any `Product` row can be reached using its `product_id`.                                                                       |
|  **3** | **Systematic Handling of NULLs:** `NULL` values must be handled consistently throughout the system.                                          | `Address.type` or `Shipment.eta` can be `NULL`, and this is handled consistently.                                              |
|  **4** | **Active Online Catalog:** The database catalog must itself use the relational model.                                                        | Something like `INFORMATION_SCHEMA` can describe our own `Customer`, `Product`, and other tables.                              |
|  **5** | **Comprehensive Data Sublanguage:** The system must provide a comprehensive language for defining and manipulating data.                     | SQL covers table creation, data modification, constraints, views, and transactions.                                            |
|  **6** | **View Updating Rule:** Views that are theoretically updatable should be capable of being updated.                                           | A view such as `top_selling_products`, if designed to be updatable, should support appropriate updates.                        |
|  **7** | **High-Level Insert, Update, and Delete:** Operations should work on sets of rows rather than requiring one row at a time.                   | A single `INSERT` statement can add multiple `OrderItem` rows for an order at once.                                            |
|  **8** | **Physical Data Independence:** Changes to physical storage should not require changes to applications or queries.                           | Adding an index on `Product.category_id` does not require changing existing queries.                                           |
|  **9** | **Logical Data Independence:** Changes to the logical structure should have minimal impact on existing applications and queries.             | Adding a new `Review` table later should not break existing `Order` queries.                                                   |
| **10** | **Integrity Independence:** Integrity constraints should be defined within the database rather than being scattered across application code. | `CHECK (price > 0)` and foreign key constraints are stored and enforced by the database.                                       |
| **11** | **Distribution Independence:** Users should not need to know where data is physically distributed.                                           | Queries should continue to work even if tables are later distributed across different servers.                                 |
| **12** | **Non-Subversion Rule:** No low-level mechanism should bypass relational integrity rules.                                                    | No low-level shortcut should be allowed to bypass a foreign key or `CHECK` constraint, such as directly modifying stored rows. |

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
