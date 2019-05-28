CREATE DATABASE EditorialPiedra;
USE EditorialPiedra;

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
VALUES('Administrator','hf6LJr9X$b9RMCJJ+gU5HpCqHh_XG6U_',1); 

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
					   imagenEmpleado varchar(255)  NOT NULL, -- Tiene que ser null 
					   Sexo bit(1) NOT NULL, PRIMARY KEY (ID)) ENGINE=InnoDB;
									
CREATE TABLE Telefonos (EmpleadoID int(3) NOT NULL, 
	                    Telefono varchar(20) NOT NULL, 
	                    PRIMARY KEY (Telefono)) ENGINE=InnoDB;

CREATE TABLE RedesSociales (EmpleadoID int(3) NOT NULL, 
	                        Cuenta varchar(255) NOT NULL,
                            TipoDeRedSocialID int(10) NOT NULL,
	                        PRIMARY KEY (EmpleadoID, Cuenta,TipoDeRedSocialID)) ENGINE=InnoDB;
                                                      
CREATE TABLE TipoDeRedSocial (ID int(3) NOT NULL AUTO_INCREMENT,
							  NombreRedSocial varchar(255) NOT NULL,
                              PRIMARY KEY (ID));                            

CREATE TABLE TipoEmpleado (ID int(10) NOT NULL AUTO_INCREMENT, 
	                       NombreTipo varchar(255), 
	                       Descripcion varchar(255), 
	                       PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Trabajos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                   Descripcion varchar(255), 
	                   Nombre varchar(255), 
	                   TiempoEntrega int(10), 
                       FechaEntrega date,
	                   TipoTrabajosID int(10) NOT NULL, 
	                   ProyectosID int(10), PRIMARY KEY (ID)) ENGINE=InnoDB;
CREATE TABLE Empleado_Trabajos (EmpleadoID int(3) NOT NULL, 
	                            TrabajosID int(10) NOT NULL, 
	                            PRIMARY KEY (EmpleadoID, TrabajosID)) ENGINE=InnoDB;
                                
CREATE TABLE TipoTrabajos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                       NombreTipoTrab varchar(255), 
	                       DescripcionTrab varchar(255), 
	                       PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Proyectos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                    Nombre varchar(255), 
	                    Descripcion varchar(255), 
	                    FechaInicio date, 
	                    FechaFin date, 
	                    Encargado varchar(255), 
	                    PRIMARY KEY (ID)) ENGINE=InnoDB;
                        
CREATE TABLE Servicios (TipoEmpleadoID int(10) NOT NULL, 
	                    NombreTécnica varchar(255) NOT NULL, 
	                    PRIMARY KEY (NombreTécnica)) ENGINE=InnoDB;

CREATE TABLE Empleado_TipoEmpleado (EmpleadoID int(3) NOT NULL, 
	                                TipoEmpleadoID int(10) NOT NULL, 
	                                PRIMARY KEY (EmpleadoID, TipoEmpleadoID)) ENGINE=InnoDB;

CREATE TABLE Pagos (ID int(10) NOT NULL AUTO_INCREMENT, 
	                numPago tinyint(2) NOT NULL, 
	                GastoID int(10), 
	                Monto int(10) NOT NULL, 
	                PagoProgramadoID int(10), 
	                MetodoID tinyint(2) NOT NULL,
                    FechaPago date not null, 
	                PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Gasto (ID int(10) NOT NULL AUTO_INCREMENT, 
	                Concepto varchar(255), 
	                PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE PagoProgramado (ID int(10) NOT NULL AUTO_INCREMENT, 
	                         Tipo bit(1) NOT NULL, 
	                         NumTotalPagos tinyint(2) NOT NULL, 
	                         PRIMARY KEY (ID)) ENGINE=InnoDB;

CREATE TABLE Pago_Empleado_Trabajos (PagoProgramadoID int(10) NOT NULL, 
	                                 EmpleadoID int(3) NOT NULL, 
	                                 TrabajosID int(10) NOT NULL, 
	                                 PRIMARY KEY (PagoProgramadoID, EmpleadoID, TrabajosID)) ENGINE=InnoDB;

CREATE TABLE Metodo (ID tinyint(2) NOT NULL AUTO_INCREMENT, 
	                 Metodo varchar(255) NOT NULL, 
	                 PRIMARY KEY (ID)) ENGINE=InnoDB;


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
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Diseñador','Diseña independientemente del trabajo');
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Editor','Edita independientemente del trabajo');   
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Fotografo','Toma fotos independientemente del trabajo');
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Maquetador','Hace maquetas independientemente del trabajo');
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Ilustrador','Ilustra independientemente del trabajo');
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Imprenta','Se encarga de la impresión independientemente del trabajo');   
INSERT INTO TipoEmpleado(NombreTipo,Descripcion) VALUES('Publicidad','Se encarga de la publicidad independientemente del trabajo');  


INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab)
VALUES("Revision", "Revisa el formato completo de un escrito");
INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab)
VALUES("Dibujo", "Revisa el formato completo de un escrito");
INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab)
VALUES("Otro", "Revisa el formato completo de un escrito");

INSERT INTO TipoDeRedSocial(NombreRedSocial)
VALUES("Facebook");
INSERT INTO TipoDeRedSocial(NombreRedSocial)
VALUES("Instagram");
INSERT INTO TipoDeRedSocial(NombreRedSocial)
VALUES("Twitter");

INSERT INTO Metodo(Metodo) VALUES ('Transferencia');
INSERT INTO Metodo(Metodo) VALUES ('Cheque');
INSERT INTO Metodo(Metodo) VALUES ('Efectivo');

