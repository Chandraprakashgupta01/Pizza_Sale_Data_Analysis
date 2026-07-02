-- 1. pizza_types
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50)  PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    ingredients   TEXT         NOT NULL
);
SELECT * FROM pizza_types;

-- 2. pizzas
CREATE TABLE pizzas (
    pizza_id      VARCHAR(50)    PRIMARY KEY,
    pizza_type_id VARCHAR(50)    NOT NULL REFERENCES pizza_types(pizza_type_id),
    size          CHAR(5)        NOT NULL,   -- S, M, L, XL, XXL
    price         NUMERIC(6, 2)  NOT NULL
);

SELECT * FROM pizzas;
-- 3. orders
CREATE TABLE orders (
    order_id  SERIAL       PRIMARY KEY,
    date      DATE         NOT NULL,
    time      TIME         NOT NULL
);

SELECT * FROM orders;

-- 4. order_details
CREATE TABLE order_details (
    order_details_id SERIAL      PRIMARY KEY,
    order_id         INT         NOT NULL REFERENCES orders(order_id),
    pizza_id         VARCHAR(50) NOT NULL REFERENCES pizzas(pizza_id),
    quantity         SMALLINT    NOT NULL CHECK (quantity > 0)
);

SELECT * FROM order_details;


--Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders 
FROM orders;

--Calculate the total revenue generated from pizza sales.
SELECT 
     sum(order_details.quantity*pizzas.price) AS Total_sales
FROM order_details join pizzas
    ON pizzas.pizza_id = order_details.pizza_id ;

--Identify the highest-priced pizza.
SELECT pizza_type_id, size, price AS highest_price_pizza
FROM pizzas
ORDER BY price DESC
LIMIT 1;

--Identify the most common pizza size ordered.
SELECT pizzas.size ,COUNT(order_details.order_details_id) AS Order_count
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size ORDER BY Order_count DESC;

--List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name,
sum(order_details.quantity)AS Quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id =pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by 	Quantity desc limit 5;

--Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,
sum(order_details.quantity)as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;


--Determine the distribution of orders by hour of the day.
SELECT EXTRACT(HOUR FROM time) AS hour_of_day,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;

--Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category;

--Group the orders by date and calculate the average number of pizzas ordered per day.
select round( avg (quantity),0) as average_pizza_order_per_day
from
(select orders.date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.date) as order_quantity;

--Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,
sum(order_details.quantity * pizzas.price)as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;

--Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category,
round (sum(order_details.quantity*pizzas.price) / (SELECT
ROUND(SUM(order_details. quantity *pizzas.price),2) AS total_sales
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id) *100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types. category order by revenue desc;

--Analyze the cumulative revenue generated over time.
select date,
sum(revenue) over(order by date)as cum_revenue
from
(select orders.date,
sum(order_details.quantity * pizzas.price)as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.date) as sales;
Determine the top 3 m
--ost ordered pizza types based on revenue for each pizza category.
select name ,revenue from
(select category,name , revenue,
rank() over(partition by category order by revenue desc) as rn
from (select pizza_types.category, pizza_types.name,
sum (order_details.quantity * pizzas.price) as revenue 
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where rn <=3;
