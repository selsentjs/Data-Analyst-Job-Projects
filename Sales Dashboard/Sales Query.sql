select * from pizza_sales;

-- Total Revenue
SELECT SUM(total_price)  as Total_Revenue
FROM pizza_sales;

-- Total Order
SELECT COUNT (DISTINCT (order_id)) as Total_Order
FROM pizza_sales;

-- Average Order
SELECT SUM(total_price) / COUNT (DISTINCT (order_id))  as Average_Order
FROM pizza_sales;

-- Total Pizza Sold
SELECT SUM(quantity) as Total_Pizza_Sold
FROM pizza_sales;

-- Average Pizza Per Order
SELECT SUM(quantity) / COUNT (DISTINCT (order_id))  as Average_Pizza_Per_Order
FROM pizza_sales;

-- Daily Trend for Total Order
SELECT order_date, COUNT(DISTINCT(order_id)) as TotalOrder
FROM pizza_sales
GROUP BY order_date
ORDER BY order_date;

-- count total order by daywise
SELECT DATENAME(DW, order_date) as Day, COUNT(DISTINCT(order_id)) as TotalOrder
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY DATENAME(DW, order_date);

-- Hourly trend for total order
SELECT DATEPART(hour, order_time) As Hour,COUNT(DISTINCT(order_id)) as TotalOrder 
FROM pizza_sales
GROUP BY DATEPART(hour, order_time)
ORDER BY DATEPART(hour, order_time);

-- Percentage of Sales by pizza category
SELECT pizza_category, SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales ) * 100 As Percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by pizza category with total sale
SELECT pizza_category, SUM(total_price) As TotalSale, SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales ) * 100 As Percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by pizza category month wise
SELECT pizza_category, SUM(total_price) As Total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) =1 )As percentage_of_sale
FROM pizza_sales
WHERE MONTH(order_date) = 1 
GROUP BY pizza_category;

-- percentage of sales by pizza size
SELECT pizza_size,SUM(total_price)As TotalSale, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales ) AS decimal(10,2)) As percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size;

-- Total pizza sold by Pizza category
SELECT pizza_category, SUM(quantity) As Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_category;

-- Top 5 best sellers by total pizzas sold
SELECT Top 5 pizza_name, SUM(quantity) As Total_Pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_sold DESC;

-- Bottom 5 worst sellers by total pizzas sold

SELECT Top 5 pizza_name, SUM(quantity) As Total_Pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_sold;


