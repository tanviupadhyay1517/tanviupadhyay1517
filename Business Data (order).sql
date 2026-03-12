-- Business Analysis
CREATE DATABASE order_data;
USE Order_data;
-- Show all tables data
SELECT * FROM customer;
SELECT * FROM transactions;
SELECT * FROM product;

-- Customer Analysis
-- 1. How many unique customers made purchases?
SELECT COUNT(DISTINCT cust_id) AS unique_customers
FROM transactions;

-- 2. What is the total number of customers in the dataset?
SELECT COUNT(customer_id) As Total_customers
FROM customer;

-- 3. How many male and female customers are there?
SELECT gender, COUNT(*) AS Male_and_Female
FROM customer
GROUP BY gender;

-- 4. Which city has the highest number of customers?
SELECT city_code, COUNT(customer_id) AS highest_customers
FROM customer
GROUP BY city_code
ORDER BY highest_customers DESC
LIMIT 1;

-- 5. What is the average age of customers?
SELECT AVG(TIMESTAMPDIFF(YEAR, DOB, CURDATE())) AS avg_customer_age
FROM customer;

-- 6. Which city generates the highest number of transactions?
SELECT c.city_code, COUNT(t.transaction_id) AS Highest_transaction
FROM transactions t
JOIN customer c
ON t.cust_id = c. customer_id
GROUP BY city_code
ORDER BY Highest_transaction DESC
LIMIT 1;
SELECT * FROM transactions;

-- 7. Which gender contributes the highest revenue?
SELECT c.gender, SUM(t.total_amt) AS highest_revenue
FROM transactions t
JOIN customer c
ON t.cust_id = c. customer_id
GROUP BY c.gender
ORDER BY highest_revenue DESC;

-- 8. What is the average spending per customer?
SELECT AVG(customer_spending) AS avg_spending_per_customer 
FROM (SELECT cust_id, SUM(total_amt) AS customer_spending 
FROM transactions 
GROUP BY cust_id
)t;

-- 9. Find top 10 customers by total spending.
SELECT cust_id, SUM(total_amt) AS Total_spending
FROM transactions
GROUP BY cust_id
ORDER BY Total_spending DESC
LIMIT 10;

-- 10. Find customers who made only one purchase.
SELECT cust_id, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY cust_id
HAVING total_transactions = 1;

-- 11. Find customers who made more than 10 transactions
SELECT cust_id, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY cust_id
HAVING total_transactions > 10;

-- 12. Which city has the highest revenue contribution
SELECT c.city_code, SUM(t.total_amt) AS total_revenue 
FROM customer c
JOIN transactions t
ON c.customer_id = t.cust_id
GROUP BY c.city_code
ORDER BY total_revenue DESC
LIMIT 1;

-- 13. Which customers generated the most tax revenue.
SELECT cust_id, SUM(tax) AS tax_revenue 
FROM transactions 
GROUP BY cust_id
ORDER BY tax_revenue DESC
LIMIT 1;

-- 14. Find customers who never made a transaction.
SELECT c.customer_id, t.transaction_id
FROM customer c
LEFT JOIN transactions t
ON c.customer_id = t.cust_id
WHERE t.cust_id IS NULL;

-- 15. Find the earliest transaction date in the dataset.
SELECT MIN(tran_date) AS first_transaction_date
FROM transactions;

-- Sales / Revenue Analysis
-- 16. What is the total revenue generated?
SELECT SUM(total_amt) AS Total_revenue
FROM transactions;

-- 17. What is the average transaction value?
SELECT AVG(total_amt) AS Avg_transaction
FROM transactions;

-- 18. Which transaction has the highest total amount?
SELECT transaction_id, total_amt
FROM transactions
ORDER BY total_amt DESC
LIMIT 1;

-- 19. Which month generated the highest sales?
SELECT MONTH(STR_TO_DATE(tran_date,'%d-%m-%Y')) AS Months, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY Months
ORDER BY total_sales DESC
LIMIT 1;

-- 20. Which year generated the highest revenue?
SELECT YEAR(STR_TO_DATE(tran_date,'%d-%m-%Y')) AS years, SUM(total_amt) AS total_revenue
FROM transactions
GROUP BY years
ORDER BY total_revenue
LIMIT 1;

