-- class practice Programm 2
USE superstore;
-- mix queries practice
-- 1. Let’s load our data into SQL and check the first 5 rows to ensure it is imported well.
SELECT * FROM storedata
LIMIT 5;

-- 2. Disply 11 to 20 rows no.
SELECT * FROM storedata
LIMIT 10 OFFSET 10;

-- 3. What region generates the highest sales and profits?
SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM storedata
GROUP BY region
ORDER BY total_profit DESC;

-- 4. Let’s observe each regions profit margins.
SELECT region, ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM storedata
GROUP BY region
ORDER BY profit_margin;

-- 5. highest sales and profit by state Top
SELECT state, SUM(profit) AS total_profit, SUM(sales) AS total_sales, ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM storedata
GROUP BY state
ORDER BY profit_margin DESC
LIMIT 10;

-- 6. highest sales and profit by state Bottom
SELECT state, SUM(profit) AS total_profit, SUM(sales) AS total_sales, ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM storedata
GROUP BY state
ORDER BY profit_margin ASC
LIMIT 10;

-- 7. highest sales and profit by city Top
SELECT city, SUM(profit) AS total_profit, SUM(sales) AS total_sales, ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM storedata
GROUP BY city
ORDER BY profit_margin DESC
LIMIT 10;

-- 8. highest sales and profit by city Bottom
SELECT city, SUM(profit) AS total_profit, SUM(sales) AS total_sales, ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM storedata
GROUP BY city
ORDER BY profit_margin 
LIMIT 10;

-- 9. Find total profit
SELECT state, ROUND(SUM(profit),2) As total_profit
FROM storedata
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;

-- 10. The relation between discounts and average sales 
SELECT discount, ROUND(AVG(sales),2) AS avg_sales
FROM storedata
GROUP BY discount
ORDER BY avg_sales;

-- 11. Total discount per product category
SELECT category, Sub-Category, ROUND(SUM(discount),2) AS total_discount
FROM storedata
GROUP BY category, Sub-Category
ORDER BY total_discount DESC; 

-- 12. What category generates the highest sales and profits in each region and state?
SELECT category, SUM(sales) AS total_sale, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin
FROM storedata
GROUP BY category
ORDER BY total_profit DESC;

-- 13. Let’s observe the highest total sales and total profits per Category in each region
SELECT region, category, SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM storedata
GROUP BY region, category
ORDER BY total_profit DESC;

-- 14. Now let’s see the highest total sales and total profits per Category in each state
SELECT state, category, SUM(profit) AS total_profit, SUM(sales) AS total_sale
FROM storedata
GROUP BY state, category
ORDER BY total_profit DESC;

-- 15. Let’s check the least profitable ones by just changing our ‘ORDER BY’ clause too ascending (ASC) 
SELECT state, category, SUM(profit) AS total_profit, SUM(sales) AS total_sale
FROM storedata
GROUP BY state, category
ORDER BY total_profit ASC;

-- i rename column name "sub-category" to "sub_category"
ALTER TABLE storedata
CHANGE `sub-category` sub_category VARCHAR(100);

-- 16. Let’s observe the total sales and total profits of each subcategory with their profit margins:
SELECT sub_category, SUM(profit) As total_profit, SUM(sales) AS total_sales, ROUND(SUM(profit)/SUM(sales)*100,2) As profit_margin
FROM storedata
GROUP BY sub_category
ORDER BY profit_margin DESC; 

-- 17. Now let’s see the highest total sales and total profits per subcategory in each region:
SELECT sub_category, region, SUM(profit) As total_profit, SUM(sales) AS total_sales
FROM storedata
GROUP BY sub_category, region
ORDER BY profit_margin DESC; 

-- 18. Now let’s see the least performing ones:
SELECT sub_category, region, SUM(profit) As total_profit, SUM(sales) AS total_sales
FROM storedata
GROUP BY sub_category, region
ORDER BY profit_margin ASC; 

