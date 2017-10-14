create database libreria2;
 
use libreria2;
 
 
create table libros
(
id_libro int identity primary key,
titulo varchar(50)not null,
descricion varchar(100),
autor varchar(50) not null,
precio_venta int not null,
precio_compra float not null
)   
 
insert into libros values('el arbol mistico','librode misterio','daniel cortez',128,111);
insert into libros values('el canguro saltarin','libro infantil','pariana perez',189,154);
insert into libros values('el gran secreto','libro de misterio','roxana pilar',254,212);
insert into libros values('ladron de sueos','libro de fantasia','carlos mantilla',321,298);
insert into libros values('programacion en PHP','libro de programacion','david hackro' ,256,231);
insert into libros values('programacion java','libro de programacion','tatiana romero',411,356);
insert into libros values('el caracol felis','libro infantin','gael vega',123,111);
insert into libros values('los misterios del mar','libro de misterios','pedro arturo',232,211);
insert into libros values('los lugares mas aterradores','libro de misterio','karla sanches',453,321);
insert into libros values('lluvia de sal','libro de fantacia','steve roll',200,154);