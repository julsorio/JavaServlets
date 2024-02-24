-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.61-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema musicadb2
--

CREATE DATABASE IF NOT EXISTS musicadb2;
USE musicadb2;

--
-- Definition of table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
CREATE TABLE `grupos` (
  `grupoId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `creacion` int(4) NOT NULL,
  `origen` varchar(45) NOT NULL,
  `genero` varchar(45) NOT NULL,
  PRIMARY KEY (`grupoId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `grupos`
--

/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` (`grupoId`,`nombre`,`creacion`,`origen`,`genero`) VALUES 
 (1,'Metallica',1981,'Estados Unidos','Heavy Metal'),
 (2,'ACDC',1973,'Australia','Hard rock'),
 (3,'Iron Maiden',1975,'Reino Unido','Heavy Metal'),
 (4,'Guns N Roses',1985,'Estados Unidos','Hard rock'),
 (5,'Queen',1970,'Reino Unido','Rock'),
 (6,'WarCry',1996,'España','Heavy Metal'),
 (7,'Tierra Santa',1997,'España','Heavy Metal'),
 (8,'Baron Rojo',1980,'España','Hard rock'),
 (9,'Mago de Oz',1988,'España','Folk metal'),
 (10,'Medina Azahara',1979,'España','Hard rock');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;

--
-- Definition of table `componentes`
--

DROP TABLE IF EXISTS `componentes`;
CREATE TABLE `componentes` (
  `componenteId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `grupoId` int(10) unsigned NOT NULL,
  `instrumento` varchar(25) NOT NULL,
  PRIMARY KEY (`componenteId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `componentes`
--

/*!40000 ALTER TABLE `componentes` DISABLE KEYS */;
INSERT INTO `componentes` (`componenteId`,`nombre`,`grupoId`,`instrumento`) VALUES 
 (1,'Manuel Martínez',10,'Voz'),
 (2,'Paco Ventura',10,'Guitarra'),
 (3,'Juanjo Cobacho',10,'Bajo'),
 (4,'Manuel Ibañez',10,'Teclados'),
 (5,'Nacho Santiago',10,'Bateria'),
 (6,'Javier Domínguez',9, 'Voz'),
 (7,'Juan Carlos Marín',9,'Guitarra'),
 (8,'Fernando Mainer',9,'Bajo'),
 (9,'Javi Díez',9,'Teclados'),
 (10,'Txus di Fellatio',9,'Bateria'),
 (11,'Carlos Prieto',9,'Violín'),
 (12,'Carlos de Castro',8,'Guitarra'),
 (13,'Armando de Castro',8,'Voz'),
 (14,'Rafa Díaz',8,'Bateria'),
 (15,'Javier Rodríguez',8,'Bajo'),
 (16,'Ángel San Juan', 7, 'Voz'),
 (17,'Dan Díez',7,'Guitarra'),
 (18,'Roberto Gonzalo',7,'Bajo'),
 (19,'Juanan San Martín',7,'Teclados'),
 (20,'David Carrica',7,'Bateria'),
 (21,'Víctor García', 6, 'Voz'),
 (22,'Pablo García',6,'Guitarra'),
 (23,'Roberto García',6,'Bajo'),
 (24,'Rafael Yugueros',6,'Bateria'),
 (25,'Freddie Mercury',5,'Voz'),
 (26,'John Deacon',5,'Bajo'),
 (27,'Roger Taylor',5,'Bateria'),
 (28,'Brian May',5,'Guitarra'),
 (29,'Axl Rose',4,'Voz'),
 (30,'Duff McKagan',4,'Bajo'),
 (31,'Slash',4,'Guitarra'),
 (32,'Dizzy Reed',4,'Teclados'),
 (33,'Frank Ferrer',4,'Bateria'),
 (34,'Bruce Dickinson',3,'Voz'),
 (35,'Nicko McBrain',3,'Bateria'),
 (36,'Janick Gers',3,'Guitarra'),
 (37,'Steve Harris',3,'Bajo'),
 (38,'Dave Murray',3,'Guitarra'),
 (39,'Adrian Smith',3,'Teclados'),
 (40,'Angus Young',2,'Guitarra'),
 (41,'Chris Slade',2,'Bateria'),
 (42,'Stevie Young',2,'Guitarra'),
 (43,'Brian Johnson',2,'Voz'),
 (44,'James Hetfield',1,'Voz'),
 (45,'Kirk Hammett',1,'Guitarra'),
 (46,'Cliff Burton',1,'Bajo'),
 (47,'Lars Ulrich',1,'Bateria');
/*!40000 ALTER TABLE `componentes` ENABLE KEYS */;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
