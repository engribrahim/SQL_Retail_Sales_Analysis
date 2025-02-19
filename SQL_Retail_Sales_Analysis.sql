

select * from [SQL - Retail Sales Analysis_utf ]

select count(*) from [SQL - Retail Sales Analysis_utf ]

select * from [SQL - Retail Sales Analysis_utf ]
	where transactions_id is null

select * from [SQL - Retail Sales Analysis_utf ]
where sale_date is null

select * from [SQL - Retail Sales Analysis_utf ]
where sale_time is null

select * from [SQL - Retail Sales Analysis_utf ]
where sale_time is null
or
sale_date is null
or
gender is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null
--------------------------------------------------------------------------------------
--Now we will Delete Null values---
delete from [SQL - Retail Sales Analysis_utf ]
where sale_time is null
or
sale_date is null
or
gender is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null
------------------------------------------------------------------
---To Verifiey -----
select count(*) from [SQL - Retail Sales Analysis_utf ]
-------------------------------------------------------------------
select count(DISTINCT customer_id) as total_sales from [SQL - Retail Sales Analysis_utf ]
------Now we will see Distinct category ----------------
select count(DISTINCT category) as total_sales from [SQL - Retail Sales Analysis_utf ]

select DISTINCT category from [SQL - Retail Sales Analysis_utf ]

------------------Data Analysis & Business Key problem & Answer-----------------
--Q write an sql query to retrive all sales made on '2022-11-05'
select * from [SQL - Retail Sales Analysis_utf ]
where sale_date='2022-11-05';
--Q write an SQL querry to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the
--month of Nov-2022----

SELECT *
FROM [SQL - Retail Sales Analysis_utf ]
WHERE category = 'Clothing'
AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
AND quantiy >=4;
--Q write an SQL querry to calculate the total sales (total sales) for each category----
SELECT 
  category,
  SUM(total_sale) AS net_sale,
  COUNT(*) AS total_orders
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY category;
---Q write a sql querry to find average age of customers who purchased items from the 'Beauty' Category.
SELECT 
  AVG(age) AS avg_age
FROM [SQL - Retail Sales Analysis_utf]
WHERE category = 'Beauty';
---Q write an sql query to find all transaction where the total_sale is greater than 1000
Select * from [SQL - Retail Sales Analysis_utf ]
where total_sale >=1000
----Q write an sql query to find the totla number of transactions (transaction_id) made by each gender in each category.
SELECT 
  category, 
  gender, 
  COUNT(*) AS total_transaction
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY category, gender;
---Q write an SQL query to calculate the average sale for each month. Find out best selling month in each year-

WITH MonthlySales AS (
  SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS avg_sale
  FROM [SQL - Retail Sales Analysis_utf]
  GROUP BY YEAR(sale_date), MONTH(sale_date)
),
RankedSales AS (
  SELECT 
    sale_year,
    sale_month,
    avg_sale,
    RANK() OVER (PARTITION BY sale_year ORDER BY avg_sale DESC) AS rank_sales
  FROM MonthlySales
)
SELECT 
  sale_year,
  sale_month,
  avg_sale
FROM RankedSales
WHERE rank_sales = 1
ORDER BY sale_year, sale_month;
-----Q write an sql query to find the top 5 customers based on the higest top sales
---select * from [SQL - Retail Sales Analysis_utf ]

SELECT top 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY customer_id
ORDER BY total_sales DESC;

-----Q write an sql query to find the number of unique customers who purchased items from each category

SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY category;

--Q write an sql query to create each shift and number of orders (Example Morning <=12,
---afternoon between 12 & 17, evening >17)
---select * FROM [SQL - Retail Sales Analysis_utf]
-----------------------
SELECT 
    CASE
        WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS number_of_orders
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY 
    CASE
        WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY shift;




