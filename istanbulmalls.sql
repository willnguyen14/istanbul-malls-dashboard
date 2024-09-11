-- view first 100 rows of table
SELECT TOP 100 *
FROM customer_shopping_data$;


-- can see there are 3 hidden columns: "F11", "F12", "F13"
-- drop these columns
ALTER TABLE customer_shopping_data$ 
DROP COLUMN F11, F12, F13;


-- check for duplicates in customer_id
-- no duplicates found
SELECT customer_id, COUNT(customer_id)
FROM customer_shopping_data$
GROUP BY customer_id
HAVING COUNT(customer_id) > 1;


-- view all unique malls
SELECT DISTINCT(shopping_mall)
FROM customer_shopping_data$
ORDER BY shopping_mall;


-- top product categories by mall that sold the highest quantities
-- best sales performing categories by mall
SELECT shopping_mall, category, SUM(quantity) AS quantity
FROM customer_shopping_data$
GROUP BY shopping_mall, category
ORDER BY shopping_mall, quantity DESC;


-- top product categories by mall that made the most revenue
SELECT shopping_mall, category, ROUND(SUM(price_usd), 2) AS price_usd
FROM customer_shopping_data$
GROUP BY shopping_mall, category
ORDER BY shopping_mall, price_usd DESC;


-- average, min, and max customer age by mall
-- age distributions the same across all malls
SELECT shopping_mall, 
       ROUND(AVG(age), 1) AS avg_age,
       MIN(age) AS min_age, 
       MAX(age) AS max_age
FROM customer_shopping_data$
GROUP BY shopping_mall;


-- total number of customers by gender for each mall
SELECT shopping_mall, gender, COUNT(gender) AS total_gender
FROM customer_shopping_data$
GROUP BY shopping_mall, gender
ORDER BY shopping_mall, total_gender DESC;


-- which product categories do each gender spend the most on?
SELECT gender, category, COUNT(gender) AS gender_buying_count
FROM customer_shopping_data$
GROUP BY gender, category
ORDER BY gender, gender_buying_count DESC;


-- which product categories do each gender spend the most on?
SELECT gender, category, ROUND(SUM(price_usd), 2) AS gender_revenue
FROM customer_shopping_data$
GROUP BY gender, category
ORDER BY gender, gender_revenue DESC;


-- customer spending distribution for each mall
SELECT shopping_mall, 
       AVG(price_usd) AS avg_spending, 
       MAX(price_usd) AS max_spending, 
       MIN(price_usd) AS min_spending
FROM customer_shopping_data$
GROUP BY shopping_mall
ORDER BY shopping_mall;


-- yearly total revenue (all malls together)
SELECT TOP 2 DATEPART(YEAR, invoice_date) AS year, 
       ROUND(SUM(price_usd), 2) AS yearly_total_revenue
FROM customer_shopping_data$
GROUP BY DATEPART(YEAR, invoice_date);


-- top malls that made the most revenue
SELECT shopping_mall, ROUND(SUM(price_usd), 2) AS total_mall_revenue
FROM customer_shopping_data$
GROUP BY shopping_mall
ORDER BY total_mall_revenue DESC;


-- top malls that sold the highest quantities
SELECT shopping_mall, ROUND(SUM(quantity), 2) AS total_sold_by_mall
FROM customer_shopping_data$
GROUP BY shopping_mall
ORDER BY total_sold_by_mall DESC;


-- monthly revenue and quantities sold for each mall
SELECT shopping_mall, 
       MONTH(invoice_date) AS month, 
       YEAR(invoice_date) AS year,
       SUM(quantity) AS monthly_quantities_by_mall,
       ROUND(SUM(price_usd), 2) AS monthly_revenue_by_mall
FROM customer_shopping_data$
GROUP BY shopping_mall, YEAR(invoice_date), MONTH(invoice_date)
ORDER BY shopping_mall,
	 DATEPART(YEAR, invoice_date),
	 DATEPART(MONTH, invoice_date);


-- daily revenue by mall
SELECT shopping_mall, invoice_date, SUM(price_usd) AS daily_revenue_by_mall
FROM customer_shopping_data$
GROUP BY shopping_mall, invoice_date
ORDER BY shopping_mall,
	 DATEPART(YEAR, invoice_date) DESC,
	 DATEPART(MONTH, invoice_date) DESC,
	 DATEPART(DAY, invoice_date) DESC;


-- total number of customers for each mall across entire data
SELECT shopping_mall, COUNT(customer_id) AS number_of_customers
FROM customer_shopping_data$
GROUP BY shopping_mall
ORDER BY number_of_customers DESC;


-- yearly total number of customers for each mall
SELECT DATEPART(YEAR, invoice_date) AS year, shopping_mall,
       COUNT(customer_id) AS number_of_customers
FROM customer_shopping_data$
GROUP BY shopping_mall, DATEPART(YEAR, invoice_date)
ORDER BY year DESC, number_of_customers DESC
