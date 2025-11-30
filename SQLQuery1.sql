select * from pizza_sales

#KPI REQUIREMENTS
select SUM(total_price) AS Total_Revenue from pizza_sales
select SUM(total_price)/count(DISTINCT order_id) AS Average_order_value from pizza_sales
select SUM(quantity) AS Total_Pizza_Sold  from pizza_sales
select COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales

'''cast is to change the data type from one to another'''

select CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))  AS Average_Pizza_Per_Order from pizza_sales


CHARTS REQUIREMENTS

'''when we are using Aggregate and coloum with respect to data then always use group by the categorial data in your data
DATENAME ---> IS USED TO DERIVE DATE OF THE WEEK (SQL Server function that returns part of a date as text (string)).
DW---> IT RETRIVE THE DATE NAME( MONDAY,TUESDAY ETC)'''

--DAILY TREND
select DATENAME(dw,order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales 
Group By DATENAME(dw,order_date)


'''DATEPART is a built-in SQL function that returns a specific part of a date — like the year, month, day, hour, or weekday — as a number (integer).'''


--HOURLY TREND
SELECT DATEPART(HOUR, order_time) AS Hours_day, COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales 
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


--percentage of sales by pizza category
SELECT pizza_category, SUM(total_price) AS total_sales, SUM(total_price) *100 / 
(SELECT SUM(total_price) from pizza_sales WHERE MONTH(ORDER_DATE)=1) AS PCT 
from pizza_sales
WHERE MONTH(ORDER_DATE)=1---if we want to fliter for particular area like month
GROUP BY pizza_category

--Percentage Of Sales by Pizza Size 
SELECT pizza_size, CAST(SUM(total_price)AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) *100 / 
(SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter,ORDER_DATE)=1)AS DECIMAL(10,2)) AS PCT 
from pizza_sales
WHERE DATEPART(quarter,ORDER_DATE)=1
GROUP BY pizza_size
ORDER BY pizza_size

---Total Pizzas sold by Pizza Category
SELECT pizza_category,SUM(quantity) AS Pizza_sold from pizza_sales
GROUP BY pizza_category

--Top 5 best sellers by total pizza sold
SELECT TOP 5 pizza_name , SUM(quantity) AS Pizza_sold from pizza_sales
Group BY pizza_name
ORDER BY Pizza_sold DESC

--Top 5 Worst Seller By total pizza Sold
SELECT TOP 5 pizza_name , SUM(quantity) AS Pizza_sold from pizza_sales
Group BY pizza_name
ORDER BY Pizza_sold ASC
