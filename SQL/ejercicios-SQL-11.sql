/* LECCION 11: Consultas en Multiples Tablas 3 */

USE northwind;

-- EJERCICIO 1

SELECT city AS City, company_name AS CompanyName, contact_name AS ContacName, "Customers" AS Relationship
FROM customers
UNION 
SELECT city, company_name, contact_name, "Suppliers"
FROM suppliers;

-- EJERCICIO 2

SELECT *
FROM orders
WHERE employee_id IN (
SELECT employee_id 
FROM employees
WHERE first_name = "Nancy" 
AND last_name = "Davolio");

-- EJERCICIO 3

SELECT company_name AS CompanyName, country AS Country
FROM customers
WHERE customer_id NOT IN (
SELECT customer_id
FROM orders
WHERE year(order_date) = 1997);

-- EJERCICIO 4

SELECT *
FROM orders
WHERE order_id IN (
SELECT order_details.order_id 
FROM order_details INNER JOIN products
ON order_details.product_id = products.product_id
WHERE products.product_name = "Konbu");

