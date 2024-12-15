CREATE DATABASE Product_Analysis;
USE Product_Analysis;
SELECT * FROM Orders;
SELECT * FROM Account;
SELECT * FROM Products;
DESCRIBE Orders;
DESCRIBE Products;
DESCRIBE Account;
-- Standardizing the Date Format in the Orders table
UPDATE Orders
SET order_date=STR_TO_DATE(Order_date,'%m/%d/%Y'),
    ship_date=STR_TO_DATE(ship_date,'%m/%d/%Y');
ALTER TABLE Orders
    MODIFY COLUMN order_date date,
    MODIFY COLUMN ship_date date;
-- Determine null values within the dataset
SELECT Count(*)
FROM orders
WHERE order_no is null;
-- Checking for duplicates
SELECT order_No,count(order_no)as Appearance_count
FROM Orders
group by order_no
order by  Appearance_count Desc; 

SELECT order_No,count(order_no)as Appearance_count
FROM Orders
GROUP BY order_no
HAVING Appearance_count>1;
SELECT *
FROM orders
WHERE order_no='5768-2' OR order_no='6159-2';

-- Total revenue generated by each product category
SELECT product_category,Round(sum(total),0)AS Revenue
FROM orders ord
LEFT JOIN Products pro
ON ord.product_id=pro.product_id
GROUP BY product_category;
-- How many unique products were ordered
SELECT Count(Distinct product_name) AS Unique_products
FROM orders ord
LEFT JOIN Products pro
ON ord.product_id=pro.product_id;
-- What is the total revenue generated each year from Highest to Lowest
SELECT Extract(Year from order_date) Year,
Round(sum(total),2) AS Revenue_per_Year
FROM Orders
 GROUP BY Year
 ORDER BY Revenue_per_year Desc;
 -- Revenue for a specified year based on months e.g 2016
 SELECT Extract(Month from order_date) month ,
        Format(sum(total),2) AS 2016Revenue_per_Month
FROM Orders
WHERE Extract(Year from order_date)=2016
 GROUP BY month;
-- What is the date of the latest and earliest order
SELECT Max(order_date) Latest_order_date,Min(order_date) Earliest_order_date
FROM orders;
-- How many days have the orders been running
SELECT datediff(max(order_date),min(order_date)) Operational_days
FROM orders;
-- What product has the lowest average price of products
select *
from orders;
SELECT product_category,Round(avg(retail_price),0)AS Average_price
FROM orders ord
LEFT JOIN products
USING(product_id)
GROUP BY product_category
ORDER BY Average_price
Limit 1;
-- What are the top 10 highest perfoming products?
SELECT product_name,Round(Sum(total),2) Revenue
FROM orders ord
LEFT JOIN products
USING(product_id)
GROUP BY product_name
ORDER BY Revenue Desc
LIMIT 10;
-- Show total revenue and profit generated by each account manager
SELECT account_manager,sum(total) Revenue,
Round(Sum(total)-sum(cost_price),2) Profit
FROM orders ord
LEFT JOIN account acc
USING(account_id)
GROUP BY account_manager
ORDER BY PROFIT DESC;
-- What is the name,city and account manager of the highest selling product in 2017?
select *
from ORDERS;
SELECT product_name,`customer name`,city,account_manager,(Sum(total)) Highest_product_Revenue
FROM Orders
LEFT JOIN Products
USING(product_id)
LEFT JOIN Account
USING(account_id)
WHERE Extract(year from order_date)=2017
GROUP BY product_name,city,account_manager,`customer name`
ORDER BY Highest_product_Revenue Desc
LIMIT 1;
-- Find the mean amount spent per order by each customer
SELECT customer_type, Round(Avg(total),2) Average_spent
FROM Orders
GROUP BY customer_type;
-- What is the fifth highest selling product?
SELECT product_name,SUM(TOTAL) Revenue
FROM orders
LEFT JOIN Products
USING (product_id)
Group by Product_name
ORDER BY Revenue Desc
LIMIT 1
OFFSET 4;

-- For use in the dashboard
SELECT ord.order_date,pro.product_id,pro.product_name,pro.product_category,ord.customer_type,ord.cost_price,ord.retail_price,ord.total,acc.account_id,acc.account_manager
FROM Orders ord
LEFT JOIN Products pro
USING(product_id)
LEFT JOIN Account acc
USING (Account_id);






 



