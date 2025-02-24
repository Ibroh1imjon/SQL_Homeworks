select customer_name from Orders o
join Customers c on o.customer_id = c.customer_id
group by c.customer_name
having count(order_id) > (select count(order_id)/count(distinct(customer_id)) from Orders)

select customer_name, sum(total_amount) from Orders o
join Customers c on o.customer_id = c.customer_id
group by c.customer_name
