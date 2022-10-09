/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.7.19 : Database - clojure_db_taskassign
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`clojure_db_taskassign` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `clojure_db_taskassign`;

/*Table structure for table `assignment` */

DROP TABLE IF EXISTS `assignment`;

CREATE TABLE `assignment` (
  `id_employee` int(11) NOT NULL,
  `id_project` int(11) NOT NULL,
  `id_assignment` int(11) NOT NULL AUTO_INCREMENT,
  `date_of_assignment` date DEFAULT NULL,
  PRIMARY KEY (`id_employee`,`id_project`,`id_assignment`),
  KEY `fk_id_project` (`id_project`),
  KEY `id_assignment` (`id_assignment`),
  CONSTRAINT `fk_id_employee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_id_project` FOREIGN KEY (`id_project`) REFERENCES `project` (`id_project`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `assignment` */

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id_department` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id_location` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_department`),
  KEY `fk_id_location` (`id_location`),
  CONSTRAINT `fk_id_location` FOREIGN KEY (`id_location`) REFERENCES `location` (`id_location`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `department` */

insert  into `department`(`id_department`,`name`,`location`,`description`,`id_location`) values (1,'IT Department','1','IT Department',1),(2,'Buss','2','Bussines Department',1),(3,'HR','3','HR Department',1);

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id_employee` int(11) NOT NULL AUTO_INCREMENT,
  `identification_number` int(11) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `max_hours` int(11) DEFAULT NULL,
  `hours_assigned` int(11) DEFAULT NULL,
  `hourly_rate` decimal(10,0) DEFAULT NULL,
  `id_department` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_employee`),
  KEY `fk_id_department` (`id_department`),
  CONSTRAINT `fk_id_department` FOREIGN KEY (`id_department`) REFERENCES `department` (`id_department`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `employee` */

insert  into `employee`(`id_employee`,`identification_number`,`employee_name`,`max_hours`,`hours_assigned`,`hourly_rate`,`id_department`) values (1,439856,'Filip Karic',176,176,'6',1),(2,657922,'Marko Peric',160,120,'7',1),(3,332156,'Petar Markovic',160,128,'5',1),(4,887634,'Petrovic Milena',144,144,'12',1),(5,330092,'Sasa Jankovic',200,160,'4',1),(6,907613,'Marija Dugic',160,80,'12',1);

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `id_location` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_location`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `location` */

insert  into `location`(`id_location`,`name`) values (1,'Belgrade'),(2,'Maribor'),(3,'6-month euribor');

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id_project` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `value` decimal(20,2) DEFAULT NULL,
  `id_projecttype` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_project`),
  KEY `fk_id_projecttype` (`id_projecttype`),
  CONSTRAINT `fk_id_projecttype` FOREIGN KEY (`id_projecttype`) REFERENCES `projecttype` (`id_projecttype`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `project` */

insert  into `project`(`id_project`,`name`,`value`,`id_projecttype`) values (1,'Nike FullOn','3000000.00',1),(2,'IvancicISinoviRebrand','120000.00',1),(3,'Lukoil Turbo','1340000.00',1),(4,'Germanizer','1520000.00',1),(5,'Heinkenen extra','10000000.00',2);

/*Table structure for table `projecttype` */

DROP TABLE IF EXISTS `projecttype`;

CREATE TABLE `projecttype` (
  `id_projecttype` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_projecttype`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `projecttype` */

insert  into `projecttype`(`id_projecttype`,`name`) values (1,'IT Project'),(2,'Business Project'),(3,'Combined');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `name_user` varchar(255) DEFAULT NULL,
  `surname_user` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`id_user`,`name_user`,`surname_user`,`username`,`password`,`role`) values (1,'Filip','Karic','filip','filip','admin'),(2,'Marko','Markovic','marko','markic','user');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
