-- Creación de las tablas

CREATE TABLE SOCIOS (
DNI VARCHAR2(9),
Nombre VARCHAR2(20),
Direccion VARCHAR2(20),
Telefono VARCHAR2(9),
email VARCHAR2(20),
CONSTRAINT pk_socios PRIMARY KEY (DNI),
CONSTRAINT nn_Nombre CHECK (Nombre IS NOT NULL),
CONSTRAINT ck_dni_socios CHECK (REGEXP_LIKE (DNI, '^[0-9]{8}[A-Z]{1}')),
CONSTRAINT ck_telefono CHECK (REGEXP_LIKE (Telefono, '^[0-9]{9}'))
);

CREATE TABLE PENALIZACIONES (
Fecha_penalizacion DATE,
DNISocioP VARCHAR2(9),
Observacion VARCHAR2(1000),
CONSTRAINT pk_penalizaciones PRIMARY KEY (Fecha_penalizacion, DNISocioP),
CONSTRAINT fk_penalizaciones_socios FOREIGN KEY (DNISocioP) REFERENCES SOCIOS(DNI),
CONSTRAINT ck_fechapenalizaciones CHECK (TO_CHAR(Fecha_penalizacion, 'MM') NOT BETWEEN '01' AND '02')
);


CREATE TABLE LIBROS (
ISBN VARCHAR2(17),
Titulo VARCHAR2(30),
Genero VARCHAR2(10),
AnioPublicacion NUMBER(4),
Editorial VARCHAR2(10),
CONSTRAINT pk_libros PRIMARY KEY (ISBN),
CONSTRAINT nn_Titulo CHECK(Titulo IS NOT NULL),
CONSTRAINT ck_mayusculas_editorial CHECK (UPPER(Editorial) = Editorial)
);


CREATE TABLE EJEMPLARES (
Cod_ejemplar VARCHAR2(9),
ISBNLibroE VARCHAR2(17),
CONSTRAINT pk_ejemplares PRIMARY KEY (Cod_ejemplar),
CONSTRAINT fk_ejemplares_libros FOREIGN KEY (ISBNLibroE) REFERENCES LIBROS(ISBN)
);


CREATE TABLE AUTOR ( 
Nombre_autor VARCHAR2(40),
FechaNac DATE,
Nacionalidad VARCHAR2(15),
CONSTRAINT pk_autor PRIMARY KEY (Nombre_autor),
CONSTRAINT nn_FechaNac CHECK (FechaNac IS NOT NULL),
CONSTRAINT ck_FechaNac CHECK (TO_CHAR(FechaNac, 'YYYY') > '1900')
);

CREATE TABLE LIBRO_AUTOR (
N_Autor VARCHAR2(40),
ISBN_Libro VARCHAR2(17),
CONSTRAINT pk_libro_autor PRIMARY KEY (N_Autor, ISBN_Libro),
CONSTRAINT fk_libro_autor_autor FOREIGN KEY (N_Autor) REFERENCES AUTOR(Nombre_autor),
CONSTRAINT fk_libro_autor_libro FOREIGN KEY (ISBN_Libro) REFERENCES LIBROS(ISBN)
);


CREATE TABLE EMPLEADOS (
DNI VARCHAR2(9),
Nombre VARCHAR2(30),
FechaNac DATE,
Direccion VARCHAR2(50),
Genero VARCHAR2(1),
CONSTRAINT pk_empleados PRIMARY KEY (DNI),
CONSTRAINT ck_Nombre_empleado CHECK (INITCAP(Nombre) = Nombre),
CONSTRAINT uk_empleados UNIQUE (Direccion),
CONSTRAINT ck_genero_empleado CHECK (Genero IN ('M', 'F')),
CONSTRAINT ck_dni_empleados CHECK (REGEXP_LIKE(DNI, '^[0-9]{8}[A-Z]{1}'))
);


