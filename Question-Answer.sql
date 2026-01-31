drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightIngms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);


SELECT * FROM ZEPTO

---1 * Which products have the highest gap between MRP and Discounted Selling Price? (Identifies "loss leaders" or heavy promotion items.)

SELECT sku_id, name ,category,mrp,discountedsellingprice, (mrp - discountedsellingprice) AS highest_gap
FROM zepto
ORDER BY highest_gap DESC
Limit 5

---2  * What are the top 5 "Premium" products? (Defined by high MRP and low Discount Percent.)
SELECT sku_id, name, mrp , discountpercent
FROM zepto
ORDER BY mrp DESC , discountpercent ASC
Limit 10

--3 * What is the average discount percentage across different categories? (Helps identify if you are over-discounting in high-demand areas.)
SELECT  category, ROUND(AVG(discountpercent),2) AS average_discount_percentage
FROM zepto
GROUP BY category
ORDER BY average_discount_percentage

--4 * What is the total potential revenue if all availableQuantity is sold at the discountedSellingPrice?
--formula sum= 1*2 
SELECT  SUM(availableQuantity * discountedSellingPrice) AS total_potential_revenue
FROM zepto
WHERE outofstock = false

--5 * Is there a correlation between the discountPercent and the outOfStock status? (Does a higher discount lead to faster stockouts?)
SELECT outOfStock, ROUND(AVG(discountPercent),2) AS Avg_percent
FROM zepto
GROUP BY outofstock

--6 * Which Category contributes the most to the total value of inventory on hand?
SELECT Category, SUM(discountedsellingprice * availablequantity) AS Total_Inventory_Value
FROM zepto
GROUP BY Category
ORDER BY Total_Inventory_Value DESC
LIMIT 5;


-- 7* Which items are currently outOfStock but have a high historical quantity (sales volume)? (Prioritizes restocking.)
SELECT name, Category, COUNT(*) AS popularity_score, MAX(mrp) AS price
FROM zepto
WHERE outOfStock = TRUE
GROUP BY name, Category
ORDER BY popularity_score DESC, price DESC
LIMIT 15;

-- 8* What is the 'Stock Cover' for each category? (Calculated by comparing availableQuantity against sales trends to see how many days of stock are left.)
SELECT sku_id, name, category,availablequantity,
ROUND(availablequantity / NULLIF(quantity / 30.0, 0),1) AS stock_cover_days
FROM zepto
WHERE outofstock = FALSE;

-- 9* Which products have high availableQuantity but zero or low movement? (Identifies "dead stock" that is tying up capital.)
SELECT sku_id, name, category,availablequantity,
ROUND(availablequantity / NULLIF(quantity / 30.0, 0),1) AS stock_cover_days
FROM zepto
WHERE outofstock = FALSE;

-- 10* What percentage of the total catalog is currently outOfStock? (A key KPI for supply chain health.)
SELECT ROUND (100.0 * SUM(CASE WHEN outofstock THEN 1 ELSE 0 END ) / COUNT(*),2) AS out_of_stock_percentage
FROM zepto






