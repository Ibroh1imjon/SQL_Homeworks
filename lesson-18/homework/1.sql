--1
Select * from Employees
where salary = (select min(salary) from employees)

--2
select * from products
where price > (select avg(price) from products)

--3
select * from employees
where department_id = (select id from departments where department_name = 'Sales')

--4
select * from Customers
where customer_id not in (select customer_id from Orders)

--5
select price, category_id from products x
where price = (select max(price) from products where x.category_id = category_id)

--6
select * from employees
where department_id = (select top 1 department_id from employees group by department_id order by avg(salary) desc)

--7
select * from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id)

--8
select s.name, g.course_id, g.grade from grades g
join students s
on s.student_id = g.student_id
where grade = (select max(grade) from grades where course_id = g.course_id)

--9
select * from products p 
where price = (select distinct price from products where category_id = p.category_id order by price desc
              limit 2 rows offset next 1 rows only
)

--10
select id, name, salary, department_id
from employees e
where salary > (select AVG(salary) from employees)  
AND salary < (select MAX(salary) from employees where department_id = e.department_id);
