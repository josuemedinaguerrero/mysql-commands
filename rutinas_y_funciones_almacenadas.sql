
-- Eliminar procesos almacenados
DROP PROCEDURE IF EXISTS name_process;


-- Crear un proceso almacenado
delimiter //
DROP PROCEDURE deletealumno;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletealumno`(
	IN `_alumnoId` SMALLINT
)
CONTAINS SQL
BEGIN
	DELETE FROM proveedores WHERE Prov_id = _alumnoId;
END//
delimiter ;

-- Llamada
CALL `updatealumno`('5');


------------------------------------------------------------------------------
delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertalumno`(
	IN `_id` TINYINT,
	IN `_nombre` VARCHAR(60)
)
CONTAINS SQL
BEGIN
	DECLARE CONTINUE handler FOR 1062 SELECT 'Llave duplicada';
	INSERT INTO alumnos(alumno_id, alumno_nombre) VALUES(_id, _nombre);
END//
delimiter ;

-- Llamada
CALL `insertalumno`('1', 'Nombre example');


------------------------------------------------------------------------------
delimiter //
DROP PROCEDURE maximaventa;
CREATE DEFINER=`root`@`localhost` PROCEDURE `maximaventa`()
CONTAINS SQL
BEGIN
	DECLARE valor_maximo DECIMAL(10,2);
	SET valor_maximo = 0;
	
	SELECT MAX(Ventas_Total) INTO valor_maximo FROM ventas;
	if valor_maximo > 1000 then
		SELECT 'Superaron los $1000' AS Mensaje, valor_maximo AS 'Valor maximo';
	ELSE
		SELECT 'Aun no superamos los $1000' AS Mensaje;
	END if; 
END //
delimiter ;


-- Funcion almacenada
------------------------------------------------------------------------------
delimiter //
CREATE DEFINER=`root`@`localhost` FUNCTION `Ganancia ventas`(
	`_cualquiermarametro` DECIMAL(10,2)
)
RETURNS decimal(10,2)
READS SQL DATA
BEGIN
	DECLARE ganancia DECIMAL(10,2);
	DECLARE precio DECIMAL(10,2);
	DECLARE cantidad MEDIUMINT;
	DECLARE costo DECIMAL(10,2);
	DECLARE final TINYINT DEFAULT 0;
	
	DECLARE CV CURSOR FOR
		SELECT VD_Precio, VD_Costo, VD_Cantidad FROM ventas_detalle;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = 1;
	
	SET ganancia = 0;
	
	OPEN CV;
	
	WHILE final = 0 DO
		FETCH CV INTO precio, costo, cantidad;
		IF final = 0 THEN
			SET ganancia = ganancia + ((precio - costo) * cantidad);
		END IF;
	END WHILE;
	
	CLOSE CV;
	
	RETURN ganancia;
END//
delimiter ;

-- Llamada
SELECT `Ganancia ventas`('25');

