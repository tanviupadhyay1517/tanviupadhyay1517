CREATE DATABASE dmart;
USE dmart;

-- Basic Analysis
-- 1. Find the total number of customers.
SELECT COUNT(*) AS total_customer 
FROM customers;

-- 2. Count the total number of products available.
SELECT COUNT(*) AS total_product
FROM products;

-- 3. Find the total number of sales transactions.
SELECT COUNT(*) AS total_sales
FROM sales;

-- 4. Show the unique cities where customers belong.
SELECT DISTINCT city
FROM customers;

-- 5. Find the total number of product categories.
SELECT COUNT(DISTINCT category) AS total_category
FROM products;

-- 6. Find the total sales revenue.
SELECT SUM(total_amount) AS revenue
FROM sales;

-- 7. Find the total quantity of products sold.
SELECT SUM(quantity) AS total_qty
FROM sales;

-- 8. Show the top 10 most expensive products by selling price.
SELECT product_name, selling_price
FROM products 
ORDER BY selling_price DESC
LIMIT 10;

-- 9. Find the average selling price of products.
SELECT AVG(selling_price) avg_price
FROM products;

-- 10. Find the average discount percentage given.
SELECT AVG(discount_percent) AS avg_discount
FROM sales;

-- 11. Count how many sales were made using each payment mode.
SELECT payment_mode, COUNT(sale_id) AS count_sale
FROM sales
GROUP BY payment_mode;

-- 12. Find the total stock quantity available.
SELECT SUM(stock_quantity) AS total_qty
FROM products;

-- 13. Find the minimum and maximum selling price of products.
SELECT MIN(selling_price) AS min_sell, MAX(selling_price) AS max_sell
FROM products;

-- 14. Find the earliest and latest sale date.
SELECT MIN(sale_date) AS first_date, MAX(sale_date) AS last_date
FROM sales;

-- 15. Find how many customers joined each year.
SELECT YEAR(STR_TO_DATE(join_date, '%d-%m-%Y')) AS years, COUNT(*) As total_customer
FROM customers
GROUP BY years
ORDER BY years;

-- Customer Analysis
-- 16. Find the top 10 customers by total spending.
SELECT customer_id, SUM(total_amount) AS total_spending
FROM sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;

-- 17. Find the total number of customers per city.
SELECT city, COUNT(customer_id) total_customer 
FROM customers
GROUP BY city;

-- 18. Find the total sales made by male vs female customers.
SELECT c.gender, SUM(s.total_amount) AS total_sales
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.gender;

-- 19. Find the average spending per customer.
SELECT customer_id, AVG(total_amount) AS Avg_spending
FROM sales 
GROUP BY customer_id;

-- 20. Find customers who have never made a purchase.
SELECT c.customer_id, c.first_name, c.last_name 
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
WHERE sale_id IS NULL;

-- 21. Find repeat customers (customers with more than 2 purchases).
SELECT customer_id, COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_id
HAVING total_orders > 2;

-- 22. Find the city with the highest number of customers.
SELECT city, COUNT(*) AS total_customer
FROM customers
GROUP BY city
ORDER BY total_customer DESC
LIMIT 1;

-- 23. Find the state generating the highest sales revenue.
SELECT state, SUM(total_amount) AS revenue
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY state
ORDER BY revenue DESC
LIMIT 1;

-- 24. Find customers who joined in the last 5 year.
SELECT *
FROM customers
WHERE STR_TO_DATE(join_date,'%d-%m-%Y') >= CURDATE() - INTERVAL 5 YEAR;

-- 25. Find the customer who made the highest single purchase.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Full_Name, MAX(s.total_amount) AS max_sales
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id, Full_Name
ORDER BY max_sales DESC
LIMIT 1;

-- 26. Find customers who bought products from more than 3 categories.
SELECT s.customer_id, COUNT(p.category) AS count_category
FROM sales s 
JOIN products p 
ON s.product_id = p.product_id
GROUP BY s.customer_id
HAVING count_category > 3;

-- 27. Find customers who made purchases in multiple branches.
SELECT customer_id, COUNT( DISTINCT branch) AS purchases_branches
FROM sales
GROUP BY customer_id
HAVING purchases_branches > 1;

-- 28. Find the average order value per customer.
SELECT customer_id, AVG(total_amount) AS avg_order
FROM Sales
GROUP BY customer_id;

-- 29. Find customers who received more than 10% discount.
SELECT DISTINCT customer_id
FROM sales
WHERE discount_percent > 10;

-- 30. Find top 5 cities with highest revenue.
SELECT c.city, SUM(s.total_amount) AS revenue
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY revenue DESC
LIMIT 5;

