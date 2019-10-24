CREATE DATABASE  IF NOT EXISTS `user_database`;

CREATE USER 'userdbacc'@'localhost' IDENTIFIED BY 'userdbacc';

GRANT ALL PRIVILEGES ON `user_database`.* TO 'userdbacc'@'localhost';

ALTER USER 'userdbacc'@'localhost' IDENTIFIED WITH mysql_native_password BY 'userdbacc';

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `active` boolean DEFAULT true,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


