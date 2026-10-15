-- ===============================================================================================
-- MYCOMPANY SALES PERFORMANCE & CUSTOMER ANALYSIS
-- File: 05_advanced_analysis.sql
-- Database: mycompanysales_db
-- Tool: MySQL
--
-- Description:
-- This file contains advanced business analysis combining
-- customer, product, store, revenue, ranking, and time-based
-- analysis.
--
-- Analysis Covered:
-- Q16: Customer ranking by store
-- Q17: Highest-revenue customer per store
-- Q18: Highest-revenue product per category
-- Q19: Highest-revenue store per month
-- Q20: Top 3 customers per store
--
-- SQL Concepts:
-- CTEs, JOINs, Aggregate Functions, RANK(),
-- PARTITION BY, HAVING, LAG(), Top-N Analysis
-- ===============================================================================================

-- ===============================================================================================
-- Question 16: Customer Ranking by Store 
-- For each store, rank its customers based on their total revenue generated at that store.
--
-- Business Objective
-- Identify the highest-value customers for each store
-- and compare customer performance at store level.
-- ===============================================================================================

with total_store_revenue as (
select 
	s.store_id,
    s.store_name,
    c.customer_id,
    c.customer_name,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from customers as c
join orders as o
	on c.customer_id = o.customer_id
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
join stores as s
	on s.store_id = o.store_id 
group by s.store_id, s.store_name, c.customer_id, c.customer_name
)
select
	store_id,
    store_name,
    customer_id,
    customer_name,
    total_revenue,
    rank() over(partition by store_id order by total_revenue desc) as store_rank
from total_store_revenue
;

-- ===============================================================================================
-- Question 17: Top Customer in each score
-- Identify the highest-revenue customer in each store
--
-- Business Objective:
-- Determine the top-performing customer for every store
-- to support customer relationship and sales strategies.
-- ===============================================================================================

with store_revenue as (select
	s.store_name,
    c.customer_id,
    c.customer_name,
	sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from customers as c
join orders as o
	on c.customer_id = o.customer_id
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
join stores as s
	on s.store_id = o.store_id
group by s.store_name, c.customer_id, c.customer_name
),
customer_rank as (
select
	store_name,
    customer_id,
    customer_name,
    total_revenue,
    rank() over(partition by store_name order by total_revenue desc) as customer_ranking
from store_revenue
)
select
	store_name,
    customer_id,
    customer_name,
    total_revenue
from customer_rank
where customer_ranking = 1
;

-- ===============================================================================================
-- Question 18: Highest Revenue Per Product Category
-- Identify the highest-revenue product within each category.
--
-- Business Objective
-- Determine the leading product in each category.
-- and identify products driving category performance.
-- ===============================================================================================

With revenue as (
select
	c.category_name,
    p.product_id,
    p.product_name,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from categories as c
join products as p
	on c.category_id = p.category_id
join order_items as oi
	on p.product_id = oi.product_id
join orders as o
	on o.order_id = oi.order_id
group by c.category_name, p.product_id, p.product_name
),
product_ranking as (
select
	category_name,
    product_id,
    product_name,
    total_revenue,
    rank() over(partition by category_name order by total_revenue desc) as category_rank
from revenue
)
select
	category_name,
    product_id,
    product_name,
    total_revenue
from product_ranking
where category_rank = 1
;

-- ===============================================================================================
-- Question 19: Highest-Revenue Store Per Month 
-- Identify the highest-revenue store for each month.
--
-- Business Objective:
-- Determine which store performed best each month
-- and identify changes in store-level sales performance.
-- ===============================================================================================
 
	with monthly_revenue as (
	select
		date_format(o.order_date, '%Y-%m') as month,
		s.store_name,
		sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
	from stores as s
	join orders as o
		on s.store_id = o.store_id
	join order_items as oi
		on o.order_id = oi.order_id
	join products as p
		on p.product_id = oi.product_id 
	group by month, s.store_name
	),
	monthly_rank as (
	select
		month,
		store_name,
		total_revenue,
		rank() over(partition by month order by total_revenue desc) as month_rank
	from monthly_revenue 
	)
	select
		month,
		store_name,
		total_revenue
	from monthly_rank
	where month_rank = 1;

-- ===============================================================================================    
-- Question 20: Top 3 Customers Per Store
-- Identify the top 3 customers by revenue within each store,
-- considering only customers who generated at least #500,000.
-- 
-- Business Objective:
-- Identify high-value customers within each store
-- for targeted account management and retention strategies.
-- ===============================================================================================

with revenue as (
select
	s.store_name,
    c.customer_id,
    c.customer_name,
    sum(oi.quantity * p.price * (1 -oi.discount)) as total_revenue
from stores as s
join orders as o
	on s.store_id = o.store_id
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
join customers as c
	on c.customer_id = o.customer_id
group by s.store_name, c.customer_id, c.customer_name
having total_revenue >= 500000
),
ranking as (
select 
	store_name,
    customer_id,
    customer_name,
    total_revenue,
    rank() over(partition by store_name order by total_revenue desc) as store_rank
from revenue
)
select
	store_name,
    customer_id,
    customer_name,
    total_revenue,
    store_rank
from ranking
where store_rank <= 3
;