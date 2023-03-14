/* LECCION 10: Consultas en multiples tablas 2 */

USE northwind;

/* EJERCICIO 1  Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de 
todas las empresas cliente, los ID de sus pedidos y las fechas. */

SELECT orders.order_id AS OrderID, customers.company_name AS CompanyName, orders.order_date AS OrderDate
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id;

/* EJERCICIO 2  Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que 
ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. 
Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos. */

SELECT customers.company_name AS NombreCliente, COUNT(orders.order_id) AS NumeroPedidos
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id
WHERE country = "UK"
GROUP BY customers.company_name;

/* EJERCICIO 3  Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido 
(tengan pedidos o no) junto con los ID de todos los pedidos que han realizado, el nombre de contacto 
de cada empresa y la fecha del pedido. */

-- para que la tabla sea igual que el ejemplo:
SELECT orders.order_id AS OrderID, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id 
WHERE country = "UK";

-- para que la tabla vaya acorde con lo que pide el enunciado
SELECT orders.order_id AS OrderID, customers.company_name AS NombreCliente, customers.contact_name AS NombreContacto, orders.order_date AS FechaPedido
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id 
WHERE country = "UK";

/* EJERCICIO 4  Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla 
los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido 
tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director? */

SELECT A.city, A.first_name AS NombreEmpleado, A.last_name AS ApellidoEmpleado, B.city, B.first_name AS NombreJefe, B.last_name AS ApellidoJefe
FROM employees AS A, employees AS B
WHERE A.employee_id <> B.employee_id  
AND A.reports_to = B.employee_id;

-- hay dos jefes, Steven y Andrew. Como Andrew es el jefe de Steven, podemos deducir que Andrew es el director.

/* EJERCICIO 5  BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. 
Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe). */

SELECT orders.order_id AS OrderID, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id 
UNION
SELECT orders.order_id AS OrderID, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido
FROM customers
RIGHT JOIN orders
ON orders.customer_id = customers.customer_id;
