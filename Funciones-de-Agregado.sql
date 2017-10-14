/* Funciones de Agregado
count --> Cuenta
sum --> Suma
max --> Maximo
min --> Minimo */

-- Total de registros
select COUNT (titulo) from libros

-- Total de registros especificando un dato
select COUNT (titulo) from libros
where precio_venta > 200

--Costo total de comprar todos los libros
select SUM(precio_venta) from libros

--Libro con el precio de compra mas alto
select MAX(precio_compra) from libros

--Libro con el precio de compra mas bajo
select MIN(precio_compra) from libros

--Concatenacion
select 'Libro: ' + titulo from libros

--Alias
select precio_venta as Precio_de_Venta from libros

--SubString
select SUBSTRING('Hola Mundo', 6,5)

--Conversión de dato tipo int a string
select STR(123)

--Reemplazo de Cadenas
select STUFF('Hola Mundo',6,5,'SQL SERVER')

--Obtener longitud de Cadena
select LEN('Hola Mundo')

--Conversión de digito a Código Assii
select CHAR(64)

--Conversión a Minusculas
select LOWER ('HOLA mundo')

--Conversión a Mayusculas
select UPPER ('HOLA mundo')

--Eliminar Espacios de la Izquierda
select LTRIM('       Hola Mundo')

--Eliminar Espacios de la Derecha
select RTRIM('       Hola Mundo       ')

--Remplazar cadena buscando coincidencias
select REPLACE('Hola Mundo','Mundo','SQL SERVER')

--Cadena al reves
select REVERSE('Daniel')

--Buscar coincidencias
select PATINDEX('%Mundo%', 'Hola Mundo')

--Replicar Cadena
select REPLICATE('Hola ', 5)

--Insertar espacio entre cadenas
select 'Hola' + SPACE(5) + 'Mundo'
