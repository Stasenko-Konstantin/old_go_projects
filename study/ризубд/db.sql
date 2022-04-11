SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `new_db`;

USE `new_db`;

CREATE TABLE `depart` (
                          `id` INTEGER AUTOINCREMENT NOT NULL,
                          `name` VARCHAR(30) NOT NULL,
                          PRIMARY KEY (`id`)
);

CREATE TABLE `emp` (
                       `depno` INTEGER NOT NULL DEFAULT 1,
                       `id` INTEGER AUTOINCREMENT NOT NULL,
                       `name` VARCHAR(40) NOT NULL,
                       `post` VARCHAR(20) NOT NULL,
                       `salary` DECIMAL(7,2) NOT NULL DEFAULT 10000.00,
                       `born` DATE NOT NULL,
                       `tel` VARCHAR(8) COLLATE cp1251_general_ci DEFAULT NULL,
                       PRIMARY KEY (`id`) USING BTREE,
                       KEY `depno` (`depno`) USING BTREE,
                       FOREIGN KEY (`depno`) REFERENCES `depart` (`id`)
);

CREATE TABLE `children` (
                            `tabno` INTEGER NOT NULL,
                            `name` VARCHAR(20) NOT NULL,
                            `pol` VARCHAR(1) NOT NULL DEFAULT 'm',
                            `born` DATE DEFAULT NULL,
                            PRIMARY KEY (`tabno`, `name`) USING BTREE,
                            KEY `tabno` (`tabno`) USING BTREE,
                            FOREIGN KEY (`tabno`) REFERENCES `emp` (`id`)
);

INSERT INTO `depart` (`id`, `name`) VALUES
                                           (1,'Экономический'),
                                           (2,'Бухгалтерский'),
                                           (3,'Юридический');
COMMIT;

INSERT INTO `emp` (`depno`, `id`, `name`, `post`, `salary`, `born`, `tel`) VALUES
                                                                                  (1,123,'Савельев Б.О.','Главный',15000.00,'2002-11-13','89374239'),
                                                                                  (1,124,'Гурбалаев Д.Ы.','Не главный',14000.00,'2002-04-12','85738274'),
                                                                                  (2,125,'Есаулов В.Д.','Почти главный',12000.00,'2001-09-14',NULL),
                                                                                  (2,126,'Грабунко Т.Р.','Охраник',11000.00,'2000-05-29','89567312'),
                                                                                  (2,127,'Глазунов И.Г.','Уборщик',11000.00,'2003-12-12','89537285'),
                                                                                  (2,128,'Карабанов У.С.','Консультант',12000.00,'2001-01-14',NULL),
                                                                                  (2,129,'Стратов Ж.Э.','Загонщик',12000.00,'2000-07-20','89517569'),
                                                                                  (2,130,'Варканов А.Ы.','Кассир',11000.00,'2003-02-20','89517165'),
                                                                                  (2,131,'Порозов Д.З.','Мерчендайзер',10000.00,'2002-08-14',NULL),
                                                                                  (2,132,'Даларова У.Г.','Директор',10000.00,'2002-02-23','89512525'),
                                                                                  (3,133,'Гаврилов Л.Л.','Резчик',10000.00,'2002-07-24','89514738'),
                                                                                  (3,134,'Страусов Т.Б.','Кинолог',10000.00,'2003-03-13',NULL);
COMMIT;

INSERT INTO `children` (`tabno`, `name`, `pol`, `born`) VALUES
                                                            ('123','Да','m','2014-11-20'),
                                                            ('124','Нет','g','2011-02-12'),
                                                            ('124','Может','g','2012-04-13'),
                                                            ('125','Быть','g','2020-05-15'),
                                                            ('126','Вполне','m','2010-01-30'),
                                                            ('127','Возможно','m','2009-09-20'),
                                                            ('128','Почему','m','2013-08-09'),
                                                            ('129','Бы','m','2006-06-06'),
                                                            ('130','И','m','2019-04-13'),
                                                            ('132','Нет','m','2016-11-20'),
                                                            ('133','Собственно','g','2005-04-14');
COMMIT;


