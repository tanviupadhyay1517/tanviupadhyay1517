 CREATE DATABASE world;
 USE world;
 DROP TABLE world_cup; -- DELETE TABLE
 RENAME TABLE supermarket TO sales;
 
 -- BASIC QUERIES
-- 1. Show all data from sales.
SELECT * FROM sales;

-- 2. Show customer name and city.
SELECT customer_name, city FROM sales;

-- 3. Show all sales from Delhi.
SELECT * FROM sales
WHERE city = "Delhi";

-- 4. Show all Electronics category sales.
SELECT * FROM sales 
WHERE category = "Electronics";

-- 5. Show sales where price is greater than 10000.
SELECT * FROM sales
WHERE price > 10000; 

-- 6. Show sales where quantity is greater than 2.
SELECT * FROM sales
WHERE quantity > 2;

-- 7. Show orders paid by UPI.
SELECT * FROM sales
WHERE payment_mode = "UPI";

-- 8. Show sales between two dates.
SELECT * FROM sales
WHERE order_date BETWEEN "2023-01-01" AND "2024-01-01";

-- 9. Show sales from Mumbai and Delhi only.
SELECT * FROM sales
WHERE city = "Mumbai" AND "Delhi";

-- 10. Show sales except Grocery category.
SELECT * FROM sales
WHERE category = "Grocery";

-- 11. Show products sorted by price high to low.
SELECT * FROM sales
ORDER BY price DESC;

-- 12. Show products sorted by price low to high.
SELECT * FROM sales
ORDER BY price ASC;

-- 13. Show top 5 highest total_amount orders.
SELECT * FROM sales
ORDER BY total_amount DESC
LIMIT 5;

-- 14. Show lowest 5 total_amount orders.
SELECT * FROM sales
ORDER BY total_amount ASC
LIMIT 5;

-- 15. Show latest 5 orders.
SELECT * FROM sales
ORDER BY order_date DESC
LIMIT 5;

-- 16. Show all unique categories.
SELECT DISTINCT(category) FROM sales;

-- 17.Show all unique payment modes.
SELECT DISTINCT(payment_mode) FROM sales;

-- 18. Show unique customer names.
SELECT DISTINCT(customer_name) FROM sales;

-- 19. Show all unique cities.
SELECT DISTINCT(city) FROM sales;

-- 20. Count total number of orders.
SELECT COUNT(*) AS total_orders FROM sales;

-- 21. Count number of orders per city.
SELECT city, COUNT(*) AS per_city FROM sales
GROUP BY city; 

-- 22. Count total unique customers.
SELECT COUNT(DISTINCT customer_name) AS unique_customer
FROM sales; 

-- 23. Find total revenue.
SELECT SUM(total_amount) AS total_revenue FROM sales;

-- 24. Find total quantity sold.
SELECT SUM(quantity) AS total_quantity FROM sales;

-- 25.Find average product price.
SELECT AVG(price) AS avg_price FROM sales; 

-- 26. Find highest order value.
SELECT MAX(price) AS highest_value FROM sales;

-- 27. Find lowest order value.
SELECT MIN(price) AS lowest_value FROM sales;

-- 28. Count number of orders per city.
SELECT city, COUNT(*) AS per_city_orders FROM sales
GROUP BY city;

-- 29. Count number of orders per category.
SELECT category, COUNT(*) AS per_category_orders FROM sales
GROUP BY category;

-- 30. Find total revenue per city.
SELECT city, SUM(total_amount) AS per_city_revenue FROM sales
GROUP BY city;

-- 31. Find total revenue per category.
SELECT category, SUM(total_amount) AS per_category_revenue FROM sales
GROUP BY category;

-- 32. Find total quantity per product.
SELECT product, SUM(quantity) AS per_product_quantity FROM sales
GROUP BY product;

-- 33. Find total spending per customer.
SELECT customer_name, SUM(total_amount)  AS per_customer_spending FROM sales
GROUP BY customer_name;
SELECT * FROM sales;

-- 34. Find average order value per city.
SELECT city, AVG(price) AS avg_price FROM sales
GROUP BY city;

-- 35. Find total revenue per payment mode.
SELECT payment_mode, SUM(total_amount) AS total_revenue FROM sales
GROUP BY payment_mode;

-- 36. Find city with highest revenue.
SELECT city, SUM(total_amount) AS revenue FROM sales
GROUP BY city
ORDER BY revenue DESC
LIMIT 1;

-- 37. Find cities where total revenue is greater than 200000.
SELECT city, SUM(total_amount) AS total_revenue FROM sales
GROUP BY city
HAVING total_revenue > 200000;

