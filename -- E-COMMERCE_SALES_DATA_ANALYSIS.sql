-- E-COMMERCE SALES DATA ANALYSIS
-- Dataset: Olist Brazilian E-commerce Dataset
-- Tool: MySQL
-- Objective: Analyze sales performance and customer behavior

-- 1. Total Orders
SELECT 
    COUNT(order_id) AS total_orders
FROM orders;

-- 2. Total Customers
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- 3. Total Revenue
SELECT 
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items;

-- 4. Average Order Value (AOV)
SELECT 
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id;

-- 5. Monthly Sales Trend
SELECT 
    MONTH(o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price), 2) AS monthly_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- 6. Top 10 Products by Revenue
SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;

-- 7. Sales by State
SELECT 
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS state_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY state_sales DESC;

-- 8. Payment Method Distribution
SELECT 
    payment_type,
    COUNT(order_id) AS total_transactions
FROM payments
GROUP BY payment_type
ORDER BY total_transactions DESC;
