-- Employee Management data  
CREATE DATABASE practice2;
USE practice2;

-- 1. Show all employee records.
SELECT * FROM employees;

-- 2. Display first name and last name of employees.
SELECT first_name, last_name FROM employees;

-- 3. Show employee names and their salary.
SELECT CONCAT(first_name, ' ', last_name) AS Names, salary
FROM employees;

-- 4. Display all departments. 
SELECT * FROM department;

-- 5. Show employee first name and city.
SELECT first_name, city FROM employees;

-- 6. Display employee id and join date.
SELECT emp_id, join_date FROM employees;

-- 7. Show department name and location.
SELECT dept_name, location FROM department;

-- 8. Display employee name and age.
SELECT CONCAT(first_name, ' ',last_name) As employee_name, age 
FROM employees;

-- 9. Show all department managers.
SELECT manager FROM department;

-- 10. Display employee id and department id.
SELECT emp_id, dept_id FROM employees;

-- 11. Find employees with salary greater than 50,000.
SELECT emp_id, salary
FROM employees
WHERE salary > 50000;

-- 12. Show employees whose age is greater than 30.
SELECT emp_id, age
FROM employees
WHERE age > 30;

-- 13. Find employees who live in Pune.
SELECT emp_id, city
FROM employees
WHERE city = "Pune";

-- 14. Show employees whose salary is between 40,000 and 80,000.
SELECT emp_id, salary 
FROM employees
WHERE salary BETWEEN 40000 AND 80000;

-- 15. Find employees whose age is less than 25.
SELECT emp_id, age 
FROM employees
WHERE age < 25;

-- 16. Display employees working in department 121.
SELECT * FROM employees
WHERE dept_id = 121;

-- 17. Show employees who are not from Mumbai.
SELECT * FROM employees
WHERE city NOT IN("Mumbai");

-- 18. Find employees with salary greater than or equal to 70,000.
SELECT * FROM employees
WHERE salary >= 70000;

-- 19. Display employees whose age is between 25 and 35.
SELECT * FROM employees
WHERE age BETWEEN 25 AND 35;

-- 20. Find departments with budget greater than 100,000.
SELECT * FROM department 
WHERE budget > 400000; 

-- 21. Display employees ordered by salary in descending order.
SELECT * FROM employees 
ORDER BY salary DESC;

-- 22. Show employees ordered by age in ascending order.
SELECT * FROM employees
ORDER BY age ASC;

-- 23. List employees ordered by first name alphabetically.
SELECT * FROM employees
ORDER BY first_name ASC;

-- 24. Display departments ordered by budget.
SELECT * FROM department
ORDER BY budget;

-- 25. Show employees ordered by join date.
SELECT * FROM employees
ORDER BY join_date;

-- 26. Find the total number of employees.
SELECT COUNT(*) AS total_employee FROM employees;

-- 27. Find the total salary paid to employees.
SELECT SUM(salary) AS Total_salary FROM employees; 

-- 28. Find the average salary of employees.
SELECT AVG(salary) AS avg_salary FROM employees;

-- 29. Find the maximum salary in the company.
SELECT MAX(salary) AS Max_salary FROM employees;

-- 30. Find the minimum age of employees.
SELECT MIN(age) AS Min_age FROM employees;

-- 31. Count employees in each department.
SELECT dept_id, COUNT(emp_id) As employees FROM employees
GROUP BY dept_id; 

-- 32. Find average salary in each department.
SELECT dept_id, AVG(salary) AS avg_salary FROM employees
GROUP BY dept_id;

-- 33. Count employees in each city.
SELECT city, COUNT(*) AS total_employees FROM employees
GROUP  BY city;

-- 34. Find maximum salary department wise.
SELECT dept_id, MAX(salary) As max_salary FROM employees
GROUP BY dept_id;

-- 35. Find total salary department wise.
SELECT dept_id, SUM(salary) AS total_salary FROM employees
GROUP BY dept_id;

-- 36. Find departments having more than 1 employees.
SELECT dept_name, COUNT(dept_name) As employees
FROM department
GROUP BY dept_name
HAVING employees >= 1;

-- 37. Find cities where average salary is greater than 50,000.
SELECT city, AVG(salary) As avg_salary
FROM employees
GROUP BY city
HAVING avg_salary > 50000;

-- 38. Find departments where total salary is greater than 200,000.
SELECT dept_id, SUM(salary) AS total_salary 
FROM employees
GROUP BY dept_id
HAVING total_salary > 200000;

-- 39. Find departments where maximum salary is greater than 80,000.
SELECT dept_id, MAX(salary) AS max_salary 
FROM employees
GROUP BY dept_id
HAVING max_salary > 80000;

-- 40. Find cities having more than 2 employees.
SELECT city, COUNT(emp_id) AS employees
FROM employees
GROUP BY city
HAVING employees > 2;

