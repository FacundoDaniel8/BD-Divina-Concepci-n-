--------------------------a.Uso de operadores (LIKE, IS NULL, NOT IN, IN, BETWEEN,)
--Consulta 1: 

SELECT id_navegante from navegantes WHERE apellido2 IS NULL;

--Consulta 2:

SELECT * FROM navegantes WHERE nombre LIKE 'J%';

--------------------------b. Funciones de fechas
--Consulta 1: 

SELECT id_navegante,nombre,apellido,apellido2,id_barco,fecha_nac FROM navegantes 
WHERE ( DATEDIFF( CURDATE() ,fecha_nac )/365 ) > 18 AND ( DATEDIFF( CURDATE() ,fecha_nac )/365 ) < 55; 

--Consulta 2:

SELECT id_navegante,nombre,apellido,
IF( MONTH(fecha_nac) > MONTH( CURDATE() )  ,DATEDIFF( CURDATE(),fecha_nac )/365 -1 , DATEDIFF( CURDATE(),fecha_nac )/365  ) AS 'Edad' FROM navegantes;

--------------------------c. Agrupación (Group By, Having)
--Consulta 1:

SELECT COUNT(*) cantidad, id_tipo
FROM producto
GROUP BY id_tipo
ORDER BY cantidad DESC;

--Consulta 2:
SELECT estado, COUNT(*) cantidad
FROM inspecciones
GROUP BY estado;


--------------------------d.Ordenamiento (Order By)
--Consulta 1:

SELECT id_modelo, capacidad_max_tripulantes FROM modelo ORDER BY 	capacidad_max_tripulantes;

--Consulta 2:

SELECT * FROM navegantes ORDER BY fecha_nac;



--------------------------e. Campos calculados ó funciones agregadas de dominio (Count, Sum, Max, Min, Avg) 
--Consulta 1:

SELECT *
FROM modelo
WHERE cargamento_max IN (
						SELECT MAX(cargamento_max)
						FROM modelo
						)
OR cargamento_max IN (
    				 SELECT MIN(cargamento_max)
    				 FROM modelo
					 );

--Consulta 2:

SELECT ROUND(AVG(capacidad), 0) promedio 
FROM puertos;
					 
					 
					 
					 
--------------------------f.Inner join
--Consulta 1:

SELECT n.* FROM (navegantes AS n INNER JOIN embarcaciones AS e ON  n.id_barco=e.id_barco) INNER JOIN inspecciones AS i ON i.id_barco=e.id_barco WHERE i.estado="Denegado";
	
	
--Consulta 2:

SELECT e.* FROM embarcaciones as e INNER JOIN producto p ON e.id_barco=p.id_barco WHERE p.id_tipo="MAQUINARIA";


--------------------------g. Sub-consulta:
--Consulta 1:

SELECT inspecciones.id_barco,fecha_inspeccion,estado,motivo_detencion,producto.id_tipo,producto.descripcion FROM inspecciones 
INNER JOIN embarcaciones ON inspecciones.id_barco = embarcaciones.id_barco
INNER JOIN producto ON embarcaciones.id_barco = producto.id_barco
WHERE motivo_detencion IS NOT NULL;

--Consulta 2:

SELECT embarcaciones.id_barco,modelo.modelo,puertos.id_puerto,puertos.ubicacion FROM modelo
INNER JOIN embarcaciones ON modelo.id_modelo = embarcaciones.id_modelo
INNER JOIN inspecciones ON embarcaciones.id_barco = inspecciones.id_barco
INNER JOIN puertos ON inspecciones.id_puerto =puertos.id_puerto;


--------------------------h 

-------I. Cursores:

--Cursor 1:
 
DELIMITER //

CREATE OR REPLACE FUNCTION promedio_estado_pendiente()
RETURNS float
BEGIN
	DECLARE suma int;
    DECLARE total int;
    DECLARE _estado varchar(15);
    DECLARE i int;
    DECLARE c1 CURSOR FOR SELECT estado FROM inspecciones;
    
    SET suma = 0;
    SET total = 0;
    SET i = 1;
    
    SELECT COUNT(*) INTO total FROM inspecciones;
    
    OPEN c1;
	WHILE i <= total DO
    	FETCH c1 INTO _estado;
        IF _estado = "Pendiente" THEN
        	SET suma = suma + 1;
        END IF;
        
        SET i = i + 1;
    END WHILE;
    CLOSE c1;
    
    RETURN suma / total;
    
END //
DELIMITER ;

--Llamado
--SELECT promedio_estado_pendiente() promedio;

--Cursor 2:

DELIMITER //

CREATE OR REPLACE PROCEDURE actualizar_precio_rango(IN minimo float, maximo float, porcentaje float)
BEGIN
	DECLARE _impuesto float;
    DECLARE total int;
    DECLARE i int;
    DECLARE c2 CURSOR FOR SELECT impuesto FROM tipo_producto;
    
    SELECT COUNT(*) INTO total FROM tipo_producto;
    SET i = 1;
    
    OPEN c2;
    	WHILE i <= total DO
    		FETCH c2 INTO _impuesto;
        	IF _impuesto <= maximo AND _impuesto >= minimo THEN
        		UPDATE tipo_producto
                SET impuesto = impuesto + (impuesto * porcentaje)
                WHERE impuesto = _impuesto;
        	END IF;
            
            SET i = i + 1;
    	END WHILE;
    CLOSE c2;
    
