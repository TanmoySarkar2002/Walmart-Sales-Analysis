CREATE DATABASE Walmart;

CREATE TABLE sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);



-- Add day_name column:-

SELECT
	date,
	DAYNAME(date) as day_name
FROM sales;


ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


-- Add month_name column:-

SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);


-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;


-- In which city is each branch?
SELECT 
	DISTINCT city, 
    branch
FROM sales;


-- How many unique product lines are there?
SELECT
	COUNT(DISTINCT product_line)
FROM sales;


-- what is the most commom payment method?
SELECT 
    payment, COUNT(payment) AS count
FROM
    sales
GROUP BY payment
ORDER BY count DESC;


-- What is the most selling product line
SELECT
	COUNT(quantity) as cnt,
    product_line
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;


 -- What is the total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue DESC;



-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;


-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue DESC;



-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(VAT) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;



-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;


-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;



-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;



-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM sales;


-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC;



-- Which Customer type buys the most?
SELECT 
    customer_type, COUNT(*) AS customer_cnt
FROM
    sales
GROUP BY customer_type;

