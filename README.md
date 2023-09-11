# MySQL Project: LCO Motors Database

## Overview

This MySQL project involves working with the LCO Motors database. The provided database, `lco_motors.sql`, contains information about customers, employees, orders, and products related to an automotive company. In this project, we will perform various SQL queries to extract meaningful insights and make modifications to the database as required.

### Database Structure

The LCO Motors database consists of the following tables:

1. `customers`: Contains customer information.
2. `employees`: Contains employee/salesman details.
3. `orders`: Stores order information, including order status.
4. `orderdetails`: Contains details of products in each order.
5. `products`: Contains information about the products.
6. `offices`: Contains details about office locations.
7. `payments`: Contains payment details.


## Queries and Actions

### Q1) Fetch Details of Customers Who Cancelled Orders

```sql
SELECT * FROM customers WHERE customerNumber IN (SELECT customerNumber FROM orders WHERE status = 'Cancelled');
```

### Q2) Fetch Details of Customers with Payments Between $5,000 and $35,000

```sql
SELECT * FROM customers WHERE customerNumber IN (SELECT customerNumber FROM payments WHERE amount BETWEEN 5000 AND 35000);
```

### Q3) Add New Employee/Salesman

```sql
INSERT INTO employees (employeeNumber, firstName, lastName, extension, email, officeCode, reportsTo, jobTitle) 
VALUES (15657, 'Lakshmi', 'Roy', 'x4065', 'lakshmiroy1@lcomotors.com', 4, 1088, 'Sales Rep');
```

### Q4) Assign the New Employee to a Customer

```sql
UPDATE customers SET salesRepEmployeeNumber = 15657 WHERE phone = '2125557413';
```

### Q5) Fetch Shipped Motorcycles

```sql
SELECT * FROM products WHERE productLine = 'Motorcycles' AND productCode IN (SELECT productCode FROM orderdetails WHERE orderNumber IN (SELECT orderNumber FROM orders WHERE status = 'Shipped'));
```

### Q6) Get Details of Employees in the Sydney Office

```sql
SELECT * FROM employees WHERE officeCode = (SELECT officeCode FROM offices WHERE city = 'Sydney');
```

### Q7) Fetch Details of Customers Whose Orders Are In Process

```sql
SELECT * FROM customers WHERE customerNumber IN (SELECT customerNumber FROM orders WHERE status = 'In Process');
```

### Q8) Fetch Products with Less Than 30 Orders

```sql
SELECT * FROM products WHERE productCode IN (SELECT productCode FROM orderdetails GROUP BY productCode HAVING COUNT(*) < 30);
```

### Q9) Update Payment Record

```sql
UPDATE payments SET amount = 2575 WHERE checkNumber = 'OM314933';
```

### Q10) Fetch Details of Salesmen/Employees Dealing with Resolved Orders

```sql
SELECT DISTINCT e.* FROM employees e
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IN (SELECT customerNumber FROM orders WHERE status = 'Resolved');
```

### Q11) Get Details of the Customer Who Made the Maximum Payment

```sql
SELECT * FROM customers WHERE customerNumber = (SELECT customerNumber FROM payments ORDER BY amount DESC LIMIT 1);
```

### Q12) Fetch List of Orders Shipped to France

```sql
SELECT o.* FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.country = 'France' AND o.status = 'Shipped';
```

### Q13) Count Customers from Finland Who Placed Orders

```sql
SELECT COUNT(*) AS customerCount FROM customers WHERE country = 'Finland' AND customerNumber IN (SELECT customerNumber FROM orders);
```

### Q14) Get Details of the Customer Who Made the Maximum Payment

```sql
SELECT c.*, p.amount FROM customers c
INNER JOIN payments p ON c.customerNumber = p.customerNumber
ORDER BY p.amount DESC LIMIT 1;
```

### Q15) Get Details of Customers and Payments Between May 2019 and June 2019

```sql
SELECT c.*, p.paymentDate, p.amount FROM customers c
INNER JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.paymentDate BETWEEN '2019-05-01' AND '2019-06-30';
```