-- 21. What is the total tax collected?
SELECT ROUND(SUM(tax),2) AS total_tax
FROM transactions;

-- 22. What is the average tax per transaction?
SELECT transaction_id, AVG(tax) AS avg_tax
FROM transactions
GROUP BY transaction_id;

-- 23. Find top 5 highest value transactions
SELECT transaction_id, total_amt
FROM transactions
ORDER BY total_amt DESC
LIMIT 5;

-- 24. Which day has the highest number of transactions?
SELECT COUNT(transaction_id) AS total_transaction, DATE(tran_date) AS Days
FROM transactions
GROUP BY Days
ORDER BY total_transaction DESC
LIMIT 1;

-- 25. What is the average quantity sold per transaction?
SELECT transaction_id, ROUND(AVG(qty)) As avg_qty
FROM transactions
GROUP BY transaction_id
ORDER BY avg_qty DESC;

-- 26. What is the daily revenue trend?
SELECT DAY(STR_TO_DATE(tran_date,'%d-%m-%Y')) AS days, SUM(total_amt) AS daily_revenue
FROM transactions
GROUP BY days
ORDER BY days;

-- 27. Which month has the lowest sales?
SELECT MONTH(STR_TO_DATE(tran_date,'%d-%m-%Y')) AS month,
       SUM(total_amt) AS total_sales
FROM transactions
GROUP BY month
ORDER BY total_sales
LIMIT 1;

-- 28. What is the average sales per month?
SELECT MONTH(str_to_date(tran_date, '%d-%m-%Y'))AS months, AVG(total_amt) AS avg_sales
FROM transactions
GROUP BY months
ORDER BY months;

-- 29. Find total revenue by year
SELECT YEAR(str_to_date(tran_date,'%d-%m-%Y')) AS years, SUM(total_amt) AS total_revenue 
FROM transactions
GROUP BY years
ORDER BY years;

-- 30. Find average revenue per day
SELECT DAY(str_to_date(tran_date, '%d-%m-%Y')) AS days, AVG(total_amt) AS avg_revenue
FROM transactions
GROUP BY days
ORDER BY days;

-- Product Performance
-- 31. Which product category generates the most revenue? 
SELECT p.prod_cat, SUM(t.total_amt) AS revenue
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY revenue DESC
LIMIT 1;

-- 32. Which product subcategory sells the highest quantity
SELECT p.prod_subcat, COUNT(t.qty) AS total_qty
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_subcat
ORDER BY total_qty DESC
LIMIT 1;

-- 33. Which product category has the highest average price
SELECT p.prod_cat, AVG(t.total_amt) AS Avg_price
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY Avg_price DESC
LIMIT 1;

-- 34. Find top 10 best-selling products by quantity
SELECT p.prod_subcat, COUNT(t.qty) AS total_quantity
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_subcat
ORDER BY total_quantity DESC
LIMIT 10;

-- 35. Which subcategory generates the highest revenue
SELECT p.prod_subcat, SUM(t.total_amt) AS revenue
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_subcat
ORDER BY revenue DESC
LIMIT 1;

-- 36. Which product category has the lowest revenue.
SELECT p.prod_cat, SUM(t.total_amt) AS revenue
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY revenue 
LIMIT 1;

-- 37. Which product subcategory has the lowest sales.
SELECT p.prod_subcat, ROUND(SUM(t.total_amt),2) AS total_sales
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_subcat
ORDER BY total_sales DESC
LIMIT 1;

-- 38. Which product category generates the highest tax.
SELECT p.prod_cat, SUM(t.tax) AS total_tax
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY total_tax DESC 
LIMIT 1;

-- 39. Average quantity sold per product category
SELECT p.prod_cat, AVG(t.qty) AS avg_qty
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY avg_qty DESC 
LIMIT 1;

-- 40. Average product rate by category
SELECT p.prod_cat, AVG(t.rate) AS avg_rate
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat;

-- 41. Subcategory contributing the most revenue
SELECT p.prod_subcat, SUM(t.total_amt) AS total_revenue
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_subcat
ORDER BY total_revenue DESC
LIMIT 1;

-- 42. Subcategory selling the least quantity.
SELECT p.prod_subcat, COUNT(t.qty) AS total_quantity
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_subcat
ORDER BY total_quantity 
LIMIT 1;