-- 19. Now let’s see the highest total sales and total profits per subcategory in each state:
SELECT sub_category, state, SUM(profit) As total_profit, SUM(sales) AS total_sales
FROM storedata
GROUP BY sub_category, state
ORDER BY profit_margin DESC; 

-- 20. Let’s see the lowest sales and profits
SELECT sub_category, state, SUM(profit) As total_profit, SUM(sales) AS total_sales
FROM storedata
GROUP BY sub_category, state
ORDER BY profit_margin ASC;

-- i rename column name "Product Name" to "product_name"

ALTER TABLE storedata
CHANGE `Product Name` product_name VARCHAR(5000);

-- 21. What are the names of the most and least profitable products to us?
SELECT product_name, SUM(profit) AS total_profit, SUM(sales) AS total_sale
FROM storedata
GROUP BY product_name
ORDER BY total_profit DESC; 

-- 22. Let’s verify our less profitable ones:
SELECT product_name, SUM(profit) AS total_profit, SUM(sales) AS total_sale
FROM storedata
GROUP BY product_name
ORDER BY total_profit ASC; 

-- 23. What segment makes the most of our profits and sales?
SELECT segment, SUM(profit) AS total_profit, SUM(sales) AS total_sale
FROM storedata
GROUP BY segment
ORDER BY total_profit DESC;
 
-- Rename of customer id
ALTER TABLE storedata
CHANGE `Customer ID` customer_id TEXT;

-- 24. How many customers do we have (unique customer IDs) in total and how much per region and state?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM storedata;

-- 25. Regionally, we had the following:
SELECT region, COUNT(DISTINCT customer_id) AS total_customers
FROM storedata
GROUP BY region
ORDER BY total_customers DESC;

-- 26. Now let's see statewise
SELECT state, COUNT(DISTINCT customer_id) AS total_customers
FROM storedata
GROUP BY state
ORDER BY total_customers DESC;

-- 27. What customers spent the most with us? 
SELECT customer_id, SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM storedata
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 15;

-- Rename Ship Mode 
ALTER TABLE storedata
CHANGE `Ship Mode` ship_mode TEXT;

ALTER TABLE storedata
CHANGE `Order Date` order_date TEXT;
-- 28. The average shipping time regardless of the shipping mode that is chosen is found with the following function:
SELECT ROUND(AVG(ship_date - order_date),1) AS avg_shipping_time
FROM storedata;

-- 29. Let's see the shipping time in each shipping mode is
SELECT ship_mode, ROUND(AVG(ship_date - order_date),1) AS avg_shipping_time
FROM storedata
GROUP BY ship_mode
ORDER BY avg_shipping_time;

-- Basic SQL Queries
-- 30. Disply storedata table
SELECT * FROM storedata;

-- Modify column of order_id
ALTER TABLE storedata
CHANGE `Order ID` order_id TEXT;
-- 31. Find the total number of orders.
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM storedata;

-- 32. Count the total number of customers.
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM storedata;

-- 33. Find the total sales revenue.
SELECT SUM(sales) AS total_sales
FROM storedata;

-- 34. Find the total profit generated.
SELECT SUM(profit) AS total_profit
FROM storedata;

-- 35. Show all unique product categories.
SELECT DISTINCT category
FROM storedata;

-- 36. Find the total quantity of products sold.
SELECT SUM(quantity) AS total_quantity
FROM storedata;

-- 37. Find the minimum and maximum sales value.
SELECT 
MIN(sales) AS min_sales,
MAX(sales) AS max_sales
FROM storedata;

-- 38. Find the number of orders per region.
SELECT region,
COUNT(DISTINCT order_id) AS total_orders
FROM storedata
GROUP BY region;

-- 39. Show all unique ship modes.
SELECT DISTINCT ship_mode
FROM storedata;

-- 40. Find the total number of cities in the dataset.
SELECT COUNT(DISTINCT city) AS total_cities
FROM storedata;

-- Aggregation & GROUP BY
-- 41. Find total sales by region.
SELECT region,
SUM(sales) AS total_sales
FROM storedata
GROUP BY region
ORDER BY total_sales DESC;

