-- Creación de las tablas

CREATE TABLE SOCIOS (
DNI VARCHAR(9),
Nombre VARCHAR(20) NOT NULL,
Direccion VARCHAR(20),
Telefono VARCHAR(9),
email VARCHAR(20),
CONSTRAINT pk_socios PRIMARY KEY (DNI),
CONSTRAINT ck_dni_socios CHECK (DNI REGEXP '^[0-9]{8}[A-Z]{1}'),
CONSTRAINT ck_telefono CHECK (Telefono REGEXP '^[0-9]{9}')
);

CREATE TABLE PENALIZACIONES (
Fecha_penalizacion DATE,
DNISocioP VARCHAR(9),
Observacion VARCHAR(1000),
CONSTRAINT pk_penalizaciones PRIMARY KEY (Fecha_penalizacion, DNISocioP),
CONSTRAINT fk_penalizaciones_socios FOREIGN KEY (DNISocioP) REFERENCES SOCIOS(DNI),
CONSTRAINT ck_fechapenalizaciones CHECK (MONTH(Fecha_penalizacion) NOT BETWEEN 01 AND 02)
);


CREATE TABLE LIBROS (
ISBN VARCHAR(13),
Titulo VARCHAR(30) NOT NULL,
Genero VARCHAR(10),
AnioPublicacion INT(4),
Editorial VARCHAR(10),
CONSTRAINT pk_libros PRIMARY KEY (ISBN),
CONSTRAINT ck_mayusculas_editorial CHECK (UPPER(Editorial) = Editorial)
);


CREATE TABLE EJEMPLARES (
Cod_ejemplar VARCHAR(9),
ISBNLibroE VARCHAR(13),
CONSTRAINT pk_ejemplares PRIMARY KEY (Cod_ejemplar),
CONSTRAINT fk_ejemplares_libros FOREIGN KEY (ISBNLibroE) REFERENCES LIBROS(ISBN)
);


CREATE TABLE AUTOR ( 
Nombre_autor VARCHAR(40),
FechaNac DATE NOT NULL,
Nacionalidad VARCHAR(15),
CONSTRAINT pk_autor PRIMARY KEY (Nombre_autor),
CONSTRAINT ck_FechaNac CHECK (YEAR(FechaNac) > 1900)
);

CREATE TABLE LIBRO_AUTOR (
N_Autor VARCHAR(40),
ISBN_Libro VARCHAR(13),
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
CONSTRAINT ck_Nombre_empleado CHECK (Nombre REGEXP '^[A-Z]\.*[A-Z]\.'),
CONSTRAINT uk_empleados UNIQUE (Direccion),
CONSTRAINT ck_genero_empleado CHECK (Genero IN ('M', 'F')),
CONSTRAINT ck_dni_empleados CHECK (DNI REGEXP '^[0-9]{8}[A-Z]{1}')
);


CREATE TABLE PROOVEDORES (
CIF VARCHAR(9),
Nombre VARCHAR(30) NOT NULL,
Telefono VARCHAR(9),
Email VARCHAR(20),
CONSTRAINT pk_proovedores PRIMARY KEY (CIF),
CONSTRAINT uk_proovedores UNIQUE (Telefono),
CONSTRAINT ck_telefono_proovedor CHECK (Telefono REGEXP '^[9]{1}[0-9]{8}')
);


CREATE TABLE PRESTAMOS (
FechaPrestamo DATE,
DNI_Socio VARCHAR(9),
Cod_ejemplarP VARCHAR(9),
DNI_empP VARCHAR(9),
FechaDevolucion DATE NOT NULL,
CONSTRAINT pk_prestamos PRIMARY KEY (FechaPrestamo, DNI_Socio, Cod_ejemplarP),
CONSTRAINT fk_prestamos_socios FOREIGN KEY (DNI_Socio) REFERENCES SOCIOS(DNI),
CONSTRAINT fk_prestamos_ejemplares FOREIGN KEY (Cod_ejemplarP) REFERENCES EJEMPLARES(Cod_ejemplar),
CONSTRAINT fk_prestamos_empleados FOREIGN KEY (DNI_empP) REFERENCES EMPLEADOS(DNI),
CONSTRAINT ck_fechadevolucion CHECK (FechaDevolucion > FechaPrestamo)
);


CREATE TABLE PROOV (
Fecha_proov DATE,
CIF_Pr VARCHAR(9),
ISBN_LibroPr VARCHAR(13),
Cantidad INT(9) DEFAULT 1 NOT NULL,
CONSTRAINT pk_proov PRIMARY KEY (Fecha_proov, CIF_Pr, ISBN_LibroPr),
CONSTRAINT fk_proov_proovedores FOREIGN KEY (CIF_Pr) REFERENCES PROOVEDORES(CIF),
CONSTRAINT fk_proov_libros FOREIGN KEY (ISBN_LibroPr) REFERENCES LIBROS(ISBN)
);


--+----------------------------------------------------------------------------------+--
--Añade las siguientes restricciones, una vez creadas las tablas:

-- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(6) con dos decimales.
ALTER TABLE EMPLEADOS ADD Sueldo FLOAT(6,2);

-- Añade la columna Direccion en la tabla PROOVEDORES, Cadena de caracterese de longitud 50.
ALTER TABLE PROOVEDORES ADD Direccion VARCHAR(50);

-- Añade la columna Fecha_nacimiento en la tabla SOCIOS, de tipo Fecha.
ALTER TABLE SOCIOS ADD Fecha_nacimiento DATE;

-- Añade la columna tipo en la tabla EMPLEADOS, Cadena de caracteres.
ALTER TABLE EMPLEADOS ADD tipo VARCHAR(15);

-- Modifica la columna tipo en la tabla EMPLEADOS y pon por defecto 'TEMPORAL'.
ALTER TABLE EMPLEADOS MODIFY tipo VARCHAR(15) DEFAULT 'TEMPORAL';

-- Modifica la columna AñoPublicacion de la tabla LIBROS cambiando el tipo de dato a fecha.
ALTER TABLE LIBROS MODIFY AnioPublicacion DATE;

-- Modifica la columna Observacion de la tabla PENALIZACIONES reduciendola a 500 caracteres.
ALTER TABLE PENALIZACIONES MODIFY Observacion VARCHAR(500);

-- Elimina la columna email de la tabla SOCIOS.
ALTER TABLE SOCIOS DROP COLUMN email;

-- La Nacionalidad de los autores estará comprendida entre las siguientes: Española, Francesa, Italiana, Americana, Alemana y Japonesa.
ALTER TABLE AUTOR ADD CONSTRAINT ck_nacionalidad_autores CHECK (Nacionalidad IN ('Española', 'Francesa', 'Italiana', 'Americana', 'Alemana', 'Japonesa'));

-- La referencia de los libros solo tienen carácteres numéricos, aunque sigue siendo de tipo cadena.
ALTER TABLE LIBROS ADD CONSTRAINT ck_ISBN_libros CHECK (ISBN REGEXP '^[0-9]{13}$');

-- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
ALTER TABLE EMPLEADOS DROP CONSTRAINT uk_empleados;

-- Desactiva la restricción de la columna Editorial de la tabla LIBROS.(En MySQL no nos deja deshabilitar la restricción, tenenemos que eliminarla.)
ALTER TABLE LIBROS DROP CONSTRAINT ck_mayusculas_editorial;
-- Para añadirla acrtivarla de nuevo tendremos que añadirle con:
ALTER TABLE LIBROS ADD CONSTRAINT ck_mayusculas_editorial CHECK (UPPER(Editorial) = Editorial);