-- 41. Display full name of employees by combining first name and last name.
SELECT CONCAT(first_name,' ', last_name) AS Full_name 
FROM employees;

-- 42. Convert employee first names to uppercase.
SELECT UPPER(first_name) AS Uppercase_name
FROM employees;

-- 43. Convert employee first names to uppercase.
SELECT LOWER(first_name) AS lowercase_name
FROM employees;

-- 44. Find the length of each employee’s first name.
SELECT first_name, LENGTH(first_name) AS length_name
FROM employees;

-- 45. Extract the first three characters of employee names.
SELECT first_name, SUBSTRING(first_name,1,3) AS First_three_letters
FROM employees;

-- 46. Remove extra spaces from employee names.
SELECT TRIM(first_name) AS clean_firstname
FROM employees;

-- 47. Replace letter 'a' with '@' in employee names.
SELECT first_name, REPLACE(first_name, 'a', '@') AS modifie_name
FROM employees;

-- 48. Find employees whose names start with 'A'.
SELECT first_name 
FROM employees
WHERE first_name LIKE 'A%';

-- 49. Find employees whose names end with 'n'.
SELECT first_name
FROM employees
WHERE first_name LIKE '%n';

-- 50. Find employees whose second letter is 'a'.
SELECT first_name
FROM employees
WHERE first_name LIKE '_a%';

-- 51. Display the current date.
SELECT NOW()
FROM employees;

-- 52. Extract the year from employee join date.
SELECT YEAR(join_date) AS YEAR
FROM employees;

-- 53. Extract the month from join date.
SELECT MONTH(join_date) AS MONTH
FROM employees;

-- 54. Extract the day from join date.
SELECT DAY(join_date) AS DATE
FROM employees;

-- 55. Find employees who joined after 2022.
SELECT emp_id, join_date
FROM employees
WHERE join_date > 2022;

-- 56. Find employees who joined in the last 2 year.
SELECT first_name, join_date
FROM employees
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 57. Calculate the number of days since employees joined.
SELECT first_name, DATEDIFF(CURDATE(), join_date) AS days_since_join 
FROM employees;

-- 58. Display join date in year–month format
SELECT first_name, DATE_FORMAT(join_date, '%Y-%m') As Join_year_month
FROM employees;

-- 59. Find employees who joined in January
SELECT first_name, join_date
FROM employees
WHERE MONTH(join_date) = 1; 

-- 60. Find employees who joined in 2023
SELECT first_name, join_date
FROM employees
WHERE YEAR(join_date) = 2023;

-- 61. Round employee salaries to the nearest integer.
SELECT first_name, ROUND(salary) AS round_salary
FROM employees;

-- 62. Find the ceiling value of employee salaries.
SELECT CEILING(salary) AS ceiling_salary
FROM employees;

-- 63. Find the floor value of employee salaries.
SELECT FLOOR(salary) AS floor_salary
FROM employees;

-- 64. Find absolute value of a negative number.
SELECT ABS(-100) AS absolute_value;

-- 65. Find square root of a number
SELECT SQRT(144) As square_root;

-- 66. Display employee names with their department names.
SELECT d.dept_name, CONCAT(e.first_name,' ',e.last_name) AS full_name
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id;

-- 67. Show employees with their department managers.
SELECT e.emp_id, d.manager 
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id;

-- 68. Display employees with department locations.
SELECT e.emp_id, d.location
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id;

-- 69. Show all employees with department details using LEFT JOIN.
SELECT e.*, d.dept_name, d.manager, d.location
FROM employees e
LEFT JOIN department d
ON e.dept_id = d.dept_id;

-- 70. Show all departments with employee details using LEFT JOIN. 
SELECT d.*, e.emp_id, e.first_name, e.last_name
FROM department d
LEFT JOIN employees e
ON e.dept_id = d.dept_id;

-- 71. Show employee full name and department name.
SELECT d.dept_name, CONCAT(e.first_name,' ', e.last_name) As Full_name
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id;

-- 72. List employees working in departments located in Delhi.
SELECT e.emp_id, d.dept_name
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
WHERE location = "Delhi";

-- 73. Show employees with salary > 60000 along with department manager.
SELECT d.manager, e.salary
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
WHERE salary > 60000;

-- 74. Count employees in each department.
SELECT d.dept_name, COUNT(*)
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 75. Show departments that have no employees.
SELECT d.dept_id, d.dept_name
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- 76. List employees older than 30 with department location.
SELECT e.age, d.location
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
WHERE e.age > 30;
 
-- 77. Show employees whose salary is higher than department budget / 10.
SELECT e.emp_id, e.first_name, e.last_name, e.salary, d.dept_name, d.budget
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
WHERE e.salary > d.budget / 10;

