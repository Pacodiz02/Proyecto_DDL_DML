-- Creación de las tablas

CREATE TABLE SOCIOS (
DNI VARCHAR(9),
Nombre VARCHAR(20),
Direccion VARCHAR(20),
Telefono VARCHAR(9),
email VARCHAR(20),
CONSTRAINT pk_socios PRIMARY KEY (DNI),
CONSTRAINT nn_Nombre CHECK (Nombre IS NOT NULL),
CONSTRAINT ck_dni_socios CHECK (DNI ~ '^[0-9]{8}[A-Z]{1}'),
CONSTRAINT ck_telefono CHECK (Telefono ~ '^[0-9]{9}')
);

CREATE TABLE PENALIZACIONES (
Fecha_penalizacion DATE,
DNISocioP VARCHAR(9),
Observacion VARCHAR(1000),
CONSTRAINT pk_penalizaciones PRIMARY KEY (Fecha_penalizacion, DNISocioP),
CONSTRAINT fk_penalizaciones_socios FOREIGN KEY (DNISocioP) REFERENCES SOCIOS(DNI),
CONSTRAINT ck_fechapenalizaciones CHECK (EXTRACT(MONTH FROM Fecha_penalizacion) NOT BETWEEN 01 AND 02)
);


CREATE TABLE LIBROS (
ISBN VARCHAR(17),
Titulo VARCHAR(30),
Genero VARCHAR(10),
AnioPublicacion INT,
Editorial VARCHAR(10),
CONSTRAINT pk_libros PRIMARY KEY (ISBN),
CONSTRAINT nn_Titulo CHECK(Titulo IS NOT NULL),
CONSTRAINT ck_mayusculas_editorial CHECK (Editorial ~ '[A-Z]{10}')
);


CREATE TABLE EJEMPLARES (
Cod_ejemplar VARCHAR(9),
ISBNLibroE VARCHAR(17),
CONSTRAINT pk_ejemplares PRIMARY KEY (Cod_ejemplar),
CONSTRAINT fk_ejemplares_libros FOREIGN KEY (ISBNLibroE) REFERENCES LIBROS(ISBN)
);


CREATE TABLE AUTOR ( 
Nombre_autor VARCHAR(40),
FechaNac DATE,
Nacionalidad VARCHAR(15),
CONSTRAINT pk_autor PRIMARY KEY (Nombre_autor),
CONSTRAINT nn_FechaNac CHECK (FechaNac IS NOT NULL),
CONSTRAINT ck_FechaNac CHECK (EXTRACT(YEAR FROM FechaNac) > 1900)
);

CREATE TABLE LIBRO_AUTOR (
N_Autor VARCHAR(40),
ISBN_Libro VARCHAR(17),
CONSTRAINT pk_libro_autor PRIMARY KEY (N_Autor, ISBN_Libro),
CONSTRAINT fk_libro_autor_autor FOREIGN KEY (N_Autor) REFERENCES AUTOR(Nombre_autor),
CONSTRAINT fk_libro_autor_libro FOREIGN KEY (ISBN_Libro) REFERENCES LIBROS(ISBN)
);


CREATE TABLE EMPLEADOS (
DNI VARCHAR(9),
Nombre VARCHAR(30),
FechaNac DATE,
Direccion VARCHAR(50),
Genero VARCHAR(1),
CONSTRAINT pk_empleados PRIMARY KEY (DNI),
CONSTRAINT ck_Nombre_empleado CHECK (Nombre ~ '^[A-Z]${1,30}'),
CONSTRAINT uk_empleados UNIQUE (Direccion),
CONSTRAINT ck_genero_empleado CHECK (Genero IN ('M', 'F')),
CONSTRAINT ck_dni_empleados CHECK (DNI ~ '^[0-9]{8}[A-Z]{1}')
);