### Q16) Count Orders Shipped to Belgium in 2018

```sql
SELECT COUNT(*) AS orderCount FROM orders WHERE status = 'Shipped' AND orderDate BETWEEN '2018-01-01' AND '2018-12-31' AND customerNumber IN (SELECT customerNumber FROM customers WHERE country = 'Belgium');
```

### Q17) Get Details of Salesmen/Employees with Offices Dealing with Customers in Germany

```sql
SELECT e.* FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.country = 'Germany';
```

### Q18) Insert a New Order

```sql
INSERT INTO orders (orderNumber, customerNumber, productCode, quantityOrdered, priceEach, orderLineNumber, orderDate, requiredDate, status)
VALUES (10426, 496, 'S12_3148', 41, 151, 11, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'In Process');
```

### Q19) Get Details of Employees Reported for Payments Between June 2018 and July 2018

```sql
SELECT DISTINCT e.* FROM employees e
INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
INNER JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.paymentDate BETWEEN '2018-06-01' AND '2018-07-31';
```

### Q20) Insert a New Payment

```sql
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (119, 'OM314944', CURDATE(), 33789.55);
```

### Q21) Get the Address of the Office of Employees Reporting to Employee 1102

```sql
SELECT o.addressLine1, o.addressLine2, o.city, o.state, o.country, o.postalCode FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode
WHERE e.reportsTo = 1102;
```

### Q22) Get Details of Payments for Classic Cars

```sql
SELECT p.* FROM payments p
INNER JOIN customers c ON p.customerNumber = c.customerNumber
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products pr ON od.productCode = pr.productCode
WHERE pr.productLine = 'Classic Cars';
```

### Q23) Count Customers Ordered from the USA

```sql
SELECT COUNT(*) AS customerCount FROM customers WHERE country = 'USA' AND customerNumber IN (SELECT customerNumber FROM orders);
```

### Q24) Get Comments Regarding Resolved Orders

```sql
SELECT o.comments FROM orders o WHERE o.status = 'Resolved';
```

### Q25) Get Details of Employees/Salesmen in the USA with Office Addresses

```sql
SELECT

 e.*, o.* FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode
WHERE o.country = 'USA';
```

### Q26) Calculate Total Price of Each Motorcycle Order

```sql
SELECT o.orderNumber, SUM(od.quantityOrdered * od.priceEach) AS total_price
FROM orders o
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Motorcycles'
GROUP BY o.orderNumber;
```

### Q27) Calculate Total Worth of All Plane Orders

```sql
SELECT SUM(od.quantityOrdered * od.priceEach) AS total_worth
FROM orderdetails od
INNER JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Planes';
```

### Q28) Count Customers Belonging to France

```sql
SELECT COUNT(*) AS customerCount FROM customers WHERE country = 'France';
```

### Q29) Get Payments of Customers Living in France

```sql
SELECT p.* FROM payments p
INNER JOIN customers c ON p.customerNumber = c.customerNumber
WHERE c.country = 'France';
```

### Q30) Get the Office Address of Employees Reporting to Employee 1143

```sql
SELECT o.* FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode
WHERE e.reportsTo = 1143;
```

## Project Purpose

The purpose of this project is to demonstrate proficiency in SQL database management. We have performed various queries to extract information and made updates to the database based on specific requirements. This project can serve as a reference for using SQL in real-world scenarios and understanding how to work with a relational database.

## Additional Notes

Feel free to explore and modify the database further to enhance your SQL skills. If you encounter any issues or have questions, please refer to the SQL documentation or seek assistance from a database expert.

Please ensure you have imported the provided `lco_motors.sql` file into your MySQL database before executing the queries.

**Note:** Replace `<today's date>` and any specific dates with the actual dates when executing queries or making updates.

For more information on using MySQL, refer to the [official MySQL documentation](https://dev.mysql.com/doc/).

---

**Disclaimer:** The database provided is fictional and for educational purposes only. Any resemblance to real entities or data is purely coincidental.
