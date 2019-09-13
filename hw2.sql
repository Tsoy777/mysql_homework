-- Создайте базу данных example, разместите в ней таблицу users, 
--состоящую из двух столбцов, числового id и строкового name.

create database example;

use example;

create table users(
id serial primary key,
name varchar(255)
)

--Создайте дамп базы данных example из предыдущего задания, 
--разверните содержимое дампа в новую базу данных sample.

mysqldump example > "D:sample.sql"

--(по желанию) Ознакомьтесь более подробно с документацией 
--утилиты mysqldump. Создайте дамп единственной таблицы 
--help_keyword базы данных mysql. Причем добейтесь того, чтобы 
--дамп содержал только первые 100 строк таблицы.

mysqldump --where="true limit 100" mysql help_keyword > "D:100.sql"