END //
DELIMITER ;

--Llamado
--CALL actualizar_precio_rango(80000, 100000, 0.15);


------II. Procedimientos almacenados con y sin parámetros:

--Con parámetros:

DROP PROCEDURE IF EXISTS inspeccionesEnBaseFecha;

DELIMITER //
     CREATE PROCEDURE inspeccionesEnBaseFecha ( formato varchar(3) , tipo int )
        BEGIN
          IF formato = 'dia'  THEN
            SELECT * FROM inspecciones WHERE DAY(fecha_inspeccion) = tipo;
          ELSEIF formato = 'mes' THEN

            IF formato<13 AND formato>0 THEN
            SELECT * FROM inspecciones WHERE MONTH(fecha_inspeccion) = tipo;
            ELSE
            SELECT "Ingreso mal la cantidad de meses" as 'Mensaje'; 
            END IF;
            
          ELSEIF formato = 'ano' THEN #se que deberia usar ñ pero no tengo idea de si el progama deje de andar por eso
            SELECT * FROM inspecciones WHERE YEAR(fecha_inspeccion) = tipo;
           ELSE
             SELECT "Por favor ingrese dia,mes,o ano";
           END IF;
   
        END //
    DELIMITER ;
--Llamado
--CALL inspeccionesEnBaseFecha( "ano" , 2023);

-- Sin parámetros:

DROP PROCEDURE IF EXISTS BarcosPendientesBorrar;
DELIMITER //
     CREATE PROCEDURE  BarcosPendientesBorrar ()
        BEGIN
          DELETE FROM inspecciones
          WHERE estado='Pendiente' ;
        END //
    DELIMITER ;

 --Llamado
 --CALL BarcosPendientesBorrar();



-------------III. Funciones almacenadas:

--Función 1:

DELIMITER //

CREATE OR REPLACE FUNCTION calculo_arancel(precio float)
RETURNS float

BEGIN
	DECLARE num_total float;
    
    SET num_total = precio*0.1;
	
    RETURN num_total;
END //
DELIMITER ;

--Llamado
--SELECT calculo_arancel(18200), calculo_arancel(4000), calculo_arancel(463340)

--Función 2:

DELIMITER //

CREATE OR REPLACE FUNCTION ubicacion_puerto(id varchar(11))
RETURNS varchar(50)

BEGIN
	DECLARE localidad varchar(50);
    
    SELECT ubicacion
    INTO localidad
    FROM puertos
    WHERE id_puerto = id;
	
    RETURN localidad;
END //
DELIMITER ;

--Llamado
--SELECT ubicacion_puerto("PSINGAPUR");


----------------------|V Vistas

--Vista 1:

CREATE VIEW navegantes_detenidos AS SELECT n.* FROM (navegantes AS n INNER JOIN embarcaciones AS e ON  n.id_barco=e.id_barco) INNER JOIN inspecciones AS i ON i.id_barco=e.id_barco WHERE i.estado="Denegado";

--Vista 2:

CREATE VIEW edad_navegante AS SELECT id_navegante,nombre,apellido,
IF( MONTH(fecha_nac) > MONTH( CURDATE() )  ,DATEDIFF( CURDATE(),fecha_nac )/365 -1 , DATEDIFF( CURDATE(),fecha_nac )/365  ) AS 'Edad' FROM navegantes;


----------------------V. Usuarios y privilegios

CREATE USER 'main_user'@'localhost' IDENTIFIED BY '1234';
USE divina_concepcion;
GRANT ALL  PRIVILEGES ON * . * TO 'main_user'@'localhost';
FLUSH PRIVILEGES;



CREATE USER 'new_user'@'localhost' IDENTIFIED BY '4321';
USE divina_concepcion;
GRANT SELECT ON * . * TO 'new_user'@'localhost';
FLUSH PRIVILEGES;




----------------------VI Triggers
--Trigger 1:

DELIMITER //
CREATE TRIGGER tr_actualizar_fecha_inspeccion
BEFORE INSERT ON inspecciones
FOR EACH ROW
SET NEW.fecha_inspeccion = CURDATE();
//
DELIMITER ;

--Prueba
--INSERT INTO inspecciones VALUES("GUANGZHOU","BAE521",20231010,"Pendiente",NULL,28200);


--Trigger 2:

DELIMITER //
CREATE TRIGGER tr_eliminar_tuplas_relacionadas
BEFORE DELETE ON embarcaciones
FOR EACH ROW
BEGIN

  DELETE FROM inspecciones WHERE id_barco = OLD.id_barco;

  DELETE FROM navegantes WHERE id_barco = OLD.id_barco;

  DELETE FROM producto WHERE id_barco = OLD.id_barco;


END //
DELIMITER ;

--Prueba
--DELETE FROM embarcaciones WHERE id_barco="AAA111";
