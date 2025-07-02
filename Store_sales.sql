--total_data
SELECT * from Store_sales
--unique_cutomers
SELECT COUNT(DISTINCT customer_id) AS Total_customers
from Store_sales 
--total category count
SELECT COUNT(DISTINCT category) AS Total_catogery
from Store_sales 
-- total category name
SELECT DISTINCT category AS name_of_products
from Store_sales

--Business Q&A AKA Data Analysis

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * from Store_sales 
where sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
  SELECT * from Store_sales
  WHERE category = 'Clothing'
  AND quantiy > 10  
  AND sale_date BETWEEN '2022-11-01' and '2022-11-30'
--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
  SELECT SUM(total_sale) AS total_Sales,category from Store_sales 
  GROUP BY category
  
--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 SELECT AVG(age) AS Average_age from Store_sales 
 WHERE category ='Beauty'
 
--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 SELECT * from Store_sales 
 WHERE total_sale > 1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
  SELECT age,category, SUM(total_sale) AS total_transactions from Store_sales 
  GROUP BY category,age
  ORDER BY category,age ASC
  
--Q.7 Write a SQL query to calculate the average sale for each month.
SELECT
  EXTRACT(YEAR FROM sale_date) AS year,
  EXTRACT(MONTH FROM sale_date) AS month,
  AVG(total_sale) AS average_monthly_sale
FROM
  Store_sales
GROUP BY
  year,
  month
ORDER BY
  year,
  month;

--Find out best selling month in each year.
SELECT
  year,
  month,
  total_monthly_sale
FROM (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    SUM(total_sale) AS total_monthly_sale,
    ROW_NUMBER() OVER (
      PARTITION BY EXTRACT(YEAR FROM sale_date)
      ORDER BY SUM(total_sale) DESC
    ) AS rn
  FROM
    Store_sales
  GROUP BY
    year,
    month
) AS ranked_sales
WHERE rn = 1
ORDER BY year;


 
--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT * from Store_sales 
ORDER BY total_sale DESC
LIMIT 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
COUNT(DISTINCT customer_id) from Store_sales 
GROUP BY category
ORDER BY category
--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) >= 12 AND EXTRACT(HOUR FROM sale_time) <= 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS number_of_orders
FROM
  Store_sales
GROUP BY
  shift
ORDER BY
  shift;


