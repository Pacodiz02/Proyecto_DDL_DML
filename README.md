# Proyecto DLL-DML


## TABLA SOCIOS

| SOCIOS         |                                 |                |
|----------------|---------------------------------|----------------|
| **DNI**        | Cadena de caracteres, tamaño 9  | No nulo        |
| Nombre         | Cadena de caracteres, tamaño 20 | No nulo        |
| Direccion      | Cadena de caracteres, tamaño 20 |                |
| Penalizaciones | Número, tamaño 2                | Por defecto, 0 |
| Teléfono       | Numerico, tamaño 9              |                |

## TABLA LIBROS

| LIBROS         |                                 |                                 |
|----------------|---------------------------------|---------------------------------|
| **RefLibro**   | Cadena de caracteres, tamaño 10 | No nulo                         |
| Nombre         | Cadena de caracteres, tamaño 30 | No nulo                         |
| Autor          | Cadena de caracteres, tamaño 20 |                                 |
| Genero         | Cadena de caracteres, tamaño 10 |                                 |
| AñoPublicacion | Numérico, tamaño 4              |                                 |  
| Editorial      | Cadena de caracteres, tamaño 10 | Letras en mayúscula             |


## TABLA EMPLEADOS

| EMPLEADOS |                                 |                                                 |
|-----------|---------------------------------|-------------------------------------------------|
| **DNI**   | Cadena de caracteres, tamaño 9  | No Nulo                                         |
| Nombre    | Cadena de caracteres, tamaño 30 | Iniciales en mayúscula                          |
| FechaNac  | Fecha                           |                                                 |
| Dirección | Cadena de caracteres, tamaño 50 | No se puede repetir                             |
| Género    | Cadena de caracteres, tamaño 1  | M para género masculino, F para género femenino |


  ## TABLA ADQUISICIÓN

| ADQUISICION|                                 |                                                 |
|------------|---------------------------------|-------------------------------------------------|
| ***DNI_a*** | Cadena de caracteres, tamaño 9  | No nulo                                        |
| ***RefLibro_a***| Cadena de caracteres, tamaño 10 | No nulo                                    |
| FechaAdqui | Fecha                           | Debe de estar en el siglo XXI                   |


## TABLA PRESTAMOS

| PRESTAMOS     |                                 |                 |
|---------------|---------------------------------|-----------------|
| ***DNI_p***      | Cadena de caracteres, tamaño 9  | No Nulo      |
| ***RefLibro_p*** | Cadena de caracteres, tamaño 10 | No Nulo      |
| FechaPrestamo | Fecha                           | No Nulo         |
| Duración      | Numérico, tamaño 2              | Por defecto, 24 |



Añade las siguientes restricciones, una vez creadas las tablas:

- Añade la columna Sueldo en la tabla EMPLEADOS, Numérico(4) con dos decimales.
- Modifica la columna AñoPublicacion de la tabla LIBROS cambiando el tipo de dato a fecha.
- Elimina la columna teléfono de la tabla SOCIOS.
- La referencia de los libros solo tienen carácteres numéricos, aunque sigue siendo de tipo cadena.
- Elimina la restricción de la columna Dirección de la tabla EMPLEADOS.
- Desactiva la restricción de la columna Editorial de la tabla LIBROS.