-- 43. Product category with highest number of transactions
SELECT p.prod_cat, AVG(t.transaction_id) AS total_transactions
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY total_transactions DESC 
LIMIT 1;

-- 44. Product category with lowest number of transactions
SELECT p.prod_cat, AVG(t.transaction_id) AS total_transactions
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY total_transactions 
LIMIT 1;

-- 45. Top 5 product categories by total quantity sold
SELECT p.prod_cat, AVG(t.qty) AS total_qty
FROM product p
JOIN transactions t
ON p.prod_cat_code = t.prod_cat_code
GROUP BY p.prod_cat
ORDER BY total_qty DESC
LIMIT 5;

-- Store Performance
-- 46. Which store type has the highest revenue?
SELECT store_type, SUM(total_amt) AS revenue
FROM transactions
GROUP BY store_type
ORDER BY revenue DESC
LIMIT 1;

-- 47. Which store type has the most transactions
SELECT store_type, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY store_type
ORDER BY total_transactions DESC
LIMIT 1;

-- 48. Which store type sells the most quantity
SELECT store_type, COUNT(qty) AS total_qty
FROM transactions
GROUP BY store_type
ORDER BY total_qty DESC
LIMIT 1;

-- 49. Average transaction value by store type.
SELECT store_type, AVG(total_amt) AS avg_trans
FROM transactions
GROUP BY store_type;

-- 50. Which store type collects the highest tax.
SELECT store_type, SUM(tax) AS total_tax
FROM transactions
GROUP BY store_type
ORDER BY total_tax DESC
LIMIT 1;

-- 51. Which store type has the lowest revenue.
SELECT store_type, SUM(total_amt) AS total_revenue
FROM transactions
GROUP BY store_type
ORDER BY total_revenue 
LIMIT 1;

-- 52. Which store type has the highest average quantity sold
SELECT store_type, AVG(qty) AS avg_qty
FROM transactions
GROUP BY store_type
ORDER BY avg_qty DESC
LIMIT 1;

-- 53. Top performing store type by total sales
SELECT store_type, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY store_type
ORDER BY total_sales DESC
LIMIT 1;

-- 54. Store type with highest revenue per transaction
SELECT store_type, SUM(total_amt) / SUM(transaction_id) AS revenue_per_transaction
FROM transactions
GROUP BY store_type
ORDER BY revenue_per_transaction DESC
LIMIT 1;

-- 55. Store type with the most unique customers
SELECT store_type, COUNT(DISTINCT cust_id) AS unique_customer
FROM transactions
GROUP BY store_type
ORDER BY unique_customer DESC
LIMIT 1;

-- Customer Purchase Behavior
-- 56. How many transactions each customer made?
SELECT cust_id, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY cust_id;

-- 57. Customers who spent more than the average customer
SELECT cust_id, SUM(total_amt) AS total_spent
FROM transactions
GROUP BY cust_id
HAVING total_spent > ( SELECT AVG(total_spent) AS avg_spent 
FROM ( SELECT SUM(total_amt) AS total_spent 
		FROM transactions 
		GROUP BY cust_id)t
);

-- 58. Customers who purchased from multiple product categories
SELECT cust_id, COUNT(DISTINCT prod_cat_code) AS category_count
FROM transactions
GROUP BY cust_id
HAVING category_count > 1;

-- 59. Customers who purchased from only one category
SELECT cust_id, COUNT(prod_cat_code) AS category_count
FROM transactions
GROUP BY cust_id
HAVING category_count = 1;

-- 60. Customers who purchased the same product multiple times
SELECT cust_id, COUNT(prod_cat_code) AS category_count
FROM transactions
GROUP BY cust_id
HAVING category_count > 1;

-- 61. Products most popular among male customers
SELECT c.gender, p.prod_subcat, SUM(t.qty) AS total_qty
FROM transactions t
JOIN customer c ON c.customer_id = t.cust_id
JOIN product p ON p.prod_cat_code = t. prod_cat_code
WHERE c.gender = 'M'
GROUP BY p.prod_subcat
ORDER BY total_qty DESC;

-- 62. Products most popular among female customers
SELECT c.gender, p.prod_subcat, SUM(t.qty) AS total_qty
FROM transactions t
JOIN customer c ON c.customer_id = t.cust_id
JOIN product p ON p.prod_cat_code = t. prod_cat_code
WHERE c.gender = 'F'
GROUP BY p.prod_subcat
ORDER BY total_qty DESC;