-- 42. Find total profit by category.
SELECT category,
SUM(profit) AS total_profit
FROM storedata
GROUP BY category
ORDER BY total_profit DESC;

-- 43. Find average sales per order.
SELECT AVG(order_sales) AS avg_sales_per_order
FROM (
    SELECT order_id,
    SUM(sales) AS order_sales
    FROM storedata
    GROUP BY order_id
) t;

-- 44. Find number of orders per segment.
SELECT segment,
COUNT(DISTINCT order_id) AS total_orders
FROM storedata
GROUP BY segment;

-- 45. Find total quantity sold per category.
SELECT category,
SUM(quantity) AS total_quantity
FROM storedata
GROUP BY category;

-- 46. Find average discount given per category.
SELECT category,
AVG(discount) AS avg_discount
FROM storedata
GROUP BY category;

-- 47. Find top 5 states by total sales.
SELECT state,
SUM(sales) AS total_sales
FROM storedata
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

-- 48. Find total profit by ship mode.
SELECT ship_mode,
SUM(profit) AS total_profit
FROM storedata
GROUP BY ship_mode;

-- 49. Find cities generating highest sales.
SELECT city,
SUM(sales) AS total_sales
FROM storedata
GROUP BY city
ORDER BY total_sales DESC;

-- 50. Find cities generating highest sales.
SELECT category,
SUM(profit) AS total_profit
FROM storedata
GROUP BY category
ORDER BY total_profit DESC;

-- Filtering & Conditions
-- 51. Find orders where sales > 500.
SELECT *
FROM storedata
WHERE sales > 500;

-- 52. Find products where discount > 20%.
SELECT product_name, discount
FROM storedata
WHERE discount > 0.20;

-- 53. Find orders where profit is negative.
SELECT *
FROM storedata
WHERE profit < 0;

-- 54. Find customers belonging to Consumer segment.
ALTER TABLE storedata
CHANGE `Customer Name` customer_name TEXT;

SELECT DISTINCT customer_id, customer_name
FROM storedata
WHERE segment = 'Consumer';

-- 55. Find orders placed in 2015.
SELECT *
FROM storedata
WHERE YEAR(order_date) = 2015;

-- 56. Find orders shipped using Second Class.
SELECT *
FROM storedata
WHERE ship_mode = 'Second Class';

-- 57. Find orders where quantity > 5.
SELECT *
FROM storedata
WHERE quantity > 5;

-- 58. Find products from Technology category.
SELECT product_name, category
FROM storedata
WHERE category = 'Technology';

-- 59. Find orders from West region.
SELECT *
FROM storedata
WHERE region = 'West';

-- 60. Find orders where profit > 100.
SELECT *
FROM storedata
WHERE profit > 100;

-- Customer & Product Analysis
-- 61. Find top 10 customers by sales.
SELECT customer_id, customer_name,
SUM(sales) AS total_sales
FROM storedata
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- 62. Find top 10 products by revenue.
SELECT product_name,
SUM(sales) AS total_sales
FROM storedata
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 63. Find top 5 products by quantity sold.
SELECT product_name,
SUM(quantity) AS total_quantity
FROM storedata
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 5;

-- 64. Find customers who placed the most orders.
SELECT customer_id, customer_name,
COUNT(DISTINCT order_id) AS total_orders
FROM storedata
GROUP BY customer_id, customer_name
ORDER BY total_orders DESC;

-- 65. Find products generating highest profit.
SELECT product_name,
SUM(profit) AS total_profit
FROM storedata
GROUP BY product_name
ORDER BY total_profit DESC;

-- 66. Find subcategories generating highest sales.
SELECT sub_category,
SUM(sales) AS total_sales
FROM storedata
GROUP BY sub_category
ORDER BY total_sales DESC;

-- 67. Find category with highest average profit.
SELECT category,
AVG(profit) AS avg_profit
FROM storedata
GROUP BY category
ORDER BY avg_profit DESC;

