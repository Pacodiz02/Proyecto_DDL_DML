# Proyecto DLL-DML


## TABLA SOCIOS

| SOCIOS         |                                 |                |
|----------------|---------------------------------|----------------|
| DNI            | Cadena de caracteres, tamaño 10 | No nulo        |
| Nombre         | Cadena de caracteres, tamaño 20 | No nulo        |
| Direccion      | Cadena de caracteres, tamaño 20 |                |
| Penalizaciones | Número, tamaño 2                | Por defecto, 0 |


## TABLA LIBROS

| LIBROS         |                                 |         |
|----------------|---------------------------------|---------|
| RefLibro       | Cadena de caracteres, tamaño 10 |         |
| Nombre         | Cadena de caracteres, tamaño 30 |         |
| Autor          | Cadena de caracteres, tamaño 20 |         |
| Genero         | Cadena de caracteres, tamaño 10 |         |
| AñoPublicación | Numérico, tamaño 4              |         |
| Editorial      | Cadena de caracteres, tamaño 10 |         |


## TABLA EMPLEADOS

| EMPLEADOS |                                 |                                                 |
|-----------|---------------------------------|-------------------------------------------------|
| DNI       | Cadena de caracteres, tamaño 10 | No Nulo                                         |
| Nombre    | Cadena de caracteres, tamaño 30 | Iniciales en mayúscula                          |
| FechaNac  | Fecha                           |                                                 |
| Dirección | Cadena de caracteres, tamaño 50 | No se puede repetir                             |
| Género    | Cadena de caracteres, tamaño 1  | M para género masculino, F para género femenino |


## TABLA PRESTAMOS

| PRESTAMOS     |                                 |                 |
|---------------|---------------------------------|-----------------|
| DNI           | Cadena de caracteres, tamaño 10 | No Nulo         |
| RefLibro      | Cadena de caracteres, tamaño 10 | No Nulo         |
| FechaPrestamo | Fecha                           | No Nulo         |
| Duración      | Numérico, tamaño 2              | Por defecto, 24 |

