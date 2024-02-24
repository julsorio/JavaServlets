USE musicadb2;
SET FOREIGN_KEY_CHECKS=0;

drop table conciertos;
/*
1 - crear tabla conciertos
*/
create table conciertos(
conciertoId int(10) unsigned NOT NULL AUTO_INCREMENT,
fecha DATE NOT NULL,
id_grupo INT(10) UNSIGNED NOT NULL,
ciudad VARCHAR(100) NOT NULL,
recinto VARCHAR(255) NULL,
PRIMARY KEY (conciertoId)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

alter table conciertos
add constraint fk_grupos FOREIGN KEY (id_grupo) references grupos(grupoid); 

/*
2- insertar registros
*/

INSERT INTO conciertos(fecha,id_grupo,ciudad,recinto) values
('2018-08-01',1,'Madrid','Wizink Center'),
('2018-08-08',1,'Barcelona','Palau Sant Jordi'),
('2016-09-18',2,'Philadelphia',NULL),
('2022-06-07',3,'Budapest',NULL),
('2022-07-29',3,'Barcelona','Estadio Olímpico')

select * from conciertos;

/*
3- insertar registro en conciertos con un id_grupo que no existe en grupos
*/
INSERT INTO conciertos(fecha,id_grupo,ciudad,recinto) values
('2023-01-12',99,'Madrid','Estadio Metropolitano')

/*
¿Qué sentencias se deberían ejecutar para permitir, de forma temporal, insertar un
Concierto para un Grupo desconocido (Grupo que no cumpla la restricción de Clave
Foránea)?
SET FOREIGN_KEY_CHECKS=0;

*/

/*
4 - Mostrar la Fecha del último Concierto de cada Grupo, pero sólo en caso de que el Grupo
tengan algún Concierto.
Los campos que se deben mostrar son:
?
Id Grupo
?
Nombre Grupo
?
Fecha Más Reciente
*/

select c.id_grupo, g.nombre,max(c.fecha)
from conciertos c
inner join (select grupoId,nombre from grupos) g
on g.grupoId  = c.id_grupo
group by c.id_grupo;

/*
5 - Mostrar la Fecha del último Concierto de cada Grupo. En caso de que no exista
información de Conciertos para un determinado Grupo, mostrar también el Grupo pero
con la Fecha vacía.
Los campos que se deben mostrar son:

Id Grupo

Nombre Grupo

Fecha Más Reciente
*/
select g.grupoId "id grupo", g.nombre "nombre grupo", c.fecha "fecha mas reciente"
from conciertos c right join grupos g on c.id_grupo = g.grupoId
order by c.fecha desc

/*
6 - Mostrar sólo los Grupos para los que NO exista información de Conciertos.
Los campos que se deben mostrar son:

Id Grupo

Nombre Grupo
Realizar la consulta usando dos tipos de sentencias distintas:

Con JOIN

Con una Subconsulta previa
*/

select distinct g.grupoId
from grupos g
left join conciertos c on g.grupoId = c.id_grupo
where c.id_grupo is null

--subconsulta
select g.grupoId
from grupos g
where g.grupoId not in (select c.id_grupo from conciertos c)

--subconsulta
select g.grupoId
from grupos g
where not EXISTS (select c.id_grupo from conciertos c where g.grupoId = c.id_grupo)

/*
7 - Mostrar los valores de los distintos Géneros a los que puede pertenecer un determinado
Grupo. Y mostrar el número de Géneros distintos que pueden tener los Grupos.
*/
select count(g.genero) , g.genero 
from grupos g
group by g.genero

/*
8 - Mostrar toda la información de los grupos que hayan sido creados a partir de 1980 (incluido)
*/
select * from grupos where creacion >= 1980
order by creacion asc;

/*
Mostrar después la información de los grupos creados durante la década de los 70
(1970 1979). Hacerlo de dos formas distintas.
*/
select * from grupos where creacion between 1970 and 1979
order by creacion desc;

select * from grupos where creacion in (1970, 1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979)
order by creacion desc;

/*
9 - Mostrar el Origen, la Fecha de Creación y el Nombre de todos los Grupos, ordenados
alfabéticamente por su Origen y ordenados también por Fecha de Creación, desde el
más reciente al más antiguo.
*/

/*
10-Mostrar el Nombre del Componente, el Grupo, el Instrumento y el Género del Grupo de
todos aquellos Componentes que sean Guitarristas o Bajistas, de grupos Españoles, con
género que contenga la palabra "Metal".
*/
select c.nombre "nombre componente", g.nombre "grupo", c.instrumento "instrumento", g.genero "genero"
from componentes c, grupos g
where 
c.grupoId = g.grupoId and
g.origen = 'España' and
(c.instrumento = 'Guitarra' OR  c.instrumento = 'Bajo') and
g.genero like '%Metal%'

/*
11-Mostrar los Títulos de las Canciones y el Nombre del Grupo de aquellos Grupos que NO
tengan Teclistas y que NO sean Españoles.
*/
select distinct ca.titulo,gr.nombre
from canciones ca, grupos gr, componentes co
where
ca.grupoId = gr.grupoId and
co.grupoId = gr.grupoId and
co.instrumento <> 'Teclados' and
gr.origen <> 'España'

/*
12-Mostrar los Conciertos que no tienen un Recinto informado
*/
select *
from conciertos co
where co.recinto is null;

/*
13-Actualizar la tabla de Conciertos para el concierto con Id = 3 (Concierto de "AC/DC"), de
manera que se pueda informar la Fecha correcta del Concierto, que fue 2 días después
de la que está actualmente. Y se pueda al mismo tiempo informar el Recinto en el que
fue el Concierto (Recinto = "Wells Fargo Center").
*/

update conciertos set fecha='2016-09-20', recinto='Wells Fargo Center'
where conciertoId = 3

/*
14-Modificar la tabla de Conciertos para incluir una nueva columna llamada "destacado", de
tipo Caracter y tamaño 1. Esta columna servirá para indicar los Conciertos más
Destacados de cada Grupo (destacado = "Y" --> (Yes)). Se considera que un Concierto NO
está como Destacado si la nueva columna tiene el valor "N" (No) o está sin informar
*/
alter table conciertos
add column destacado char(1) null;

/*
15-Realiza una consulta previa para obtener los Conciertos hechos en el último año (últimos
365 días). Una vez obtengas el Id de dichos Conciertos, actualiza la tabla "conciertos"
para indicar que dichos Conciertos (los del último año) NO se consideran Destacados
(destacado = N
*/
UPDATE conciertos AS s, (SELECT conciertoId  FROM conciertos where fecha between '2023-01-01' and '2023-12-31') AS p
SET s.destacado='N' 
WHERE s.conciertoId = p.conciertoId

/*
16-Actualiza el Concierto con Id = 1, para indicar que SÍ es Destacado (destacado = Y).
Después de eso haz una consulta que devuelva todos los Conciertos que NO se
consideran Destacados.
*/
update conciertos set destacado = 'Y'
where conciertoId = 1

select * from conciertos where destacado <> 'N'

/*
17-Inserta un nuevo Concierto para el Grupo "
Guns N Roses" ( id_grupo = 4) con Fecha
"01/08/2024" en el "Estadio de Wembley" de Londres, que quede explícitamente
marcado como NO destacado.
Tras insertar el registro, comprueba qué Id de Concierto se ha generado (Ej.:
conciertoId
=
Después borra de la tabla "conciertos" ese nuevo registro que se ha creado (
id_grupo =
4).
*/
insert into conciertos (fecha, id_grupo, ciudad, recinto, destacado)
 values('2024-08-01',4,'Londres','Estadio de Wembley','N');

select * from conciertos where fecha = '2024-08-01'

delete from conciertos where conciertoId = 9;

/*
18 - Mostrar sólo los tres Conciertos más antiguos.
*/
select * from conciertos order by fecha asc limit 3

/*
19 -Muestra la Fecha de Creación de los Grupos más Antigua y más Reciente, en una misma
consulta.
*/

/*
20-Modificar la tabla de Conciertos para incluir una nueva columna llamada "espectadores",
de tipo Entero Sin Signo y tamaño 10. Después de ello, actualizar la tabla con distintas
sentencias de manera que los Conciertos tengan el siguiente número de Espectadores,
según el Id del Grupo:
*/
alter table conciertos
add column espectadores int(10) unsigned;

update conciertos c
join grupos g on c.id_grupo = g.grupoId
set c.espectadores = g.grupoId
where c.id_grupo = g.grupoId

update conciertos
set espectadores = 10000 where id_grupo = 1;

update conciertos
set espectadores = 20000 where id_grupo = 2;

update conciertos
set espectadores = 30000 where id_grupo = 3;

update conciertos
set espectadores = 40000 where id_grupo = 4;

/*
21-Calcula la Suma de todos los Espectadores de los Conciertos celebrados en España.
*/
select sum(c.espectadores)
from conciertos c where
c.ciudad in ('Madrid', 'Barcelona')

/*
22-Muestra aquellos Conciertos que tengan un
Nº de Espectadores superior a la Media de
todos los Conciertos.
*/
select c.conciertoId, c.ciudad, c.espectadores
from conciertos c
group by c.conciertoId
having c.espectadores > avg(c.espectadores)

/*
23-Muestra en una sola columna el resultado de Concatenar el Nombre del Vocalista de
cada Grupo, junto con el Nombre el Grupo y Año de Creación (entre paréntesis).
Ejemplo:
James Hetfield Metallica (1981)
*/
select CONCAT(co.nombre, " ", gr.nombre, " (", gr.creacion, ")")
from componentes co join grupos gr on co.grupoId = gr.grupoId

/*
24-Muestra todos los Conciertos, aunque no sean de un Grupo conocido.
Los campos que se deben mostrar son:

Nº
Concierto

Fecha

Ciudad

Id Grupo

Nombre Grupo
*/

select co.conciertoId "Nº Concierto", co.fecha "Fecha", co.ciudad "Ciudad", gr.grupoId "Id Grupo", gr.nombre "Nombre Grupo"
from conciertos co join grupos gr on co.id_grupo = gr.grupoId

/*
25-Mostrar las Ciudades, el Id de los Conciertos y las Fechas en caso de que haya habido
distintos Conciertos en una misma Ciudad. Para ello realiza un JOIN de la tabla
"conciertos" consigo misma.
Los campos que se deben mostrar son:

Ciudad

Nº
Concierto 1

Fecha Concierto 1

Nº
Concierto 2

Fecha Concierto 2
*/
select co.ciudad "ciudad", co.conciertoId "concierto 1", co.fecha "fecha concierto 1", con.conciertoId "concierto 2", con.fecha "fecha concierto 2"
from conciertos co join conciertos con on co.conciertoId = con.conciertoId
where co.ciudad = con.ciudad

/*
26-Inserta un nuevo Concierto para el Grupo "Mago de Oz" (
id_grupo = 9) con Fecha
"18/12/2015" en el "Estadio Neza" de "Ciudad de México". Será un Concierto marcado
como Destacado. Y con 25000 espectadores.
6
Una vez hecho, muestra la información de los Conciertos como el UNION de dos
Una vez hecho, muestra la información de los Conciertos como el UNION de dos consultas:consultas:
1.
1.
La primera debe mostrar los Conciertos de todos los Grupos Españoles
La primera debe mostrar los Conciertos de todos los Grupos Españoles
2.
2.
La segunda debe mostrar los Conciertos de todos los Grupos Extranjeros
La segunda debe mostrar los Conciertos de todos los Grupos Extranjeros
Los campos que se deben mostrar son:
Los campos que se deben mostrar son:


Tipo Grupo: Con los literales 'Español' o 'Extranjero', en función del Origen del
Tipo Grupo: Con los literales 'Español' o 'Extranjero', en función del Origen del GrupoGrupo


Nº Concierto
Nº Concierto


Fecha
Fecha


Ciudad
Ciudad


Id Grupo
Id Grupo


Nombre Grupo
Nombre Grupo
*/

insert into conciertos(fecha,id_grupo,ciudad,recinto,destacado,espectadores)
values('2015-12-18',9,'Ciudad de México','Estadio Neza','Y',25000);

select case when gr.origen = 'España' then 'Español' end as "Tipo Grupo", co.conciertoId "No Concierto", co.fecha "Fecha", co.ciudad "Ciudad", co.id_grupo "Id Grupo", gr.nombre "Nombre Grupo"
from conciertos co
inner join grupos gr on co.id_grupo = gr.grupoId
where gr.origen = 'España'
UNION
select case when gr.origen <> 'España' then 'Extranjero' end as "Tipo Grupo", co.conciertoId "No Concierto", co.fecha "Fecha", co.ciudad "Ciudad", co.id_grupo "Id Grupo", gr.nombre "Nombre Grupo"
from conciertos co
inner join grupos gr on co.id_grupo = gr.grupoId
where gr.origen <> 'España'

/*
27 - Muestra el
Nº de Componentes que tiene cada Grupo, ordenando los resultados desde
el Grupo que tiene más Componentes hasta el que tiene menos.
Los campos que se deben mostrar son:

Id Grupo

Nombre Grupo

Nº
Componentes
*/
select gr.grupoId "Id Grupo", gr.nombre "Nombre Grupo", count(co.componenteId) "No Componentes"
from componentes co join grupos gr
on co.grupoId = gr.grupoId
group by gr.grupoId , gr.nombre

/*
28-Muestra el número Medio de Espectadores que han tenido todos los Conciertos de una
misma Ciudad, para aquellos casos en los que la Media de Espectadores haya sido igual
o superior a 25000.
Los campos que se deben mostrar son:

Ciudad

Media Espectadores: Redondeando el valor de forma que no tenga decimales
*/
select c1.ciudad "Ciudad", round(AVG(c1.espectadores)) "Media Espectadores"
from conciertos c1 join conciertos c2
on c1.conciertoId = c2.conciertoId
where 
c1.ciudad = c2.ciudad 
group by c1.ciudad
having AVG(c1.espectadores) >= 25000

/*
29-Crear la nueva tabla "
canciones_esp " con las mismas columnas de la tabla actual
"canciones". Es

songId
Tipo " Integer " de 10 posiciones, sin signo. No nula. Y que se genere de
forma automática. Será la Clave Primaria de nuestra tabla ( Primary Key (PK))

grupoId
Tipo " Integer " de 10 posiciones, sin signo. No

titulo
Tipo  Varchar  de 250 posiciones. No

album
Tipo  Varchar  de 250 posiciones. No nula
Una vez creada, usar una sentencia INSERT INTO para insertar en la nueva tabla
canciones_esp " todas las canciones de Grupos Españoles que existan actualmente en la
tabla "canciones".

*/
create table canciones_esp
(
   songId int(10) unsigned NOT NULL AUTO_INCREMENT,
   grupoId int(10) unsigned NOT NULL,
   titulo varchar(250) NOT NULL,
   album varchar(250) NOT NULL,
   PRIMARY KEY(songId)
);

insert into canciones_esp (grupoId,titulo,album)
select ca.songId, ca.titulo, ca.album
from canciones ca join grupos gr on ca.grupoId = gr.grupoId
where gr.origen = 'España'

select * from canciones_esp

/*
30-Muestra la información de todos los Grupos de música, incluyendo una columna
adicional en el resultado de la consulta que nos diga el "Tipo Grupo", con los siguientes
valores:

Español

Extranjero
Para informar la columna con ese resultado, utilizar una sentencia "CASE".
Los campos que se deben mostrar son:

Id Grupo

Nombre Grupo

Origen

Tipo Grupo: Con los literales 'Español' o 'Extranjero', en función del Origen del
Grupo

*/
select gr.grupoId "Id Grupo", gr.nombre "Nombre Grupo", gr.origen "Origen", case when gr.origen = 'España' then 'Español' when gr.origen <> 'España' then 'Extranjero' end as "Tipo Grupo"
from grupos gr

/*
31 - Mostrar la información de todos los Conciertos, mostrando una columna "Nº
Espectadores" con el texto 'Desconocido' en caso de que no esté informado el dato de
Nº de Espectadores.
Los campos que se deben mostrar son:
8


Nº
NºConciertoConcierto


Fecha
Fecha


Id Grupo
Id Grupo


Ciudad
Ciudad


Nº
NºEspectadores: Valor numérico o literal 'Desconocido' en caso de no estar Espectadores: Valor numérico o literal 'Desconocido' en caso de no estar informadoinformado
*/
select co.conciertoId "No Concierto", co.fecha "Fecha", gr.grupoId "Id Grupo", co.ciudad "Ciudad", coalesce(co.espectadores, 'Desconocido')
from conciertos co join grupos gr on co.id_grupo = gr.grupoId

/*
Crear un Procedimiento Almacenado llamado "
BuscarComponente " al que se le pasen
dos parámetros de entrada:

pInstrumento
= Instrumento del Componente del Grupo

pGrupo
= Nombre del Grupo
Y que devuelva el Nombre del Componente o Componentes de ese Grupo que toque ese
Instrumento. Se asume que el parámetro " pGrupo " puede no contener el Nombre
completo.
Los campos que se deben mostrar son:

Nombre Componente

Nombre Grupo

Instrumento
Ejecutar el Procedimiento Almacenado con los siguientes parámetros, y comprobar el
resultado:

pInstrumento
= '

pGrupo
= Iron 
*/

DELIMITER //
create procedure BuscarComponente(IN pInstrumento varchar(25), IN pGrupo varchar(45))
begin
select co.nombre, gr.nombre, co.instrumento
from componentes co join grupos gr on co.grupoId = gr.grupoId
where co.instrumento = pInstrumento and 
gr.nombre LIKE CONCAT('%', pGrupo,'%');
end
//
DELIMITER ;

CALL BuscarComponente('Guitarra', 'Iron');

/*
33-Utiliza los símbolos de "Comentarios" de una sola línea para comentar la primera
condición de la cláusula WHERE de la siguiente consulta.
Haz lo mismo con los símbolos de "Comentarios" de múltiples líneas para comentar las
condiciones segunda y tercera de la consulta.
9
SELECT * FROM grupos
SELECT * FROM grupos
WHERE
WHERE
origen = 'Estados Unidos' OR
origen = 'Estados Unidos' OR
origen = 'Reino Unido' OR
origen = 'Reino Unido' OR
origen = 'España' OR
origen = 'España' OR
origen
origen= 'Australia'= 'Australia'
ORDER BY
ORDER BY grupoIdgrupoId;;
*/
select * from grupos
where 
--origen = 'Estados Unidos' or
/*origen = 'Reino Unido' or
origen = 'España' or*/
origen = 'Australia'
order by grupoId;

/*
34-Utiliza las cláusulas CASE y el operador "Módulo" (Resto División
--> %) para indicar si el
Nº de Espectadores en un concierto es Múltiplo de 20000 o no.
Los campos que se deben mostrar son:
•
Nº
Concierto
•
Ciudad
•
Recinto
•
Nº
Espectadores
•
Espectadores Múltiplo: Literal 'Múltiplo 20000' en caso de que el
Nº de
Espectadores de un concierto sea Múltiplo de 20000. Literal 'No Múltiplo' en caso
contrario.
*/

select co.conciertoId "No Concierto", co.ciudad "Ciudad", co.recinto "Recinto", co.espectadores "No Espectadores", case when mod(co.espectadores, 20000) then 'Multiplo 20000' else 'No Multiplo' end as "Espectadores Multiplo"
from conciertos co;

/*
35-Crea una Base de Datos nueva llamada "
BBDD_Prueba ". Después de comprobar que se
ha creado correctamente, Borra esa nueva Base de Datos recién creada.
*/
create database BBDD_Prueba;
drop database BBDD_Prueba;

/*
36-Modifica la Tabla "
canciones_esp ", creada anteriormente, de manera que la Columna
album " pase a tener el tipo de dato "VARCHAR(100)", y pueda contener el valor vacío
(NULL)
*/
alter table canciones_esp
modify column album varchar(100) null;

/*
37-Modifica la Tabla "
canciones_esp " de manera que se incluya una nueva Restricción por la
cual la combinación de las Columnas "titulo" y " album " sea Única (no se pueda repetir).
Después de ello ejecuta una sentencia para Insertar una Canción con un Título y Álbum que ya exista en la Tabla (aunque sea de un Grupo distinto). Y comprueba qué Error se que ya exista en la Tabla (aunque sea de un Grupo distinto). Y comprueba qué Error se muestra.muestra.
NOTA: Utilizar la cláusula ADD CONSTRAINT … UNIQUE

*/
alter table canciones_esp
add constraint titulo_album_unq unique(titulo,album);

insert into canciones_esp(grupoId,titulo,album) values (3,'La vida en un beso','Revolución');

/*
38 - Modifica la Tabla "grupos" de manera que se incluya una nueva Restricción por la cual la
Columna " creacion " esté comprendida entre los años 1900 y 2100 (incluidos). Después
de ello ejecuta una sentencia para Insertar un nuevo Grupo que haya sido creado fuera
de ese rango de fechas. Y comprueba qué Error se muestra.
NOTA: Utilizar la cláusula ADD CONSTRAINT … CHECK

*/
alter table grupos
add constraint creacion_check check(creacion between 1900 and 2100);

select * from grupos;
insert into grupos(nombre,creacion,origen,genero, discograficaIdActual) values ('20 seconds to mars',1800, 'Estados Unidos','Rock',4);

/*
39 - Modifica la Tabla "grupos" de manera que se incluya el valor por Defecto "España" en la
Columna "origen". Después de ello ejecuta una sentencia para Insertar un nuevo Grupo
que no tenga la columna "origen" informada. Y comprueba si se informa
automáticamente con el valor por Defecto.
NOTA: Utilizar la cláusula ALTER … SET DEFAULT
*/
alter table grupos
alter origen set default 'España';
insert into grupos(nombre,creacion,genero, discograficaIdActual) values ('20 seconds to mars',2000, 'Rock',4);
select * from grupos;

/*
40-Crea un Índice en la Tabla "
canciones_esp " que sea
Único y que esté formado por las Columnas "titulo"
y " album ". Después de ello, comprueba en "MySQL
Workbench " que en la Tabla canciones_esp " se ha
generado el nuevo Índice dentro de la carpeta
"Indexes", y que está formado por esas dos
Columnas:
*/
alter table canciones_esp
add index canciones_esp_indx (titulo,album);

/*
41-Mostrar la información de todos los Conciertos que se hayan realizado antes de 40
años desde la Creación del Grupo.
Los campos que se deben mostrar son:
•
Nº
Concierto
•
Nombre Grupo
•
Creación Grupo
•
Fecha Concierto
•
Año Concierto
•
Diferencia Años: Como la Diferencia entre el Año en el que se ha hecho el
Concierto y el Año de Creación del Grupo
NOTA: Utilizar la función YEAR()
*/
select co.conciertoId "No Concierto", gr.nombre "Nombre Grupo", gr.creacion "Creacion Grupo", co.fecha "Fecha Concierto", (year(co.fecha) - gr.creacion) "Diferencia Años"
from conciertos co inner join grupos gr on co.id_grupo = gr.grupoId;

/*
42 - Crea un Vista llamada 
Conciertos_EEUU  en la que se muestren los Conciertos de
Grupos que sean de "Estados Unidos".
Los nombres de las Columnas de la Vista serán:
Num_Concierto
Fecha_Concierto
Ciudad
Id_Grupo
Nombre_Grupo
Origen_Grupo
*/
create view conciertos_EEUU as
(
select co.conciertoId "Num_Concierto", co.fecha "Fecha_Concierto", co.ciudad "Ciudad", gr.grupoId "Id_Grupo", gr.nombre "Nombre_Grupo", gr.origen "Origen_Grupo"
from conciertos co join grupos gr on co.id_grupo = gr.grupoId
where gr.origen = 'Estados Unidos'
);
select * from conciertos_EEUU;

/*
43-Mostrar los distintos Componentes de los Grupos de aquellos Conciertos que están
en la Vista " Conciertos_EEUU
12
Los campos que se deben mostrar son:
Los campos que se deben mostrar son:
•
•
Id_Grupo
Id_Grupo
•
•
Nombre_Grupo
Nombre_Grupo
•
•
Nombre_Componente
Nombre_Componente
•
•
Instrumento
Instrumento
*/
select con.Id_Grupo, con.Nombre_Grupo, comp.nombre, comp.instrumento
from conciertos_EEUU con, componentes comp
where
con.Id_Grupo = comp.grupoId
group by con.Id_Grupo,con.Id_Grupo, con.Nombre_Grupo, comp.nombre, comp.instrumento;

/*
44-Mostrar el Título en Mayúsculas y el
Nº de Caracteres de la Canción que tenga el Título
más largo en la tabla “canciones”.
NOTA: Utilizar los operadores UCASE, CHAR_LENGTH y MAX
*/
select ucase(c.titulo) "titulo",max(char_length(c.titulo)) "No de Caracteres"
from canciones c
group by c.titulo
order by 2 desc limit 1;

/*
45 - Mostrar la primera palabra del Título de cada Canción de la tabla “canciones”. Para ello,
habrá que buscar en qué posición del Título está el primer carácter de espacio (" ").
Y mostrar todos los caracteres del Título, empezando por la izquierda, hasta esa
Posición.
En caso de que el Título no tenga ningún espacio, se deberá mostrar el Título completo.
*/
select ca.songId "No Cancion", ca.titulo "Titulo Completo", position(" " in ca.titulo) "Posicion Primer Espacion", 
case when position(" " in ca.titulo) = 0 then ca.titulo else left(ca.titulo, position(" " in ca.titulo)) end as "Primera Palabra"  
from canciones ca;

/*
46 - Mostrar la Columna "
album " de la tabla "canciones" sin espacios en blanco a derecha e
izquierda. Y completando el texto por la derecha con guiones (" ("--") hasta llegar a 25
caracteres.
NOTA: Utilizar los operadores RPAD y TRIM
*/
select rpad(trim(ca.album), 25, "-")
from canciones ca;

/*
47 - Mostrar la Antigüedad de todos los Conciertos en Días.
NOTA: Utilizar las funciones DATEDIFF() y CURRENT_DATE()
*/
select co.conciertoId "No Concierto", co.fecha "Fecha Concierto",  datediff(CURRENT_DATE(), co.fecha)"Antiguedad [Dias]"
from conciertos co;

/*
48 - Mostrar la Fecha y Hora actuales, el Nombre del Día de la Semana que es hoy y el
Nombre del Mes.
IMPORTANTE: Hacer la consulta sobre la tabla “DUAL”. Es una tabla especial que existe
de forma predeterminada en las instalaciones de BB.DD. y que sirve para ejecutar
operaciones genéricas.
(Ej.: SELECT 10+20 FROM DUAL;
--> Devuelve como resultado

*/
select current_timestamp() "Fecha y Hora", dayofweek(current_date()) "Nombre del Día de la Semana", monthname(current_date()) "Nombre del Mes" from dual;

/*
49 - Mostrar los Títulos de todas las Canciones de la tabla "canciones_esp " en Mayúsculas y Sin tildes
NOTA: Utilizar los operadores UCASE y REPLACE
*/
select ucase(replace(replace(replace(replace(REPLACE(ca.titulo, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u')) "Titulos"
from canciones_esp ca;s

/*
50 - Realiza la misma consulta que el Ejercicio 30, pero con la cláusula IF en vez de CASE.
Es decir, muestra la información de todos los Grupos de música, incluyendo una
columna adicional en el resultado de la consulta que nos diga el "Tipo Grupo", con los
siguientes valores:
•
Español
•
Extranjero
Para informar la columna con ese resultado, utilizar una sentencia "IF".
Los campos que se deben mostrar son:
•
Id Grupo
•
Nombre Grupo
•
Origen
•
Tipo Grupo: Con los literales 'Español' o 'Extranjero', en función del Origen del
Grupo
*/
select gr.grupoId "Id Grupo", gr.nombre "Nombre Grupo", gr.origen "Origen", if(gr.origen ='España', 'Español' , 'Extranjero') as "Tipo Grupo"
from grupos gr;