CREATE TABLE PROOVEDORES (
CIF VARCHAR(9),
Nombre VARCHAR(30),
Telefono VARCHAR(9),
Email VARCHAR(40),
CONSTRAINT pk_proovedores PRIMARY KEY (CIF),
CONSTRAINT nn_Nombre_proovedor CHECK (Nombre IS NOT NULL),
CONSTRAINT uk_proovedores UNIQUE (Telefono),
CONSTRAINT ck_telefono_proovedor CHECK (Telefono ~ '^[9]{1}[0-9]{8}')
);


CREATE TABLE PRESTAMOS (
FechaPrestamo DATE,
DNI_Socio VARCHAR(9),
Cod_ejemplarP VARCHAR(9),
DNI_empP VARCHAR(9),
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
CIF_Pr VARCHAR(9),
ISBN_LibroPr VARCHAR(17),
Cantidad INT DEFAULT 1,
CONSTRAINT pk_proov PRIMARY KEY (Fecha_proov, CIF_Pr, ISBN_LibroPr),
CONSTRAINT fk_proov_proovedores FOREIGN KEY (CIF_Pr) REFERENCES PROOVEDORES(CIF),
CONSTRAINT fk_proov_libros FOREIGN KEY (ISBN_LibroPr) REFERENCES LIBROS(ISBN),
CONSTRAINT nn_Cantidad CHECK (Cantidad IS NOT NULL)
);


--+----------------------------------------------------------------------------------+--
--Añade las siguientes restricciones, una vez creadas las tablas:

-- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(6) con dos decimales.
ALTER TABLE EMPLEADOS ADD Sueldo DECIMAL(6,2);

-- Añade la columna Direccion en la tabla PROOVEDORES, Cadena de caracterese de longitud 50.
ALTER TABLE PROOVEDORES ADD Direccion VARCHAR(50);

-- Añade la columna Fecha_nacimiento en la tabla SOCIOS, de tipo Fecha.
ALTER TABLE SOCIOS ADD Fecha_nacimiento DATE;

-- Añade la columna tipo en la tabla EMPLEADOS, Cadena de caracteres.
ALTER TABLE EMPLEADOS ADD tipo VARCHAR(15);

-- Modifica la columna tipo en la tabla EMPLEADOS y pon por defecto 'TEMPORAL'.
ALTER TABLE EMPLEADOS ALTER COLUMN tipo SET DEFAULT 'TEMPORAL';

-- Modifica la columna Observacion de la tabla PENALIZACIONES reduciendola a 500 caracteres.
ALTER TABLE PENALIZACIONES ALTER COLUMN Observacion TYPE VARCHAR(500);

-- Elimina la columna email de la tabla SOCIOS.
ALTER TABLE SOCIOS DROP COLUMN email;

-- La Nacionalidad de los autores estará comprendida entre las siguientes: Española, Francesa, Italiana, Americana, Alemana y Japonesa.
ALTER TABLE AUTOR ADD CONSTRAINT ck_nacionalidad_autores CHECK (Nacionalidad IN ('Española', 'Francesa', 'Italiana', 'Americana', 'Alemana', 'Japonesa'));

-- El ISBN de los libros tienen el siguiente formato: 978-84-37604-94-7
ALTER TABLE LIBROS ADD CONSTRAINT ck_ISBN_libros CHECK (ISBN ~ '[0-9]{3}\-[0-9]{2}\-[0-9]{5}\-[0-9]{2}\-[0-9]{1}');

-- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
ALTER TABLE EMPLEADOS DROP CONSTRAINT uk_empleados;

-- Desactiva la restricción de la columna Editorial de la tabla LIBROS.(En PostgreSQL no nos deja deshabilitar la restricción, tenenemos que eliminarla.)
ALTER TABLE LIBROS DROP CONSTRAINT ck_mayusculas_editorial;
-- Para añadirla acrtivarla de nuevo tendremos que añadirle con:
ALTER TABLE LIBROS ADD CONSTRAINT ck_mayusculas_editorial CHECK (Editorial ~ '[A-Z]{10}');



--+------------------------------------INSERTS-----------------------------------------+--

-- Tabla SOCIOS

