--+-- Consultas sencillas

-- Muestra todos los socios.

SELECT * FROM SOCIOS;

-- Muestra los DNI de los socios que tienen penalizaciones por 'Sin pago'.

SELECT DNISocioP as "DNI" FROM PENALIZACIONES WHERE Observacion = 'Sin pago';

-- Lista los libros que se publicaron después del año 1960.

SELECT Titulo FROM LIBROS WHERE AnioPublicacion > 1960;


-- Muestra los Autores que hayan nacido despues de los años 50.

SELECT Nombre_Autor FROM AUTOR WHERE YEAR(FechaNac) > 1951;


-- +-- Vistas

-- Crea una vista con los empleados con trabajaran temporalmente en la librería.

 CREATE VIEW TempEmp as
 SELECT Nombre 
 FROM EMPLEADOS
 WHERE Tipo = 'TEMPORAL';

-- Para ver la vista

SELECT * FROM TempEmp;


-- Crea una vista con los libros y el nombre de su respectivo autor/es.

CREATE VIEW Libros_Autores as
SELECT l.Titulo as "Título del Libro", la.N_Autor as "Nombre del Autor"
FROM LIBRO_AUTOR la, LIBROS l
WHERE la.ISBN_Libro = l.ISBN;

-- Para ver la vista

SELECT * FROM Libros_Autores;


-- +-- Subconsultas

-- Muestra los Nombres de los empleados que tienen el mismo genero que 'Barbara Acuca'

SELECT Nombre
FROM EMPLEADOS
WHERE Genero= (SELECT Genero
	       FROM EMPLEADOS
	       WHERE Nombre = 'Barbara Acuca');


--+-- Combinaciones de tablas

-- Muestra los socios que tengan penalizaciones ordenados alfabeticamente.

SELECT s.Nombre
FROM SOCIOS s, PENALIZACIONES p
WHERE s.DNI = p.DNISocioP ORDER BY Nombre asc;


--+-- Inserción de registros. Consultas de datos anexados.

-- Inserta en nuevo empleado que tenga el mismo sueldo y tipo que 'Paul Barrero'

INSERT INTO EMPLEADOS(DNI,Nombre,FechaNac,Direccion,Genero)
SELECT '29530596E','Angel Suarez',STR_TO_DATE('16/12/2003','%d/%m/%Y'),'Calle Fuengirola 1','M'
FROM EMPLEADOS
WHERE Nombre='Paul Barrero';


--+-- Modificacion de registros. Consultas de actualización.

-- Actualiza el telefono del PROVedor con CIF B23456789.

UPDATE PROVEEDORES
SET Telefono = '988775689' WHERE CIF='B23456789';

-- Actualiza la fecha de devolucion del Socio que tiene como DNI el 12345678A.
 
UPDATE PRESTAMOS
SET FechaDevolucion = '2021/06/03' WHERE DNI_Socio='12345678A';

 
--+-- Borrado de registros. Consultas de eliminación.

-- Elimina los socios menores de edad.

DELETE FROM PENALIZACIONES WHERE DNISocioP IN (SELECT DNI FROM SOCIOS WHERE TIMESTAMPDIFF(MONTH,Fecha_nacimiento,Sysdate())<216);

DELETE FROM SOCIOS WHERE TIMESTAMPDIFF(MONTH,Fecha_nacimiento,Sysdate())<216;


--+-- Group by y having

-- Muestra el nombre y el DNI del empleado que más prestamos realizó.
-- (La función MAX(COUNT(*) no funciona en MYSQL)

SELECT Nombre, DNI
FROM EMPLEADOS
WHERE DNI IN (SELECT DNI_empP
	      FROM PRESTAMOS
	      GROUP BY DNI_empP
	      HAVING COUNT(*)=(SELECT MAX(COUNT(*))
			               FROM PRESTAMOS
			               GROUP BY DNI_empP));


-- Muestra los nombres de los socios que tienen más de 1 prestamos.

SELECT Nombre 
FROM SOCIOS 
WHERE DNI IN (SELECT DNI_Socio 
	      FROM PRESTAMOS 
	      GROUP BY DNI_Socio 
	      HAVING COUNT(*) > 1);


--+-- Outer joins. Combinaciones externas.

-- Mostrar todos los libros junto al numero de PROVEEDORES que PROVeen ese libro. 
-- (Tambien se muestran los libros que no tienen PROVEEDORES)

SELECT l.Titulo, count(p.CIF) as "PROVEEDORES"
FROM PROV pr left join PROVEEDORES p ON p.CIF = pr.CIF_Pr, LIBROS l
WHERE ISBN_LibroPr = ISBN
GROUP BY l.Titulo
ORDER BY count(p.CIF) desc;


--+-- Consultas con operadores de conjuntos.

-- Muestra los empleados que nacieron antes del año 1990 y los socios que nacieron después de ese mismo año.

SELECT Nombre FROM EMPLEADOS WHERE EXTRACT(YEAR FROM FechaNac) < '1990'
UNION
SELECT Nombre FROM SOCIOS WHERE EXTRACT(YEAR FROM Fecha_nacimiento) > '1990';

-- Muestra los proveedores que no han proveeido ningún libro.
-- (La función MINUS no funciona en MYSQL)

SELECT CIF FROM PROVEEDORES
MINUS
SELECT CIF_Pr FROM PROV;


--+-- Subconsultas correlacionadas.

-- Muestra el nombre y DNI de los empleados cuyo sueldo sea igual al máximo de empleados.

SELECT Nombre, DNI FROM EMPLEADOS WHERE sueldo = (SELECT MAX(Sueldo)
						  FROM EMPLEADOS);