-- 63. Average spending per customer per year
SELECT cust_id, YEAR(str_to_date(tran_date, '%d-%m-%Y')) AS years, AVG(total_amt) AS avg_spending 
FROM transactions
GROUP BY cust_id, years;

-- 64. Customers who made purchases in the before 30 days
SELECT DISTINCT cust_id
FROM transactions
WHERE tran_date <= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 65. Top 20% customers contributing to revenue
SELECT cust_id, total_revenue
FROM (SELECT cust_id, SUM(total_amt) AS total_revenue,
		NTILE(5) OVER (ORDER BY SUM(total_amt) DESC) AS percentile_group
        FROM transactions
        GROUP BY cust_id
	)t
WHERE percentile_group = 1;

-- 66. Customers with highest number of transactions
SELECT cust_id, COUNT(transaction_id) AS total_tran
FROM transactions
GROUP BY cust_id
ORDER BY total_tran DESC;

-- 67. Customers with highest average purchase value
SELECT cust_id, AVG(total_amt) AS avg_purchase
FROM transactions
GROUP BY cust_id
ORDER BY avg_purchase DESC;

-- 68. Customers who spent more than 10000 total
SELECT cust_id, SUM(total_amt) AS total_spent
FROM transactions
GROUP BY cust_id
HAVING total_spent > 10000;

-- 69. Customers who purchased in multiple store types
SELECT cust_id, COUNT(DISTINCT store_type) AS store_count
FROM transactions
GROUP BY cust_id
HAVING store_count > 1;

-- 70. Customers who purchased from more than 3 categories
SELECT cust_id, COUNT(DISTINCT prod_cat_code) AS category_count
FROM transactions
GROUP BY cust_id
HAVING category_count > 3;

-- Time-Based Analysis
-- 71. Total sales by year.
SELECT YEAR(str_to_date(tran_date,'%d-%m-%Y')) AS years, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY years;

-- 72. Total sales by month 
SELECT MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY months;

-- 73. Total sales by day of week
SELECT DAYNAME(str_to_date(tran_date,'%d-%m-%Y')) AS days, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY days;

-- 74. Peak sales month
SELECT MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY months
ORDER BY total_sales DESC
LIMIT 1;

-- 75. Peak sales day
SELECT DAY(str_to_date(tran_date,'%d-%m-%Y')) AS days, SUM(total_amt) AS total_sales
FROM transactions
GROUP BY days
ORDER BY total_sales DESC
LIMIT 1;

-- 76. Monthly revenue.
SELECT YEAR(str_to_date(tran_date,'%d-%m-%Y')) AS years, MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, 
SUM(total_amt) AS total_sales
FROM transactions
GROUP BY months, years;

-- 77. Running total of revenue.
SELECT tran_date,
SUM(total_amt) OVER(ORDER BY tran_date) AS running_total
FROM transactions;

-- 78. Average daily sales
SELECT DATE(tran_date) AS days, AVG(total_amt) AS avg_sales
FROM transactions
GROUP BY days;

-- 79. Total transactions per month
SELECT MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY months;

-- 80. Total quantity sold per month
SELECT  MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, SUM(qty) AS total_qty
FROM transactions
GROUP BY months;

-- 81. Month with highest number of customers
SELECT  MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, COUNT( DISTINCT cust_id) AS total_customer
FROM transactions
GROUP BY months
ORDER BY total_customer DESC
LIMIT 1;

-- 82. Month with lowest number of transactions
SELECT MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY months
ORDER BY total_transactions
LIMIT 1;

-- 83. Average transaction amount per month
SELECT MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, AVG(transaction_id) AS Avg_transactions
FROM transactions
GROUP BY months
ORDER BY Avg_transactions;

-- 84. Monthly tax collected
SELECT MONTH(str_to_date(tran_date,'%d-%m-%Y')) AS months, SUM(tax) AS total_tax
FROM transactions
GROUP BY months;

-- 85.Year-wise revenue
SELECT YEAR(str_to_date(tran_date,'%d-%m-%Y')) AS years, SUM(total_amt) AS total_revenue
FROM transactions
GROUP BY years;

