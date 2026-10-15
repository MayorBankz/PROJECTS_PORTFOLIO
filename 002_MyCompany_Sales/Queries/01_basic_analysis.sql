-- ============================================================
-- MYCOMPANY SALES PERFORMANCE & CUSTOMER ANALYSIS
-- File: 01_basic_analysis.sql
-- Database: mycompanysales_db
-- Tool: MySQL
--
-- Description:
-- This file contains basic sales analysis focused on customers,
-- products, and order activity.
--
-- Analysis Covered:
-- Q1: Customers from Lagos
-- Q2: Products above ₦15,000
-- Q3: Total orders per customer
-- Q4: Customer order volume
--
-- SQL Concepts:
-- SELECT, WHERE, ORDER BY, COUNT(), GROUP BY, JOIN
-- ============================================================

-- ===============================================================================================
-- Question 1: Identify all customers from Lagos
--
-- Business Objective: Identify customers located in Lagos for geographic 
-- and customer distribution analysis
-- ===============================================================================================

select
	customer_id,
    customer_name,
    city,
    state, 
    customer_type
from customers
where city = "Lagos"
order by customer_name;

-- ===============================================================================================
-- Question 2: Identify products with a selling price above than #15,000
--
-- Business Objective:
-- Identify higher-priced products within the product
-- portfolio for pricing and product analysis.
-- ===============================================================================================

select
	product_id,
    product_name,
    price
from products
where price > 15000
order by price desc;

-- ===============================================================================================
-- Question 3: Calculate the total number of orders placed by each customer.
--
-- Business Objective:
-- Measure customer ordering frequency and identify 
-- customers with the highest number of orders
-- ===============================================================================================

select
	customer_id,
    count(order_id) as total_orders
from orders
group by customer_id
order by total_orders desc;


-- ===============================================================================================
-- Question 4: Display customer names alongside their order count.
--
-- Business Objective:
-- Identify the most active customers based on the 
-- number of orders placed.
-- ===============================================================================================

select
	c.customer_id,
    c.customer_name,
    count(o.order_id) as total_orders
from customers as c
join orders as o
	on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_orders desc;