-- 78. Show employees who joined after 2022 with department name.
SELECT e.emp_id, e.join_date, d.dept_name
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
WHERE e.join_date > 2022;

-- 79. Find total salary expense per department.
SELECT d.dept_name, SUM(e.salary) As total_salary 
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 80. Show employees working under each manager.
SELECT e.emp_id, e.first_name,e.last_name, d.manager
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id;

-- 81. Departments where average salary > 50000.
SELECT d.dept_id, d.dept_name, AVG(e.salary) As avg_salary
FROM department d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > 50000;

-- 82. Departments with more than 2 employees.
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS All_employees
FROM department d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) > 2;

-- 83. Cities with more than 3 employees.
SELECT city, COUNT(emp_id) AS employee , first_name, last_name
FROM employees
GROUP BY city, first_name, last_name
HAVING COUNT(emp_id) > 1;

-- 84. Department with highest total salary expense.
SELECT d.dept_id, d.dept_name, SUM(e.salary) AS total_salary
FROM department d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC
LIMIT 1;

-- 85. Average age of employees in each department.
SELECT d.dept_id, d.dept_name, AVG(e.age) As avg_age
FROM employees e
JOIN department d
ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 86. Employees earning more than overall average salary.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 87. Employees earning more than department average salary.
SELECT *
FROM employees e
WHERE salary > (SELECT AVG(budget) FROM department d WHERE d.dept_id = e.dept_id);

-- 88. Departments where total salary exceeds budget.
SELECT d.dept_id, d.dept_name, d.budget, SUM(e.salary) As Total_salary, SUM(e.salary) - d.budget AS exceed_amount
FROM department d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name, d.budget
HAVING SUM(e.salary) > d.budget;

-- 89. Employees working in department with highest budget.
SELECT emp_id, first_name, last_name, dept_id
FROM employees
WHERE dept_id = (SELECT dept_id FROM department WHERE budget = (SELECT MAX(budget) FROM department) );

-- 90. Employees working in same department as highest-paid employee.
SELECT emp_id, first_name, last_name, salary, dept_id
FROM employees
WHERE dept_id = (SELECT dept_id FROM employees WHERE salary = (SELECT MAX(salary) FROM employees) );

-- 91. Rank employees by salary within department.
SELECT
    emp_id, first_name, last_name, dept_id, salary,
    RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 92. Find highest paid employee in each department
SELECT *
FROM (SELECT emp_id, first_name, last_name, dept_id, salary, RANK() OVER(partition by dept_id ORDER BY salary DESC ) As rnk
FROM employees
) t
WHERE rnk = 1;

-- 93. Top 3 salaries per department
SELECT *
FROM (SELECT emp_id, first_name, last_name, dept_id, salary, DENSE_RANK() OVER(partition by dept_id ORDER BY salary DESC ) As rnk
FROM employees
) t
WHERE rnk <= 3;

-- 94. Running total of salary by department
SELECT emp_id, first_name, last_name, dept_id, salary, SUM(salary) OVER ( partition by dept_id ORDER BY salary DESC ROWS BETWEEN unbounded preceding AND current row) AS running_total_salary
FROM employees;

-- 95. Compare employee salary with previous employee salary
SELECT
    emp_id, first_name, dept_id, salary,
    LAG(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS previous_salary,
    salary - LAG(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS salary_difference
FROM employees;

-- 96. Categorize salary as Low / Medium / High.
SELECT emp_id, first_name, last_name, salary,
CASE
	WHEN salary < 40000 THEN 'LOW'
    WHEN salary BETWEEN 40000 AND 80000 THEN 'MEDIUM'
    ELSE 'HIGH'
END AS salary_category
FROM employees;

-- 97. Show experience level based on join_date
SELECT
    emp_id,
    first_name,
    join_date,
    CASE
        WHEN join_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) THEN 'Junior'
        WHEN join_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) THEN 'Mid-Level'
        ELSE 'Senior'
    END AS experience_level
FROM employees;

-- 98. Show age group: Young / Mid / Senior
SELECT emp_id, first_name, age,
CASE
	WHEN age < 30 THEN 'Young'
    WHEN age BETWEEN 30 AND 55 THEN 'Mid'
    ELSE 'Senior'
END AS age_group
FROM employees;

-- 99. Show bonus eligibility
SELECT emp_id, first_name, last_name, dept_id, salary,
CASE
	WHEN salary > AVG(salary) OVER (partition by dept_id) THEN 'Eligible'
    ELSE 'Not Eligible'
END AS bonus_eligibility
FROM employees;

-- 100. Use CTE to find employees earning above average salary.
WITH avg_salary AS( SELECT AVG(salary) avg_sal FROM employees)
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT avg_sal FROM avg_salary);