-- Advanced Business Insights
-- 86. Rank product categories by revenue
SELECT p.prod_cat, SUM(t.total_amt) AS total_revenue, RANK() OVER (ORDER BY SUM(t.total_amt) DESC) AS product_cat_rank
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_cat;

-- 87. Find top 3 products in each category
SELECT * 
FROM 
( SELECT p.prod_cat, p.prod_subcat, SUM(t.qty) AS total_qty, 
RANK() OVER (PARTITION BY p.prod_cat ORDER BY SUM(t.qty) DESC) AS rnk
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_cat, p.prod_subcat
)x
WHERE rnk <= 3;

-- 88. Percentage contribution of each category to total sales
SELECT p.prod_cat,
       SUM(t.total_amt) AS revenue,
       ROUND(SUM(t.total_amt)*100/
       (SELECT SUM(total_amt) FROM transactions),2) AS revenue_percent
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_cat;

-- 89. Customer lifetime value
SELECT cust_id,
       SUM(total_amt) AS lifetime_value
FROM transactions
GROUP BY cust_id
ORDER BY lifetime_value DESC;

-- 90. Customers whose spending is above average customer spending.
SELECT cust_id,
       SUM(total_amt) AS total_spent
FROM transactions
GROUP BY cust_id
HAVING SUM(total_amt) >
(
SELECT AVG(total_spent)
FROM
(
SELECT SUM(total_amt) AS total_spent
FROM transactions
GROUP BY cust_id
) t
);

-- 91. Products contributing 80% of total revenue (Pareto).
SELECT *
FROM
(
SELECT p.prod_subcat,
       SUM(t.total_amt) AS revenue,
       SUM(SUM(t.total_amt)) OVER(ORDER BY SUM(t.total_amt) DESC) /
       SUM(SUM(t.total_amt)) OVER() AS cumulative_percent
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_subcat
) x
WHERE cumulative_percent <= 0.8;

-- 92. Highest spending customer per city.
SELECT *
FROM
(
SELECT c.city_code,
       t.cust_id,
       SUM(t.total_amt) AS total_spent,
       RANK() OVER(PARTITION BY c.city_code ORDER BY SUM(t.total_amt) DESC) rnk
FROM transactions t
JOIN customer c
ON t.cust_id = c.customer_id
GROUP BY c.city_code, t.cust_id
) x
WHERE rnk = 1;

-- 93. Rank customers by spending within each city.
SELECT c.city_code,
       t.cust_id,
       SUM(t.total_amt) AS total_spent,
       RANK() OVER(PARTITION BY c.city_code ORDER BY SUM(t.total_amt) DESC) AS rank_in_city
FROM transactions t
JOIN customer c
ON t.cust_id = c.customer_id
GROUP BY c.city_code, t.cust_id;

-- 94. Top transaction per product category
SELECT *
FROM
(
SELECT p.prod_cat,
       t.transaction_id,
       t.total_amt,
       RANK() OVER(PARTITION BY p.prod_cat ORDER BY t.total_amt DESC) rnk
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
) x
WHERE rnk = 1;

-- 95. Running total of sales by category.
SELECT p.prod_cat,
       t.tran_date,
       SUM(t.total_amt) OVER(PARTITION BY p.prod_cat ORDER BY t.tran_date) AS running_sales
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code;

-- 96. Highest sales transaction per store type
SELECT *
FROM
(
SELECT store_type,
       transaction_id,
       total_amt,
       RANK() OVER(PARTITION BY store_type ORDER BY total_amt DESC) rnk
FROM transactions
) x
WHERE rnk = 1;

-- 97. Top product subcategory per store type.
SELECT *
FROM
(
SELECT store_type,
       prod_subcat_code,
       SUM(total_amt) AS revenue,
       RANK() OVER(PARTITION BY store_type ORDER BY SUM(total_amt) DESC) rnk
FROM transactions
GROUP BY store_type, prod_subcat_code
) x
WHERE rnk = 1;

-- 98. Percentage of revenue contributed by each store type
SELECT store_type,
       SUM(total_amt) AS revenue,
       ROUND(SUM(total_amt)*100/
       (SELECT SUM(total_amt) FROM transactions),2) AS revenue_percent
FROM transactions
GROUP BY store_type;

