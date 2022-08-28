
-- Crear una base de datos
CREATE DATABASE nombreDB;


-- Mostrar usuarios
SELECT user FROM mysql.user;


ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'TU_PASSWORD';


-- Mostrar bases de datos
show nombreDB;


-- Crea una tabla
use nombreDB;
CREATE TABLE tabla_example (
   id INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
   edad INT NOT NULL,
   nombre VARCHAR(60) DEFAULT NULL,
   estado VARCHAR(1) DEFAULT NULL,
   PRIMARY KEY(id)
)


-- Modificar una tabla
ALTER TABLE tabla_example MODIFY COLUMN id int auto_increment;


ALTER TABLE tabla_example ADD (
   mascota char(30) default 'perro',
   pasatiempo char(20) not null
);


-- Eliminar una tabla
DROP TABLE empleado;


-- CONDICIONALES
SELECT * FROM tabla_example LIMIT 2;
SELECT * FROM tabla_example WHERE edad > 15;
SELECT * FROM tabla_example WHERE edad >= 15;
SELECT * FROM tabla_example WHERE edad > 20 AND email = 'nose@correo.com';
SELECT * FROM tabla_example WHERE edad > 15 OR nombre = 'Cualquiercosa';
SELECT * FROM tabla_example WHERE estado != 1;
SELECT * FROM tabla_example WHERE edad BETWEEN 15 AND 30;
SELECT * FROM tabla_example WHERE correo LIKE '%gmail%';
SELECT * FROM tabla_example ORDER BY edad ASC;
SELECT * FROM tabla_example ORDER BY edad DESC;


-- Sentencias SQL --


SELECT Ventas_Id AS 'Id', Ventas_Fecha AS 'Fecha', Cli_RazonSocial AS 'Razon social', Ventas_Total AS 'Ventas totales'
FROM ventas, clientes
WHERE Ventas_CliId = Cli_Id


-- El SUM se puede reemplazar por AVG, MIN, MAX
SELECT SUM(Ventas_Total)
FROM ventas
WHERE MONTH(Ventas_Fecha) = 1 AND YEAR(Ventas_Fecha)


SELECT COUNT(*) AS 'Registros'
FROM ventas
WHERE MONTH(Ventas_Fecha) = 1 AND YEAR(Ventas_Fecha)


SELECT Ventas_Fecha, SUM(Ventas_Total) AS total
FROM ventas
GROUP BY Ventas_Fecha


SELECT
	YEAR(Ventas_Fecha) AS anio,
	MONTH(Ventas_Fecha) AS mes,
	DAY(Ventas_Fecha) AS dia,
	SUM(Ventas_Total) AS total
FROM ventas
GROUP BY anio, mes, dia


-- No permite que se repitan valores
SELECT DISTINCT(Ventas_CliId) FROM ventas


SELECT DISTINCT(Ventas_CliId) FROM ventas
WHERE Ventas_CliId IN (1, 2, 3, 13)


SELECT DISTINCT(Ventas_CliId) FROM ventas
WHERE Ventas_CliId NOT IN (1, 2, 3, 13)


SELECT * FROM ventas
WHERE Ventas_Fecha >= '2018-02-01'


SELECT * FROM ventas
WHERE Ventas_Fecha BETWEEN '2018-01-01' AND '2018-02-01'


SELECT * FROM productos
WHERE Prod_Descripcion LIKE 'a%'


SELECT * FROM productos
WHERE CONCAT(Prod_Descripcion, Prod_Color) LIKE '%an%'


SELECT * FROM ventas
	JOIN ventas_detalle ON VD_VentasId = Ventas_Id
	JOIN productos ON VD_ProdId = Prod_Id
	JOIN proveedores ON Prod_ProvId = Prov_Id


SELECT * FROM ventas
    LEFT JOIN ventas_detalle ON VD_VentasId = Ventas_Id


SELECT * FROM ventas
	RIGHT JOIN ventas_detalle ON VD_VentasId = Ventas_Id


SELECT * FROM ventas LEFT JOIN ventas_detalle ON VD_VentasId = Ventas_Id
UNION
SELECT * FROM ventas RIGHT JOIN ventas_detalle ON VD_VentasId = Ventas_Id


-- Sentencias de control

SELECT Prod_Id, if(Prod_Status = 1, 'HABILITADO', 'DESHABILITADO') AS 'Estado'
FROM productos


SELECT Prod_Id, case Prod_Status
						when 1 then 'HABILITADO'
						when 0 then 'DESHABILITADO'
					 END AS 'Estado'
FROM productos


SELECT Prod_Id, Prod_Descripcion, SUBSTR(Prod_Descripcion, 1, 10) AS 'Parte'
FROM productos


SELECT YEAR(Ventas_Fecha) AS anio, MONTH(Ventas_Fecha) AS mes, SUM(Ventas_Total) AS Suma
FROM ventas
GROUP BY anio, mes
HAVING Suma > 1000000


-- Fechas

SELECT CURRENT_DATE

SELECT CURRENT_TIME

SELECT CURRENT_TIMESTAMP

SELECT DATABASE()

SELECT DATEDIFF(CURRENT_DATE, '2021-10-28')

SELECT DAYOFWEEK(CURRENT_DATE)

SELECT Ventas_Fecha AS Fecha, ADDDATE(Ventas_Fecha, 5) FROM ventas

SELECT CONVERT('2022-05-10', DATE) AS 'Convertir'

SELECT CONVERT('09:45:00', TIME) AS 'Convertir'

-- Al Y se lo conoce como verbos
SELECT DATE_FORMAT('2022-05-10', '%Y') AS 'Convertir'

SELECT DATE_FORMAT('2022-05-10', '%Y del mes %m(dia %d)') AS 'Convertir'






-- INSERT

INSERT INTO tabla (Prov_Nombre) VALUES('Pepito el morochero')


-- UPDATE

UPDATE productos SET Prod_Descripcion = 'Siempre te llamo de madruga', Prod_Precio = 500.2
WHERE Prod_Id = 1


-- DELETE
DELETE FROM ventas_detalle
WHERE VD_ProdId IN (SELECT Prod_Id FROM productos WHERE Prod_Precio = 0)






-- Encriptar datos
SELECT Prod_Descripcion, AES_ENCRYPT(Prod_Descripcion, '123') AS 'Encriptar data' FROM productos


-- Desencriptar data
SELECT Prod_Descripcion, AES_DECRYPT(AES_ENCRYPT(Prod_Descripcion, '123'), '123') AS 'Desencriptar data' FROM productos


-- Numero de caracteres
SELECT Prod_Descripcion, LENGTH(Prod_Descripcion) AS Largo FROM productos


SELECT CONCAT(Prod_Id, '    ', Prod_Descripcion) AS Concatenacion FROM productos


SELECT CONCAT_WS(' || ', Prod_Id, Prod_Descripcion, Prod_Color) AS Concatenacion FROM productos































































