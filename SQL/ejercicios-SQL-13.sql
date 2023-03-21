USE northwind;

/*Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada. */

SELECT order_id AS OrderID, customer_id AS CustomerID, employee_id AS EmployeeID, order_date AS OrderDate, required_date AS RequiredDate
FROM orders AS t1
WHERE order_date = (
	SELECT MAX(order_date)
	FROM orders AS t2
    WHERE t1.employee_id = t2.employee_id);

/*Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
De nuevo lo tendréis que hacer con queries correlacionadas.*/

SELECT DISTINCT product_id, unit_price AS Max_unit_price_sold
FROM order_details AS t1
WHERE unit_price = (
	SELECT MAX(unit_price)
	FROM order_details AS t2
	WHERE t1.product_id = t2.product_id);
						
/*Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/

SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%';

/*Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".*/

SELECT DISTINCT city AS ciudad, company_name AS empresa, contact_name AS persona_contacto, COUNT(order_id*company_name) AS numero_pedidos
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE city LIKE 'L%'
GROUP BY order_id;

/*Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/

SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE '%Sales%';

/*Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT contact_name AS ContactName
FROM customers
WHERE contact_name NOT LIKE '_a%';