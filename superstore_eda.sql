USE superstore;

-- SUPERSTORE EDA
-- total revenue and profit
SELECT SUM(sales) AS total_revenue, SUM(profit) AS total_profit
FROM superstore_sales;

-- seasonality (total revenue & profits by month)
SELECT
	MONTH(STR_TO_DATE(order_date, '%m/%d/%Y')) AS order_month,
    SUM(sales) as total_revenue,
    SUM(profit) AS total_profit
FROM superstore_sales
GROUP BY 1
ORDER BY 1;

-- running total 2017 revenue by month
SELECT 
    DISTINCT(MONTH(STR_TO_DATE(s.order_date, '%m/%d/%Y'))) AS month,
    SUM(s.sales) OVER (ORDER BY MONTH(STR_TO_DATE(s.order_date, '%m/%d/%Y'))) running_total_revenue_2017
FROM superstore_sales AS s
JOIN superstore_products AS p
	ON s.product_id = p.product_id
WHERE YEAR(STR_TO_DATE(s.order_date, '%m/%d/%Y')) = 2017;

-- total revenue by segment
SELECT segment, SUM(sales) AS total_revenue
FROM superstore_sales AS s
JOIN superstore_products AS p
	ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;

-- total revenue by state
SELECT state, region, SUM(sales) AS total_revenue
FROM superstore_sales AS s
JOIN superstore_products AS p
	ON s.product_id = p.product_id
GROUP BY 1, 2
ORDER BY 3 DESC;

-- impact of discounts on sales, profit, and profit margin
SELECT 
	(SELECT SUM(sales) FROM superstore_sales WHERE discount = 0) AS revenue_no_discount,
    (SELECT SUM(sales) FROM superstore_sales WHERE discount > 0) AS revenue_discount,
	(SELECT SUM(profit) FROM superstore_sales WHERE discount = 0) AS profit_no_discount,
    (SELECT SUM(profit) FROM superstore_sales WHERE discount > 0) AS profit_discount,
    (SELECT ROUND((SUM(profit) / SUM(sales) * 100), 2) FROM superstore_sales WHERE discount = 0) AS profit_margin_no_discount,
    (SELECT ROUND((SUM(profit) / SUM(sales) * 100), 2) FROM superstore_sales WHERE discount > 0) AS profit_margin_discount
FROM superstore_sales
LIMIT 1;

-- top 100 products in quantities sold
WITH top_sellers AS (
    SELECT 
        s.product_id,
        s.product_name,
        SUM(s.quantity) AS quantity_sold
    FROM superstore_sales AS s
    JOIN superstore_products AS p 
		ON s.product_id = p.product_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 100
)
SELECT 
    ts.product_id,
    ts.product_name,
    ts.quantity_sold
FROM top_sellers AS ts;

-- top 100 products in revenue
WITH top_products_revenue AS (
    SELECT 
        s.product_id,
        s.product_name,
        SUM(s.sales) AS total_revenue
    FROM superstore_sales AS s
    JOIN superstore_products AS p 
		ON s.product_id = p.product_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 100
)
SELECT 
    tpr.product_id,
    tpr.product_name,
    tpr.total_revenue
FROM top_products_revenue AS tpr;

-- top 100 products in profit
WITH top_products_profit AS (
    SELECT 
        s.product_id,
        s.product_name,
        SUM(s.profit) AS total_profit
    FROM superstore_sales AS s
    JOIN superstore_products AS p 
		ON s.product_id = p.product_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 100
)
SELECT 
    tpp.product_id,
    tpp.product_name,
    tpp.total_profit
FROM top_products_profit AS tpp;

-- profit margin by product
WITH top_products_profit_margin AS (
    SELECT 
        s.product_id,
        s.product_name,
        ROUND((SUM(s.profit) / SUM(s.sales) * 100), 2) AS profit_margin
    FROM superstore_sales AS s
    JOIN superstore_products AS p 
		ON s.product_id = p.product_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 100
)
SELECT 
    tpm.product_id,
    tpm.product_name,
    tpm.profit_margin
FROM top_products_profit_margin AS tpm;

-- profit margin by category
SELECT p.category, ROUND((SUM(s.profit) / SUM(s.sales) * 100), 2) AS profit_margin
FROM superstore_sales AS s
JOIN superstore_products AS p
	ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;

-- profit margin by sub_category
SELECT p.sub_category, p.category, ROUND((SUM(s.profit) / SUM(s.sales) * 100), 2) AS profit_margin
FROM superstore_sales AS s
JOIN superstore_products AS p
	ON s.product_id = p.product_id
GROUP BY 1, 2
ORDER BY 3 DESC;

-- products in supplies, bookcases, and tables sub-categories with negative profit margins
SELECT p.sub_category, s.product_id, s.product_name, ROUND((SUM(s.profit) / SUM(s.sales) * 100), 2) AS profit_margin
FROM superstore_sales AS s
JOIN superstore_products AS p
	ON s.product_id = p.product_id
WHERE p.sub_category = 'Supplies' OR p.sub_category = 'Bookcases' OR p.sub_category = 'Tables'
GROUP BY 1, 2, 3
HAVING profit_margin < 0
ORDER BY 4;

-- top 100 customers in revenue
SELECT customer_id, customer_name, SUM(sales) total_revenue
FROM superstore_sales
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 100;

-- top 100 customers in profit, profit margin
SELECT customer_id, customer_name, SUM(profit) AS total_profit, ROUND((SUM(profit) / SUM(sales) * 100), 2) AS profit_margin
FROM superstore_sales
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 100;

-- top 100 customers in quantity of sales
SELECT customer_id, customer_name, SUM(quantity) AS quantity_sales, SUM(profit) as total_profit, ROUND((SUM(profit) / SUM(sales) * 100), 2) AS profit_margin
FROM superstore_sales
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 100;

-- total revenue, total profit, profit margin by shipping method
SELECT ship_mode, SUM(sales) total_revenue, SUM(profit) as total_profit, ROUND((SUM(profit) / SUM(sales) * 100), 2) AS profit_margin
FROM superstore_sales
GROUP BY 1
ORDER BY 2 DESC;