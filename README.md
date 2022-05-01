## PROYECTO DDL DML

Nota: Los caracteres en negrita son PK y cursiva FK.


### TABLA SOCIOS

| SOCIOS         |                                 |                |
|----------------|---------------------------------|----------------|
| **DNI**        | Cadena de caracteres, tamaño 9  |                |
| Nombre         | Cadena de caracteres, tamaño 20 | No nulo        |
| Direccion      | Cadena de caracteres, tamaño 20 |                |
| Teléfono       | Numerico, tamaño 9              |                |


### TABLA PENALIZACIONES

| PENALIZACIONES     |                                   |
|--------------------|-----------------------------------|
| **Fecha penalizacion** | Fecha                             |
| ***DNISocio_p***       | Cadena de caracteres, tamaño 9    |
| Observacion        | Cadena de caracteres, tamaño 1000 |
 
 
### TABLA EJEMPLARES

| EJEMPLARES        |                                 |         |
|-------------------|---------------------------------|---------|
| **Cod_ejemplar** | Cadena de caracteres, tamaño 9   |         |
| _ISBN_LibroE_     | Cadena de caracteres, tamaño 13 | No nulo |


### TABLA LIBROS

| LIBROS         |                                 |                                 |
|----------------|---------------------------------|---------------------------------|
| **ISBN**       | Cadena de caracteres, tamaño 13 |                                 |
| Titulo         | Cadena de caracteres, tamaño 30 | No nulo                         |
| Genero         | Cadena de caracteres, tamaño 10 |                                 |
| AñoPublicacion | Numérico, tamaño 4              |                                 |  
| Editorial      | Cadena de caracteres, tamaño 10 | Letras en mayúscula             |


### TABLA AUTOR

| AUTORES      |                                 |         |
|--------------|---------------------------------|---------|
| **Nombre_Autor** | Cadena de caracteres, tamaño 40 |     |
| FechaNac     | Fecha                           | No nulo |
| Nacionalidad | Cadena de caracteres, tamaño 15 |         |


### TABLA LIBRO_AUTOR

| AUTORES      |                                 |
|--------------|---------------------------------|
| ***N_Autor***      | Cadena de caracteres, tamaño 40 |
| ***ISBN_libro***     | Cadena de caracteres, tamaño 10 |


### TABLA EMPLEADOS

| EMPLEADOS |                                 |                                                 |
|-----------|---------------------------------|-------------------------------------------------|
| **DNI**   | Cadena de caracteres, tamaño 9  |                                                 |
| Nombre    | Cadena de caracteres, tamaño 30 | Iniciales en mayúscula                          |
| FechaNac  | Fecha                           |                                                 |
| Dirección | Cadena de caracteres, tamaño 50 | No se puede repetir                             |
| Género    | Cadena de caracteres, tamaño 1  | M para género masculino, F para género femenino |


### TABLA PROOVEDORES

| PROOVEDORES |                                 |                     |
|-------------|---------------------------------|---------------------|
| **CIF**     | Cadena de caracteres, tamaño 9  |                     |
| Nombre      | Cadena de caracteres, tamaño 30 | No nulo             |
| Teléfono    | Cadena de caracteres, tamaño 9  | No se puede repetir |
| Email       | Cadena de caracteres, tamaño 20 |                     |
 
 
### TABLA PRESTAMOS

| PRESTAMOS     |                                 |                 |
|---------------|---------------------------------|-----------------|
| ***DNI_socioP***   | Cadena de caracteres, tamaño 9  |            |
| ***Codigo_ejemplarP***  | Cadena de caracteres, tamaño 9 |        |
| **FechaPrestamo** | Fecha                     |                   |
| _DNI_empP_    | Cadena de caracteres, tamaño 9  | No Nulo         |
| FechaDevolu   | Fecha                           | No nulo         |


### TABLA PROOV

| PROOV         |                                 |                 |
|---------------|---------------------------------|-----------------|
| ***CIF_Pr***  | Cadena de caracteres, tamaño 9  |                 |
| **Fecha_proov** | Fecha                         |                 |
| Cantidad      | Cadena de caracteres, tamaño 9  | No Nulo         |
| ***ISBN_LibroPr***  | Cadena de caracteres, tamaño 13 |           |


+------------------------------------------------------------------------------+


Añade las siguientes restricciones, una vez creadas las tablas:

- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(6) con dos decimales.
- Modifica la columna AñoPublicacion de la tabla LIBROS cambiando el tipo de dato a fecha.
- Elimina la columna teléfono de la tabla SOCIOS.
- La referencia de los libros solo tienen carácteres numéricos, aunque sigue siendo de tipo cadena.
- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
- Desactiva la restricción de la columna Editorial de la tabla LIBROS.
