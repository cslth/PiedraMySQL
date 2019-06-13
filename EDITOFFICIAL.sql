CREATE DATABASE EditorialPiedra;
USE EditorialPiedra;
-- DROP DATABASE EditorialPiedra;
CREATE TABLE Sesiones(ses_id int(11) NOT NULL auto_increment primary key,
					  ses_cadena char(32) NOT NULL,
                      ses_inicio datetime NOT NULL,
                      ses_fin datetime,
                      ses_ip varchar(15) NOT NULL,
                      ses_so varchar(255),
                      usr_id int(11) NOT NULL);

CREATE TABLE Usuarios(usr_id int(11) NOT NULL auto_increment primary key,
					  usr_login varchar(255) NOT NULL,
                      usr_pwd char(32) NOT NULL,
                      ses_id int(11) NOT NULL);
                      
CREATE TABLE Roles(rol_id int(11) NOT NULL auto_increment primary key,
                   rol_nombre varchar(255) NOT NULL,
                   ses_id int(11) NOT NULL);
                   
CREATE TABLE Permisos(perm_id int(11) NOT NULL auto_increment primary key,
                      perm_permisos char(10) NOT NULL,
                      perm_fcreacion datetime NOT NULL,
                      ses_id int(11) NOT NULL,
                      rol_id int(11) NOT NULL);
                      
CREATE TABLE Roles_Usuarios(ru_id int(11) NOT NULL auto_increment primary key,
						    ru_fecha datetime NOT NULL,
                            rol_id int(11) NOT NULL,
                            usr_id int(11) NOT NULL,
                            ses_id int(11) NOT NULL);
                            
-- Creacón de sesiones
-- Sesion 1
INSERT INTO Sesiones(ses_cadena, ses_inicio,ses_fin,ses_ip,ses_so,usr_id)
VALUES('sesion1',now(),now(),'localhost','Windows 10',1); 

-- Usuario 1
INSERT INTO Usuarios(usr_login, usr_pwd, ses_id)
VALUES('Administrator','JJS030310',1); 

INSERT INTO Usuarios(usr_login, usr_pwd, ses_id)
VALUES('Chava','12345',1); 

-- Rol
INSERT INTO Roles(rol_nombre,ses_id) 
VALUES('superUser',1);   
 
INSERT INTO Roles(rol_nombre,ses_id) 
VALUES('Empleado',1);    

-- Rol_Usuario
INSERT INTO Roles_Usuarios(ru_fecha,rol_id,usr_id,ses_id)
VALUES(now(),1,1,1);

INSERT INTO Roles_Usuarios(ru_fecha,rol_id,usr_id,ses_id)
VALUES(now(),2,2,1);

-- Permisos del Rol
INSERT INTO Permisos(perm_permisos,perm_fcreacion,ses_id,rol_id)
VALUES('FFFF',now(),1,1);       

INSERT INTO Permisos(perm_permisos,perm_fcreacion,ses_id,rol_id)
VALUES('8008',now(),1,2);  

CREATE TABLE Empleado (ID int(3) NOT NULL AUTO_INCREMENT, 
					   Nombre varchar(255) NOT NULL,
					   email varchar(255) NOT NULL, 
					   Calle varchar(255), 
					   Colonia varchar(255), 
                       CP int(10), 
					   Ciudad varchar(255), 
					   Estado varchar(255), 
					   RFC varchar(255), 
					   FechaNacimiento date NOT NULL,
					   imagenEmpleado varchar(255), -- Tiene que ser null 
					   Sexo bit(1) NOT NULL,
                       ses_id int(11) not null,PRIMARY KEY (ID)) ENGINE=InnoDB;
									
CREATE TABLE Telefonos (EmpleadoID int(3) NOT NULL, 
	                    Telefono varchar(20) NOT NULL,
                        ses_id int(11) not null,
	                    PRIMARY KEY (Telefono)) ENGINE=InnoDB;

CREATE TABLE RedesSociales (EmpleadoID int(3) NOT NULL, 
	                        Cuenta varchar(255) NOT NULL,
                            TipoDeRedSocialID int(10) NOT NULL,
                            ses_id int(11) not null,
	                        PRIMARY KEY (EmpleadoID, Cuenta,TipoDeRedSocialID)) ENGINE=InnoDB;
                                                      
