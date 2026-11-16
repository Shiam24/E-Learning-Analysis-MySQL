-- Data Analytics Module-End Assignment 3
-- Project: Analyzing E-Learning Platform Purchases using MySQL
-- Run this script in MySQL after connecting as your MySQL user.

CREATE DATABASE IF NOT EXISTS elearning_analysis;
USE elearning_analysis;

-- Drop child table first so the script can be re-run safely.
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS learners;

-- 1. Create tables
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT NOT NULL,
    course_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date DATE NOT NULL,
    CONSTRAINT fk_purchases_learner
        FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    CONSTRAINT fk_purchases_course
        FOREIGN KEY (course_id) REFERENCES courses(course_id),
    CONSTRAINT chk_purchase_quantity CHECK (quantity > 0)
);

-- 2. Insert sample learners
INSERT INTO learners (learner_id, full_name, country) VALUES
(101, 'Arun Kumar', 'India'),
(102, 'Priya Sharma', 'India'),
(103, 'John Smith', 'USA'),
(104, 'David Lee', 'Singapore'),
(105, 'Sarah Wilson', 'UK');

-- 3. Insert sample courses
INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(201, 'Python Programming', 'Programming', 1500.00),
(202, 'SQL for Beginners', 'Database', 1200.00),
(203, 'Power BI Masterclass', 'Data Analytics', 2000.00),
(204, 'Machine Learning', 'Artificial Intelligence', 2500.00),
(205, 'Advanced Excel', 'Data Analytics', 1000.00),
(206, 'Cyber Security Basics', 'Cyber Security', 1800.00);

-- 4. Insert sample purchases
INSERT INTO purchases
(purchase_id, learner_id, course_id, quantity, purchase_date) VALUES
(301, 101, 201, 2, '2026-10-01'),
(302, 101, 202, 1, '2026-10-03'),
(303, 102, 203, 1, '2026-10-05'),
(304, 102, 205, 2, '2026-10-07'),
(305, 103, 204, 1, '2026-10-10'),
(306, 104, 201, 1, '2026-10-12'),
(307, 104, 203, 2, '2026-10-15'),
(308, 105, 202, 3, '2026-10-18');

-- 5. Verify inserted data
SELECT * FROM learners;
SELECT * FROM courses;
SELECT * FROM purchases;

-- 6. Data Exploration: INNER JOIN
SELECT
    l.learner_id,
    l.full_name AS learner_name,
    c.course_name AS course_name,
    c.category AS category,
    p.quantity AS quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date AS purchase_date
FROM learners AS l
INNER JOIN purchases AS p
    ON l.learner_id = p.learner_id
INNER JOIN courses AS c
    ON p.course_id = c.course_id
ORDER BY (p.quantity * c.unit_price) DESC;

-- 7. Data Exploration: LEFT JOIN
SELECT
    l.learner_id,
    l.full_name AS learner_name,
    c.course_name AS course_name,
    c.category AS category,
    p.quantity AS quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date AS purchase_date
FROM learners AS l
LEFT JOIN purchases AS p
    ON l.learner_id = p.learner_id
LEFT JOIN courses AS c
    ON p.course_id = c.course_id
ORDER BY l.learner_id;

-- 8. Data Exploration: RIGHT JOIN
SELECT
    c.course_id,
    c.course_name AS course_name,
    c.category AS category,
    l.full_name AS learner_name,
    p.quantity AS quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date AS purchase_date
FROM purchases AS p
RIGHT JOIN courses AS c
    ON p.course_id = c.course_id
LEFT JOIN learners AS l
    ON p.learner_id = l.learner_id
ORDER BY c.course_id;

-- 9. Analytical Query Q1:
-- Each learner's total spending and country (including learners with no purchases).
SELECT
    l.learner_id,
    l.full_name AS learner_name,
    l.country AS country,
    FORMAT(COALESCE(SUM(p.quantity * c.unit_price), 0), 2) AS total_spending
FROM learners AS l
LEFT JOIN purchases AS p
    ON l.learner_id = p.learner_id
LEFT JOIN courses AS c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
ORDER BY COALESCE(SUM(p.quantity * c.unit_price), 0) DESC;

-- 10. Analytical Query Q2:
-- Top 3 courses by total quantity sold.
SELECT
    c.course_id,
    c.course_name AS course_name,
    c.category AS category,
    SUM(p.quantity) AS total_quantity_sold
FROM courses AS c
INNER JOIN purchases AS p
    ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name, c.category
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- 11. Analytical Query Q3:
-- Category-wise revenue and number of unique learners.
SELECT
    c.category AS course_category,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_revenue,
    COUNT(DISTINCT p.learner_id) AS unique_learners
FROM courses AS c
INNER JOIN purchases AS p
    ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- 12. Analytical Query Q4:
-- Learners who purchased courses from more than one category.
SELECT
    l.learner_id,
    l.full_name AS learner_name,
    l.country AS country,
    COUNT(DISTINCT c.category) AS total_categories
FROM learners AS l
INNER JOIN purchases AS p
    ON l.learner_id = p.learner_id
INNER JOIN courses AS c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY total_categories DESC;

-- 13. Analytical Query Q5:
-- Courses that have never been purchased.
SELECT
    c.course_id,
    c.course_name AS course_name,
    c.category AS category,
    FORMAT(c.unit_price, 2) AS unit_price
FROM courses AS c
LEFT JOIN purchases AS p
    ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;
