/*Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”*/
drop database if exists vk1;
create database vk1;
use vk1;

drop table if exists users;
create table users(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150),
	email varchar(150) unique,
	created_at varchar(50),
	updated_at varchar(50)
);

/*1.Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/
INSERT INTO `users` VALUES ('1','Margarita','Cassin','jaqueline57@example.org',NULL,NULL),
('2','Margret','Okuneva','summer15@example.org',NULL,NULL),
('3','Julian','Maggio','sabina20@example.org',NULL,NULL),
('4','Marjory','Lang','walsh.wayne@example.org',NULL,NULL),
('5','Gerard','O\'Conner','brock.fadel@example.com',NULL,NULL),
('6','Juvenal','Spinka','guido.hickle@example.com',NULL,NULL),
('7','Elda','Steuber','leffler.gerson@example.org',NULL,NULL),
('8','Jaylin','Krajcik','natasha24@example.org',NULL,NULL),
('9','Chester','Harber','dmcdermott@example.net',NULL,NULL),
('10','Johann','Miller','oconnelly@example.net',NULL,NULL),
('11','Jeramie','Koch','grimes.natalia@example.com',NULL,NULL),
('12','Marcos','Feeney','mason.kunde@example.com',NULL,NULL),
('13','Kareem','White','klein.dejon@example.org',NULL,NULL),
('14','Anjali','Jakubowski','nikki.o\'conner@example.net',NULL,NULL),
('15','Reilly','Fritsch','qkris@example.net',NULL,NULL),
('16','Jessika','Goodwin','mstiedemann@example.net',NULL,NULL),
('17','Violet','Lowe','roberta.daugherty@example.com',NULL,NULL),
('18','Yasmine','Cremin','whand@example.net',NULL,NULL),
('19','Ethel','Vandervort','veum.ruby@example.com',NULL,NULL),
('20','Alba','Grant','nkertzmann@example.com',NULL,NULL); 

update users set created_at = now(), updated_at = now();

/*2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в 
них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, 
сохранив введеные ранее значения.*/

select * from users;
alter table users 
	modify created_at datetime,
	modify updated_at datetime;
select * from users;
/*3.В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
 чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех 
 записей.
*/

drop database if exists storehouses;
create database storehouses;
use storehouses;

drop table if exists storehouses_products;
create table storehouses_products(
	id serial primary key,
	name varchar(150) unique,
	value bigint,
	
	index (value)
);

describe storehouses_products;

INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('1', 'rerum', '1');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('2', 'incidunt', '6');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('3', 'illo', '8');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('4', 'neque', '5');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('5', 'molestiae', '3');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('6', 'non', '9');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('7', 'eveniet', '3');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('8', 'quo', '6');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('9', 'voluptatem', '4');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('10', 'sapiente', '7');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('11', 'sed', '4');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('12', 'porro', '4');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('13', 'dolorum', '0');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('14', 'praesentium', '7');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('15', 'minima', '7');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('16', 'optio', '9');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('17', 'et', '1');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('18', 'dicta', '7');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('19', 'ut', '9');
INSERT INTO `storehouses_products` (`id`, `name`, `value`) VALUES ('20', 'nulla', '7');


select * from storehouses_products
order by case when value = 0 then 1 else 0 end, value;