CREATE TABLE fact_sales (
    order_id VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    year INT,
    quarter INT,
    month VARCHAR(20),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10),
    product_category_name VARCHAR(100),
    payment_type VARCHAR(50),
    sales NUMERIC(10,2),
    freight_cost NUMERIC(10,2),
    estimated_profit NUMERIC(10,2)
);

SELECT COUNT(*)
FROM fact_sales;

--How much revenue did the company generate?
SELECT
ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM fact_sales;

--How many unique orders were placed?
SELECT
COUNT(DISTINCT order_id) AS total_orders
FROM fact_sales;

--On average, how much revenue does one order generate?
SELECT
ROUND(
    SUM(sales) / COUNT(DISTINCT order_id),
    2
) AS average_order_value
FROM fact_sales;

--After accounting for freight costs, how much profit was generated?
SELECT
ROUND(SUM(estimated_profit), 2) AS total_profit
FROM fact_sales;

--What percentage of revenue is retained as estimated profit?
SELECT
ROUND(
    (SUM(estimated_profit) / SUM(sales)) * 100,
    2
) AS profit_margin_pct
FROM fact_sales;

--Which states generate the highest revenue?
SELECT
    customer_state,
    ROUND(SUM(sales),2) AS total_sales
FROM fact_sales
GROUP BY customer_state
ORDER BY total_sales DESC
LIMIT 10;

--How do sales change over time?
SELECT
    year,
    month,
    ROUND(SUM(sales),2) AS total_sales
FROM fact_sales
GROUP BY year, month
ORDER BY year, month;

--Which product categories generate the most revenue?
SELECT
    product_category_name,
    ROUND(SUM(sales),2) AS total_sales
FROM fact_sales
GROUP BY product_category_name
ORDER BY total_sales DESC
LIMIT 10;

--Which payment methods do customers prefer?
SELECT
    payment_type,
    COUNT(*) AS transactions
FROM fact_sales
GROUP BY payment_type
ORDER BY transactions DESC;

--Which states generate the highest profit?
SELECT
    customer_state,
    ROUND(SUM(estimated_profit),2) AS total_profit
FROM fact_sales
GROUP BY customer_state
ORDER BY total_profit DESC
LIMIT 10;

--Which cities generate the highest revenue?
SELECT
    customer_city,
    ROUND(SUM(sales),2) AS total_sales
FROM fact_sales
GROUP BY customer_city
ORDER BY total_sales DESC
LIMIT 10;