CREATE TABLE PROOVEDORES (
CIF VARCHAR2(9),
Nombre VARCHAR2(30),
Telefono VARCHAR2(9),
Email VARCHAR2(40),
CONSTRAINT pk_proovedores PRIMARY KEY (CIF),
CONSTRAINT nn_Nombre_proovedor CHECK (Nombre IS NOT NULL),
CONSTRAINT uk_proovedores UNIQUE (Telefono),
CONSTRAINT ck_telefono_proovedor CHECK (REGEXP_LIKE(Telefono, '^[9]{1}[0-9]{8}'))
);


CREATE TABLE PRESTAMOS (
FechaPrestamo DATE,
DNI_Socio VARCHAR2(9),
Cod_ejemplarP VARCHAR2(9),
DNI_empP VARCHAR2(9),
FechaDevolucion DATE,
CONSTRAINT pk_prestamos PRIMARY KEY (FechaPrestamo, DNI_Socio, Cod_ejemplarP),
CONSTRAINT fk_prestamos_socios FOREIGN KEY (DNI_Socio) REFERENCES SOCIOS(DNI),
CONSTRAINT fk_prestamos_ejemplares FOREIGN KEY (Cod_ejemplarP) REFERENCES EJEMPLARES(Cod_ejemplar),
CONSTRAINT fk_prestamos_empleados FOREIGN KEY (DNI_empP) REFERENCES EMPLEADOS(DNI),
CONSTRAINT nn_FechaDevolucion CHECK (FechaDevolucion IS NOT NULL),
CONSTRAINT ck_fechadevolucion CHECK (FechaDevolucion > FechaPrestamo)
);


CREATE TABLE PROOV (
Fecha_proov DATE,
CIF_Pr VARCHAR2(9),
ISBN_LibroPr VARCHAR2(17),
Cantidad NUMBER(9) DEFAULT 1,
CONSTRAINT pk_proov PRIMARY KEY (Fecha_proov, CIF_Pr, ISBN_LibroPr),
CONSTRAINT fk_proov_proovedores FOREIGN KEY (CIF_Pr) REFERENCES PROOVEDORES(CIF),
CONSTRAINT fk_proov_libros FOREIGN KEY (ISBN_LibroPr) REFERENCES LIBROS(ISBN),
CONSTRAINT nn_Cantidad CHECK (Cantidad IS NOT NULL)
);


--+----------------------------------------------------------------------------------+--
--Añade las siguientes restricciones, una vez creadas las tablas:

-- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(6) con dos decimales.
ALTER TABLE EMPLEADOS ADD Sueldo NUMBER(6,2);

-- Añade la columna Direccion en la tabla PROOVEDORES, Cadena de caracterese de longitud 50.
ALTER TABLE PROOVEDORES ADD Direccion VARCHAR2(50);

-- Añade la columna Fecha_nacimiento en la tabla SOCIOS, de tipo Fecha.
ALTER TABLE SOCIOS ADD Fecha_nacimiento DATE;

-- Añade la columna tipo en la tabla EMPLEADOS, Cadena de caracteres.
ALTER TABLE EMPLEADOS ADD tipo VARCHAR2(15);

-- Modifica la columna tipo en la tabla EMPLEADOS y pon por defecto 'TEMPORAL'.
ALTER TABLE EMPLEADOS MODIFY (tipo DEFAULT 'TEMPORAL');

-- Modifica la columna Observacion de la tabla PENALIZACIONES reduciendola a 500 caracteres.
ALTER TABLE PENALIZACIONES MODIFY (Observacion VARCHAR2(500));

-- Elimina la columna email de la tabla SOCIOS.
ALTER TABLE SOCIOS DROP COLUMN email;

-- La Nacionalidad de los autores estará comprendida entre las siguientes: Española, Francesa, Italiana, Americana, Alemana y Japonesa.
ALTER TABLE AUTOR ADD CONSTRAINT ck_nacionalidad_autores CHECK (Nacionalidad IN ('Española', 'Francesa', 'Italiana', 'Americana', 'Alemana', 'Japonesa'));

