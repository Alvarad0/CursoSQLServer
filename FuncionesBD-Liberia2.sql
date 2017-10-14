--********* Tutorial SQL SERVER 2008 R2 *********

select * from libros
-- Sacar las ganancias de cada libro
select titulo, precio_venta - precio_compra from libros

-- Presuspuesto de compras de los libros
select titulo, precio_venta * 10 from libros
select titulo, precio_venta *10 from libros where titulo = 'Aura'

-- Actualización de cambio de precio a un libro
update libros set precio_venta = precio_venta + (precio_venta * 0.1) where id_libro = 1

--Modificar Propiedades de una Columna
alter table libros alter column titulo varchar(50) null

--Order by
select titulo from libros
order by titulo --Ordena de A - Z

select titulo, precio_venta from libros
order by precio_venta -- Ordena de Menor a Mayor

select titulo, precio_venta from libros
order by precio_venta desc -- Ordena de Menor a Mayor

-- Operadores Logicos
-- not --> != --> Negación 
-- and --> && --> Y
-- or --> || -> O

select * from libros where not id_libro = 1 --Excluir registro de la tabla
select * from libros where precio_venta = 189 and precio_compra = 154 --Condición Y
select * from libros where id_libro = 1 or id_libro = 6 --Condición O

-- is null --> Si es Nulo
--Mostrar Campos Nulos
select * from libros where titulo is null

-- between --> Entre rango de Valores
select * from libros where precio_venta between 200 and 300

--Like busca los registros que tengan el valor especificado dentro de la tabla
--Buscar libros que tengan la palabra especificada
select * from libros where titulo like '%el%'

--Buscar libros que no tengan la palabra especificada
select * from libros where titulo not like '%el%'

--Buscar registros que empiezen con la palabra especificada
select * from libros where titulo like 'llu%'

--Buscar registros que no terminan con la palabra especificada
select * from libros where titulo like '%al'

-- Buscar registros cuando desconozcas como se escribe una palabra
select * from libros where titulo like '%_ava%'

--Obtener promedio de los registros de una columna
select AVG(precio_venta)as Promedio from libros where precio_compra < 200
--Obtener promedio de los registros de una columna
select SUM(precio_venta) / COUNT(id_libro) as Promedio from libros where precio_compra < 200

--Obtener registro minimo de una columna tipo String de la tabla
select MIN(titulo) from libros

--Obtener registro Maximo de una columna tipo String de la tabla
select MAX(titulo) from libros

-- Where --> Filtro de registros individuales
-- having --> Filtro por grupos de registros, para utilizarse se necesita un operador de agrupamiento y la expresion group by
select titulo, AVG(precio_venta) as Promedio from libros where precio_compra < 200
group by titulo
having AVG(precio_venta) < 200

-- compute --> Expresion para hacer dos select dentro de una misma consulta
select titulo, precio_venta from libros where precio_compra < 200
compute min(titulo), sum(precio_venta)

--distinct --> Elimina de la tabla temporal los valores repetidos
select SUM(precio_venta) as Suma from libros --Suma = 2497
select SUM(distinct precio_venta) as Suma from libros --Suma = 2247

--top --> Limita la cantidad de registros a mostrar
select top 4 * from libros order by id_libro
select top 4 * from libros order by id_libro desc
