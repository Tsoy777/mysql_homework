/*������������ ������� �� ���� ����������, ����������, ���������� � �����������*/
drop database if exists vk;
create database vk;
use vk;

drop table if exists users;
create table users(
	id serial primary key,
	firstname varchar(150),
	lastname varchar(150),
	email varchar(150) unique,
	created_at varchar(50),
	updated_at varchar(50)
);

/*1.����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.*/
insert into users set firstname = "Ivan", lastname = "Ivanov", email = "mail1@mail.ru";
insert into users set firstname = "Masha", lastname = "Sidorova", email = "mail2@mail.ru";

update users set created_at = now(), updated_at = now();

/*2.������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � 
��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, 
�������� �������� ����� ��������.*/
alter table users 
	modify created_at datetime,
	modify updated_at datetime;
select * from users;

/*3.� ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����:
 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
 ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� 
 �������.
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

insert into storehouses_products set name = "milk", value = 5;
insert into storehouses_products set name = "apple", value = 1;
insert into storehouses_products set name = "pig", value = 0;
insert into storehouses_products set name = "bread", value = 10;

select * from storehouses_products
order by case when value = 0 then 1 else 0 end, value;