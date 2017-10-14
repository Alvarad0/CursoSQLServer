create database Escuela

use Escuela

create table Datos(
id_datos int primary key,
mail varchar(50) not null,
edad int not null,
id_alumno int not null,
CONSTRAINT FK_Alumno FOREIGN KEY (id_alumno) REFERENCES Alumnos(id_alumno)
)

create table Alumnos(
id_alumno int primary key,
nombre varchar(50) not null,
apellidos varchar(50) not null,
id_carrera int not null,
CONSTRAINT FK_Carrera FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
)

create table Carrera(
id_carrera int primary key,
carrera varchar(50) not null
)
-- Insert carreras
insert into Carrera values(1, 'Ing. Sistemas')
insert into Carrera values(2, 'Lic. Derecho')
insert into Carrera values(3, 'Lic. Administracion')

-- Insert Alumnos
insert into Alumnos values(1, 'Pablo', 'Picapiedra', 1)
insert into Alumnos values(2, 'Homero', 'Simpson', 2)
insert into Alumnos values(3, 'Bart', 'Simpson', 1)
insert into Alumnos values(4, 'March', 'Simpson', 3)

-- Insert Datos
insert into Datos values(1, 'pablo@dev.com', 22, 1)
insert into Datos values(2, 'Homero@dev.com', 14, 2)
insert into Datos values(3, 'Bart@dev.com', 21, 2)
insert into Datos values(4, 'March@dev.com', 28, 4)

select * from Alumnos
select * from Carrera
select * from Datos

/********* JOIN *********/
-- inner join
select Alumnos.nombre, Datos.mail, Carrera.carrera from Datos 
	join Alumnos on Datos.id_alumno = Alumnos.id_alumno 
	join Carrera on Alumnos.id_carrera = carrera.id_carrera
	where Alumnos.id_carrera = 12

--Cuando no coinciden no muestran registros
select * from Datos join Alumnos on Datos.id_alumno = Alumnos.id_carrera

/* left join --> Muestra todos los datos de la tabla padre a la izquierda aunque no tengan relación,
con la otra tabla con la que se realiza el join */
select * from Alumnos left join Datos on Alumnos.id_alumno = Datos.id_alumno

/* right join --> Muestra todos los datos de la tabla padre a la Derecha aunque no tengan relación,
con la otra tabla con la que se realiza el join */
select * from Datos right join Alumnos on Datos.id_alumno = Alumnos.id_alumno

-- join con group by
select Alumnos.nombre, Carrera.carrera from Datos 
	left join Alumnos on Datos.id_alumno = Alumnos.id_alumno
	left join Carrera on Alumnos.id_carrera = Carrera.id_carrera where Alumnos.id_carrera = 12
	group by Alumnos.nombre, Carrera.carrera

select Alumnos.nombre, Datos.mail, Carrera.carrera from Datos join Alumnos
	on Alumnos.id_alumno = Datos.id_alumno 
	join Carrera on Carrera.id_carrera = Alumnos.id_carrera
	where Alumnos.id_carrera = 12

--Update usando left join	
update Datos set mail = Alumnos.nombre + '@sistemas.com'
	from Datos join Alumnos
	on Datos.id_alumno = Alumnos.id_alumno
	where Alumnos.id_carrera= 12

--Agregar mas columnas a la tabla creada
alter table Carrera
add cupo_min int

alter table Carrera
add cupo_max int

--Eliminar columnas de tabla creada
alter table Carrera
drop column cupo_max

--Campos Calculados
alter table Carrera
add cupo_disponible as (cupo_max - cupo_min)

--Subconsultas
select * from Carrera where Carrera.id_carrera = (select id_carrera from Carrera where id_carrera = 12)

--//////////// SCRIPTS USADOS EN LA BD LIBRERIA ////////////
use Libreria

--Expresión in & not in
-- In se asigna un conjunto de datos y los usa para comparar contra el select
select * from Libros where id_libro not in (1,3,5,6)
-- In con subconsulta
select * from Libros where id_libro not in (select id_libro from Libros where num_pag > 500)

