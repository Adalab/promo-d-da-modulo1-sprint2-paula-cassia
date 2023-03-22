/* LECCION 14: CTEs */

USE northwind;

/* Ejercicio 1: Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers. */

WITH nombres_comp 
AS (
	SELECT customer_id AS CustID, company_name AS CompanyName
    FROM customers
    )
SELECT *
FROM nombres_comp;

/* Ejercicio 2: Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo 
queremos los que pertezcan a "Germany". */

WITH solo_alemania
AS (
SELECT customer_id AS CustID, company_name AS CompanyName
FROM customers
WHERE country = 'Germany'
)
SELECT *
FROM solo_alemania;

/* Ejercicio 3: Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).*/

WITH facturas_cliente
AS (
SELECT customer_id, order_id, order_date
FROM orders
)
SELECT facturas_cliente.customer_id, customers.company_name, facturas_cliente.order_id, facturas_cliente.order_date
FROM facturas_cliente
NATURAL JOIN customers; 

/* Ejercicio 4: Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente. */

WITH facturas_cliente2
AS (
SELECT customer_id, order_id
FROM orders
)
SELECT facturas_cliente2.customer_id, customers.company_name, COUNT(facturas_cliente2.order_id) AS numero_facturas
FROM facturas_cliente2
NATURAL JOIN customers
GROUP BY facturas_cliente2.customer_id, customers.company_name; 

/* Ejercicio 5: Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media. */

WITH cantidad_media
AS (
SELECT product_id, SUM(quantity) AS media
FROM order_details
GROUP BY product_id
)
SELECT products.product_name AS producto, AVG(cantidad_media.media)
FROM cantidad_media
NATURAL JOIN products
GROUP BY products.product_name;


