-- DROP database editorialpiedra;
CREATE DATABASE EditorialPiedra;
USE EditorialPiedra;

CREATE TABLE Sesiones(ses_id int(11) NOT NULL auto_increment primary key,
					  ses_cadena char(32) NOT NULL,
                      ses_inicio datetime NOT NULL,
                      ses_ultima_actividad datetime NOT NULL,
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
                            
INSERT INTO Sesiones(ses_cadena, ses_inicio, ses_ultima_actividad,ses_fin,ses_ip,ses_so,usr_id)
VALUES('ses1',now(),now(),now(),'localhost','Windows 10',1);    

INSERT INTO Usuarios(usr_login, usr_pwd, ses_id)
VALUES('Administrator','hf6LJr9X$b9RMCJJ+gU5HpCqHh_XG6U_',1); 

SELECT usr_login FROM Usuarios WHERE usr_login = 'Administrator';
SELECT usr_pwd FROM Usuarios WHERE usr_login = 'Administrator';
SELECT * FROM Usuarios;
SELECT * FROM Sesiones;

ALTER TABLE Sesiones
DROP ses_ultima_actividad;

SELECT creado.usr_login AS 'Cuenta creada',	
       creador.usr_login AS 'Creador' 
       FROM usuarios AS creado
       INNER JOIN sesiones AS ses ON(creado.ses_id = ses.ses_id)
       INNER JOIN usuarios AS creador ON (ses.usr_id = creador.usr_id)
       WHERE creador.usr_id = (SELECT creador.usr_id
       FROM usuarios AS creado
       INNER JOIN sesiones AS ses ON(creado.ses_id = ses.ses_id)
       INNER JOIN usuarios AS creador ON (ses.usr_id = creador.usr_id)
       GROUP BY creador.usr_login
       ORDER BY COUNT(*) DESC
       LIMIT 2,1);

SELECT MAX(ses_id) AS SES_ID FROM Sesiones WHERE usr_id = (SELECT usr_id FROM Usuarios WHERE usr_login = 'Administrator');

INSERT INTO Roles(rol_nombre,ses_id) 
VALUES('superUser',1);      

INSERT INTO Roles_Usuarios(ru_fecha,rol_id,usr_id,ses_id)
VALUES(now(),1,1,1);

INSERT INTO Permisos(perm_permisos,perm_fcreacion,ses_id,rol_id)
VALUES('FFFF',now(),1,1);       

UPDATE Sesiones
SET ses_fin = now()
WHERE ses_id = 1
and usr_id = 1;   

UPDATE Sesiones
SET ses_fin = null
WHERE ses_id = 1
and usr_id = 1;          

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
					
-- Select * from Empleado;
                       

CREATE TABLE Telefonos (EmpleadoID int(3) NOT NULL, 
	                    Telefono varchar(20) NOT NULL, 
	                    PRIMARY KEY (Telefono)) ENGINE=InnoDB;

CREATE TABLE RedesSociales (EmpleadoID int(3) NOT NULL, 
	                        Cuenta varchar(255) NOT NULL,
                            TipoDeRedSocialID int(10) NOT NULL,
	                        PRIMARY KEY (TipoDeRedSocialID, Cuenta)) ENGINE=InnoDB;
                            
-- DROP TABLE RedesSociales;                            
                            
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

  INSERT INTO Empleado (Nombre,email,Calle,Colonia,Ciudad,Estado,RFC,FechaNacimiento,imagenEmpleado,Sexo) 
  VALUES ("Salvador Santos","chava@gmail.com","triana","triana", 
  "Torreon","Coahuila","MESS981016",'1998/03/03', "En el disco local D ",1);
  
  INSERT INTO Empleado (Nombre,email,Calle,Colonia,CP,Ciudad,Estado,RFC,FechaNacimiento,imagenEmpleado,Sexo) 
  VALUES ("Prueba","prueba@gmail.com","triana","triana",1234, 
  "Torreon","Coahuila","MESS981016",'1998/03/03', "En el disco local D ",1);
  
  INSERT INTO Empleado (Nombre,email,Calle,Colonia,Ciudad,Estado,RFC,FechaNacimiento,imagenEmpleado,Sexo) 
  VALUES ("Javier Eluney","eluney@gmail.com","Desierto de arizona 65-11","Santa elena", 
  "Torreon","Coahuila","MESS981016",'1998/03/10', "En el disco local C ",0);
  
INSERT INTO Empleado (Nombre,email,Calle,Colonia,Ciudad,Estado,RFC,FechaNacimiento,imagenEmpleado,Sexo) 
  VALUES ("Josue Romero","josue@gmail.com","Desierto de arabia 67-12","Santa elena", 
  "Torreon","Coahuila","MESS981016",'1998/03/03', "En el disco local D ",1);
  
 INSERT INTO Telefonos
VALUES(1,'8713321074');  

INSERT INTO Telefonos
VALUES(1,'8713321045');  

INSERT INTO Telefonos
VALUES(1,'8713321099');

INSERT INTO Telefonos
VALUES(2,'8713321555');  

INSERT INTO Telefonos
VALUES(3,'56736576');

INSERT INTO Telefonos
VALUES((SELECT MAX(ID) from Empleado),'654565465'); 
  
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


 /*
 SELECT imagenEmpleado FROM Empleado;
 
 SELECT * FROM Empleado;
 
 
 DELETE FROM Empleado ORDER BY ID DESC LIMIT 1;
 
 SELECT * FROM Empleado;
 SELECT * FROM Telefonos;
 SELECT * FROM RedesSociales;
 SELECT * FROM Empleado_TipoEmpleado;
 
 SELECT * FROM TipoEmpleado;
 
 SELECT tp.NombreTipo FROM TipoEmpleado AS tp
 INNER JOIN Empleado_TipoEmpleado AS tpe ON(tpe.TipoEmpleadoID = tp.ID)
 INNER JOIN Empleado AS e ON(tpe.EmpleadoID = e.ID)
 WHERE e.ID = 59;
 
 UPDATE Empleado
 SET
	Nombre = "Lel",
    Calle = "lol"
 WHERE ID = 59;   
 
 
 SELECT * FROM Empleado;
 SELECT * FROM Telefonos;
 SELECT * FROM RedesSociales;
 
 SELECT tr.NombreRedSocial, r.Cuenta FROM TipoDeRedSocial as tr
 INNER JOIN RedesSociales AS r ON(r.TipoDeRedSocialID = tr.ID)
 INNER JOIN Empleado AS emp ON(emp.ID = r.EmpleadoID)
 WHERE emp.ID = 59;
 
 SELECT ID FROM TipoDeRedSocial WHERE NombreRedSocial = 'Facebook';
 
 SELECT tr.ID FROM TipoDeRedSocial AS tr
 INNER JOIN RedesSociales AS r ON(tr.ID = r.TipoDeRedSocialID)
 WHERE tr.NombreRedSocial = 'Instagram';
 
 INSERT INTO RedesSociales
 VALUES(61,'hvg',1);
 
 SELECT * FROM TipoDeRedSocial;

DELETE FROM Empleado_TipoEmpleado WHERE EmpleadoID = 40;

DELETE FROM RedesSociales WHERE EmpleadoID = 59;

DELETE FROM RedesSociales 
WHERE EmpleadoID = (SELECT MAX(ID) FROM Empleado);

DELETE FROM Telefonos 
WHERE EmpleadoID = (SELECT MAX(ID) FROM Empleado);

-- DROP DATABASE editorialpiedra; */