-- Product Analysis
-- 31. Find the top 10 best-selling products by quantity.
SELECT p.product_name, SUM(s.quantity) AS total_quantity_sold
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 32. Find the top 10 products generating highest revenue.
SELECT p.product_name, SUM(s.total_amount) AS total_revenue
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 33. Find products with low stock (stock < 50).
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity < 50;

-- 34. Find the most profitable products (selling_price − cost_price).
SELECT product_name, (selling_price - cost_price) AS profit
FROM products
ORDER BY profit DESC
LIMIT 10;

-- 35. Find average selling price by category.
SELECT category, AVG(selling_price) Avg_price
FROM products
GROUP BY category;

-- 36. Find number of products in each category.
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;

-- 37. Find brands with the most products.
SELECT brand, COUNT(*) AS total_products
FROM products
GROUP BY brand
ORDER BY total_products DESC;
 
-- 38. Find top 5 brands by revenue.
SELECT p.brand, SUM(s.total_amount) AS revenue
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.brand
ORDER BY revenue DESC
LIMIT 5;

-- 39. Find categories generating highest revenue.
SELECT p.category, SUM(s.total_amount) AS revenue
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 1;

-- 40. Find categories selling the highest quantity.
SELECT p.category, SUM(s.quantity) AS total_quantity
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY total_quantity DESC
LIMIT 1;
-- 41. Find products never sold.
SELECT p.product_name
FROM products p
LEFT JOIN sales s
ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;

-- 42. Find products sold in multiple branches.
SELECT p.product_name, COUNT(DISTINCT s.branch) AS branches_sold
FROM products p
LEFT JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
HAVING branches_sold > 1;

-- 43. Find products with the highest discount applied.
SELECT p.product_name, MAX(s.discount_percent) AS max_discount
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY max_discount DESC;

-- 44. Find average discount by category.
SELECT p.category, AVG(s.discount_percent) AS Avg_discount
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY Avg_discount DESC;

-- 45. Find category (product name) generating highest sales. 
SELECT 
    p.category, SUM(s.total_amount) AS total_sales
FROM
    products p
        JOIN
    sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Sales Analysis
-- 46. Find the total sales revenue per branch.
SELECT branch, SUM(total_amount) AS revenue
FROM sales
GROUP BY branch;

-- 47. Find the top performing branch by sales revenue.
SELECT branch, SUM(total_amount) AS revenue
FROM sales
GROUP BY branch
ORDER BY revenue DESC
LIMIT 1;

-- 48. Find the branch selling the highest quantity of products.
SELECT branch, SUM(quantity) AS count_qty
FROM sales
GROUP BY branch
ORDER BY count_qty DESC
LIMIT 1;

-- 49. Find monthly sales revenue.
SELECT YEAR(str_to_date(sale_date, '%d-%m-%Y')) AS years, 
MONTH(str_to_date(sale_date, '%d-%m-%Y')) AS months, 
SUM(total_amount) AS revenue
FROM sales
GROUP BY years, months
ORDER BY years, months;

-- 50. Find daily average sales.
SELECT sale_date, AVG(total_amount) AS avg_sales
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 51. Find the month with the highest sales.
SELECT MONTH(str_to_date(sale_date, '%d-%m-%Y')) AS month,
SUM(total_amount) AS total_revenue
FROM sales
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 1;

-- 52. Find sales by payment mode.
SELECT payment_mode,
SUM(total_amount) AS total_revenue
FROM sales
GROUP BY payment_mode
ORDER BY total_revenue DESC;

-- 53. Find average order value.
SELECT AVG(total_amount) AS avg_order_value
FROM sales;

-- 54. Find transactions where discount > 25%.
SELECT *
FROM sales
WHERE discount_percent > 15;

-- 55. Find the largest transaction value.
SELECT MAX(total_amount) AS highest_transaction
FROM sales;

-- 56. Find number of sales transactions per day.
SELECT sale_date,
COUNT(*) AS total_transactions
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 57. Find top 5 sales days by revenue.
SELECT sale_date,
SUM(total_amount) AS total_revenue
FROM sales
GROUP BY sale_date
ORDER BY total_revenue DESC
LIMIT 5;

-- 58. Find average quantity per order.
SELECT sale_id, AVG(quantity) AS avg_quantity
FROM sales
GROUP BY sale_id;

-- 59. Find revenue generated by each category.
SELECT p.category,
SUM(s.total_amount) AS total_revenue
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 60. Find quantity sold by each category.
SELECT p.category,
SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_quantity DESC;

-- Advanced Business
-- 61. Rank products by total revenue.
SELECT p.product_name,
SUM(s.total_amount) AS revenue, 
RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS total_rnk
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 62. Find top 3 products in each category.
SELECT *
FROM (
    SELECT p.category,
           p.product_name,
           SUM(s.total_amount) AS revenue,
           RANK() OVER (PARTITION BY p.category ORDER BY SUM(s.total_amount) DESC) AS rnk
    FROM sales s
    JOIN products p
    ON s.product_id = p.product_id
    GROUP BY p.category, p.product_name
) t
WHERE rnk <= 3;

