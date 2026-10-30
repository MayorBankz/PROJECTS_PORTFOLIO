# Retail Sales & Business Performance Analysis

## Business scenario
You are a junior data analyst supporting a fictional Nigerian retail business. Management wants to understand sales performance, customer behaviour, product/category performance, store performance, and data-quality issues using transaction data from **1 January 2025 to 30 September 2026**.

All records and people are synthetic and created for practice. Currency values are in Nigerian naira (NGN).

## Dataset files
- `customers.csv` — customer details and segments
- `categories.csv` — product categories
- `products.csv` — product catalogue, reference price/cost, supplier and reorder level
- `suppliers.csv` — supplier information
- `stores.csv` — store locations and formats
- `staff.csv` — staff roles and store assignments
- `orders.csv` — order headers, channels, payment method and status
- `order_items.csv` — order line items, quantity, actual unit price and discount
- `data_dictionary.csv` — column descriptions and relationships

## Relationships and modelling notes
- `orders` contains one row per order header; `order_items` contains one or more lines per order.
- Join `order_items.order_id` to `orders.order_id`, then use dimension IDs to connect customers, stores, staff, products, categories, and suppliers.
- `products.unit_price` is the catalogue/reference price; `order_items.unit_price` is the actual line-level selling price when available.
- `discount_pct` is a fraction: `0.10` represents 10%.
- Do not assume all orders are realized sales. Investigate `Completed`, `Cancelled`, and `Returned` statuses and document your analysis rule.
- A small number of data-quality issues are intentional: missing values, inconsistent text, invalid quantities/discounts, and a duplicated order line. Find and document them; do not silently change raw files.
- `unit_cost` is a reference cost proxy. If you estimate gross profit, state the assumptions and limitations. The data does not include operating expenses or full inventory movements.

## Business questions

### A. Data quality and preparation
1. What data-quality issues exist? Quantify them and assess their likely impact.
2. Which columns should contain unique keys? Are there duplicate records or orphan foreign keys?
3. How should missing prices, discounts, and customer attributes be handled? Justify each decision.
4. What rules define a valid order line and a completed sale?

### B. Overall sales performance
5. What are total gross sales, discounts, net sales, and estimated gross profit for the period?
6. How do monthly net sales and order counts change over time?
7. Which months show the strongest and weakest performance? What explanations can the data support?
8. What proportion of orders are completed, cancelled, and returned?

### C. Products and categories
9. Which products and categories contribute the most net sales?
10. Which products have the highest estimated gross profit and gross margin?
11. Are there high-volume products with relatively low sales value or margin?
12. Which products may warrant a stock/reorder review based on sales activity and the provided reorder levels? What data limitations affect this analysis?

### D. Customers and channels
13. Which customer types contribute most to net sales and order volume?
14. Who are the top customers by net sales, and how concentrated is revenue among them?
15. How do sales and average order value vary by sales channel and payment method?
16. Do signup cohorts show differences in spending? State the limitations of the available data.

### E. Stores and staff
17. Which stores contribute most and least to net sales, order count, and estimated gross profit?
18. Do store formats or locations show meaningful differences in performance?
19. How does recorded sales performance vary by staff member or role? Avoid treating this as a fair productivity ranking without considering shifts, tenure, and assignment differences.

### F. Recommendations
20. Recommend three to five actions management should consider. Link every recommendation to evidence and describe uncertainty or data limitations.

## Required deliverables
1. **Data audit:** issue log with counts, severity, remediation decision, and rationale.
2. **Analysis-ready dataset/model:** preserve raw data and document reproducible transformations.
3. **SQL analysis:** queries for data quality, sales trends, product/customer/store analysis, and at least one advanced analysis.
4. **Python notebook/script:** data profiling, cleaning decisions, EDA, and at least three useful visualizations.
5. **Power BI report:** overview page plus at least two drill-down pages, useful measures, date handling, and interactive filters.
6. **Business insights report:** concise findings, limitations, and three to five evidence-based recommendations.
7. **GitHub README:** business problem, data model, methods, actual findings, screenshots, and reproduction instructions.
8. **LinkedIn post/article:** explain the problem, tools, one or two actual insights, and lessons learned. Do not invent findings before completing the analysis.

## Suggested project structure
```text
retail-sales-business-analysis/
├── data/
│   ├── raw/
│   ├── cleaned/
│   └── data_dictionary.csv
├── sql/
├── notebooks/
├── powerbi/
├── reports/
├── images/
└── README.md
```

## Project rules
- Keep original raw files unchanged.
- Document assumptions for order status, duplicates, missing values, discount treatment, and cost estimates.
- Separate observed facts from hypotheses.
- Use SQL and Python for analysis, Excel where useful for validation or quick exploration, and Power BI for the final interactive report.
- Do not include solution queries or precomputed findings in your submission. The aim is to complete the analysis independently.
