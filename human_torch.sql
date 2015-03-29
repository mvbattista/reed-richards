# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.22)
# Database: human_torch
# Generation Time: 2015-03-29 20:37:24 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# Creation of database if exists
# ------------------------------------------------------------

DROP DATABASE IF EXISTS `human_torch`;

CREATE DATABASE `human_torch`

# Dump of table events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(64) NOT NULL DEFAULT '',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ranks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ranks`;

CREATE TABLE `ranks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `ranks` WRITE;
/*!40000 ALTER TABLE `ranks` DISABLE KEYS */;

INSERT INTO `ranks` (`id`, `name`, `description`)
VALUES
	(1,'Crew','Regular Crew Member'),
	(2,'Area Manager','Area Manager Crew Member'),
	(3,'Staff','The people with the different color shirts');

/*!40000 ALTER TABLE `ranks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shift_location_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shift_location_requests`;

CREATE TABLE `shift_location_requests` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `volunteer_id` int(11) unsigned NOT NULL,
  `shift_location_id` int(11) unsigned NOT NULL,
  `preference` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volunteer_id` (`volunteer_id`,`shift_location_id`),
  KEY `shift_location_id` (`shift_location_id`),
  CONSTRAINT `shift_location_requests_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `shift_location_requests_ibfk_2` FOREIGN KEY (`shift_location_id`) REFERENCES `shift_locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shift_locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shift_locations`;

CREATE TABLE `shift_locations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) unsigned NOT NULL,
  `description` varchar(64) NOT NULL DEFAULT '',
  `location` varchar(128) NOT NULL DEFAULT '',
  `instruction` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `shift_locations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shift_time_requests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shift_time_requests`;

CREATE TABLE `shift_time_requests` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `volunteer_id` int(11) unsigned NOT NULL,
  `shift_time_id` int(11) unsigned NOT NULL,
  `preference` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volunteer_id` (`volunteer_id`,`shift_time_id`),
  KEY `shift_time_id` (`shift_time_id`),
  CONSTRAINT `shift_time_requests_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `shift_time_requests_ibfk_2` FOREIGN KEY (`shift_time_id`) REFERENCES `shift_times` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shift_times
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shift_times`;

CREATE TABLE `shift_times` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) unsigned NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `shift_times_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shifts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shifts`;

CREATE TABLE `shifts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shift_location_id` int(11) unsigned NOT NULL,
  `shift_time_id` int(11) unsigned NOT NULL,
  `min_crew` int(11) unsigned NOT NULL DEFAULT '0',
  `max_crew` int(11) unsigned NOT NULL DEFAULT '0',
  `min_manager` int(11) unsigned NOT NULL DEFAULT '0',
  `max_manager` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `shift_location_id` (`shift_location_id`),
  KEY `shift_time_id` (`shift_time_id`),
  CONSTRAINT `shifts_ibfk_1` FOREIGN KEY (`shift_location_id`) REFERENCES `shift_locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `shifts_ibfk_2` FOREIGN KEY (`shift_time_id`) REFERENCES `shift_times` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `email_address` varchar(64) DEFAULT NULL,
  `first_name` varchar(64) NOT NULL DEFAULT '',
  `last_name` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT '',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table volunteers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volunteers`;

CREATE TABLE `volunteers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `rank_id` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `rank_id` (`rank_id`),
  CONSTRAINT `volunteers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `volunteers_ibfk_2` FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