-- 38. Find customers whose total spending is more than 50000.
SELECT customer_name, SUM(total_amount) AS total_spend FROM sales
GROUP BY customer_name
HAVING total_spend > 50000;

-- 39. Find products sold more than 50 units in total.
SELECT product, SUM(quantity) AS total_unit FROM sales
GROUP BY product
HAVING total_unit > 50;

-- 40. Find categories generating less than 100000 revenue.
SELECT category, SUM(total_amount) AS revenue FROM sales
GROUP BY category
HAVING revenue < 100000; 

-- 41. Find payment modes used more than 30 times.
SELECT payment_mode, COUNT(payment_mode) AS used_payment FROM sales
GROUP BY payment_mode
HAVING used_payment > 30;

-- DATE & TIME
-- 42. Find total revenue per month.
SELECT MONTH(order_date) AS month, SUM(total_amount) AS total_revenue FROM sales
GROUP BY month;

-- 43. Find number of orders per month.
SELECT MONTH(order_date) AS month, COUNT(*) AS total_order FROM sales
GROUP BY month;

-- 44. Find revenue per year.
SELECT YEAR(order_date) AS year, SUM(total_amount) AS total_revenue FROM sales
GROUP BY year; 

-- 45. Find the month with highest revenue.
SELECT MONTH(order_date) AS month, SUM(total_amount) AS revenue FROM sales
GROUP BY month
ORDER BY revenue DESC
LIMIT 1; 

-- 46. Find the day with highest total sales.
SELECT DAY(order_date) AS day, COUNT(*) AS total_sales FROM sales
GROUP BY day
ORDER BY total_sales DESC
LIMIT 1;

-- subqueries
-- 47. Find customers whose spending is above overall average spending.
SELECT customer_name, SUM(total_amount) AS spend FROM sales
GROUP BY customer_name
HAVING spend > (SELECT AVG(total_amount) AS avg_spend FROM sales);

-- 48. Find products whose price is above average price of their category.
SELECT *
FROM sales s1
WHERE price > (SELECT AVG(price) AS avg_price FROM sales s2 WHERE s1.category = s2.category);

-- 49. Find orders where total_amount is greater than overall average order value.
SELECT * FROM sales 
WHERE total_amount > (SELECT AVG(price) AS avg_value FROM sales);

-- 50. Find cities whose revenue is above average city revenue.
SELECT city, SUM(total_amount) AS revenue FROM sales 
GROUP BY city
HAVING revenue > (SELECT AVG(city_revenue) FROM (SELECT SUM(total_amount) As city_revenue FROM sales GROUP BY city) AS temp);

-- 51. Find categories whose revenue is below overall average category revenue.
SELECT category, SUM(total_amount) AS revenue FROM sales
GROUP BY category
HAVING revenue < (SELECT AVG(category_revenue) 
FROM (SELECT SUM(total_amount) AS category_revenue FROM sales GROUP BY category) AS temp);

-- RANKING & TOP ANALYSIS
-- 52. Find top 3 customers by total spending.
SELECT customer_name, SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_name
ORDER BY total_spend DESC
LIMIT 3;

-- 53. Find top 3 products by revenue.
SELECT product, SUM(total_amount) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC
LIMIT 3;

-- 54. Find second highest order value.
SELECT DISTINCT total_amount
FROM sales
ORDER BY total_amount DESC
LIMIT 1 OFFSET 1;

-- 55. Find third highest revenue product.
SELECT product, SUM(total_amount) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC
LIMIT 1 OFFSET 2;

-- 56. Find top product in each category.
SELECT * FROM ( SELECT category, product, SUM(total_amount) AS revenue, RANK() OVER (PARTITION BY category 
ORDER BY SUM(total_amount) DESC) AS rnk
FROM sales
GROUP BY category, product
) AS ranked
WHERE rnk = 1;

-- 57. Categorize customers as High / Medium / Low spenders.
SELECT customer_name, SUM(total_amount) AS spending, 
CASE
	WHEN SUM(total_amount) > 50000 THEN "High"
    WHEN SUM(total_amount) BETWEEN 20000 AND 50000 THEN "Medium"
    ELSE "Low"
END AS categorize_customer
FROM sales
GROUP BY customer_name;

-- 58. Classify orders as Small (<5000), Medium (5000–20000), Large (>20000).
SELECT *,
CASE 
	WHEN total_amount > 20000 THEN "Large"
    WHEN total_amount BETWEEN 5000 AND 20000 THEN "Medium"
    ELSE "Small"
END AS order_size
FROM sales;

