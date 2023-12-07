-- Total_Revenue
SELECT SUM(TOTAL_PRICE) AS Total_Revenue FROM pizza_sales

-- Average Order Value
SELECT SUM(TOTAL_PRICE)/COUNT(DISTINCT ORDER_ID) AS Avg_Ord_Value FROM pizza_sales

-- Total Pizza Sold
SELECT SUM(QUANTITY) AS Total_Pizza_Sold FROM pizza_sales

--Total Orders
SELECT COUNT(DISTINCT ORDER_ID) AS Total_Orders FROM pizza_sales

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(QUANTITY) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT ORDER_ID) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Sales_Per_Order from pizza_sales

-- Daily Trend for total orders
SELECT DATENAME(DW,ORDER_DATE) AS Order_day , COUNT(DISTINCT ORDER_ID) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW,ORDER_DATE)

-- Monthly Trend for Total Orders
SELECT DATENAME(MONTH,ORDER_DATE) AS Month_Name, COUNT(DISTINCT ORDER_ID) Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH,ORDER_DATE)
ORDER BY Total_Orders
DESC

-- Monthly Perentage Trend of Total Sales
SELECT PIZZA_CATEGORY, SUM(TOTAL_PRICE) AS Total_Sales, CAST(SUM(TOTAL_PRICE) *100/ (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(ORDER_DATE) = 1) AS decimal(10,2)) AS PCT_Total_Sales FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY PIZZA_CATEGORY

-- Percentage of Sales by Pizza Size
SELECT PIZZA_SIZE AS Pizza_Size, SUM(TOTAL_PRICE) AS Total_Sales, CAST(SUM(TOTAL_PRICE) *100/ 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, ORDER_DATE) = 1) AS decimal(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, ORDER_DATE) = 1
GROUP BY PIZZA_SIZE
ORDER BY PCT DESC

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, sum(quantity) as Total_Quantity_Sold from pizza_sales
group by pizza_category
ORDER BY Total_Quantity_Sold
desc

-- Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(TOTAL_PRICE) AS Total_Revenue FROM pizza_sales
GROUP BY PIZZA_NAME
ORDER BY Total_Revenue
desc

-- Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(TOTAL_PRICE) AS Total_Revenue FROM pizza_sales
GROUP BY PIZZA_NAME
ORDER BY Total_Revenue
ASC

--Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_name
order by Total_Pizzas_Sold
desc

--Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_name
order by Total_Pizzas_Sold
asc

-- Top 5 Pizzas by Total Orders
SELECT top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders desc

-- Bottom 5 Pizzas by Total Orders
SELECT top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders asc
