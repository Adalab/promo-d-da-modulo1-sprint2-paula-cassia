/* LECCION 11: Consultas en Multiples Tablas 3 */

-- EJERCICIO 1

SELECT contact_last_name AS Apellidos
FROM customers
UNION
SELECT last_name AS Apellidos
FROM employees;

-- EJERCICIO 2

SELECT contact_first_name AS Nombre, contact_last_name AS Apellidos
FROM customers
UNION
SELECT first_name AS Nombre, last_name AS Apellidos
FROM employees;

-- EJERCICIO 3

SELECT contact_first_name AS Nombre, contact_last_name AS Apellidos
FROM customers
UNION ALL
SELECT first_name AS Nombre, last_name AS Apellidos
FROM employees;

-- EJERCICIO 4

SELECT employee_number AS NumeroEmpleado, first_name AS NombreEmpleado, last_name AS ApellidoEmpleado
FROM employees
WHERE employee_number IN (
	SELECT sales_rep_employee_number
    FROM customers);

-- EJERCICIO 5

SELECT city AS Ciudad, customer_name AS NombredelaEmpresa
FROM customers
WHERE city NOT IN (
	SELECT city
    FROM offices);