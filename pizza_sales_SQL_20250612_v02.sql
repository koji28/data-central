-- Pizza Sales Analysis
SELECT
	*
FROM pizza_sales;

-- KPI's requirement
-- Total Revenue
SELECT
	SUM(total_price) AS total_revenue
FROM pizza_sales;

-- Average order value
SELECT
	CAST(SUM(total_price) /
	(SELECT
		COUNT(DISTINCT order_id) 
	FROM pizza_sales) AS DECIMAL(10,2)) AS avg_order
FROM pizza_sales;

-- Total pizza sold
SELECT
	SUM(quantity) AS total_pizza_sold
FROM pizza_sales;

-- Total orders
SELECT
	count(distinct order_id) as total_orders 
FROM pizza_sales;

-- Average pizza per order
SELECT
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/ 
	CAST((SELECT
		COUNT(DISTINCT order_id)
	FROM pizza_sales) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS avg_pizza_per_order
FROM pizza_sales;

-- Daily trend for total order
SELECT
	DATENAME(DW, order_date) AS day_name, 
	COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY total_order DESC;

-- Monthly trend for total order
SELECT 
	DATENAME(MONTH, order_date) AS mont_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC;

-- Hourly trend for total order
SELECT
	DATEPART(HOUR, order_time) AS hour_show,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

-- % of sales by pizza category
SELECT
	pizza_category,CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) * 100 /
	(SELECT 
	SUM(total_price)
	FROM 
	pizza_sales
	WHERE 
	MONTH(order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY PCT DESC;

-- % of sales by pizza size
SELECT
	pizza_size, CAST(CAST(SUM(total_price) AS DECIMAL(10,2)) * 100 /
	CAST((SELECT
		SUM(total_price)
	FROM 
	pizza_sales
	WHERE DATEPART(QUARTER, order_date) = 2) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 2
GROUP BY pizza_size
ORDER BY pizza_size DESC;

-- Total pizza sold by pizza category
SELECT
	pizza_category, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
WHERE MONTH(order_date) = 4
GROUP BY pizza_category
ORDER BY total_pizza_sold DESC;

-- Top 5 pizza by Revenue
SELECT 
	TOP 5 pizza_name, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_name
ORDER BY total_revenue DESC;

-- Bottom 5 pizza by Revenue
SELECT
	TOP 5 pizza_name,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
WHERE MONTH(order_date) = 10
GROUP BY pizza_name
ORDER BY total_revenue ASC;

-- Top 5 pizza by quantity
SELECT
	TOP 5 pizza_name, 
	SUM(quantity) AS total_quantities
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantities DESC;

-- Bottom 5 pizza by quantity
SELECT
	TOP 5 pizza_name, 
	SUM(quantity) AS total_quantities
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantities ASC;

-- Top 5 pizza by total orders
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;

-- Bottom 5 pizza by total orders
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC;








