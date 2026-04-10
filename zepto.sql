create database zepto ;
use zepto;

-- data exploration
select count(*) from zepto_v2;
select * from zepto_v2 limit 10;

-- null values
select * from zepto_v2
where name is null
or
category is null
or
name is null
or
mrp is null
or 
discountpercent is null
or
availablequantity is null
or 
discountedsellingprice is null
or
weightInGms is null
or 
outofstock is null
or
quantity is null ;

-- different product categories
select distinct category
from zepto_v2
order by category;

-- PRODUCT NAMES PRESENT MULTIPLE TIMES
select distinct name
 from zepto_v2
group by name ;
-- data cleaning
-- products with price =0
select * 
from zepto_v2
where mrp = 0 or discountedsellingprice = 0;

-- convert paise to rupees
SELECT mrp,
       mrp/100 AS mrp_in_rupees,
       discountedsellingprice,
       discountedsellingprice/100 AS dsp_in_rupees
FROM zepto_v2;

update zepto_v2
set mrp = mrp/100,
discountedsellingprice =discountedsellingprice/100;
SET SQL_SAFE_UPDATES = 0;

select mrp, discountedsellingprice from zepto_v2; 

-- --data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp
FROM zepto_V2
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto_v2;

-- Q8.What is the Total Inventory Weight Per Category 

SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight;