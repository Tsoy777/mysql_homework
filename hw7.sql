-- Тема “Сложные запросы”

drop database if exists shop;
create database shop;
use shop;

drop table if exists catalogs;
create table catalogs(
	id serial primary key,
	name varchar(100)
);

drop table if exists products;
create table products(
	id serial primary key,
	name varchar(100),
	category_id bigint unsigned not null,
	
	foreign key (category_id) references catalogs(id)
);

drop table if exists users;
create table users(
	user_id serial primary key,
	name varchar(100),
	surname varchar(100),
	address varchar(100),
	phone varchar(10)
);

drop table if exists orders;
create table orders(
	id serial primary key,
	user_id bigint unsigned not null,
	product_id bigint unsigned not null,
	
	foreign key (product_id) references products(id),
	foreign key (user_id) references users(user_id)
);

INSERT INTO `catalogs` VALUES ('1','impedit'),
('2','non'),
('3','velit'),
('4','quo'),
('5','reprehenderit'); 

INSERT INTO `users` VALUES ('1','nihil','quod','47879 Orrin Walks\nAmericoborough, TN 70754-7433','535.354.86'),
('2','debitis','alias','6971 Annalise Oval Apt. 219\nPort Verner, MD 94744','(848)041-1'),
('3','ab','ut','3632 Estelle Road\nBeckerfurt, RI 44699-2914','1-273-097-'),
('4','qui','perferendis','029 Mitchel Circle Apt. 225\nRogahnville, CO 60542-2769','(734)588-4'),
('5','eligendi','aut','511 Bernadine Court\nWisokystad, CT 20497-8466','(883)340-7'),
('6','exercitationem','qui','724 Jaskolski Hills Apt. 153\nFadelfurt, AL 07342-1451','127-164-26'),
('7','itaque','doloribus','55506 Gulgowski Canyon Apt. 951\nNew Aracelimouth, DC 89803','495-054-36'),
('8','quibusdam','dolorem','3882 Bednar Parkways\nEast Dessie, WV 72127-9491','(417)928-1'),
('9','est','dolores','682 Connie Flats\nElisahaven, CO 21121-8345','880.977.24'),
('10','hic','iure','44088 Nona Land\nLake Joesphville, MI 56326','665.812.44'); 

INSERT INTO `products` VALUES ('1','ut','1'),
('2','quas','1'),
('3','laudantium','2'),
('4','laudantium','2'),
('5','est','3'),
('6','sit','3'),
('7','amet','4'),
('8','rerum','4'),
('9','nam','5'),
('10','odio','5'); 

insert into orders values ('1', '1', '5'),
('2', '1', '3'),
('3', '1', '9'),
('4', '5', '1'),
('5', '7', '3'),
('6', '5', '7');

-- 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select 
	user_id,
	name,
	surname
from users
where user_id in (
	select 
		orders.user_id
	from orders
	group by orders.user_id
);

-- 2 Выведите список товаров products и разделов catalogs, который соответствует товару.
select
	products.id,
	products.name,
	catalogs.name
from products
join catalogs on products.category_id = catalogs.id;
-- 3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
drop table if exists flights;
create table flights(
	id serial primary key,
	city_from varchar(100),
	city_to varchar(100)
);

drop table if exists cities;
create table cities
(
	label varchar(100),
	name varchar(100)
);

insert into flights values 
('1', 'moscow', 'omsk'),
('2', 'novgorod','kazan'),
('3', 'irkutsk','moscow'),
('4', 'omsk','irkutsk'),
('5', 'moscow','kazan');

insert into cities values
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');

select 
	flights.id,
	cities.name as name_from,
	(select 
		cities.name 
		from cities where cities.label = flights.city_to) as name_to
	from flights
	join cities on cities.label = flights.city_from
	order by flights.id	;