-- Vista
CREATE VIEW TipEmp
AS SELECT ID AS clave, NombreTipo AS NT 
FROM TipoEmpleado;

-- Consultas
SELECT * FROM Telefonos;
SELECT * FROM Empleado;
SELECT * FROM RedesSociales;
SELECT * FROM Sesiones;

-- Procedimientos almacenados



-- Tipo de trabajo
DELIMITER ;;
CREATE PROCEDURE insert_TipoTrabajo(IN nombre varchar(255), IN descripcion varchar(255))
BEGIN
	INSERT INTO TipoTrabajos (NombreTipoTrab,DescripcionTrab) VALUES(nombre,descripcion);
END;;

-- Utilidades
CREATE PROCEDURE delete_TipoDeRedSocial(IN id int(11))
BEGIN
	DELETE FROM TipoDeRedSocial WHERE ID = id;
END;; 

CREATE PROCEDURE delete_TipoTrabajos(IN id int(11))
BEGIN
	DELETE FROM TipoTrabajos WHERE ID = id;
END;;

-- VisuaTrabajos
CREATE PROCEDURE update_Trabajos(nombre varchar(255), descripcion varchar(255),tiposTrabajosID int(11), tiempoEntrega int(10), idTrab int(11))
BEGIN
	UPDATE Trabajos SET Nombre = nombre ,Descripcion = descripcion ,TipoTrabajosID = tiposTrabajosID, TiempoEntrega = tiempoEntrega,
								FechaEntrega = adddate(CURDATE(),tiempoEntrega) WHERE ID = idTrab;
END;;

CREATE PROCEDURE update_ProyID(IN idProy int(11), IN idTrab int(11))
BEGIN
	UPDATE Trabajos SET ProyectosID = idProy WHERE ID = idTrab;
END;;

CREATE PROCEDURE update_ProyIDNulo(IN idProy int(11), IN idTrab int(11))
BEGIN
	UPDATE Trabajos SET ProyectosID = null WHERE ID = idTrab;
END;;

-- FormularioPago
CREATE PROCEDURE delete_Pagos(IN idPP int(11))
BEGIN
	DELETE FROM Pagos WHERE ID = idPP;
END;;

CREATE PROCEDURE delete_Gasto(IN idG int(11))
BEGIN
	DELETE FROM Gasto WHERE ID = idG;
END;;

CREATE PROCEDURE update_NumTotalPagos(IN idPP int(11))
BEGIN
	UPDATE PagoProgramado SET NumTotalPagos = NumTotalPagos-1 WHERE ID = idPP;
END;;

CREATE PROCEDURE update_NumTotalPagos2(IN id int(11))
BEGIN
	UPDATE PagoProgramado SET NumTotalPagos = NumTotalPagos+1 WHERE ID = id;
END;;

CREATE PROCEDURE update_PagosMonto(IN monto int(10), IN metodoID int(10), IN id int(10))
BEGIN
	UPDATE Pagos SET Monto = monto, MetodoID = metodoID WHERE ID = id;
END;;

CREATE PROCEDURE update_Concepto(IN concepto varchar(255), IN idPP int(10))
BEGIN
	UPDATE Gasto SET Concepto = concepto WHERE ID = idPP;
END;;

CREATE PROCEDURE insert_Pagos(numPago tinyint(2), Monto INT(10), PagoProgramadoID INT(10), MetodoID INT(10))
BEGIN
	INSERT INTO Pagos (numPago, Monto, PagoProgramadoID, MetodoID, FechaPago) VALUES (numPago,Monto,PagoProgramadoID,MetodoID,CURDATE());
END;;

CREATE PROCEDURE insert_Pagos2(Monto INT(10), GastoID INT(10), MetodoID INT(10))
BEGIN
	INSERT INTO Pagos (numPago, Monto, GastoID, MetodoID, FechaPago) VALUES (1,Monto,GastoID,MetodoID,CURDATE());
END;;

CREATE PROCEDURE insert_Gastos(IN concepto varchar(255))
BEGIN
	Insert into Gasto(Concepto) Values (concepto);
END;;


CREATE PROCEDURE update_TipoTrabajo(IN nombre varchar(255), IN descripcion varchar(255), IN id int(11))
BEGIN
	UPDATE TipoTrabajos SET NombreTipoTrab = nombre.Text, DescripcionTrab = descripcion WHERE ID = id;
END;;

CREATE PROCEDURE update_Desc_TipoTrabajo(IN descripcion varchar(255), IN id int(11))
BEGIN
	UPDATE TipoTrabajos SET DescripcionTrab = descripcion WHERE ID = id;
END;;

-- VisuaProyecto
CREATE PROCEDURE insert_Proyectos(nombre varchar(255),descripcion varchar(255),fechaInicio date, fechaFin date, encargado varchar(255))
BEGIN
	INSERT INTO Proyectos(Nombre,Descripcion,FechaInicio, FechaFin, Encargado ) 
				VALUES(nombre,descripcion,fechaInicio,fechaFin,encargado);
END;;

CREATE PROCEDURE update_Proyectos(nombre varchar(255),descripcion varchar(255),fechaInicio date, fechaFin date, encargado varchar(255), idProy int(11))
BEGIN 
	UPDATE Proyectos SET Nombre = nombre , Descripcion = descripcion ,FechaInicio = fechaInicio, FechaFin = fechaFin ,Encargado = encargado WHERE ID = idProy;
END;;

CREATE PROCEDURE delete_Proyectos(IN idProy int(11))
BEGIN
	DELETE FROM Proyectos WHERE ID = idProy;
END;;

    


