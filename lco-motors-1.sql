-- select*from information_schema.tables;
-- DESCRIBE customers;--
-- how would you fetch details of customers who cancelled orders?
SELECT 
    *
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    orders.status = 'Cancelled';
-- count total number of orders cancelled
SELECT 
    customers.customer_name,
    customers.country,
    COUNT(Status) AS `Count_of_cancelled_orders`
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    orders.status = 'Cancelled'
GROUP BY customers.customer_name , customers.country;

SELECT 
    COUNT(Status) AS `Count_of_cancelled_orders`
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    orders.status = 'Cancelled';
-- fetch the details of customers who have done payments between the amount 5000 and 35000?

SELECT 
    customers.customer_name, customers.country, payments.amount
FROM
    customers
        LEFT JOIN
    payments ON payments.customer_id = customers.customer_id
WHERE
    amount BETWEEN '5000' AND '35000'
GROUP BY customers.customer_name , customers.country , payments.amount;

-- Add new employee/salesman with following details 
insert into employees (employee_id,
First_Name,
Last_Name,
Extension,
Email,
Office_Code,
Reports_To,
Job_Title)
values
( 15657,'Lakshmi','Roy','x4065','lakshmiroy1@lcomotors.com','4', '1088', 'Sales Rep');

SELECT 
    employees.employee_id,
    employees.First_Name,
    employees.Last_Name,
    employees.Extension,
    employees.Office_Code,
    employees.Reports_To,
    employees.Job_Title
FROM
    employees
WHERE
    employees.employee_id = 15657;

-- Assign the new employee to the customer whose phone is 2125557413..

UPDATE customers 
SET 
    customers.sales_employee_id = 15657
WHERE
    customers.phone = 2125557413;

SELECT 
    *
FROM
    orders
        LEFT JOIN
    orderdetails ON orderdetails.order_id = orders.order_id
        LEFT JOIN
    products ON orderdetails.product_code = products.product_code
WHERE
    products.product_line = 'motorcycles'
        AND orders.status = 'Shipped';
    
    -- Write a SQL query to get details of all employees/salesmen in the office located in Sydney.
    
SELECT 
    *
FROM
    employees;
SELECT 
    *
FROM
    offices;
DESCRIBE employees;
show columns from employees;

SELECT 
    employees.employee_id,
    employees.last_name,
    employees.first_name,
    employees.extension,
    employees.email,
    employees.office_code,
    employees.reports_to,
    employees.job_title,
    offices.city AS City
FROM
    employees
        LEFT JOIN
    offices ON offices.office_code = employees.office_code
WHERE
    offices.city = 'Sydney';

-- How would you fetch the details of customers whose orders are in process?

describe customers;
describe orders;
SELECT 
    *
FROM
    orders;
SELECT 
    customers.customer_id,
    customers.customer_name,
    customers.last_name,
    customers.first_name,
    customers.phone,
    customers.address_line1,
    customers.address_line2,
    customers.city,
    customers.state,
    customers.postal_code,
    customers.country,
    customers.sales_employee_id,
    customers.credit_limit,
    orders.status AS status
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    orders.status = 'in process';

SELECT 
    *
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    orders.status = 'in process';

-- How would you fetch the details of products with less than 30 orders?
desc products;
desc orders;
desc orderdetails;

SELECT 
    products.product_name,
    orderdetails.quantity_ordered AS Quantity
FROM
    products
        LEFT JOIN
    orderdetails ON orderdetails.product_code = products.product_code
        LEFT JOIN
    orders ON orders.order_id = orderdetails.order_id
WHERE
    orderdetails.quantity_ordered < 30;

-- It is noted that the payment (check number OM314933) was actually 2575. Update the record.

desc payments;
UPDATE payments AS updated_payment 
SET 
    amount = 2575
WHERE
    check_number = 'OM314933';

SELECT 
    *
FROM
    payments
WHERE
    check_number = 'OM314933';

-- Fetch the details of salesmen/employees dealing with customers whose orders are resolved.
SELECT 
    customers.customer_name, orders.status
FROM
    employees
        LEFT JOIN
    customers ON customers.sales_employee_id = employees.employee_id
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    orders.status = 'resolved';

-- Get the details of the customer who made the maximum payment.
SELECT 
    *
FROM
    customers
        LEFT JOIN
    payments ON payments.customer_id = customers.customer_id
WHERE
    payments.amount = (SELECT 
            MAX(amount)
        FROM
            payments);

-- Fetch list of orders shipped to France.
select  ROW_NUMBER()  over (ORDER BY customers.customer_name)  AS serial_number, customers.customer_name,customers.country,orders.status from customers left join orders on customers.customer_id = orders.customer_id
where customers.country = 'France' and orders.status = 'shipped';

-- How many customers are from Finland who placed orders.
select row_number() over (order by customers.customer_name) as S_No, customers.customer_name, customers.country,orders.status from customers
left join orders on orders.customer_id = customers.customer_id
where customers.country = 'Finland';

-- Get the details of the customer who made the maximum payment.
select row_number() over ( order by customers.customer_name) as S_No, customers.customer_name,payments.amount 
from customers left join payments on payments.customer_id = customers.customer_id
where payments.amount = (select max(amount) from payments);

 -- Get the details of the customer and payments they made between May 2019 and June 2019.
SELECT 
    *
FROM
    customers
        JOIN
    payments ON customers.customer_id = payments.customer_id
WHERE
    payments.payment_date BETWEEN '2019-05-01' AND '2019-06-30';

-- How many orders shipped to Belgium in 2018?
SELECT 
    *
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.customer_id
WHERE
    customers.country = 'Belgium'
        AND YEAR(orders.order_date) = 2018;

 -- Get the details of the salesman/employee with offices dealing with customers in Germany.
 
SELECT 
    *
FROM
    employees
        CROSS JOIN
    offices ON offices.office_code = employees.office_code
        LEFT JOIN
    customers ON customers.sales_employee_id = employees.employee_id
WHERE
    customers.country = 'Germany';
    
    -- The customer (id:496 ) made a new order today and the details are as follows:

INSERT INTO `orders`(`order_id`, `order_date`, `required_date`, `status`,`customer_id`)
 VALUES (10426, CURRENT_DATE(), (CURRENT_DATE() + INTERVAL 10 DAY), "In Process" , 496);
 
insert into orders ( order_id, Product_code, quantity, each_price, order_line_number, order_date, required_date,status)
values(10426,'S12_3148', 41, 151, 11,'2023-09-04','2023-09-14','In Process')