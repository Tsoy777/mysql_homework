-- �������� ���� ������ example, ���������� � ��� ������� users, 
--��������� �� ���� ��������, ��������� id � ���������� name.

create database example;

use example;

create table users(
id serial primary key,
name varchar(255)
)

--�������� ���� ���� ������ example �� ����������� �������, 
--���������� ���������� ����� � ����� ���� ������ sample.

mysqldump example > "D:sample.sql"

--(�� �������) ������������ ����� �������� � ������������� 
--������� mysqldump. �������� ���� ������������ ������� 
--help_keyword ���� ������ mysql. ������ ��������� ����, ����� 
--���� �������� ������ ������ 100 ����� �������.

mysqldump --where="true limit 100" mysql help_keyword > "D:100.sql"