-- Plantilla: INSERT INTO SOCIOS VALUES ('DNI', 'Nombre', 'Apellidos', 'Direccion', 'Telefono', 'Fecha_nacimiento');

INSERT INTO SOCIOS VALUES ('12345678A', 'Juan Perez', 'C/Falsa 123', '912345678', '1990/01/01');
INSERT INTO SOCIOS VALUES ('43210845B', 'Paco Diz', 'C/Malaga 1', '423085866', '2000/06/04');
INSERT INTO SOCIOS VALUES ('98765432C', 'Maria Lopez', 'C/Utrera 4', '574356768', '1999/07/11');
INSERT INTO SOCIOS VALUES ('88465632D', 'Jose Berlanga', 'C/Paso de la Arena', '634856394', '1998/03/14');
INSERT INTO SOCIOS VALUES ('27642461E', 'Ana Roldan', 'C/Domingo', '683657345', '1997/05/20');
INSERT INTO SOCIOS VALUES ('87645321F', 'Juan Urerña', 'C/Real 3', '643764864', '2007/08/28');
INSERT INTO SOCIOS VALUES ('98745542G', 'Pedro Rodrigez', 'C/Sevilla 3', '746346564', '2005/04/28');
INSERT INTO SOCIOS VALUES ('47765232H', 'Rocio Jimenez', 'C/German 7', '648364683', '1996/12/24');
INSERT INTO SOCIOS VALUES ('54372666K', 'Lola Perez','C/Lucio 3', '643764874', '1997/09/15');

-- INSERT INTO SOCIOS VALUES ('86647321L', 'Beatriz Ramirez', 'C/Santiago 3', '678354029', '29/08/2001');


-- Tabla PENALIZACIONES

-- Plantilla: INSERT INTO PENALIZACIONES VALUES ('Fecha_penalizacion', 'DNISOCIOP', 'Observacion');

