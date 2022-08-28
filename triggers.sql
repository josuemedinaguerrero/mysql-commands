
-- Eliminacion de un trigger
DROP TRIGGER IF EXISTS name_trigger;

delimiter &&
CREATE DEFINER =`root`@`localhost` TRIGGER `materiamayuscula` BEFORE INSERT ON `materias`
FOR EACH ROW
BEGIN
	SET NEW.materia_nombre = UCASE(NEW.materia_nombre);
END&&
delimiter ;


delimiter&&
CREATE DEFINER=`root`@`localhost` TRIGGER `historialclientes` AFTER UPDATE ON `clientes`
FOR EACH ROW 
BEGIN
	if OLD.Cli_RazonSocial <> NEW.Cli_RazonSocial then
      INSERT INTO historial_clientes(hist_old, hist_new) VALUES(OLD.Cli_RazonSocial, NEW.Cli_RazonSocial);
	END if;
END&&
delimiter ;

