
SELECT * FROM [dbo].[pizza_sales];

-- KPI(s) Requirement

-- Total Revenue
SELECT SUM(total_price) AS TotalRevenue FROM pizza_sales;

-- Avg. Order Value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS AvgOrderValue FROM pizza_sales;

-- Total Pizza Sold
SELECT SUM(quantity) AS TotalPizzasSold FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS TotalOrders FROM pizza_sales;

-- Avg Pizzas Per Order
SELECT 
	CAST(
	    SUM(quantity) * 1.0/COUNT(DISTINCT order_id) 
		AS DECIMAL(10,2)
	) AS AvgPizzasPerOrder 
FROM pizza_sales;
