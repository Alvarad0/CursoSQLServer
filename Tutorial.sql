create table Usuarios(
id_usuario int primary key,
nombre varchar(50) not null,
edad int not null
)

drop table Usuarios;

insert into Usuarios values(1, 'Pedro', 22);
insert into Usuarios values(2, 'Pablo', 25);
insert into Usuarios values(3, 'Maria', 19);
insert into Usuarios values(4, 'Ian', 22);

select * from Usuarios
select Usuarios.id_usuario from Usuarios
select nombre, edad from Usuarios

select * from Usuarios
where edad = 22;

select nombre, edad from Usuarios
where edad <> 22

delete from Usuarios
where id_usuario = 4

truncate table Usuarios

update Usuarios set edad = 25
where id_usuario = 3
