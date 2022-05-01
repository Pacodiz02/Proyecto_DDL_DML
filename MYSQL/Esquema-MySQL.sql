CREATE TABLE SOCIOS (
DNI VARCHAR2(9),
Nombre VARCHAR2(20),
Direccion VARCHAR2(20),
Telefono VARCHAR2(9),
CONSTRAINT pk_socios PRIMARY KEY (DNI),
CONSTRAINT nn_Nombre IS NOT NULL(Nombre)
);

CREATE TABLE PENALIZACIONES (
Fecha_penalizacion DATE,
DNISocioP VARCHAR2(9),
Observacion VARCHAR2(1000),
CONSTRAINT pk_penalizaciones PRIMARY KEY (Fecha_penalizacion, DNISocioP),
CONSTRAINT fk_penalizaciones_socios FOREIGN KEY (DNISocioP) REFERENCES SOCIOS(DNI)
);


CREATE TABLE LIBROS (
ISBN VARCHAR2(13),
Titulo VARCHAR2(30),
Genero VARCHAR2(10),
AnioPublicaion NUMBER(4),
Editorial VARCHAR2(10),
CONSTRAINT pk_libros PRIMARY KEY (ISBN),
CONSTRAINT nn_Titulo IS NOT NULL(Titulo)
CONSTRAINT ck_mayusculas_editorial CHECK (UPPER(Editorial) = Editorial)
);


CREATE TABLE EJEMPLARES (
Cod_ejemplar VARCHAR2(9),
ISBNLibroE VARCHAR2(13),
CONSTRAINT pk_ejemplares PRIMARY KEY (Cod_ejemplar),
CONSTRAINT fk_ejemplares_libros FOREIGN KEY (ISBNLibroE) REFERENCES LIBROS(ISBN)
);


CREATE TABLE AUTROR ( 
Nombre_autor VARCHAR2(40),
FechaNac DATE,
Nacionalidad VARCHAR2(15),
CONSTRAINT pk_autor PRIMARY KEY (Nombre_autor),
CONSTRAINT nn_FechaNac IS NOT NULL(FechaNac)
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
CONSTRAINT ck_genero_empleado CHECK (Genero IN ('M', 'F'))
);


CREATE TABLE PROOVEDORES (
CIF VARCHAR(9),
Nombre VARCHAR(30),
Telefono VARCHAR2(9),
Email VARCHAR2(20),
CONSTRAINT pk_proovedores PRIMARY KEY (CIF),
CONSTRAINT nn_Nombre_proovedor IS NOT NULL(Nombre),
CONSTRAINT uk_proovedores UNIQUE (Telefono)
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
CONSTRAINT nn_FechaDevolucion IS NOT NULL(FechaDevolucion)
);


CREATE TABLE PROOV (
Fecha_proov DATE,
CIF_Pr VARCHAR(9),
ISBN_LibroPr VARCHAR(13),
Cantidad NUMBER(9),
CONSTRAINT pk_proov PRIMARY KEY (Fecha_proov, CIF_Pr, ISBN_LibroPr),
CONSTRAINT fk_proov_proovedores FOREIGN KEY (CIF_Pr) REFERENCES PROOVEDORES(CIF),
CONSTRAINT fk_proov_libros FOREIGN KEY (ISBN_LibroPr) REFERENCES LIBROS(ISBN),
CONSTRAINT nn_Cantidad IS NOT NULL(Cantidad)
);


--+----------------------------------------------------------------------------------+--
--Añade las siguientes restricciones, una vez creadas las tablas:

-- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(6) con dos decimales.
ALTER TABLE EMPLEADOS ADD COLUMN Sueldo NUMBER(6,2);

-- Modifica la columna AñoPublicacion de la tabla LIBROS cambiando el tipo de dato a fecha.
ALTER TABLE LIBROS MODIFY (AnioPublicacion DATE);

-- Elimina la columna teléfono de la tabla SOCIOS.
ALTER TABLE SOCIOS DROP COLUMN Telefono;

-- La referencia de los libros solo tienen carácteres numéricos, aunque sigue siendo de tipo cadena.
ALTER TABLE LIBROS ADD CONSTRAINT ck_ISBN_libros CHECK (ISBN REGEXP '^[0-9]{13}$');

-- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
ALTER TABLE EMPLEADOS DROP CONSTRAINT uk_empleados;

-- Desactiva la restricción de la columna Editorial de la tabla LIBROS.
ALTER TABLE LIBROS DISABLE CONSTRAINT ck_mayusculas_editorial;

