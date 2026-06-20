Create database Super_market;
use Super_market;
select * from customers;
select * from orders;
select * From products;

select customer_id, gender, age
from customers;

select customer_id, gender, age, city
from customers;

select sum(price) as price
from products;

SELECT ROUND(SUM(price), 0) AS price
FROM products;

SELECT CAST(SUM(price) AS SIGNED) AS price
FROM products;

SELECT ROUND(SUM(price), 2) AS price
FROM products;

SELECT FLOOR(SUM(price)) AS price
FROM products;

select customer_id, gender, age, city
from customers
where gender = "Male";

select gender, count(gender) as count
from customers
group by gender;

select customer_id,city, gender
from  customers
where  city = "London" and gender = "Male";

select customer_id, quantity, payment_method
from orders
where payment_method = "Card";

Select sum(quantity) as stock
from orders;


select payment_method, sum(quantity) as product_quantity
from orders
group by payment_method;

select category, round(sum(price))
from products
group  by category;

select category, round(max(price))
from products
group by category;


SELECT c.customer_id as id, o.quantity
FROM customers c
Right JOIN orders o
    ON c.customer_id = o.customer_id
order by o.quantity;

Select max(price) as Product_Price
from products
where price ;

Select category, round(sum(price)) as total_price,
DENSE_RANK() over(order by sum(price) desc) as Price_Rank
from products
group by category;


SELECT *
FROM (
    SELECT
        product_id,
        product_name,
        category,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS rn
    FROM products
) t
WHERE rn = 1;

-- RANK
SELECT
       rank() over(order by sum(price) asc) as Price_Rank,
       category, 
	round(sum(price))
       from products
     Group by  category;
     use super_market;
     
-- Find the order_count Customer
Select city, count(*) as order_count
from customers
group by city
order by order_count asc;

Select customer_id, COUNT(*) as Count_customer_id
from orders
group by customer_id
having COUNT(*) >1;


    SELECT
    c.customer_id,
    o.product_id,
    p.price
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
WHERE p.price > (
    SELECT AVG(price)
    FROM products
);



Select 
    product_name,
     case
		When price >= 100 then 'low'
        when price >= 120 then 'high'
        else 'Normal'
	End as Product_Price
    From products;


SELECT
    customer_id,
    CASE
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
        ELSE 'Unknown'
    END AS gender_name
FROM customers;

SELECT
    SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM customers;

SELECT
    product_name,
    IF(price > 100, 'Expensive', 'Cheap') AS category
FROM products;

select 
      customer_id,
      if(gender >0, 'Male', 'Female')as Customer_gender
      from customers;

select
      product_name,
      if(Profit > 1800, "true", "False") as Product_Ptrofit
      from products;
      
-- Find out top 5 sales by category and products
Select product_name, category, round(price), round(Profit)
from products
order by price desc
limit 5;

-- find out customer sales for city by counts
select product_id, category, Names, count(*)
from products
group by product_id, category, Names
limit 10;

select * 
from orders
where order_date >= dateadd(month, -6, getdate());

select category, product_name, price,
rank() over(order by price desc ) as Price,
avg(price) over() as Total_price
from products;

select 
Rank() over (order by price desc)as Product_price,
category, product_name, round(price),
avg(price) over() as avg_price,
sum(price) over() as sum_price
from products;



-- Pivot table
select payment_method,
         sum(case when order_date = "jan" then quantity else 0 end) as Jan,
         sum(case when order_date = "feb" then quantity else 0 end) as Feb,
         sum(case when order_date = "mar" then quantity else 0 end) as Mar,
         sum(case when order_date = "Apr" then quantity else 0 end) as Apr
         from orders
         group by payment_method;
         
Select order_date, quantity,
             Sum(quantity) over (order by order_date
             Rows between unbounded preceding and 
             current row) as overall_quantity
		from orders
        order by order_date;
        
Select order_date , payment_method, quantity
from orders
order by payment_method ;

DELIMITER //

CREATE FUNCTION TotalIncome(
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN salary + bonus;
END //

DELIMITER ;

select customer_id, gender, age, signup_date
from customers
where year (signup_date)  = '12-04-2023'
and (signup_date)< '09-10-2022'; 

SELECT customer_id, gender, age, signup_date
FROM customers
WHERE signup_date >= '2023-01-01'
  AND signup_date < '2024-01-01';
  
  SELECT
    customer_id,
    signup_date,
    YEAR(signup_date) AS signup_year
FROM customers;

SELECT
    customer_id,
    order_date,
    MONTH(order_date) AS order_date
FROM orders;

SELECT *
FROM orders
WHERE MONTH(order_date) = 6;

SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month
FROM orders;