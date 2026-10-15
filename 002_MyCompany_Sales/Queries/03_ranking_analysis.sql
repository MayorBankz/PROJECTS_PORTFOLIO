-- ============================================================
-- MYCOMPANY SALES PERFORMANCE & CUSTOMER ANALYSIS
-- File: 03_ranking_analysis.sql
-- Database: mycompanysales_db
-- Tool: MySQL
--
-- Description:
-- This file focuses on ranking customers and products based
-- on revenue and identifying top-performing products within
-- specific categories.
--
-- Analysis Covered:
-- Q10: Customer revenue ranking
-- Q11: Product ranking within each category
--
-- SQL Concepts:
-- CTE, RANK(), DENSE_RANK(), OVER(), PARTITION BY,
-- ORDER BY, Top-N Analysis
-- ============================================================

-- ===============================================================================================

-- Question 10: Rank customers based on their total revenue. 
--
-- Business Objective:
-- Identify the highest-value customers and understand 
-- their relative contribution to sales revenue
-- ===============================================================================================

with customer_revenue as (
select
	c.customer_id,
    c.customer_name,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from customers as c
join orders as o
	on c.customer_id = o.customer_id
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on oi.product_id = p.product_id
group by c.customer_id, c.customer_name
)
select
	customer_id,
    customer_name,
    total_revenue,
    rank() over(order by total_revenue desc) as revenue_rank;

-- ===============================================================================================
-- Question 11: Ranking Within Groups 
-- Rank products by revenue within each product category. */
--
-- Business Objective:
-- Identify the strongest-performing products within
-- each category rather than comparing all products together.
-- ===============================================================================================

with product_revenue as (
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
	on oi.order_id = o.order_id
group by c.category_name, p.product_id, p.product_name
),
 product_category_rank as (
select
	category_name,
    product_id,
    product_name,
    total_revenue,
    rank() over(partition by category_name order by total_revenue desc) as category_rank
from product_revenue
) 
select
	category_name,
    product_id,
    product_name,
    total_revenue,
    category_rank
from product_category_rank
where category_rank <= 2;
