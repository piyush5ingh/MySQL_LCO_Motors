-- Fetch details of employees who were reported for the payments made by the customers between June 2018 and July 2018.
select * from employees as e left join customers as c on c.sales_employee_id= e.employee_id
right join payments as p on p.customer_id = c.customer_id
where p.payment_date between '2018-06-01' and '2018-07-01'; 

-- A new payment was done by a customer(id: 119). Insert the below details.
-- Check Number : OM314944
-- Payment date : <today’s date>
-- Amount : 33789.55;

insert into payments ( customer_id,check_number,payment_date, amount)
value(119,'OM314944',current_date(),33789.55);
select * from payments 
WHERE customer_id = 119;

-- Get the address of the office of the employees that reports to the employee whose id is 1102.
select * from employees left join offices on offices.office_code = employees.office_code
where employees.employee_id = 1102;

-- Get the details of the payments of classic cars.

select* from payments as p left join customers as c on c.customer_id = p.customer_id
left join orders as o on o.customer_id = c.customer_id
left join orderdetails on orderdetails.order_id = o.order_id
left join products on products.product_code = orderdetails.product_code
where products.product_line = 'classic cars';

-- How many customers ordered from the USA?

select count(*) from customers as c left join orders as o on o.customer_id = c.customer_id
where c.country = 'USA';

-- Get the comments regarding resolved orders.

select*from orders where status = 'resolved';

-- Fetch the details of employees/salesmen in the USA with office addresses.
select * from employees as e left join offices as o on o.office_code = e.office_code
where o.country = 'USA';

-- ) Fetch total price of each order of motorcycles. (Hint: quantity x price for each record).

select products.product_name,products.product_line,orderdetails.quantity_ordered, orderdetails.each_price, orderdetails.quantity_ordered* orderdetails.each_price from orders as o 
left join orderdetails on orderdetails.order_id = o.order_id
left join products on products.product_code = orderdetails.product_code
where products.product_line = 'motorcycles';

-- Get the total worth of all planes ordered.
select products.product_name,products.product_line,orderdetails.quantity_ordered, orderdetails.each_price, orderdetails.quantity_ordered* orderdetails.each_price from orders as o 
left join orderdetails on orderdetails.order_id = o.order_id
left join products on products.product_code = orderdetails.product_code
where products.product_line = 'planes';

select sum(orderdetails.quantity_ordered* orderdetails.each_price ) from orders as o 
left join orderdetails on orderdetails.order_id = o.order_id
left join products on products.product_code = orderdetails.product_code
where products.product_line = 'planes';

-- How many customers belong to France?
select count(*) from customers where country = 'France';

-- Get the payments of customers living in France.
select * from customers left join payments on payments.customer_id = customers.customer_id
where country = 'France';

-- Get the office address of the employees/salesmen who report to employee 1143.

select * from employees left join offices on offices.office_code = employees.office_code
where employees.employee_id = 1143;