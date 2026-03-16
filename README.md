## 🔍 Overview

This project showcases SQL queries used to explore and analyze warehouse datasets, including product movement, handler performance, and inventory flow. The SQL work demonstrates the ability to:

- Clean and structure raw data  
- Join multiple tables  
- Build CTE‑driven logic  
- Use window functions for ranking and time‑based analysis  
- Extract insights that support supply chain and operations decision‑making  

The visuals included in this repository summarize key findings and show how SQL outputs translate into business‑ready insights.

---

## 🧠 Skills Demonstrated

- Joins (INNER, LEFT, FULL)  
- Common Table Expressions (CTEs)  
- Window Functions (ROW_NUMBER, RANK, LAG, LEAD)  
- Aggregations & Grouping  
- Data Cleaning & Filtering  
- Business Logic Development  
- Operational KPI Interpretation  

## 🖼️ Screenshot 1 — Outbound SKU Velocity Report

![Outbound SKU Velocity](QUERY_ONE_OUTBOUND_SKU_VELOCITY_REPORT.png)

**Summary:**  
This screenshot represents the outbound SKU velocity analysis. It highlights which products are moving fastest through the warehouse, helping identify high‑velocity SKUs that require priority slotting, faster replenishment, or dedicated handling strategies. This visual translates raw SQL output into operational insight that supports inventory planning and warehouse flow optimization.

## 🖼️ Screenshot 2 — SKU Movement Velocity

![SKU Movement Velocity](QUERY_TWO_SKU_MOVEMENT_VELOCITY.png)

**Summary:**  
This screenshot represents the SKU movement velocity analysis. It highlights how frequently each SKU moves through the warehouse, allowing you to identify fast‑moving, slow‑moving, and stagnant products. This insight supports decisions around slotting, replenishment cycles, storage optimization, and overall warehouse flow efficiency.

## 🖼️ Screenshot 3 — Category Movement Flow

![Category Movement Flow](QUERY_THREE_CATEGORY_MOVEMENT_FLOW.png)

**Summary:**  
This screenshot shows the category‑level movement flow analysis. It identifies which product categories move the most through the warehouse and breaks their activity into inbound and outbound movement. This helps reveal which categories drive the highest operational load, where warehouse strain is concentrated, and how category‑level demand patterns shape storage, replenishment, and labor planning.

## 🖼️ Screenshot 4 — Orphaned Transaction Audit

![Orphaned Transaction Audit](QUERY_FOUR_ORPHANED_TRANSACTION_AUDIT.png)

**Summary:**  
This screenshot highlights the orphaned transaction audit, which identifies transactions that do not have matching parent records. These “orphaned” entries often signal data integrity issues such as incomplete loads, failed joins, or mismatched foreign keys. This audit is essential for maintaining clean warehouse data, ensuring accurate reporting, and preventing downstream analytical errors.

## 🖼️ Screenshot 5 — Inventory Turnover Ratio

![Inventory Turnover Ratio](QUERY_FIVE_INVENTORY_TURNOVER_RATIO.png)

**Summary:**  
This screenshot shows the inventory turnover ratio analysis, a key metric that measures how efficiently inventory is being cycled through the warehouse. A higher turnover ratio indicates strong product movement and optimized stock levels, while a lower ratio can signal overstocking, slow‑moving items, or capital tied up in excess inventory. This metric is essential for evaluating operational efficiency and guiding replenishment, purchasing, and storage decisions.

## 🖼️ Screenshot 6 — Warehouse Zone Movement Summary

![Warehouse Zone Movement Summary](QUERY_SIX_WAREHOUSE_ZONE_MOVEMENT_SUMMARY.png)

**Summary:**  
This screenshot shows the warehouse zone movement summary, breaking down product flow by physical warehouse zones. It highlights which zones experience the highest traffic, which areas are underutilized, and how movement patterns shift across inbound, outbound, and internal transfers. This analysis supports decisions around layout optimization, labor allocation, congestion reduction, and overall warehouse efficiency.

## 🖼️ Screenshot 7 — Daily Handler Productivity Report

![Daily Handler Productivity Report](QUERY_SEVEN_DAILY_HANDLER_PRODUCTIVITY_REPORT.png)

**Summary:**  
This screenshot displays the daily handler productivity report, breaking down how many units each handler processed within a given day. It highlights top performers, identifies potential bottlenecks, and reveals workload distribution across the team. This metric is essential for labor planning, performance coaching, and ensuring operational throughput remains consistent across shifts.



