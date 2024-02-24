/*SQL EJERCICIOS PARTE 1*/

use musicadb2;
--EJERCICIO 1: CLAVES FORÁNEAS (FOREING KEYS)
--a
CREATE TABLE discograficas (
discograficaId int(10) not null auto_increment,
discografica varchar (250) not null,
primary key (discograficaId));

--b
insert into discograficas
(discografica)
VALUES 
('Metal Blade Records'),('Megaforce Records'),('EMI Records'),('Epic Records'),('Sony Music'),
('Columbia Records'),('Capitol Records'),('Warner Music'),('RCA Records'),('Universal Music');

--c
alter table grupos
add column (discograficaIdActual int(10) not null) 

--d
delete from grupos

ALTER TABLE grupos ADD CONSTRAINT fk_discografica FOREIGN KEY (discograficaIdActual) 
REFERENCES discograficas(discograficaId) ON DELETE CASCADE ON UPDATE CASCADE;

--e
insert into grupos
(grupoId, nombre, creacion, origen, genero, discograficaIdActual)
VALUES
(1, 'Metallica',1981,'Estados Unidos','Heavy Metal',99);
/*Error: Cannot add or update a child row: a foreign key constraint fails (`musicadb2`.`grupos`, CONSTRAINT `fk_discografica` FOREIGN KEY (`discograficaIdActual`) 
REFERENCES `discograficas` (`discograficaId`) ON DELETE CASCADE ON UPDATE CASCADE)*/

insert into grupos
(grupoId, nombre, creacion, origen, genero, discograficaIdActual)
VALUES
(1,'Metallica',1981,'Estados Unidos','Heavy Metal',2),(2,'ACDC',1973,'Australia','Hard rock',4),
(3,'Iron Maiden',1975,'Reino Unido','Heavy Metal',5),(4,'Guns N Roses',1985,'Estados Unidos','Hard rock',8),
(5,'Queen',1970,'Reino Unido','Rock',10),(6,'WarCry',1996,'España','Heavy Metal',3),
(7,'Tierra Santa',1997,'España','Heavy Metal',5),(8,'Baron Rojo',1980,'España','Hard rock',8),
(9,'Mago de Oz',1988,'España','Folk metal',9),(10,'Medina Azahara',1979,'España','Hard rock',10);

--f
DELETE FROM discograficas
WHERE
discograficaId = 10;

--g
insert into discograficas
(discograficaId, discografica)
VALUES 
(10,'Universal Music');

insert into grupos
(grupoId, nombre, creacion, origen, genero, discograficaIdActual)
VALUES
(5,'Queen',1970,'Reino Unido','Rock',10),(10,'Medina Azahara',1979,'España','Hard rock',10);


--EJERCICIO 2 CONSULTAS AVANZADAS
--1 ORDER BY y LIMIT
SELECT nombre, creacion
FROM
grupos
ORDER BY creacion DESC
limit 1;
--1 Operador MAX y subconsulta

select nombre, creacion
FROM
grupos where creacion = (select MAX(creacion) from grupos);

--2 COUNT y GROUP BY
SELECT
discograficaIdActual AS "Id Discográfica", COUNT(*) AS "Nº Grupos"
FROM grupos
GROUP BY
discograficaIdActual
ORDER BY
discograficaIdActual

--3
SELECT
grupoId AS "Id Grupo", COUNT(*) AS "Nº Guitarristas"
FROM
componentes
WHERE
instrumento = 'Guitarra'
GROUP BY
grupoId
HAVING COUNT(*) > 1
ORDER BY
grupoId

--4
select * from canciones where titulo = album

--5
SELECT
*
FROM componentes
WHERE grupoId IN ( SELECT grupoId FROM grupos WHERE discograficaIdActual IN ( SELECT discograficaId FROM discograficas WHERE discografica LIKE '%Music'));

select  c.*, d.discografica
from componentes c, grupos g, discograficas d
WHERE 
g.discograficaIdActual = g.grupoId and
c.grupoId = g.grupoId and
d.discografica LIKE '%Music'

--6
select concat( c.titulo , "(", c.album , ")" )
from canciones c

--ejercicio 3
--1
select d.discografica, g.nombre
from grupos g, discograficas d
where
g.discograficaIdActual = d.discograficaId;



--2
select d.discografica, g.nombre
from grupos g inner join discograficas d on g.discograficaIdActual = d.discograficaId

--3
set FOREIGN_KEY_CHECKS=1
select * from grupos;
update grupos set discograficaIdActual = 99 where grupoId = 1; -- discograficaIdActual=2