-- 68. Find customers with negative profit orders.
SELECT DISTINCT customer_id, customer_name
FROM storedata
WHERE profit < 0;

-- 69. Find top cities by profit.
SELECT city,
SUM(profit) AS total_profit
FROM storedata
GROUP BY city
ORDER BY total_profit DESC;

-- 70. Find states with highest number of orders.
SELECT state,
COUNT(DISTINCT order_id) AS total_orders
FROM storedata
GROUP BY state
ORDER BY total_orders DESC;

-- Date & Time Analysis
-- 71. Find earliest and latest order date.
SELECT state,
COUNT(DISTINCT order_id) AS total_orders
FROM storedata
GROUP BY state
ORDER BY total_orders DESC;

-- 72. Find monthly sales revenue.
SELECT 
YEAR(order_date) AS year,
MONTH(order_date) AS month,
SUM(sales) AS total_sales
FROM storedata
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 73. Find yearly profit.
SELECT 
YEAR(order_date) AS year,
SUM(profit) AS total_profit
FROM storedata
GROUP BY YEAR(order_date)
ORDER BY year;

-- 74. Find number of orders per year.
SELECT 
YEAR(order_date) AS year,
COUNT(DISTINCT order_id) AS total_orders
FROM storedata
GROUP BY YEAR(order_date)
ORDER BY year;

-- 75. Find average shipping time (ship_date − order_date).
SELECT 
AVG(DATEDIFF(ship_date, order_date)) AS avg_shipping_days
FROM storedata;

-- 76. Find sales trend by month.
SELECT 
MONTH(order_date) AS month,
SUM(sales) AS total_sales
FROM storedata
GROUP BY MONTH(order_date)
ORDER BY month;

-- 77. Find top sales month.
SELECT 
MONTH(order_date) AS month,
SUM(sales) AS total_sales
FROM storedata
GROUP BY MONTH(order_date)
ORDER BY total_sales DESC
LIMIT 1;

-- 78. Find orders shipped within 3 days.
SELECT *
FROM storedata
WHERE DATEDIFF(ship_date, order_date) <= 3;

-- 79. Find orders shipped late (>5 days).
SELECT *
FROM storedata
WHERE DATEDIFF(ship_date, order_date) > 5;

-- 80. Find daily average sales.
SELECT 
order_date,
AVG(sales) AS avg_daily_sales
FROM storedata
GROUP BY order_date
ORDER BY order_date;

-- Advanced Business Analysis
-- 81. Rank products by total sales.
SELECT product_name,
SUM(sales) AS total_sales,
RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM storedata
GROUP BY product_name;

-- 82. Find top 3 products in each category.
SELECT *
FROM (
    SELECT category, product_name,
    SUM(sales) AS total_sales,
    RANK() OVER (PARTITION BY category ORDER BY SUM(sales) DESC) AS rnk
    FROM storedata
    GROUP BY category, product_name
) t
WHERE rnk <= 3;

-- 83. Find percentage contribution of each category to total sales.
SELECT category,
SUM(sales) AS category_sales,
(SUM(sales) / (SELECT SUM(sales) FROM storedata)) * 100 AS sales_percentage
FROM storedata
GROUP BY category;

-- 84. Find customers whose spending is above average.
SELECT customer_id, customer_name,
SUM(sales) AS total_spent
FROM storedata
GROUP BY customer_id, customer_name
HAVING SUM(sales) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(sales) AS total_sales
        FROM storedata
        GROUP BY customer_id
    ) t
);

-- 85. Find top spending customer in each region.
SELECT *
FROM (
    SELECT region, customer_id, customer_name,
    SUM(sales) AS total_sales,
    RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk
    FROM storedata
    GROUP BY region, customer_id, customer_name
) t
WHERE rnk = 1;

-- 86. Find running total of monthly sales.
SELECT order_date,
SUM(sales) AS daily_sales,
SUM(SUM(sales)) OVER (ORDER BY order_date) AS running_total
FROM superstore
GROUP BY order_date;