CREATE TABLE TipoDeRedSocial (ID int(3) NOT NULL AUTO_INCREMENT,
							  NombreRedSocial varchar(255) NOT NULL,
                              ses_id int(11) not null,
                              PRIMARY KEY (ID));                            

CREATE TABLE TipoEmpleado (ID int(10) NOT NULL AUTO_INCREMENT, 
	                       NombreTipo varchar(255), 
	                       Descripcion varchar(255),
                           ses_id int(11) not null,
	                       PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Trabajos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                   Descripcion varchar(255), 
	                   Nombre varchar(255), 
                       FechaInicio date not null,
                       FechaFin    date not null, 
	                   TipoTrabajosID int(10) NOT NULL, 
	                   ProyectosID int(10),
                       ses_id int(11) not null, PRIMARY KEY (ID)) ENGINE=InnoDB;
                       
CREATE TABLE Empleado_Trabajos (EmpleadoID int(3) NOT NULL, 
	                            TrabajosID int(10) NOT NULL, 
                                ses_id int(11) not null,
	                            PRIMARY KEY (EmpleadoID, TrabajosID)) ENGINE=InnoDB;
                                
CREATE TABLE TipoTrabajos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                       NombreTipoTrab varchar(255), 
	                       DescripcionTrab varchar(255),
                           ses_id int(11) not null,
	                       PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Proyectos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                    Nombre varchar(255), 
	                    Descripcion varchar(255), 
	                    FechaInicio date, 
	                    FechaFin date, 
	                    Encargado varchar(255),
                        ses_id int(11) not null,
	                    PRIMARY KEY (ID)) ENGINE=InnoDB;
                        
CREATE TABLE Servicios (TipoEmpleadoID int(10) NOT NULL, 
	                    NombreTécnica varchar(255) NOT NULL,
                        ses_id int(11) not null,
	                    PRIMARY KEY (NombreTécnica)) ENGINE=InnoDB;

CREATE TABLE Empleado_TipoEmpleado (EmpleadoID int(3) NOT NULL, 
	                                TipoEmpleadoID int(10) NOT NULL, 
                                    ses_id int(11) not null,
	                                PRIMARY KEY (EmpleadoID, TipoEmpleadoID)) ENGINE=InnoDB;
                                    
CREATE TABLE Ingresos(IngresoID int(10) NOT NULL auto_increment,
					  Concepto text NOT NULL,
                      ses_id int(11) NOT NULL,
                      primary key (IngresoID)) ENGINE = InnoDB;
					
