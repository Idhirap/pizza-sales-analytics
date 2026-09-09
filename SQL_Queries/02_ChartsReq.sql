
SELECT * FROM pizza_sales;

-- 1.Daily Trend for Total Orders

SELECT DATENAME(DW,order_date) AS OrderDay,COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales
GROUP BY DATENAME(DW,order_date),DATEPART(DW,order_date)
ORDER BY DATEPART(DW,order_date);

-- 2.Hourly Trend for Total Orders

SELECT DATEPART(HOUR,order_time) AS OrderHour,COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY OrderHour;


-- 3.Percentage of Sales by Pizza Category 
-- 1.Approach - Window function
SELECT
	pizza_category,SUM(total_price) AS TotalSales,
	CAST(
		SUM(total_price)*100.0/SUM(SUM(total_price)) OVER()
		AS DECIMAL(10,2)
		) AS SalesPercentage
FROM pizza_sales
GROUP BY pizza_category;

-- 2.Approach - Subquery 
SELECT
	pizza_category,
	SUM(total_price) AS TotalSales,
	CAST(
		 SUM(total_price)*100.0/(SELECT SUM(total_price)FROM pizza_sales)
		 AS DECIMAL(10,2)
		) AS SalesPercentage
FROM pizza_sales
GROUP BY pizza_category

-- 4. % of Sales by Pizza Size
-- 1.Approach - Window function
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS TotalSales,
	CAST(
		SUM(total_price)*100.0/SUM(SUM(total_price)) OVER()
		AS DECIMAL(10,2)
		) AS SalesPercentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY SalesPercentage DESC;

-- 2.Approach - Subquery 
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS TotalSales,
	CAST(
		 SUM(total_price)*100.0/(SELECT SUM(total_price)FROM pizza_sales)
		 AS DECIMAL(10,2)
		) AS SalesPercentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY SalesPercentage DESC;

-- 5.Total Pizzas Sold by Pizza Category : 
SELECT 
	pizza_category,
	SUM(quantity) AS TotalPizzasSold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY TotalPizzasSold DESC

-- 6.Top 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5
	pizza_name,
	SUM(quantity) AS TotalPizzasSold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalPizzasSold DESC ;

-- 7. Bottom 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5
	pizza_name,
	SUM(quantity) AS TotalPizzasSold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalPizzasSold ASC ;