-- 59. Show city performance as “Good” if revenue > 200000 else “Average”.
SELECT city, SUM(total_amount) AS revenue,
CASE
	WHEN SUM(total_amount) > 200000 THEN "GOOD"
	ELSE "AVERAGE"
END AS city_performance
FROM sales
GROUP BY city;

-- 60. Classify products as Expensive (>20000) or Budget.
SELECT price,
CASE
	WHEN price > 20000 THEN "Expensive"
    ELSE "Budget"
END AS price_category
FROM sales;
	
-- 61. Find customers who purchased from more than one category.
SELECT customer_name, COUNT(DISTINCT category) AS more_category 
FROM sales
GROUP BY customer_name
HAVING  more_category > 1;

-- 62. Find customers who used more than one payment mode.
SELECT customer_name, COUNT(payment_mode) As more_payment
FROM sales
GROUP BY customer_name
HAVING more_payment > 1;

-- 63. Find customers who ordered on multiple different dates.
SELECT customer_name, order_date, COUNT(order_date) AS multiple_dates
FROM sales
GROUP BY customer_name, order_date
HAVING multiple_dates > 1;

-- 64. Find customers who have not ordered in the last 60 days.
SELECT customer_name
FROM sales
WHERE order_date < CURDATE() - INTERVAL 60 DAY;

-- 65. Find revenue contribution percentage of each product.
SELECT SUM(total_amount) AS revenue, (SUM(total_amount)/ (SELECT SUM(total_amount) FROM sales)) * 100 AS revenue_percentage 
FROM sales
GROUP BY product;

-- Advance level & windows functions
-- 66. Rank customers by total spending.
SELECT customer_name, SUM(total_amount) AS spending, RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rnk
FROM sales
GROUP BY customer_name;

-- 67. Dense rank products by revenue
SELECT product, SUM(total_amount) AS revenue, dense_rank() OVER (ORDER BY SUM(total_amount) DESC ) AS dense_rnk
FROM sales
GROUP BY product;

-- 68. Row number per customer (by date)
SELECT *, row_number() OVER(PARTITION BY customer_name ORDER BY order_date) AS order_no
FROM sales;

-- 69. Previous order amount per customer
SELECT customer_name, order_date, total_amount, LAG(total_amount) OVER (PARTITION BY customer_name ORDER BY order_date) AS prev_order
FROM sales;

-- 70. Difference between current & previous order
SELECT customer_name, order_date, total_amount, total_amount - LAG(total_amount) OVER (PARTITION BY  customer_name ORDER BY order_date) AS diff_order
FROM sales;

-- 71. Running total revenue per city
SELECT city, order_date, SUM(total_amount) OVER (PARTITION BY city ORDER BY order_date) AS running_revenue
FROM sales;

-- 72. Running total per customer
SELECT customer_name, order_date, SUM(total_amount) OVER (PARTITION BY customer_name ORDER BY order_date) AS running_customer
FROM sales;

-- 73. Top 2 products in each category
SELECT *
FROM (SELECT product, category, SUM(total_amount) AS revenue, RANK() OVER (PARTITION BY category ORDER BY SUM(total_amount) DESC) AS rnk 
FROM sales
GROUP BY category, product
)t
WHERE rnk <= 2;

-- 74. Lowest revenue product in each category
SELECT *
FROM (SELECT product, category, SUM(total_amount) AS revenue, RANK() OVER(PARTITION BY category ORDER BY SUM(total_amount) ASC) AS rnk
FROM sales
GROUP BY category, product
)t
WHERE rnk = 1; 

-- 75. % contribution of each order within its city
SELECT city, order_id, total_amount, (total_amount / SUM(total_amount) OVER (PARTITION BY city)) * 100 AS pct_city
FROM sales;

-- 76. Duplicate orders
SELECT customer_name, order_date, total_amount, COUNT(*) AS cnt
FROM sales
GROUP BY customer_name, order_date, total_amount
HAVING cnt > 1;

-- 77. Products never above avg quantity
SELECT product
FROM sales
GROUP BY product
HAVING MAX(quantity) <= (SELECT AVG(quantity) FROM sales); 

-- 78. Customers only one category
SELECT customer_name
FROM sales
GROUP BY customer_name
HAVING COUNT(DISTINCT category) = 1;

-- 79. Categories where every product sold >10000 once
SELECT category, MAX(total_amount) AS max_sale
FROM sales
GROUP BY category
HAVING max_sale > 10000;

-- 80. Products >10% revenue
SELECT product, SUM(total_amount) AS revenue
FROM sales
GROUP BY product
HAVING revenue > 0.10 * (SELECT SUM(total_amount) FROM sales);

