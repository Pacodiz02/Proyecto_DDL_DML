## PROYECTO DLL DML


### TABLA SOCIOS

| SOCIOS         |                                 |                |
|----------------|---------------------------------|----------------|
| **DNI**        | Cadena de caracteres, tamaño 9  | No nulo        |
| Nombre         | Cadena de caracteres, tamaño 20 | No nulo        |
| Direccion      | Cadena de caracteres, tamaño 20 |                |
| Teléfono       | Numerico, tamaño 9              |                |


### TABLA PENALIZACIONES

| PENALIZACIONES     |                                   |         |
|--------------------|-----------------------------------|---------|
| **Cod_Penali**         | Cadena de caracteres, tamaño 9    | No nulo |
| **Fecha penalizacion** | Fecha                             | No nulo |
| Observacion        | Cadena de caracteres, tamaño 1000 |         |
| _DNISocio_p_       | Cadena de caracteres, tamaño 9    | No nulo |  

### TABLA LIBROS

| LIBROS         |                                 |                                 |
|----------------|---------------------------------|---------------------------------|
| **ISBN**       | Cadena de caracteres, tamaño 10 | No nulo                         |
| Nombre         | Cadena de caracteres, tamaño 30 | No nulo                         |
| Genero         | Cadena de caracteres, tamaño 10 |                                 |
| AñoPublicacion | Numérico, tamaño 4              |                                 |  
| Editorial      | Cadena de caracteres, tamaño 10 | Letras en mayúscula             |


### TABLA AUTOR

| AUTORES      |                                 |         |
|--------------|---------------------------------|---------|
| **Nombre_Autor** | Cadena de caracteres, tamaño 40 | No nulo |
| FechaNac     | Fecha                           | No nulo |
| Nacionalidad | Cadena de caracteres, tamaño 15 |         |


### TABLA LIBRO_AUTOR

| AUTORES      |                                 |         |
|--------------|---------------------------------|---------|
| ***N_Autor***      | Cadena de caracteres, tamaño 40 | No nulo |
| ***ISBN_libro***     | Cadena de caracteres, tamaño 10 | No nulo |


### TABLA EMPLEADOS

| EMPLEADOS |                                 |                                                 |
|-----------|---------------------------------|-------------------------------------------------|
| **DNI**   | Cadena de caracteres, tamaño 9  | No Nulo                                         |
| Nombre    | Cadena de caracteres, tamaño 30 | Iniciales en mayúscula                          |
| FechaNac  | Fecha                           |                                                 |
| Dirección | Cadena de caracteres, tamaño 50 | No se puede repetir                             |
| Género    | Cadena de caracteres, tamaño 1  | M para género masculino, F para género femenino |


### TABLA PROOVEDORES

| PROOVEDORES |                                 |                     |
|-------------|---------------------------------|---------------------|
| **CIF**     | Cadena de caracteres, tamaño 9  | No nulo             |
| Nombre      | Cadena de caracteres, tamaño 30 | No nulo             |
| Teléfono    | Cadena de caracteres, tamaño 9  | No se puede repetir |
| Email       | Cadena de caracteres, tamaño 20 |                     |
 
 
 ### TABLA ATENCIÓN

| ATENCION   |                                 |                                                 |
|------------|---------------------------------|-------------------------------------------------|
| ***DNI_empA***| Cadena de caracteres, tamaño 9  | No nulo                                         |
| ***DNI_socioA***| Cadena de caracteres, tamaño 9 | No nulo                                         |
| FechaAten  | Fecha                           | Debe de estar en el siglo XXI y no nulo         |


### TABLA PRESTAMOS

| PRESTAMOS     |                                 |                 |
|---------------|---------------------------------|-----------------|
| ***DNI_socioP***   | Cadena de caracteres, tamaño 9  | No Nulo         |
| ***ISBN_libroP***  | Cadena de caracteres, tamaño 10 | No Nulo         |
| FechaPrestamo | Fecha                           | No Nulo         |
| FechaDevolu   | Fecha                           | No nulo         |


### TABLA PROOV

| PROOV         |                                 |                 |
|---------------|---------------------------------|-----------------|
| ***CIF_Pr***   | Cadena de caracteres, tamaño 9  | No Nulo         |
| ***ISBN_libroPr***  | Cadena de caracteres, tamaño 10 | No Nulo         |



Añade las siguientes restricciones, una vez creadas las tablas:

- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(4) con dos decimales.
- Modifica la columna AñoPublicacion de la tabla LIBROS cambiando el tipo de dato a fecha.
- Elimina la columna teléfono de la tabla SOCIOS.
- La referencia de los libros solo tienen carácteres numéricos, aunque sigue siendo de tipo cadena.
- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
- Desactiva la restricción de la columna Editorial de la tabla LIBROS.