CREATE TABLE Pagos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                numPago tinyint(2) NOT NULL, 
	                GastoID int(10), 
	                Monto int(10) NOT NULL, 
	                PagoProgramadoID int(10), 
	                MetodoID tinyint(2) NOT NULL,
                    FechaPago date not null, 
                    ses_id int(11) not null,
                    IngresoID int(10) NOT NULL,
	                PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Gasto (ID int(10) NOT NULL AUTO_INCREMENT, 
	                Concepto varchar(255),
                    ses_id int(11) not null,
	                PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE PagoProgramado (ID int(10) NOT NULL AUTO_INCREMENT, 
	                         Tipo bit(1) NOT NULL, 
	                         NumTotalPagos tinyint(2) NOT NULL, 
                             ses_id int(11) not null,
	                         PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Pago_Empleado_Trabajos (PagoProgramadoID int(10) NOT NULL, 
	                                 EmpleadoID int(3) NOT NULL, 
	                                 TrabajosID int(10) NOT NULL,
                                     ses_id int(11) not null,
	                                 PRIMARY KEY (PagoProgramadoID, EmpleadoID, TrabajosID)) ENGINE=InnoDB;

CREATE TABLE Metodo (ID tinyint(2) NOT NULL AUTO_INCREMENT, 
	                 Metodo varchar(255) NOT NULL,
                     ses_id int(11) not null,
	                 PRIMARY KEY (ID)) ENGINE=InnoDB;

-- PONER LA SESION EN CADA UNA DE LAS TABLAS (CONSTRAINT)
ALTER TABLE Empleado
ADD CONSTRAINT FKEmpleado_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE Telefonos
ADD CONSTRAINT FKTelefonos_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE RedesSociales
ADD CONSTRAINT FKRedesSociales_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE TipoDeRedSocial
ADD CONSTRAINT FKTipoRedes_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE TipoEmpleado
ADD CONSTRAINT FKTipoEmpleado_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE Trabajos
ADD CONSTRAINT FKTrabajos_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE Empleado_Trabajos 
ADD CONSTRAINT FKEmpTrabajos_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE TipoTrabajos
ADD CONSTRAINT FKTipoTrabajos_Sesiones
FOREIGN KEY(ses_id) REFERENCES Sesiones(ses_id);

ALTER TABLE Proyectos
ADD CONSTRAINT proyectos_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Servicios
ADD CONSTRAINT servicios_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Empleado_TipoEmpleado
ADD CONSTRAINT empleado_tipoempleado_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Pagos
ADD CONSTRAINT pagos_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Pagos
ADD CONSTRAINT ingresos_pagos
foreign key(IngresoID) references Ingresos(IngresoID)
ON DELETE CASCADE;

ALTER TABLE Gasto
ADD CONSTRAINT gasto_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE PagoProgramado 
ADD CONSTRAINT pagoprogramado_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Pago_Empleado_Trabajos
ADD CONSTRAINT pago_empleado_trabajos_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Metodo
ADD CONSTRAINT metodo_ses
foreign key(ses_id) references Sesiones(ses_id);

-- Fin de los constraints de union

ALTER TABLE Sesiones
ADD CONSTRAINT ses_usr
foreign key(usr_id) references Usuarios(usr_id);

ALTER TABLE Usuarios 
ADD CONSTRAINT usr_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Permisos
ADD CONSTRAINT perm_1
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Permisos
ADD CONSTRAINT perm_2
foreign key(rol_id) references Roles(rol_id);

ALTER TABLE Roles
ADD CONSTRAINT rol_ses
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Roles_Usuarios
ADD CONSTRAINT r1
foreign key(rol_id) references Roles(rol_id);

ALTER TABLE Roles_Usuarios
ADD CONSTRAINT r2
foreign key(ses_id) references Sesiones(ses_id);

ALTER TABLE Roles_Usuarios
ADD CONSTRAINT r3
foreign key(usr_id) references Usuarios(usr_id);


ALTER TABLE RedesSociales
ADD CONSTRAINT FKRedSocial74000 
FOREIGN KEY (TipoDeRedSocialID) REFERENCES TipoDeRedSocial (ID);
 
ALTER TABLE Telefonos 
ADD CONSTRAINT FKTelefonos73181 
FOREIGN KEY (EmpleadoID) REFERENCES Empleado (ID)
ON DELETE CASCADE;

ALTER TABLE RedesSociales 
ADD CONSTRAINT FKRedesSocia996356 
FOREIGN KEY (EmpleadoID) REFERENCES Empleado (ID)
ON DELETE CASCADE;

ALTER TABLE Empleado_Trabajos 
ADD CONSTRAINT FKEmpleado_T412432 
FOREIGN KEY (EmpleadoID) REFERENCES Empleado (ID);

ALTER TABLE Empleado_Trabajos 
ADD CONSTRAINT FKEmpleado_T692345 
FOREIGN KEY (TrabajosID) REFERENCES Trabajos (ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Trabajos 
ADD CONSTRAINT FKTrabajos1642 
FOREIGN KEY (TipoTrabajosID) REFERENCES TipoTrabajos (ID);

ALTER TABLE Trabajos 
ADD CONSTRAINT FKTrabajos306403 
FOREIGN KEY (ProyectosID) REFERENCES Proyectos (ID);

ALTER TABLE Servicios 
ADD CONSTRAINT FKServicios846259 
FOREIGN KEY (TipoEmpleadoID) REFERENCES TipoEmpleado (ID);

ALTER TABLE Empleado_TipoEmpleado 
ADD CONSTRAINT FKEmpleado_T830935 
FOREIGN KEY (EmpleadoID) REFERENCES Empleado (ID)
ON DELETE CASCADE;

ALTER TABLE Empleado_TipoEmpleado 
ADD CONSTRAINT FKEmpleado_T656512 
FOREIGN KEY (TipoEmpleadoID) REFERENCES TipoEmpleado (ID)
ON DELETE CASCADE;

ALTER TABLE Pagos 
ADD CONSTRAINT FKPagos501068 
FOREIGN KEY (GastoID) REFERENCES Gasto (ID);

ALTER TABLE Pago_Empleado_Trabajos 
ADD CONSTRAINT FKPago_Emple206669 
FOREIGN KEY (PagoProgramadoID) REFERENCES PagoProgramado (ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Pago_Empleado_Trabajos 
ADD CONSTRAINT FKPago_Emple624837 
FOREIGN KEY (EmpleadoID, TrabajosID) REFERENCES Empleado_Trabajos (EmpleadoID, TrabajosID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Pagos 
ADD CONSTRAINT FKPagos797390 
FOREIGN KEY (PagoProgramadoID) REFERENCES PagoProgramado (ID);

ALTER TABLE Pagos 
ADD CONSTRAINT FKPagos745505 
FOREIGN KEY (MetodoID) REFERENCES Metodo (ID);

-- Inserts por defautl en la BD
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Diseñador','Diseña independientemente del trabajo',1);
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Editor','Edita independientemente del trabajo',1);   
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Fotógrafo','Toma fotos independientemente del trabajo',1);
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Maquetador','Hace maquetas independientemente del trabajo',1);
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Ilustrador','Ilustra independientemente del trabajo',1);
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Imprenta','Se encarga de la impresión independientemente del trabajo',1);   
INSERT INTO TipoEmpleado(NombreTipo,Descripcion,ses_id) VALUES('Publicidad','Se encarga de la publicidad independientemente del trabajo',1);  


INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab,ses_id)
VALUES("Revision", "Revisa el formato completo de un escrito",1);
INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab,ses_id)
VALUES("Dibujo", "Revisa el formato completo de un escrito",1);
INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab,ses_id)
VALUES("Otro", "Revisa el formato completo de un escrito",1);

INSERT INTO TipoDeRedSocial(NombreRedSocial,ses_id)
VALUES("Facebook",1);
INSERT INTO TipoDeRedSocial(NombreRedSocial,ses_id)
VALUES("Instagram",1);
INSERT INTO TipoDeRedSocial(NombreRedSocial,ses_id)
VALUES("Twitter",1);

INSERT INTO Metodo(Metodo,ses_id) VALUES ('Transferencia',1);
INSERT INTO Metodo(Metodo,ses_id) VALUES ('Cheque',1);
INSERT INTO Metodo(Metodo,ses_id) VALUES ('Efectivo',1);

-- Vista
CREATE VIEW TipEmp
AS SELECT ID AS clave, NombreTipo AS NT 
FROM TipoEmpleado;

-- Procedimientos
-- FormularioProgramarPago
DELIMITER ;;
CREATE PROCEDURE insert_Trabajos (des varchar(255), nomb varchar(255), fechaA date,fechaB date,TTID int(10),PID int(10),ses int(11))
BEGIN
	IF(PID > 0) THEN
		INSERT INTO Trabajos (Descripcion,Nombre,FechaInicio,FechaFin,TipoTrabajosID, ProyectosID,ses_id) 
		VALUES(des,nomb,FechaA,FechaB,TTID,PID,ses);
	ELSE 
		INSERT INTO Trabajos (Descripcion,Nombre,FechaInicio,FechaFin,TipoTrabajosID,ses_id) 
		VALUES(des,nomb,FechaA,FechaB,TTID,ses);
	END IF;
END;;
DELIMITER ;

-- registroEmpleado
DELIMITER ;;
CREATE PROCEDURE insert_EmpleadoTipoEmpleado(num int(10),ses int(11))
BEGIN 
    INSERT INTO Empleado_TipoEmpleado VALUES ((SELECT MAX(ID) FROM Empleado), num,ses);
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE insert_Empleado(nombre varchar(255), email varchar(255), calle varchar(255), colonia varchar(255), 
								cp int(10), ciudad varchar(255), estado varchar(255), rfc varchar(255),fechaNac date,
                                sexo bit(1),ses int(11))
BEGIN 
    INSERT INTO Empleado(Nombre,email,Calle,Colonia,CP,Ciudad,Estado,RFC,FechaNacimiento,Sexo,ses_id) 
    VALUES(nombre,email,calle,colonia,cp,ciudad,estado,rfc,fechaNac,sexo,ses);
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE insert_Telefonos( telefono varchar(20),ses int(11))
BEGIN
	INSERT INTO Telefonos VALUES((SELECT MAX(ID) FROM Empleado),telefono,ses);
END;;
DELIMITER ;
-- FormularioPago
DELIMITER ;;
CREATE PROCEDURE delete_Pagos(IN idPP int(11))
BEGIN
	DELETE FROM Pagos WHERE ID = idPP;
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE update_PagosMonto(IN monto int(10), IN metodoID int(10), IN id int(10), ses int(11))
BEGIN
	UPDATE Pagos SET Monto = monto, MetodoID = metodoID, ses_id = ses WHERE ID = id;
END;;
DELIMITER ;

-- Empleados
DELIMITER //
CREATE PROCEDURE delete_Empleado (IN empleadoID int(10))
BEGIN
DELETE FROM Empleado WHERE ID = empleadoID;
END//
DELIMITER ;

-- EdicionEmpleados
DELIMITER //
CREATE PROCEDURE update_EdicionEmpleado (nombre varchar(255), email varchar(255), calle varchar(255), colonia varchar(255), cp int(10), ciudad varchar(255), 
											estado varchar(255), rfc varchar(255), fechaNac varchar(255), sexo int(10), f1 int(10),ses int(11))
BEGIN
UPDATE Empleado SET Nombre = nombre, email = email, Calle = calle, Colonia = colonia, CP = cp, Ciudad = ciudad, Estado = estado, RFC = rfc, 
	FechaNacimiento = fechaNac, Sexo = sexo, ses_id = ses
		WHERE ID = f1;
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE delete_EdicionEmpleado (IN f1 int(10))
BEGIN
DELETE FROM Telefonos WHERE EmpleadoID = f1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insertTel_EdicionEmpleado (IN f1 int(10), tel varchar (20),ses int(11))
BEGIN
INSERT INTO Telefonos VALUES(f1, tel,ses);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_e_te (IN f1 int(10), tipo int(10),ses int(11))
BEGIN
INSERT INTO Empleado_TipoEmpleado VALUES((SELECT ID FROM Empleado WHERE ID = f1), tipo,ses);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE delete_RedesSociales (IN f1 int(10))
BEGIN
DELETE FROM RedesSociales WHERE EmpleadoID = f1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_RedesSociales (IN f1 int(10), tabla varchar(255), id int (10), ses int(11))
BEGIN
INSERT INTO RedesSociales VALUES (f1, tabla, id, ses);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE delete_e_te (IN f1 int(10))
BEGIN
DELETE FROM Empleado_TipoEmpleado WHERE EmpleadoID = f1;
END//
DELIMITER ;
CALL delete_e_te(10);

-- Metodos reportes
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION renglonesGR (fechaA DATE, fechaB DATE) RETURNS INT
BEGIN
	SET @total = 0;                
SELECT COUNT(*) INTO @total
	FROM Pagos AS p INNER JOIN Gasto as g ON (g.ID = p.GastoID)
    WHERE p.gastoID IS NOT NULL AND p.FechaPago BETWEEN fechaA AND fechaB;
RETURN @total;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION totalGR (fechaA DATE, fechaB DATE) RETURNS INT
BEGIN
	SET @total = 0;
	SELECT SUM(p.Monto) INTO @total
				FROM Pagos AS p INNER JOIN Metodo AS m ON(m.ID = p.MetodoID)
				INNER JOIN Gasto AS g ON(g.ID = p.GastoID)
				WHERE p.GastoID IS NOT NULL
				AND p.FechaPago BETWEEN fechaA AND fechaB;
	RETURN @total;
END//
DELIMITER ;

-- Triggers
DELIMITER ;;
CREATE TRIGGER edadEmpleado
BEFORE INSERT ON Empleado FOR EACH ROW 
BEGIN
	IF(TIMESTAMPDIFF(YEAR, NEW.FechaNacimiento, CURDATE()) < 15) THEN
		SIGNAL SQLSTATE '45000';
    END IF;
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER crearProyecto
BEFORE INSERT ON Proyectos FOR EACH ROW 
BEGIN
	IF(TIMESTAMPDIFF(DAY, NEW.FechaInicio, NEW.FechaFin) < 1) THEN
		SIGNAL SQLSTATE '45000';
    END IF;
END;;
DELIMITER ;



-- Consultas
SELECT * FROM Telefonos;
SELECT * FROM Empleado;
SELECT * FROM RedesSociales;
SELECT * FROM Sesiones;
SELECT * FROM Empleado;
SELECT *  FROM Trabajos;
SELECT * FROM Empleado_Trabajos;
SELECT * FROM Empleado_TipoEmpleado;
SELECT * FROM Pagos;
SELECT * FROM Proyectos;