-- 99. Customers whose spending increased year over year.
SELECT *
FROM
(
SELECT cust_id,
       YEAR(tran_date) AS year,
       SUM(total_amt) AS yearly_spent,
       LAG(SUM(total_amt)) OVER(PARTITION BY cust_id ORDER BY YEAR(tran_date)) AS prev_year
FROM transactions
GROUP BY cust_id, year
) x
WHERE yearly_spent > prev_year;

-- 100. Categories where sales are above overall average category sales
SELECT prod_cat, revenue
FROM
(
SELECT p.prod_cat,
       SUM(t.total_amt) AS revenue
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_cat
) x
WHERE revenue >
(
SELECT AVG(revenue)
FROM
(
SELECT SUM(total_amt) AS revenue
FROM transactions
GROUP BY prod_cat_code
) t
);

-- practice questions
-- 101. What is the total number of rows in each of the 3 tables in the database?
SELECT COUNT(*) AS total_no_rows FROM customer;
SELECT COUNT(*) AS total_no_rows FROM transactions;
SELECT COUNT(*) AS total_no_rows FROM product;

-- 102. What is the total number of transactions that have a return?
SELECT COUNT(total_amt) AS total_transactions
FROM transactions
WHERE total_amt LIKE '-%';

-- 103. As you would have noticed, the dates provided across the datasets must be in the correct format. As the first step, 
-- please convert the date variables into valid date formats before proceeding.
SELECT STR_TO_DATE(dob,'%d-%m-%Y') dob_dates FROM customer;
SELECT STR_TO_DATE(tran_date,'%d-%m-%Y') transaction_dates FROM transactions;

-- 104. What is the time range of the transaction data available for analysis? 
-- Show the output in the number of days, months, and years simultaneously in different columns.
SELECT 
DATEDIFF(
    MAX(STR_TO_DATE(tran_date,'%d-%m-%Y')),
    MIN(STR_TO_DATE(tran_date,'%d-%m-%Y'))
) AS total_days,

TIMESTAMPDIFF(
    MONTH,
    MIN(STR_TO_DATE(tran_date,'%d-%m-%Y')),
    MAX(STR_TO_DATE(tran_date,'%d-%m-%Y'))
) AS total_months,

TIMESTAMPDIFF(
    YEAR,
    MIN(STR_TO_DATE(tran_date,'%d-%m-%Y')),
    MAX(STR_TO_DATE(tran_date,'%d-%m-%Y'))
) AS total_years

FROM transactions;

-- 105. Which product category does the sub-category “DIY” belong to?
SELECT prod_cat, prod_subcat
FROM product
WHERE prod_subcat = "DIY";

-- 106. Which channel is most frequently used for transactions?
 SELECT store_type, COUNT(transaction_id) As frequent
 FROM transactions
 GROUP BY store_type
 ORDER BY frequent DESC;

-- 107. What is the count of Male and Female customers in the database?
SELECT gender, COUNT(customer_id) AS count_gender
FROM customer
WHERE Gender IN('M' , 'F' )
GROUP BY Gender;

-- 108. From which city do we have the maximum number of customers, and how many?
SELECT city_code, COUNT(customer_id) As count_cust
FROM customer
GROUP BY city_code
ORDER BY count_cust DESC;

-- 109. How many sub-categories are there under the Books category?
SELECT prod_cat, COUNT(prod_subcat) AS count_category 
FROM product
WHERE prod_cat = "Books"
GROUP BY prod_cat;

-- 110. What is the maximum quantity of products ever ordered?
SELECT cust_id, SUM(qty) AS max_qty
FROM transactions
GROUP BY cust_id;

-- 111. What is the net total revenue generated in the categories of Electronics and Books?
SELECT p.prod_cat, ROUND(SUM(total_amt),2) AS Revenue
FROM transactions t
JOIN product p
ON p.prod_cat_code = t.prod_cat_code
WHERE p.prod_cat IN("Electronics", "Books")
GROUP BY p.prod_cat;

-- 112. How many customers have >10 transactions with us, excluding returns?
SELECT COUNT(customer_id) AS count_customer
FROM customer
WHERE customer_id IN(SELECT cust_id 
						FROM transactions 
                        LEFT JOIN customer 
                        ON customer_id = cust_id 
						WHERE total_amt NOT LIKE "-%"
                        GROUP BY cust_id
                        HAVING COUNT(transaction_id) > 10);