-- Like interviews questions
-- 81. Find the second highest order value.
SELECT DISTINCT total_amount
FROM sales
ORDER BY total_amount DESC
LIMIT 1 OFFSET 1;

-- 82. Customers with More Than 5 Orders
SELECT customer_name, COUNT(*) AS total_order
FROM sales
GROUP BY Customer_name
HAVING total_order > 5;

-- 83. Customer with Highest Revenue
SELECT customer_name, SUM(total_amount) AS revenue
FROM sales
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 1;

-- 84. City with Highest Average Order Value
SELECT city, AVG(total_amount) AS avg_order
FROM sales
GROUP BY city
ORDER BY avg_order DESC
LIMIT 1;

-- 85. Customers Spending Above Average Customer
SELECT customer_name, SUM(total_amount) AS spending 
FROM sales
GROUP BY customer_name
HAVING spending > (SELECT AVG(total_spending) FROM (SELECT SUM(total_amount) AS total_spending FROM sales GROUP BY customer_name
)t
);

-- 86. Most Popular Payment Mode
SELECT payment_mode, COUNT(*) AS popmode
FROM Sales
GROUP BY payment_mode
ORDER BY popmode DESC
LIMIT 1;

-- 87. Product with Highest Revenue
SELECT product, SUM(total_amount) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC
LIMIT 1;

-- 88. Top 3 Products in Each Category
SELECT *
FROM (SELECT category, product, SUM(total_amount) AS revenue, RANK() OVER(PARTITION BY category ORDER BY SUM(total_amount) DESC) AS rnk
FROM sales
GROUP BY category, product
)t
WHERE rnk <= 3; 

-- 89. Customers with Consecutive Day Orders
SELECT customer_name
FROM(SELECT customer_name, order_date, LAG(order_date) OVER (PARTITION BY customer_name ORDER BY order_date) As Prev_date
  FROM sales
)t
WHERE DATEDIFF(order_date, Prev_date) = 1;

-- 90. Category Revenue Percentage
SELECT category, SUM(total_amount) AS revenue, (SUM(total_amount)/(SELECT SUM(total_amount) FROM sales)) * 100 AS percentage 
FROM sales
GROUP BY category;

-- 91. Monthly revenue
SELECT YEAR (order_date) As yr, MONTH(order_date) As mn, SUM(total_amount) AS revenue
FROM sales
GROUP BY yr, mn
ORDER BY revenue DESC;

-- 92. Find the category that has the highest number of unique customers.
SELECT category, COUNT(DISTINCT customer_name) AS unique_customers
FROM sales
GROUP BY category
ORDER BY unique_customers DESC
LIMIT 1;

-- 93. Find the customer who placed the highest number of orders in a single month.
SELECT customer_name, yr, mn, total_orders
FROM (SELECT customer_name, YEAR(order_date) AS yr, MONTH(order_date) AS mn, COUNT(*) As total_orders, 
RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
FROM sales
GROUP BY customer_name, yr, mn
)t
WHERE rnk = 1;

-- 94. City with maximum gap between highest and lowest order.
SELECT city, MAX(total_amount) - MIN(total_amount) AS gap_value
FROM sales
GROUP BY city
ORDER BY gap_value DESC
LIMIT 1;

-- 95. Product sold in highest number of cities
SELECT product, COUNT(DISTINCT city) AS city_count
FROM sales
GROUP BY product
ORDER BY city_count DESC
LIMIT 1;

-- 96. Month with highest average order value
SELECT yr, mn, avg_order
FROM (SELECT YEAR(order_date) AS yr, MONTH(order_date) AS mn, AVG(total_amount) AS avg_order,
RANK() OVER (ORDER BY AVG(total_amount) DESC) AS rnk 
FROM sales
GROUP BY yr, mn
)t
WHERE rnk = 1;

-- 97. Find the customer who generated the highest revenue in each city.
SELECT customer_name, city, revenue
FROM (SELECT city, customer_name, SUM(total_amount) AS revenue, RANK() OVER (PARTITION BY city ORDER BY SUM(total_amount) DESC) AS rnk
FROM sales
GROUP BY city, customer_name
)t
WHERE rnk =1; 

-- 98. Find the product with the highest total quantity sold.
SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product
ORDER BY total_qty
LIMIT 1;

-- 99. Find the total number of orders per payment mode.
SELECT payment_mode, COUNT(*) As total_orders
FROM sales 
GROUP BY payment_mode;

-- 100. Find the customer who spent the most in a single order.
SELECT customer_name, total_amount
FROM Sales
ORDER BY total_amount DESC
LIMIT 1;