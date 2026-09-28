create database pizza_sales;

use pizza_sales;


select * from pizza_types limit 10;
select * from pizzas limit 10;
select * from orders limit 10;
select * from order_details limit 10;


SELECT COUNT(*) AS total_orders
FROM orders;

select count(*) as total_order_detailes from order_details;

SELECT COUNT(*) AS total_pizzas
FROM pizzas;

SELECT COUNT(*) AS total_pizzas_types
FROM pizza_types;

select 
od.order_id,
od.pizza_id,
od.quantity,
p.size,
p.price
from order_details as od
join pizzas as p
on od.pizza_id = p.pizza_id;



select 
o.order_id,
o.date,
o.time,
od.pizza_id,
od.quantity,
p.size,
p.price,
pt.name as pizza_name,
pt.category
from orders as o
join order_details as od
  on o.order_id = od.order_id
  join pizzas as p
  on od.pizza_id = p.pizza_id
join pizza_types as pt
on p.pizza_type_id = pt.pizza_type_id
limit 20;

select
round (sum(od.quantity * p.price)) as total_revenue
 from order_details as od
 join pizzas as p
 on od.pizza_id = p.pizza_id;


select 
sum(quantity) as total_pizzas_sold
from order_details;

select 
round(sum(od.quantity * p.price) / count(distinct od.order_id),2) as average_order_value
from order_details as od
join pizzas as p on
od.pizza_id = p.pizza_id;


select * from orders 
where order_id is null
or date is null
or time is null;


select * from order_details
where order_details_id is null
or order_id is null
or pizza_id is null
or quantity is null;

select * from pizzas
where pizza_id is null
or pizza_type_id is null
or size is null
or price is null;

select * from pizza_types
where pizza_type_id is null
or name is null
or category is null
or ingredients is null;

select order_id,
count(*) as count 
from orders
group by order_id
having count(*) > 1;


select order_details_id,
count(*) as count 
from order_details
group by order_details_id
having count(*)>1;


select pizza_id,
count(*) as count 
from pizzas 
group by pizza_id
having count(*) >1;


select pizza_type_id,
count(*) as count 
from pizza_types
group by pizza_type_id
having count(*) >1;


 select * from order_details 
 where quantity <=0;
 
 select * from pizzas
 where price <=0;
 
 
 
 select 
 pt.category,
 sum(od.quantity) as pizza_sold,
 round (sum(od.quantity * p.price),2) as revenue
 from order_details as od
 join pizzas as p
 on od.pizza_id = p.pizza_id
 join pizza_types as pt
 on p.pizza_type_id = pt.pizza_type_id
 group by pt.category
 order by revenue desc;
 
 
 
  select 
 pt.category,
 sum(od.quantity) as pizza_sold,
 round (sum(od.quantity * p.price),2) as revenue,
 round (sum(od.quantity * p.price)/(select sum(od2.quantity * p2.price) 
 from order_details as od2
join pizzas as p2 on 
od2.pizza_id = p2.pizza_id )*100,
2) as revenue_percentage
 from order_details as od
 join pizzas as p
 on od.pizza_id = p.pizza_id
 join pizza_types as pt
 on p.pizza_type_id = pt.pizza_type_id
 group by pt.category
 order by revenue desc;
 
 
 select pt.name as pizza_name,
 sum(od.quantity) as pizzas_sold,
 round(sum(od.quantity * p.price), 2 )as revenue
 
 from order_details as od
 join pizzas as p
 on od.pizza_id = p.pizza_id
 join pizza_types as pt
 on pt.pizza_type_id = p.pizza_type_id
 group by pt.name
 order by revenue desc limit 10;
 
 
 select
 month(o.date) as month_number,
 monthname(o.date) as month_name,
 round(sum(od.quantity * p.price),2) as monthly_income
 from orders as o
 join order_details as od 
 on o.order_id = od.order_id
 join pizzas as p 
 on od.pizza_id = p.pizza_id
 group by month(o.date), monthname(o.date)
order by month_NUMBER;



select 
hour(time) as order_hour,
count(distinct order_id) as total_orders
from orders
group by hour(time)
order by order_hour;


select 
case 
when dayofweek(o.date) in (1,7) then 'weekend'
else 'weekday'
end as day_type,
count(distinct o.order_id) as total_orders,
round(sum(od.quantity * p.price),2) as revenue
from orders as o
join order_details as od
on o.order_id = od.order_id
join pizzas as p
on od.pizza_id = p.pizza_id
group by day_type;


select count(*) as total_rows
from order_details;

select user(), current_user();

select user, host, plugin
from mysql.user 
where user = 'root';