-- 113. What is the combined revenue earned from the “Electronics” & “Clothing” categories from “Flagship stores”?
SELECT SUM(t.total_amt) AS revenue
FROM transactions t
INNER JOIN product p
ON p.prod_cat_code = t.prod_cat_code AND p.prod_sub_cat_code = t.prod_subcat_code 
WHERE p.prod_cat IN('Clothing', 'Electronics') AND t.store_type = "Flagship store";

-- 114. What is the total revenue generated from “Male” customers in the “Electronics” category? 
-- Output should display total revenue by prod sub-cat.
SELECT p.prod_subcat, SUM(t.total_amt) AS total_revenue
FROM transactions t
JOIN customer c
ON c.customer_id =t.cust_id
JOIN product p
ON p.prod_cat_code = t.prod_cat_code
WHERE c.gender = 'M' AND p.prod_cat = 'Electronics'
GROUP BY p.prod_subcat;

-- 115. What is the percentage of sales and returns by product subcategory; display only the top 5 subcategories in terms of sales?
SELECT 
p.prod_subcat,
(SUM(t.total_amt) / (SELECT SUM(total_amt) FROM transactions)) * 100 AS sales_percentage,
(COUNT(CASE WHEN t.qty < 0 THEN 1 END) / COUNT(*)) * 100 AS percentage_of_return

FROM transactions t
JOIN product p
ON p.prod_sub_cat_code = t.prod_subcat_code

GROUP BY p.prod_subcat
ORDER BY SUM(t.total_amt) DESC
LIMIT 5;

-- 116. For all customers aged between 25 and 35 years, 
-- find what is the net total revenue generated by these consumers in the last 30 days of transactions from 
-- max transaction date available in the data.
SELECT SUM(t.total_amt) AS net_total_revenue
FROM transactions t
JOIN customer c 
ON t.cust_id = c.customer_id
WHERE 
TIMESTAMPDIFF(YEAR, STR_TO_DATE(c.dob,'%d-%m-%Y'),
              (SELECT MAX(STR_TO_DATE(tran_date,'%d-%m-%Y')) FROM transactions))
BETWEEN 25 AND 35
AND STR_TO_DATE(t.tran_date,'%d-%m-%Y') >= 
DATE_SUB(
    (SELECT MAX(STR_TO_DATE(tran_date,'%d-%m-%Y')) FROM transactions),
    INTERVAL 30 DAY
);

-- 117. Which product category has seen the maximum value of returns in the last 3 months of transactions?
SELECT p.prod_cat,
       SUM(t.total_amt) AS total_return_value
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
WHERE t.qty < 0
AND STR_TO_DATE(t.tran_date,'%d-%m-%Y') >=
DATE_SUB(
        (SELECT MAX(STR_TO_DATE(tran_date,'%d-%m-%Y')) 
         FROM transactions),
        INTERVAL 3 MONTH
)
GROUP BY p.prod_cat
ORDER BY total_return_value ASC
LIMIT 1;

-- 118. Which store type sells the maximum number of products, based on the value of sales amount and quantity sold?
SELECT store_type,
       SUM(total_amt) AS total_sales_amount,
       SUM(qty) AS total_quantity_sold
FROM transactions
GROUP BY store_type
ORDER BY total_sales_amount DESC, total_quantity_sold DESC
LIMIT 1;

-- 119. What are the categories for which average revenue is above the overall average?
SELECT p.prod_cat,
       AVG(t.total_amt) AS avg_category_revenue
FROM transactions t
JOIN product p
ON t.prod_cat_code = p.prod_cat_code
GROUP BY p.prod_cat
HAVING avg_category_revenue >
      (SELECT AVG(total_amt) FROM transactions);
      
-- 120. Find each subcategory's average and total revenue for the categories among the top 5 categories in quantity sold.
SELECT 
p.prod_subcat,
AVG(t.total_amt) AS avg_revenue,
SUM(t.total_amt) AS total_revenue
FROM transactions t
JOIN product p
ON t.prod_subcat_code = p.prod_sub_cat_code

JOIN (
        SELECT prod_cat_code
        FROM transactions
        GROUP BY prod_cat_code
        ORDER BY SUM(qty) DESC
        LIMIT 5
     ) top_categories

ON t.prod_cat_code = top_categories.prod_cat_code
GROUP BY p.prod_subcat;