INSERT INTO PENALIZACIONES VALUES ('2003/03/18', '12345678A', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES ('2003/03/20', '43210845B', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES ('2006/03/22', '98765432C', 'No entregó el libro');
INSERT INTO PENALIZACIONES VALUES ('2006/03/27', '88465632D', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES ('2005/03/29', '27642461E', 'Sin pago');
INSERT INTO PENALIZACIONES VALUES ('2005/07/30', '87645321F', 'Sin observaciones');
INSERT INTO PENALIZACIONES VALUES ('2007/08/12', '98745542G', 'Sin pago');
INSERT INTO PENALIZACIONES VALUES ('2007/08/12', '47765232H', 'No entregó el libro');
INSERT INTO PENALIZACIONES VALUES ('2009/11/17', '54372666K', 'Sin observaciones');

-- INSERT INTO PENALIZACIONES VALUES ('20/12/2009'), '86647321L', 'Sin observaciones');


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

INSERT INTO AUTOR VALUES ('Carlos Santos', '1940/04/02', 'Española');
INSERT INTO AUTOR VALUES ('Juan Perino', '1950/12/05', 'Italiana');
INSERT INTO AUTOR VALUES ('Antonio Luengo', '1968/07/09', 'Francesa');
INSERT INTO AUTOR VALUES ('Joseph Lopez', '1971/05/18', 'Americana');


-- Tabla LIBRO_AUTOR

-- Plantilla: INSERT INTO LIBRO_AUTOR VALUES ('Nombre_Autor', 'ISBN');

INSERT INTO LIBRO_AUTOR VALUES ('Carlos Santos', '978-84-37604-94-7');
INSERT INTO LIBRO_AUTOR VALUES ('Juan Perino', '978-92-57508-94-8');
INSERT INTO LIBRO_AUTOR VALUES ('Antonio Luengo', '978-99-38201-94-0');
INSERT INTO LIBRO_AUTOR VALUES ('Joseph Lopez', '978-95-77894-94-1');


-- Tabla EMPLEADOS

-- Plantilla: INSERT INTO EMPLEADOS VALUES ('DNI', 'Nombre', 'FechaNac', 'Direccion', 'Genero', 'Sueldo', 'Tipo');

INSERT INTO EMPLEADOS VALUES ('32537832K', 'Carmen Sampedro', '1979/09/04', 'Travesía Jana', 'F', '3000', 'FIJO');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('47642821F', 'Paulo Benitez', '2001/08/29', 'Paseo Biel', 'M', '2000');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('94246532C', 'Paul Barrero', '1971/04/07', 'Camino Montes 20', 'M', '1000');
INSERT INTO EMPLEADOS VALUES ('27532561E', 'Tomas Fuente', '1970/12/06', 'Carrer Velasco 7', 'M', '1200', 'FIJO');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('37765232T', 'Maria Sol Marcos', '1986/08/07', 'Ruela Roque 0', 'F', '1600');
INSERT INTO EMPLEADOS (DNI, Nombre, FechaNac, Direccion, Genero, Sueldo) VALUES ('46372616P', 'Jose Ignacio Sanmartin', '2003/09/07', 'Ronda Miguel 8', 'M', '4200');
INSERT INTO EMPLEADOS VALUES ('56647381O', 'Barbara Acuca', '1995/04/20', 'Calle Reynoso 17', 'F', '2200', 'FIJO');


-- Tabla PROOVEDORES

-- Plantilla: INSERT INTO PROOVEDORES VALUES ('CIF', 'Nombre', 'Telefono', 'Email', 'Direccion');

INSERT INTO PROOVEDORES VALUES ('B23456789', 'Librería de la Mancha', '945678944', 'librerialamancha@gmail.com', 'Travesía de la Mancha');
INSERT INTO PROOVEDORES VALUES ('B34567891', 'Libros Castillo', '975164944', 'libroscastillo@gmail.com', 'Calle Castillo');
INSERT INTO PROOVEDORES VALUES ('B45678912', 'Almacenes Jimenez', '983264273', 'almacenesjimenez@gmail.com', 'Calle Jimenez');


-- Tabla PRESTAMOS

-- Plantilla: INSERT INTO PRESTAMOS VALUES (FechaPrestamo, 'DNI_Socio', 'Cod_ejemplarP', 'DNI_empP', 'FechaDevolucion;

INSERT INTO PRESTAMOS VALUES ('2019/06/03', '12345678A', '235473JKU', '32537832K', '2020/06/03');
INSERT INTO PRESTAMOS VALUES ('2019/05/14', '43210845B', '283657DHJ', '47642821F', '2020/05/14');
INSERT INTO PRESTAMOS VALUES ('2020/09/18', '98765432C', '325735KDJ', '94246532C', '2021/09/18');
INSERT INTO PRESTAMOS VALUES ('2019/03/12', '88465632D', '239075EKD', '27532561E', '2020/03/12');
INSERT INTO PRESTAMOS VALUES ('2021/11/04', '27642461E', '471295KFE', '27532561E', '2022/11/04');
INSERT INTO PRESTAMOS VALUES ('2019/01/01', '27642461E', '471295KFE', '27532561E', '2020/01/01');


-- Tabla PROOV

-- Plantilla: INSERT INTO PROOV VALUES ('Fecha_proov', 'CIF_Pr', 'ISBN_LibroPr', 'Cantidad');

INSERT INTO PROOV VALUES ('2021/05/03', 'B23456789', '978-84-37604-94-7', '2');
INSERT INTO PROOV VALUES ('2021/06/04', 'B23456789', '978-92-57508-94-8', '1');
INSERT INTO PROOV VALUES ('2019/11/07', 'B34567891', '978-99-38201-94-0', '5');
INSERT INTO PROOV (Fecha_proov,CIF_Pr,ISBN_LibroPr) VALUES ('2019/11/08', 'B34567891', '978-95-77894-94-1');
INSERT INTO PROOV (Fecha_proov,CIF_Pr,ISBN_LibroPr) VALUES ('2020/01/05', 'B45678912', '978-92-75486-94-2');