-- 87. Find year-over-year sales growth.
SELECT year,
total_sales,
LAG(total_sales) OVER (ORDER BY year) AS previous_year_sales
FROM (
    SELECT YEAR(order_date) AS year,
    SUM(sales) AS total_sales
    FROM storedata
    GROUP BY YEAR(order_date)
) t;

-- 88. Find products contributing 80% of revenue (Pareto analysis).
SELECT product_name,
total_sales,
cumulative_sales,
(cumulative_sales / total_revenue) * 100 AS cumulative_percentage
FROM (
    SELECT product_name,
           total_sales,
           SUM(total_sales) OVER (ORDER BY total_sales DESC) AS cumulative_sales,
           SUM(total_sales) OVER () AS total_revenue
    FROM (
        SELECT product_name,
               SUM(sales) AS total_sales
        FROM storedata
        GROUP BY product_name
    ) t1
) t2
WHERE cumulative_sales <= 0.8 * total_revenue;

-- 89. Find profit margin for each product.
SELECT product_name,
SUM(profit) AS total_profit,
SUM(sales) AS total_sales,
(SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM storedata
GROUP BY product_name;

-- 90. Find regions with above-average profit.
SELECT region,
SUM(profit) AS total_profit
FROM storedata
GROUP BY region
HAVING SUM(profit) > (
    SELECT AVG(region_profit)
    FROM (
        SELECT SUM(profit) AS region_profit
        FROM storedata
        GROUP BY region
    ) t
);

-- Window Functions & Advanced
-- 91. Rank customers by sales within each region.
SELECT region,
customer_id,
customer_name,
SUM(sales) AS total_sales,
RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS sales_rank
FROM storedata
GROUP BY region, customer_id, customer_name;

-- 92. Find top 5 products in each subcategory.
SELECT *
FROM (
    SELECT sub_category,
           product_name,
           SUM(sales) AS total_sales,
           RANK() OVER (PARTITION BY sub_category ORDER BY SUM(sales) DESC) AS rnk
    FROM storedata
    GROUP BY sub_category, product_name
) t
WHERE rnk <= 5;

-- 93. Calculate cumulative sales over time.
SELECT order_date,
SUM(sales) AS daily_sales,
SUM(SUM(sales)) OVER (ORDER BY order_date) AS cumulative_sales
FROM storedata
GROUP BY order_date;

-- 94. Find previous order sales using LAG().
SELECT order_date,
sales,
LAG(sales) OVER (ORDER BY order_date) AS previous_sales
FROM storedata;

-- 95. Find next order sales using LEAD().
SELECT order_date,
sales,
LEAD(sales) OVER (ORDER BY order_date) AS next_sales
FROM storedata;

-- 96. Calculate moving average of sales (3 orders).
SELECT order_date,
sales,
AVG(sales) OVER ( ORDER BY order_date
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_avg_sales
FROM storedata;

-- 97. Find highest sales order per customer.
SELECT *
FROM (
    SELECT customer_id, customer_name, order_id, sales,
           RANK() OVER (PARTITION BY customer_id ORDER BY sales DESC) AS rnk
    FROM storedata
) t
WHERE rnk = 1;

-- 98. Find second highest profit order per category.
SELECT *
FROM (
    SELECT category, order_id, profit,
           DENSE_RANK() OVER (PARTITION BY category ORDER BY profit DESC) AS rnk
    FROM storedata
) t
WHERE rnk = 2;

-- 99. Find second highest profit order per category.
SELECT region,
SUM(sales) AS total_sales,
RANK() OVER (ORDER BY SUM(sales) DESC) AS region_rank
FROM storedata
GROUP BY region;

-- 100. Find the most profitable product in each category
SELECT *
FROM (
    SELECT category,
           product_name,
           SUM(profit) AS total_profit,
           RANK() OVER (PARTITION BY category ORDER BY SUM(profit) DESC) AS rnk
    FROM storedata
    GROUP BY category, product_name
) t
WHERE rnk = 1;


