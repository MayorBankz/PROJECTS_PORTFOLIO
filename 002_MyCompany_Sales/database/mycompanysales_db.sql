CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories (category_id, category_name)
VALUES
(1, 'Whisky'),
(2, 'Gin'),
(3, 'Vodka'),
(4, 'Brandy'),
(5, 'Rum');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(12,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products (product_id, product_name, category_id, price)
VALUES
(101, 'Royal Crown Whisky', 1, 18500),
(102, 'Golden Oak Whisky', 1, 22000),
(103, 'Premium Dry Gin', 2, 12500),
(104, 'London Classic Gin', 2, 15000),
(105, 'Crystal Vodka', 3, 11000),
(106, 'Silver Vodka', 3, 13500),
(107, 'Grand Brandy', 4, 17500),
(108, 'Imperial Brandy', 4, 21000),
(109, 'Caribbean Rum', 5, 14000),
(110, 'Dark Reserve Rum', 5, 16500);

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

INSERT INTO stores (store_id, store_name, city, state)
VALUES
(1, 'Lagos Central Store', 'Lagos', 'Lagos'),
(2, 'Ikeja Distribution Store', 'Ikeja', 'Lagos'),
(3, 'Abuja Central Store', 'Abuja', 'FCT'),
(4, 'Ibadan Distribution Store', 'Ibadan', 'Oyo');


CREATE TABLE staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

INSERT INTO staffs (staff_id, first_name, last_name, email, store_id)
VALUES
(1, 'John', 'Adeyemi', 'john.adeyemi@email.com', 1),
(2, 'Mary', 'Okafor', 'mary.okafor@email.com', 1),
(3, 'David', 'Ibrahim', 'david.ibrahim@email.com', 2),
(4, 'Sarah', 'Adeleke', 'sarah.adeleke@email.com', 2),
(5, 'Michael', 'Eze', 'michael.eze@email.com', 3),
(6, 'Grace', 'Bello', 'grace.bello@email.com', 3),
(7, 'Daniel', 'Ojo', 'daniel.ojo@email.com', 4),
(8, 'Esther', 'Musa', 'esther.musa@email.com', 4);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_type VARCHAR(30)
);

INSERT INTO customers
(customer_id, customer_name, city, state, customer_type)
VALUES
(201, 'Bolu Distributors', 'Lagos', 'Lagos', 'Distributor'),
(202, 'Prime Retailers Ltd', 'Ikeja', 'Lagos', 'Retailer'),
(203, 'Abuja Drinks Hub', 'Abuja', 'FCT', 'Distributor'),
(204, 'Capital Retail Store', 'Abuja', 'FCT', 'Retailer'),
(205, 'Oyo Beverage Mart', 'Ibadan', 'Oyo', 'Retailer'),
(206, 'Westline Distributors', 'Lagos', 'Lagos', 'Distributor'),
(207, 'City Choice Stores', 'Ibadan', 'Oyo', 'Retailer'),
(208, 'Northern Drinks Ltd', 'Abuja', 'FCT', 'Distributor'),
(209, 'Metro Supermarket', 'Lagos', 'Lagos', 'Retailer'),
(210, 'Elite Beverage Centre', 'Ikeja', 'Lagos', 'Retailer');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    store_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

INSERT INTO orders
(order_id, customer_id, staff_id, store_id, order_date)
VALUES
(1001, 201, 1, 1, '2026-01-05'),
(1002, 202, 2, 1, '2026-01-08'),
(1003, 203, 5, 3, '2026-01-12'),
(1004, 204, 6, 3, '2026-01-18'),
(1005, 205, 7, 4, '2026-01-22'),
(1006, 206, 1, 1, '2026-02-03'),
(1007, 207, 8, 4, '2026-02-07'),
(1008, 208, 5, 3, '2026-02-11'),
(1009, 209, 2, 1, '2026-02-15'),
(1010, 210, 4, 2, '2026-02-19'),
(1011, 201, 1, 1, '2026-03-02'),
(1012, 202, 3, 2, '2026-03-05'),
(1013, 203, 5, 3, '2026-03-10'),
(1014, 204, 6, 3, '2026-03-14'),
(1015, 205, 7, 4, '2026-03-18'),
(1016, 206, 2, 1, '2026-03-22'),
(1017, 207, 8, 4, '2026-03-25'),
(1018, 208, 5, 3, '2026-04-02'),
(1019, 209, 1, 1, '2026-04-08'),
(1020, 210, 4, 2, '2026-04-15'),
(1021, 201, 2, 1, '2026-05-03'),
(1022, 203, 5, 3, '2026-05-07'),
(1023, 206, 1, 1, '2026-05-12'),
(1024, 208, 6, 3, '2026-05-18'),
(1025, 209, 3, 2, '2026-05-25');

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, discount)
VALUES
(1, 1001, 101, 10, 0.05),
(2, 1001, 103, 8, 0.00),

(3, 1002, 102, 6, 0.10),
(4, 1002, 105, 10, 0.05),

(5, 1003, 104, 12, 0.08),
(6, 1003, 107, 7, 0.05),

(7, 1004, 106, 15, 0.00),
(8, 1004, 109, 10, 0.05),

(9, 1005, 101, 8, 0.03),
(10, 1005, 108, 6, 0.05),

(11, 1006, 102, 15, 0.10),
(12, 1006, 103, 12, 0.05),

(13, 1007, 105, 10, 0.00),
(14, 1007, 109, 8, 0.05),

(15, 1008, 104, 18, 0.10),
(16, 1008, 108, 10, 0.05),

(17, 1009, 101, 12, 0.05),
(18, 1009, 106, 8, 0.00),

(19, 1010, 102, 10, 0.08),
(20, 1010, 107, 12, 0.05),

(21, 1011, 103, 15, 0.05),
(22, 1011, 105, 10, 0.00),

(23, 1012, 104, 20, 0.10),
(24, 1012, 109, 12, 0.05),

(25, 1013, 101, 18, 0.08),
(26, 1013, 108, 10, 0.05),

(27, 1014, 106, 20, 0.05),
(28, 1014, 107, 8, 0.00),

(29, 1015, 102, 14, 0.10),
(30, 1015, 103, 10, 0.05),

(31, 1016, 105, 18, 0.00),
(32, 1016, 109, 15, 0.05),

(33, 1017, 104, 16, 0.08),
(34, 1017, 108, 12, 0.05),

(35, 1018, 101, 20, 0.10),
(36, 1018, 106, 10, 0.05),

(37, 1019, 102, 18, 0.05),
(38, 1019, 107, 10, 0.08),

(39, 1020, 103, 20, 0.05),
(40, 1020, 109, 15, 0.00),

(41, 1021, 104, 22, 0.10),
(42, 1021, 108, 12, 0.05),

(43, 1022, 101, 15, 0.05),
(44, 1022, 105, 12, 0.00),

(45, 1023, 102, 20, 0.08),
(46, 1023, 106, 15, 0.05),

(47, 1024, 107, 18, 0.10),
(48, 1024, 109, 12, 0.05),

(49, 1025, 103, 25, 0.05),
(50, 1025, 108, 15, 0.08);