--Expresión = any equivalente a in y Expresión <> all equivalente a not in usadas para obtener grupos de valores y usarlos para consultar
select * from Libros order by status
select titulo, num_pag, pag_leidas from Libros where num_pag = any (select pag_leidas from Libros where pag_leidas = num_pag)
select titulo, num_pag, pag_leidas from Libros where num_pag <> all (select pag_leidas from Libros where pag_leidas = num_pag)

alter table Libros
add status varchar(20)

--Update usando la expresión de subconsultas asignando valores con campos calculados
update Libros set status = 'Terminado' where num_pag = any (select pag_leidas from Libros where pag_leidas = num_pag)
update Libros set status = 'Leyendo' where num_pag <> all (select pag_leidas from Libros where pag_leidas = num_pag)

--Delete usando la expresión de subconsultas asignando valores con campos calculados
delete Libros where num_pag = any (select pag_leidas from Libros where pag_leidas = num_pag)

create table NombreLibros(
	nombreLibros varchar(150) not null
)

select * from NombreLibros

-- insert usando una subconsulta
insert into NombreLibros (nombreLibros)
	select (titulo) from Libros

/********* VISTAS *********/
create view V_Libros as
--Sentencia SQL asignada a la Vista
	select titulo, status from Libros
--Ejecutar Vista
select * from V_Libros order by status

--Expresión para obtener la programación de una vista
sp_helptext V_Libros

--Crear Vista con cifrado
create view V_Libros2 with encryption as
	select titulo, status from Libros
select * from V_Libros2
sp_helptext V_Libros2

--Eliminar Vista
drop view V_Libros3

--Update usando una vista
select * from V_Libros2
update V_Libros2 set titulo = '3 MSC'
	where titulo = 'lolita'

--Delete usando una vista
delete V_Libros2
	where titulo = 'guerra y paz'

--with check option
--Elimina registros de la vista usando la condición con la que fue creada la vista
create view V_Leyendo as
	select titulo, status from libros
	where status = 'Leyendo' --condición
	with check option--Sentencia que obtiene la condición declarada anteriormente
	go
select * from V_Leyendo
delete from V_Leyendo

select * from V_Libros

--Update Vista creada
alter view V_Libros with encryption as
	select id_libro, titulo, status from Libros
GO
select * from V_Libros
sp_helptext V_Libros

/********* LENGUAJE DE CONTROL DE FLUJO *********/
--Estructura CASE
/*	case 
		when then
	end */
select * from Libros
go
select titulo, status = --Campos a mostrar
	case status --Campo a evaluar
		when 'Terminado' then 'Termino de leerlo' --Casos
	end --Por defecto retorna null
from Libros --Tabla de donde consulta los datos

--Estructura IF
/*	IF(Condicion)
		--Sentencia a ejecutar
	ELSE
		--Sentencia a ejecutar */
if exists (select * from Libros where status = 'Leyendo')
	BEGIN
		select titulo, status from Libros
	END
else 
	BEGIN
		select 'No hay Libros con estatus Leyendo'
	END

if exists (select * from Libros where status = 'Terminado')
	BEGIN
		select titulo, status from Libros
	END
else
	BEGIN
		select 'No hay Libros con estatus Terminado'
	END

/********* VARIABLES *********/
/* Estructura
	declare @nombreVariable TipoDato
	set @nombreVariable = valor */
select * from Libros

declare @status varchar(20)
declare @pagLeidas int
set @status = 'Leyendo'
set @pagLeidas = 200
select * from Libros where status = @status and pag_leidas > @pagLeidas

/********* PROCEDIMIENTOS ALMECENADOS *********/
create procedure LibrosTerminados  as --Creación del procedimiento
	declare @status varchar(20)
	set @status = 'Terminado'
	select titulo, status from Libros where status = @status --Sentencias del procedimiento

exec LibrosTerminados --Ejecutar Procedimiento

create procedure DML_InserLibro as
	declare @idLibro int
	declare @titulo varchar(100)
	declare @numPaginas int
	declare @pagLeidas int
	declare @status varchar(20)
	set @idLibro= 7
	set @titulo = 'Divergente'
	set @numPaginas = 874
	set @pagLeidas = 873
	set @status = ''
		
