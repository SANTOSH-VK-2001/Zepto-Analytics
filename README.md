# 🛒 Zepto E-commerce SQL Analysis: Inventory & Pricing Insights
![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue?style=for-the-badge&logo=postgresql)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![Data](https://img.shields.io/badge/Analysis-Inventory_&_Revenue-orange?style=for-the-badge)

### 🔗 [View Live Project Website](https://santosh-vk-2001.github.io/Zepto-Analytics/)

---

## 📋 Project Overview
In the fast-paced world of **Quick Commerce**, inventory turnover and pricing precision are the keys to survival. This project analyzes a real-world dataset from **Zepto** to simulate how a Data Analyst optimizes a digital warehouse.

I performed end-to-end analysis: from cleaning "messy" raw data to calculating complex KPIs like **Stock Cover Days** and **Inventory Value at Risk**.



### 🎯 Key Business Questions Addressed:
* 📉 **Promotional Impact:** Which items are our "Loss Leaders"?
* 📦 **Stock Health:** How many days of inventory do we have left for high-demand goods?
* 💰 **Revenue Leakage:** How much potential revenue are we losing due to Out-of-Stock (OOS) items?
* ⚠️ **Dead Stock:** Which products are occupying warehouse space with zero movement?

---

## 🏗️ Database Architecture & Workflow
The data was ingested into a PostgreSQL environment, followed by a rigorous cleaning process.

### 🔧 The Workflow:
1.  **Data Ingestion:** Handled CSV encoding issues and established a primary key structure.
2.  **Normalization:** Converted pricing from Paise to Rupees (₹) for standard reporting.
3.  **Exploratory Data Analysis (EDA):** Audited nulls and category distributions.
4.  **Advanced Querying:** Used **Window Functions** and **CTEs** to rank performance.

---

## 📊 High-Impact SQL Insights

### ⚡ 1. Restock Prioritization (OOS Analysis)
Identifies "popular" products that are currently out of stock to minimize revenue loss.
```sql
SELECT name, category, quantity AS past_sales_volume
FROM zepto
WHERE outOfStock = TRUE
ORDER BY past_sales_volume DESC
LIMIT 10;
```
### 📉 2. Stock Cover (Runway Calculation)
Predicts the "burn rate" of inventory to ensure we never hit zero on essentials.

```SQL
SELECT name, category, availableQuantity,
       ROUND(availableQuantity / NULLIF(quantity / 30.0, 0), 1) AS days_of_stock_left
FROM zepto
WHERE outOfStock = FALSE;
```
### 🏆 3. Category Performance (Window Functions)
Ranking the top 3 items per category to identify "Hero Products."

```SQL
WITH RankedProducts AS (
    SELECT name, category, quantity,
           DENSE_RANK() OVER(PARTITION BY category ORDER BY quantity DESC) as sales_rank
    FROM zepto
)
SELECT * FROM RankedProducts WHERE sales_rank <= 3;
```
### 🚀 Key Project Findings
* **Critical Stockouts:** Approximately X% of the catalog is OOS, signaling a need for supply chain optimization.

* **Capital Efficiency:** Identified "Dead Stock" items—products with high quantity but low historical sales—tying up warehouse capital.

* **Pricing Strategy:** Average discounts hover around X%, with specific categories being used as aggressive acquisition channels.

### 🛠️ Tools Used
* **Database:** PostgreSQL (pgAdmin 4)

* **Documentation:** Markdown & Git

* **Hosting:** GitHub Pages

👤 Author
* **Santosk Khatate - [Check_My_Portfolio](https://santosh-vk-2001.github.io/)**

* **LinkedIn - [LinkedIn/santosh-khatate](https://www.linkedin.com/in/santosh-khatate/)**

* **GitHub - [GitHub/SANTOSH-VK-2001](https://github.com/SANTOSH-VK-2001)**

---

## 🚀 Getting Started (Setup)

To explore this project locally, follow these steps:

### 1. Clone the Repository
```bash
git clone https://github.com/santosh-vk-2001/Zepto-Analytics.git 
cd Zepto-Analytics 
``` 
⭐ If this project helped you learn SQL for E-commerce, feel free to give it a star!
