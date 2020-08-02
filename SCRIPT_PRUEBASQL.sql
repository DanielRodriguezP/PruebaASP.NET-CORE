CREATE DATABASE SCRIPPRUEBA
GO

USE SCRIPPRUEBA
GO

----------------------PRUEBA SQL------------------------------------

---------------SCRIPT 1--------------------------------------------------------
CREATE TABLE CIUDAD(
ID INT  PRIMARY KEY NOT NULL,
NOMBRE CHAR(20) NOT NULL,
)
GO

CREATE TABLE CLIENTE(
ID INT PRIMARY KEY NOT NULL,
PRIMER_NOMBRE VARCHAR(20),
PRIMER_APELLIDO VARCHAR(30),
DIAS_MORA INT NOT NULL,
ID_CIUDAD INT NOT NULL
)
GO

ALTER TABLE CLIENTE
ADD FOREIGN KEY (ID_CIUDAD) REFERENCES CIUDAD(ID);
GO

INSERT INTO CIUDAD VALUES(1,'Medellin')
INSERT INTO CIUDAD VALUES(2,'Cali')
INSERT INTO CIUDAD VALUES(3,'Bogota')
GO

INSERT INTO CLIENTE VALUES(1,'Daniel','Rodriguez',2,1)
INSERT INTO CLIENTE VALUES(2,'Juan','Pulido',25,2)
INSERT INTO CLIENTE VALUES(3,'Shirly','Bedoya',38,3)
GO

SELECT CL.ID as cedula, CL.PRIMER_NOMBRE + ' ' + CL.PRIMER_APELLIDO AS nombre, CL.DIAS_MORA as diasEnMora, 
IIF(DIAS_MORA > 1 and DIAS_MORA < 20,'Riesgo Bajo', 
IIF(DIAS_MORA > 21 AND DIAS_MORA <35,'Riesgo Medio',
IIF(DIAS_MORA > 35,'Riesgo Alto','Por fuera de los intervalos'))) as riesgo, CI.NOMBRE as ciudad
FROM CIUDAD CI INNER JOIN CLIENTE CL ON CI.ID = CL.ID_CIUDAD 
ORDER BY CL.DIAS_MORA

-------------SCRIPT 2-----------------------------------------------------------------------

CREATE TABLE SUCURSAL(
ID INT PRIMARY KEY NOT NULL,
NOMBRE VARCHAR(20) NOT NULL
)
GO
CREATE TABLE COTIZACION(
ID INT PRIMARY KEY NOT NULL,
VALOR_POLIZA_IVA_INCLUIDO DECIMAL NOT NULL,
VALOR_POLIZA INT NOT NULL,
VALOR_POLIZA_CUOTA DECIMAL NOT NULL,
ID_SUCURSAL INT NOT NULL
)
GO

ALTER TABLE COTIZACION
ADD FOREIGN KEY(ID_SUCURSAL) REFERENCES SUCURSAL(ID)

INSERT INTO SUCURSAL VALUES(1,'BANCOLOMBIA');
INSERT INTO SUCURSAL VALUES(2,'BBVA');
INSERT INTO COTIZACION VALUES(234,2000,1000,3000,1);
INSERT INTO COTIZACION VALUES(346,3466,1000,3000,2);
INSERT INTO COTIZACION VALUES(634,2030,1000,3000,1);

SELECT  S.NOMBRE as sucursal, CAST(((VALOR_POLIZA_IVA_INCLUIDO / 12) * VALOR_POLIZA_CUOTA) as INT) as ValorTotalPagado 
FROM COTIZACION C 
INNER JOIN SUCURSAL S on S.ID = C.ID_SUCURSAL 
ORDER BY  ValorTotalPagado

--------------------SCRIPT 3---------------------------------------------------------------------

CREATE TABLE PERSONA(
CC INT PRIMARY KEY NOT NULL,
NOMBRE VARCHAR(20) NOT NULL,
APELLIDO VARCHAR(20) NOT NULL
)
GO

CREATE TABLE ESTUDIOS(
ID INT PRIMARY KEY NOT NULL,
INSTITUCION VARCHAR(40) NOT NULL,
FECHA DATETIME NOT NULL,
FKPERSONA INT NOT NULL
)
GO

ALTER TABLE ESTUDIOS
ADD FOREIGN KEY(FKPERSONA) REFERENCES PERSONA(CC)
GO

INSERT INTO PERSONA VALUES(123242,'DANIEL','RODRIGUEZ');
INSERT INTO PERSONA VALUES(346364,'JUAN','PULIDO');
INSERT INTO ESTUDIOS VALUES(45744,'LA CANDELARIA','01-01-2000',123242);
INSERT INTO ESTUDIOS VALUES(3475,'LA CANDELARIA','01-01-2000',123242);
INSERT INTO ESTUDIOS VALUES(34734,'LA CANDELARIA','01-01-2000',346364);
INSERT INTO ESTUDIOS VALUES(24652,'INEM','2020-04-30',123242);


SELECT  e.FKPERSONA as CC, p.NOMBRE as Nombre, e.INSTITUCION as Institucion,
       MAX(FECHA) Fecha
FROM ESTUDIOS e inner join PERSONA p on e.FKPERSONA = p.CC
GROUP BY e.FKPERSONA, p.NOMBRE, e.INSTITUCION, e.FECHA

------------SCRIPT 4-------------------------------------------------------------------

CREATE TABLE EMPLEADOS(
CC INT NOT NULL PRIMARY KEY,
NOMBRE VARCHAR(50),
CARGO VARCHAR(50),
AREA VARCHAR(50),
IDJEFE INT,
CONSTRAINT JEFE_FK FOREIGN KEY (IDJEFE) REFERENCES EMPLEADOS(CC)
);

INSERT INTO EMPLEADOS VALUES(235235,'DANIEL','SUPERVISOR','FABRICA',235235)
INSERT INTO EMPLEADOS VALUES(3673346,'JUAN','JEFE','TALENTO HUMANO',235235)
INSERT INTO EMPLEADOS VALUES(45735,'PEDRO','GERENTE','GOBIERNO TI',235235)

SELECT E.CC, E.NOMBRE, E.CARGO, E.AREA, J.NOMBRE AS NOMBRE_JEFE 
FROM EMPLEADOS E INNER JOIN EMPLEADOS J ON  E.IDJEFE = J.CC