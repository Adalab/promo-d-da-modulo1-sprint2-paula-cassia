/* LECCION 11: Consultas en Multiples Tablas 3 */

USE northwind;

/*Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. 
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). 
Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.*/ 

SELECT city AS City, company_name AS CompanyName, contact_name AS ContacName, "Customers" AS Relationship
FROM customers
UNION 
SELECT city, company_name, contact_name, "Suppliers"
FROM suppliers;

/*Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", una de nuestras empleadas.
Nos pide todos los detalles tramitados por ella.*/

SELECT *
FROM orders
WHERE employee_id IN (
SELECT employee_id 
FROM employees
WHERE first_name = "Nancy" 
AND last_name = "Davolio");

/*Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber qué empresas no han comprado en el año 1997.
💡 Pista 💡 Para extraer el año de una fecha, podemos usar el estamento year.*/

SELECT company_name AS CompanyName, country AS Country
FROM customers
WHERE customer_id NOT IN (
SELECT customer_id
FROM orders
WHERE year(order_date) = 1997);

/*Extraed toda la información de los pedidos donde tengamos "Konbu"
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
💡 Pista 💡 En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores como por ejemplo el INNER JOIN.*/

SELECT *
FROM orders
WHERE order_id IN (
SELECT order_details.order_id 
FROM order_details INNER JOIN products
ON order_details.product_id = products.product_id
WHERE products.product_name = "Konbu");