insert into Libros values (@idLibro, @titulo, @numPaginas, @pagLeidas, @status)
update Libros set status = 'Terminado' where num_pag = any (select pag_leidas from Libros where pag_leidas = num_pag)
update Libros set status = 'Leyendo' where num_pag <> all (select pag_leidas from Libros where pag_leidas = num_pag)
	exec DML_InserLibro
	
	select * from Libros

--Eliminar procedimiento almecanado
drop proc DML_InserLibro
--Sentencia para controlar errores al momento de eliminar un procedimiento almacenado que no existe
if OBJECT_ID('DML_UpdateLibros') is not null
	drop proc DML_UpdateLibros
else 
	select 'El procedimiento no Existe o ya fue Eliminado'

--Procedimiento Almacenado con Parametros de Entrada
create procedure DML_Libros
	@numPaginas int as
	select * from Libros where num_pag >= @numPaginas
	
	exec DML_Libros 800

--Procedimiento Almacenado con Parametros de Salida
create procedure DML_StatusLibros 
@status varchar(20),
@count int output as
	select COUNT(*) from Libros where status = @status

--Se declara variabla que almacenara el resultado obtenido
declare @total int
exec DML_StatusLibros 'Terminado', @total output

--Procedimiento Almecenado Return
create procedure DML_LibrosReturn
	@status varchar(20) as
	if (@status is null)
		return 0
	else
		return 1

declare @result int 
exec @result = DML_LibrosReturn null
select @result

--Sentencias de Información enfocados a Procedimientos Almacenados
sp_help --> Muestra los objectos de la BD
sp_helptext DML_LibrosReturn --> Muestra el texto que define el objeto del procedimiento almacenado
sp_stored_procedures --> Muestra todos los procedimientos almacenados
sp_depends V_Leyendo --> Muestra las dependencias del de la vista, tabla o procedimiento almacenado
select * from sysobjects --> Muestra nombre y demas datos de los objectos de la BD

--Procedimientos almacenados encriptación
alter procedure DML_LibrosReturn --Modificación del procedimiento almacenado
	@status varchar(20)
	with encryption as --Agrega encriptación
	if (@status is null)
		return 0
	else
		return 1

sp_helptext DML_LibrosReturn

--Anidación de Procedimientos Almacenados
create procedure DML_SumaLibrosTerminados
	@cantidad int output
	with encryption as
	select COUNT(*) from Libros 
		where status = 'Terminado'
		
--Procedimiento Almacenado Anidado
create procedure DML_ObtValProc
	@total int output --Variable que absorve el valor del procedimiento almacenado anidado
	with encryption as
	begin
		declare @cantidad int --Recibe el valor del procedimiento anidado
		exec DML_SumaLibrosTerminados @cantidad output
		set @cantidad = @total
	end
	
--Mostramos los datos del DML_SumaLibrosTerminados
declare @num int
exec DML_ObtValProc @num output

use Tienda
drop trigger InsertarVenta
/********* TRIGGERS *********/
create trigger InsertarVenta
	on TablaVentas
	for insert
	as 
	begin
		declare @total int
		set @total = (select SUM(cantidad) from Tablaventas)
		insert into TablaTotales values (@total, GETDATE())
		--Obtener Ultimo Id Producto insertado
		declare @id_producto int
		set @id_producto = (Select top 1 id_producto from TablaVentas order by id_venta desc)
		select @id_producto
		-- Obtener la suma de las cantidades por Id Producto
		declare @cantidad int
		set @cantidad =  (select SUM(cantidad) from TablaVentas where id_producto = @id_producto)
		update TablaAlmacen set cantidad = @cantidad where id_producto = @id_producto
	end
	
insert into TablaVentas values (3, 1);

Select * from TablaAlmacen
Select * from TablaVentas 
Select * from TablaTotales

select GETDATE ( )
update TablaTotales set Fecha = GETDATE()
select * from TablaTotales

alter table TablaTotales 
	alter column fecha datetime

