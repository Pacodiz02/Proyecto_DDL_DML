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
ISBN VARCHAR2(13),
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
ISBNLibroE VARCHAR2(13),
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
ISBN_Libro VARCHAR2(13),
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
Email VARCHAR2(20),
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
ISBN_LibroPr VARCHAR2(13),
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

-- Modifica la columna AñoPublicacion de la tabla LIBROS cambiando el tipo de dato a fecha.
ALTER TABLE LIBROS MODIFY (AnioPublicacion DATE);

-- Modifica la columna Observacion de la tabla PENALIZACIONES reduciendola a 500 caracteres.
ALTER TABLE PENALIZACIONES MODIFY (Observacion VARCHAR2(500));

-- Elimina la columna email de la tabla SOCIOS.
ALTER TABLE SOCIOS DROP COLUMN email VARCHAR2(20);

-- La Nacionalidad de los autores estará comprendida entre las siguientes: Española, Francesa, Italiana, Americana, Alemana y Japonesa.
ALTER TABLE AUTOR ADD CONSTRAINT ck_nacionalidad_autores CHECK (Nacionalidad IN ('Española', 'Francesa', 'Italiana', 'Americana', 'Alemana', 'Japonesa'));

-- La referencia de los libros solo tienen carácteres numéricos, aunque sigue siendo de tipo cadena.
ALTER TABLE LIBROS ADD CONSTRAINT ck_ISBN_libros CHECK (REGEXP_LIKE(ISBN, '^[0-9]{13}$'));

-- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
ALTER TABLE EMPLEADOS DROP CONSTRAINT uk_empleados;

-- Desactiva la restricción de la columna Editorial de la tabla LIBROS.
ALTER TABLE LIBROS DISABLE CONSTRAINT ck_mayusculas_editorial;

