-- ============================================================
-- MYCOMPANY SALES PERFORMANCE & CUSTOMER ANALYSIS
-- File: 04_sales_trends.sql
-- Database: mycompanysales_db
-- Tool: MySQL
--
-- Description:
-- This file analyzes revenue trends over time and measures
-- month-over-month changes in sales performance.
--
-- Analysis Covered:
-- Q12: Monthly revenue
-- Q13: Previous month's revenue
-- Q14: Month-over-month revenue change
-- Q15: Month-over-month revenue growth percentage
--
-- SQL Concepts:
-- DATE_FORMAT(), CTE, LAG(), Window Functions,
-- Date Analysis, Percentage Calculations
-- ============================================================

-- ===============================================================================================
-- Question 12: Monthly Revenue
-- Calculate the total revenue generated for each month in 2026. 
--
-- Business Objective:
-- Analyze sales performance over time and identify
-- high- and -low performing months.
-- ===============================================================================================

select
	date_format(o.order_date, '%m-%Y') as month,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from orders as o
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
group by month
order by min(order_date)
;

-- ===============================================================================================
-- Question 13: Monthly Revenue + Previous Month
-- Calculate the total revenue for each month and show the revenue from the previous month alongside it */
-- 
-- Business Objective:
-- Establish a month-to-month revenue comparison 
-- for sales trend analysis.
-- ===============================================================================================

with monthly_revenue as 
(select
	date_format(o.order_date, '%m-%Y') as month,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from orders as o
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
group by month
)
select
	month,
    total_revenue,
    lag(total_revenue) over(order by month) as previous_monthly_revenue
from monthly_revenue;

-- ===============================================================================================
-- Question 14: Month-over-month Revenue change 
-- Calculate each month's revenue, precious month's revenue, and the revenue change from the previous month.
-- 
-- Formula:
-- Current Month Revenue - Previous Month Revenue
--
-- Business Objective
-- Measure whether monthly revenue increased or decreased
-- and determine the size of the change.
-- ===============================================================================================

with monthly_total_revenue as (
select
	date_format(o.order_date, '%m-%y') as month,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from orders as o
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
group by month
),
previous_month_revenue as (
select
	month,
    total_revenue,
    lag(total_revenue) over(order by month) as previous_month
from monthly_total_revenue
)
select
	month,
    total_revenue,
    previous_month,
    total_revenue - previous_month as revenue_change
from previous_month_revenue
;

-- ===============================================================================================
-- Question 15: Month-over-Month Growth % 
-- Using the same monthly revenue analysis, calculate:
-- month, total_revenue, previous_month_revenue, revenue_change, Growth_percentage
-- Formula:
-- (Current Revenue - Previous Revenue) / previous Revenue x 100
-- 
-- Business Objective:
-- Measure the rate of monthly revenue growth or decline
-- to understand sales momentum over time.
-- ===============================================================================================

with monthly_total_revenue as (
select
	date_format(o.order_date, '%m-%y') as month,
    sum(oi.quantity * p.price * (1 - oi.discount)) as total_revenue
from orders as o
join order_items as oi
	on o.order_id = oi.order_id
join products as p
	on p.product_id = oi.product_id
group by month
),
previous_month_revenue as (
select
	month,
    total_revenue,
    lag(total_revenue) over(order by month) as previous_month
from monthly_total_revenue
),
revenue_change_diff as (
select
	month,
    total_revenue,
    previous_month,
    total_revenue - previous_month as revenue_change
from previous_month_revenue
)
select
	month,
    total_revenue,
    previous_month,
    revenue_change,
    coalesce((total_revenue - previous_month) / previous_month * 100, 0) as growth_percentage
from revenue_change_diff;