select d.discografica, g.nombre
from grupos g left join discograficas d on g.discograficaIdActual = d.discograficaId

--4
select d.discografica as "discografica", g.nombre as "grupo"
from grupos g right join discograficas d on g.discograficaIdActual = d.discograficaId

--5
select * from componentes where instrumento = 'Voz' --todos los cantantes
union
select * from componentes where instrumento != 'Voz'; --todos los musicos

--6
select can.titulo, can.album, gru.nombre
from canciones can, discograficas dis, grupos gru
where
can.grupoId = gru.grupoId and
gru.discograficaIdActual = dis.discograficaId
order by gru.grupoId, can.songId

select 
g.grupoId AS "Id Grupo", g.nombre AS "Grupo",
d.discograficaId AS "Id Discográfica", d.discografica AS "Discográfica",
c.songId as "Id Canción", c.titulo as "Canción", c.album as "album"
from grupos g left join discograficas d on g.discograficaIdActual = d.discograficaId
left join canciones c on c.grupoId = g.grupoId
order by g.grupoId, c.songId

--7
select g.nombre, c.titulo, c.album, d.discograficaId AS "Id Discográfica", d.discografica AS "Discográfica"
from grupos g left join discograficas d on g.discograficaIdActual = d.discograficaId
right join canciones c on c.grupoId = g.grupoId
where (g.origen <> 'España' or g.origen is null)
order by g.grupoId, c.songId

--8
select count(g.grupoId),d.discografica, d.discograficaId
from grupos g right join discograficas d on g.discograficaIdActual = d.discograficaId
group by d.discograficaId 

--ejercicio 4
--1
select c.titulo "titulo cancion",c.album "album",g.grupoId "id grupo", g.nombre "nombre grupo",d.discografica "discografica"
from grupos g inner join canciones c on g.grupoId = c.grupoId
inner join discograficas d on g.discograficaIdActual = d.discograficaId
where g.origen = 'España'

create view vista_canciones_espanolas as select c.titulo "titulo cancion",c.album "album",g.grupoId "id grupo", g.nombre "nombre grupo",d.discografica "discografica"
from grupos g inner join canciones c on g.grupoId = c.grupoId
inner join discograficas d on g.discograficaIdActual = d.discograficaId
where g.origen = 'España' order by g.grupoId, c.songId

drop view vista_canciones_espanolas 

select * from vista_canciones_espanolas;

--2
select c.titulo "titulo cancion",c.album "album",g.grupoId "id grupo", g.nombre "nombre grupo",d.discografica "discografica"
from grupos g inner join canciones c on g.grupoId = c.grupoId
inner join discograficas d on g.discograficaIdActual = d.discograficaId
where g.origen <> 'España'

create view vista_canciones_extranjeras as select c.titulo "titulo cancion",c.album "album",g.grupoId "id grupo", g.nombre "nombre grupo",d.discografica "discografica"
from grupos g inner join canciones c on g.grupoId = c.grupoId
inner join discograficas d on g.discograficaIdActual = d.discograficaId
where g.origen <> 'España' order by g.grupoId, c.songId

select * from vista_canciones_extranjeras;

--3
select * from vista_canciones_extranjeras
union
select * from vista_canciones_espanolas

--ejercicio 5
--1
DELIMITER //
CREATE PROCEDURE
BuscarCancion (IN pCancion VARCHAR(250))
BEGIN
SELECT
gru.grupoId AS "Id Grupo", gru.nombre AS "Grupo",
dis.discograficaId AS "Id Discográfica", dis.discografica AS "Discográfica",
can.songId as "Id Canción", can.titulo as "Canción", can.album as "ALBUM"
FROM
grupos gru
LEFT JOIN discograficas dis ON gru.discograficaIdActual = dis.discograficaId
RIGHT JOIN canciones can ON  gru.grupoId = can.grupoId
WHERE can.titulo like CONCAT('%',pCancion,'%');
END
//
DELIMITER ;



select * from canciones limit 2,3;

create table pregunta13 (codigo int , descripcion varchar(20), fecha date);
insert into pregunta13(codigo, descripcion, fecha) values (1,'Registro 1','2023-08-15'),(2,'Registro 2','2023-08-15'),(3,'Registro 3','2023-08-30'),(4,'Registro 4','2023-09-15'),(5,'Registro 5','2023-09-15'),(6,'Registro 6','2023-09-15')

select * from pregunta13;

select fecha as "fecha"--, count(fecha) as "numero"
from pregunta13
group by fecha
having count(fecha) > 1
order by count(fecha) asc
limit 1;