-- El ISBN de los libros tienen el siguiente formato: 978-84-37604-94-7
ALTER TABLE LIBROS ADD CONSTRAINT ck_ISBN_libros CHECK (REGEXP_LIKE(ISBN, '[0-9]{3}\-[0-9]{2}\-[0-9]{5}\-[0-9]{2}\-[0-9]{1}'));

-- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
ALTER TABLE EMPLEADOS DROP CONSTRAINT uk_empleados;

-- Desactiva la restricción de la columna Editorial de la tabla LIBROS.
ALTER TABLE LIBROS DISABLE CONSTRAINT ck_mayusculas_editorial;



--+------------------------------------INSERTS-----------------------------------------+--

-- Tabla SOCIOS

-- Plantilla: INSERT INTO SOCIOS VALUES ('DNI', 'Nombre', 'Apellidos', 'Direccion', 'Telefono', 'Fecha_nacimiento');

INSERT INTO SOCIOS VALUES ('12345678A', 'Juan Perez', 'C/Falsa 123', '912345678', TO_DATE('01/01/1990', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('43210845B', 'Paco Diz', 'C/Malaga 1', '423085866', TO_DATE('04/06/2000', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('98765432C', 'Maria Lopez', 'C/Utrera 4', '574356768', TO_DATE('11/07/1999', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('88465632D', 'Jose Berlanga', 'C/Paso de la Arena', '634856394', TO_DATE('14/03/1998', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('27642461E', 'Ana Roldan', 'C/Domingo', '683657345', TO_DATE('20/05/1997', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('87645321F', 'Juan Urerña', 'C/Real 3', '643764864', TO_DATE('28/08/2007', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('98745542G', 'Pedro Rodrigez', 'C/Sevilla 3', '746346564', TO_DATE('28/04/2005', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('47765232H', 'Rocio Jimenez', 'C/German 7', '648364683', TO_DATE('24/12/1996', 'DD/MM/YYYY'));
INSERT INTO SOCIOS VALUES ('54372666K', 'Lola Perez','C/Lucio 3', '643764874', TO_DATE('15/09/1997', 'DD/MM/YYYY'));

-- INSERT INTO SOCIOS VALUES ('86647321L', 'Beatriz Ramirez', 'C/Santiago 3', '678354029', TO_DATE('29/08/2001', 'DD/MM/YYYY'));


-- Tabla PENALIZACIONES

-- Plantilla: INSERT INTO PENALIZACIONES VALUES ('Fecha_penalizacion', 'DNISOCIOP', 'Observacion');

INSERT INTO PENALIZACIONES VALUES (TO_DATE('18/03/2003'), '12345678A', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('20/03/2003'), '43210845B', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('22/03/2006'), '98765432C', 'No entregó el libro');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('27/03/2006'), '88465632D', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('29/03/2005'), '27642461E', 'Sin pago');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('30/07/2005'), '87645321F', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('12/08/2007'), '98745542G', 'Sin pago');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('12/08/2007'), '47765232H', 'No entregó el libro');
INSERT INTO PENALIZACIONES VALUES (TO_DATE('17/11/2009'), '54372666K', 'Sin observaciones');

-- INSERT INTO PENALIZACIONES VALUES (TO_DATE('20/12/2009'), '86647321L', 'Sin observaciones');


-- Tabla LIBROS

-- Plantilla: INSERT INTO LIBROS VALUES ('ISBN', 'Titulo', 'Genero', 'AnioPublicacion', 'Editorial');

INSERT INTO LIBROS VALUES ('978-84-37604-94-7', 'El Quijote de la Mancha', 'Novela', '1937', 'Juventud');
INSERT INTO LIBROS VALUES ('978-92-57508-94-8', 'La Odisea', 'Novela', '1923', 'Combel');
INSERT INTO LIBROS VALUES ('978-99-38201-94-0', 'El Señor de los Anillos', 'Novela', '1996', 'Tirant');
INSERT INTO LIBROS VALUES ('978-95-77894-94-1', 'La Comedia de las Almas', 'Novela', '1956', 'Nordical');
INSERT INTO LIBROS VALUES ('978-92-75486-94-2', 'El Principito', 'Novela', '1969', 'Salamandra');


-- Tabla EJEMPLARES

-- Plantilla: INSERT INTO EJEMPLARES VALUES('Cod_ejemplar, 'isbnlibroE');

INSERT INTO EJEMPLARES VALUES ('235473JKU','978-84-37604-94-7');
INSERT INTO EJEMPLARES VALUES ('283657DHJ','978-92-57508-94-8');
INSERT INTO EJEMPLARES VALUES ('325735KDJ','978-99-38201-94-0');
INSERT INTO EJEMPLARES VALUES ('239075EKD','978-95-77894-94-1');
INSERT INTO EJEMPLARES VALUES ('471295KFE','978-92-75486-94-2');


-- Tabala AUTOR

-- Plantilla: INSERT INTO AUTOR VALUES ('Nombre_Autor', 'FechaNac', 'Nacionalidad');

INSERT INTO AUTOR VALUES ('Carlos Santos', TO_DATE('02/04/1940', 'DD/MM/YYYY'), 'Española');
INSERT INTO AUTOR VALUES ('Juan Perino', TO_DATE('05/12/1950', 'DD/MM/YYYY'), 'Italiana');
INSERT INTO AUTOR VALUES ('Antonio Luengo', TO_DATE('09/07/1968', 'DD/MM/YYYY'), 'Francesa');
INSERT INTO AUTOR VALUES ('Joseph Lopez', TO_DATE('18/05/1971', 'DD/MM/YYYY'), 'Americana');


-- Tabla LIBRO_AUTOR

-- Plantilla: INSERT INTO LIBRO_AUTOR VALUES ('Nombre_Autor', 'ISBN');

INSERT INTO LIBRO_AUTOR VALUES ('Carlos Santos', '978-84-37604-94-7');
INSERT INTO LIBRO_AUTOR VALUES ('Juan Perino', '978-92-57508-94-8');
INSERT INTO LIBRO_AUTOR VALUES ('Antonio Luengo', '978-99-38201-94-0');
INSERT INTO LIBRO_AUTOR VALUES ('Joseph Lopez', '978-95-77894-94-1');


-- Tabla EMPLEADOS

-- Plantilla: INSERT INTO EMPLEADOS VALUES ('DNI', 'Nombre', 'FechaNac', 'Direccion', 'Genero', 'Sueldo', 'Tipo');

INSERT INTO EMPLEADOS VALUES ('32537832K', 'Carmen Sampedro', TO_DATE('04/09/1979', 'DD/MM/YYYY'), 'Travesía Jana', 'F', '3000', 'FIJO');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('47642821F', 'Paulo Benitez', TO_DATE('29/08/2001', 'DD/MM/YYYY'), 'Paseo Biel', 'M', '2000');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('94246532C', 'Paul Barrero', TO_DATE('07/04/1971', 'DD/MM/YYYY'), 'Camino Montes 20', 'M', '1000');
INSERT INTO EMPLEADOS VALUES ('27532561E', 'Tomas Fuente', TO_DATE('06/12/1970', 'DD/MM/YYYY'), 'Carrer Velasco 7', 'M', '1200', 'FIJO');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('37765232T', 'Maria Sol Marcos', TO_DATE('07/08/1986', 'DD/MM/YYYY'), 'Ruela Roque 0', 'F', '1600');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('46372616P', 'Jose Ignacio Sanmartin', TO_DATE('07/09/2003', 'DD/MM/YYYY'), 'Ronda Miguel 8', 'M', '4200');
INSERT INTO EMPLEADOS VALUES ('56647381O', 'Barbara Acuca', TO_DATE('20/04/1995', 'DD/MM/YYYY'), 'Calle Reynoso 17', 'F', '2200', 'FIJO');


-- Tabla PROOVEDORES

-- Plantilla: INSERT INTO PROOVEDORES VALUES ('CIF', 'Nombre', 'Telefono', 'Email', 'Direccion');

INSERT INTO PROOVEDORES VALUES ('B23456789', 'Librería de la Mancha', '945678944', 'librerialamancha@gmail.com', 'Travesía de la Mancha');
INSERT INTO PROOVEDORES VALUES ('B34567891', 'Libros Castillo', '975164944', 'libroscastillo@gmail.com', 'Calle Castillo');
INSERT INTO PROOVEDORES VALUES ('B45678912', 'Almacenes Jimenez', '983264273', 'almacenesjimenez@gmail.com', 'Calle Jimenez');


-- Tabla PRESTAMOS

-- Plantilla: INSERT INTO PRESTAMOS VALUES (TO_DATE(FechaPrestamo,'DD/MM/YYYY'), 'DNI_Socio', 'Cod_ejemplarP', 'DNI_empP', 'TO_DATE(FechaDevolucion, 'DD/MM/YYYY');

INSERT INTO PRESTAMOS VALUES (TO_DATE('03/06/2019', 'DD/MM/YYYY'), '12345678A', '235473JKU', '32537832K', TO_DATE('03/06/2020', 'DD/MM/YYYY'));
INSERT INTO PRESTAMOS VALUES (TO_DATE('14/05/2019', 'DD/MM/YYYY'), '43210845B', '283657DHJ', '47642821F', TO_DATE('14/05/2020', 'DD/MM/YYYY'));
INSERT INTO PRESTAMOS VALUES (TO_DATE('18/09/2020', 'DD/MM/YYYY'), '98765432C', '325735KDJ', '94246532C', TO_DATE('18/09/2021', 'DD/MM/YYYY'));
INSERT INTO PRESTAMOS VALUES (TO_DATE('12/03/2019', 'DD/MM/YYYY'), '88465632D', '239075EKD', '27532561E', TO_DATE('12/03/2020', 'DD/MM/YYYY'));
INSERT INTO PRESTAMOS VALUES (TO_DATE('04/11/2021', 'DD/MM/YYYY'), '27642461E', '471295KFE', '27532561E', TO_DATE('04/11/2022', 'DD/MM/YYYY'));
INSERT INTO PRESTAMOS VALUES (TO_DATE('01/01/2019', 'DD/MM/YYYY'), '27642461E', '471295KFE', '27532561E', TO_DATE('01/01/2020', 'DD/MM/YYYY'));


-- Tabla PROOV

-- Plantilla: INSERT INTO PROOV VALUES (TO_DATE('Fecha_proov','DD/MM/YYYY'), 'CIF_Pr', 'ISBN_LibroPr', 'Cantidad');

INSERT INTO PROOV VALUES (TO_DATE('03/05/2021', 'DD/MM/YYYY'), 'B23456789', '978-84-37604-94-7', '2');
INSERT INTO PROOV VALUES (TO_DATE('04/06/2021', 'DD/MM/YYYY'), 'B23456789', '978-92-57508-94-8', '1');
INSERT INTO PROOV VALUES (TO_DATE('07/11/2019', 'DD/MM/YYYY'), 'B34567891', '978-99-38201-94-0', '5');
INSERT INTO PROOV (Fecha_proov,CIF_Pr,ISBN_LibroPr) VALUES (TO_DATE('08/11/2019', 'DD/MM/YYYY'), 'B34567891', '978-95-77894-94-1');
INSERT INTO PROOV (Fecha_proov,CIF_Pr,ISBN_LibroPr) VALUES (TO_DATE('05/01/2020', 'DD/MM/YYYY'), 'B45678912', '978-92-75486-94-2');