-- 63. Calculate percentage contribution of each category to total sales.
SELECT p.category,
SUM(s.total_amount) AS revenue,
(SUM(s.total_amount) / (SELECT SUM(total_amount) FROM sales)) * 100 AS percentage_contribution
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category;

-- 64. Find customers whose spending is above average customer spending.
SELECT customer_id,
SUM(total_amount) AS total_spending
FROM sales
GROUP BY customer_id
HAVING SUM(total_amount) >
       (SELECT AVG(total_amount) FROM sales);
       
-- 65. Find top spending customer in each city.
SELECT *
FROM (
    SELECT c.city,
           c.customer_id,
           SUM(s.total_amount) AS spending,
           RANK() OVER (PARTITION BY c.city ORDER BY SUM(s.total_amount) DESC) AS rnk
    FROM customers c
    JOIN sales s
    ON c.customer_id = s.customer_id
    GROUP BY c.city, c.customer_id
) t
WHERE rnk = 1;

-- 66. Find branch-wise sales ranking.
SELECT branch, SUM(total_amount) AS total_sales, RANK() OVER (PARTITION BY branch ORDER BY SUM(total_amount) DESC) total_rnk
FROM sales
GROUP BY branch;

-- 67. Find running total of daily sales.
SELECT sale_date,
SUM(total_amount) AS daily_sales,
SUM(SUM(total_amount)) OVER (ORDER BY sale_date) AS running_total
FROM sales
GROUP BY sale_date;

-- 68. Find yearly sales growth.
SELECT YEAR(sale_date) AS year,
SUM(total_amount) AS yearly_sales
FROM sales
GROUP BY YEAR(sale_date)
ORDER BY year;

-- 69. Find products contributing 80% of revenue (Pareto analysis).
SELECT p.product_name,
SUM(s.total_amount) AS revenue
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 70. Find customers whose purchase frequency increased over time.
SELECT customer_id, year, total_orders
FROM (
    SELECT customer_id,
           YEAR(sale_date) AS year,
           COUNT(*) AS total_orders,
           LAG(COUNT(*)) OVER (PARTITION BY customer_id ORDER BY YEAR(sale_date)) AS prev_orders
    FROM sales
    GROUP BY customer_id, YEAR(sale_date)
) t
WHERE total_orders > prev_orders;

-- 71. Find average discount given by each branch.
SELECT branch,
AVG(discount_percentage) AS avg_discount
FROM sales
GROUP BY branch;

-- 72. Find category with highest profit margin. 
SELECT category,
AVG(selling_price - cost_price) AS avg_profit
FROM products
GROUP BY category
ORDER BY avg_profit DESC
LIMIT 1;

-- 73. Find top payment mode by revenue.
SELECT payment_mode,
SUM(total_amount) AS revenue
FROM sales
GROUP BY payment_mode
ORDER BY revenue DESC
LIMIT 1;

-- 74. Find products generating highest profit.
SELECT product_name,
(selling_price - cost_price) AS profit
FROM products
ORDER BY profit DESC
LIMIT 10;

-- 75. Find customers purchasing the most variety of products.
SELECT customer_id,
COUNT(DISTINCT product_id) AS product_variety
FROM sales
GROUP BY customer_id
ORDER BY product_variety DESC
LIMIT 5;

-- 76. Find revenue generated per customer per year.
SELECT customer_id,
YEAR(sale_date) AS year,
SUM(total_amount) AS yearly_revenue
FROM sales
GROUP BY customer_id, YEAR(sale_date)
ORDER BY customer_id, year;

-- 77. Find products frequently bought together (basic analysis).
SELECT product_id,
COUNT(*) AS purchase_count
FROM sales
GROUP BY product_id
ORDER BY purchase_count DESC;

-- 78. Find sales trend for the last 6 months.
SELECT sale_date,
SUM(total_amount) AS revenue
FROM sales
WHERE sale_date >= CURDATE() - INTERVAL 6 MONTH
GROUP BY sale_date
ORDER BY sale_date;

-- 79. Find top 5 products per branch.
SELECT *
FROM (
    SELECT branch,
           product_id,
           SUM(total_amount) AS revenue,
           RANK() OVER (PARTITION BY branch ORDER BY SUM(total_amount) DESC) AS rnk
    FROM sales
    GROUP BY branch, product_id
) t
WHERE rnk <= 5;

-- 80. Find branches where sales are above the overall branch average.
SELECT branch,
SUM(total_amount) AS revenue
FROM sales
GROUP BY branch
HAVING SUM(total_amount) >
       (SELECT AVG(total_amount) FROM sales);

