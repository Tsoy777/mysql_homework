DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50), 
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id) 
    	ON UPDATE CASCADE 
    	ON DELETE restrict
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    `is_deleted` ENUM('yes', 'no') default 'no',
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,	
    PRIMARY KEY (initiator_user_id, target_user_id),
	INDEX (initiator_user_id), 
    INDEX (target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	INDEX communities_name_idx(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,  
	PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);


-- Заполнить новые таблицы.



INSERT INTO `users` VALUES ('1','Brent','Stracke','drunolfsdottir@example.com','1'),
('2','Marshall','Swaniawski','hermiston.stan@example.net','2778199330'),
('3','Agustina','Gutmann','go\'connell@example.net','0'),
('4','Theresa','Powlowski','jeanie.funk@example.com','0'),
('5','Nathaniel','Wisoky','bridget.pfeffer@example.net','1'),
('6','Jace','Purdy','hilton33@example.org','248442'),
('7','Manuela','Homenick','cummings.myriam@example.com','1'),
('8','Ova','Pagac','daugherty.kolby@example.net','1'),
('9','Tomasa','Will','rosendo35@example.com','7054374057'),
('10','Lonzo','Koelpin','guido83@example.org','0'); 

INSERT INTO `communities` VALUES ('8','ad'),
('4','alias'),
('2','dolor'),
('1','earum'),
('5','explicabo'),
('9','rerum'),
('7','tenetur'),
('3','ut'),
('10','voluptates'),
('6','voluptatum'); 


INSERT INTO `friend_requests` VALUES ('1','1','requested','1972-11-13 12:14:10','1996-08-31 20:51:32'),
('2','2','requested','1994-10-22 22:12:04','1999-09-02 10:33:08'),
('3','3','unfriended','1973-11-05 23:35:23','1994-10-11 12:08:26'),
('4','4','approved','1986-01-13 16:26:56','1996-08-27 14:52:22'),
('5','5','approved','1976-03-23 08:23:42','1982-10-26 13:58:01'); 


INSERT INTO `media_types` VALUES ('1','sit','1982-10-05 23:22:57','1982-07-24 21:22:00'),
('2','numquam','2016-05-01 13:49:58','2003-12-14 04:25:01'),
('3','saepe','2002-04-04 02:21:00','1976-02-25 01:51:31'),
('4','natus','1975-01-07 08:40:23','2007-04-13 22:48:44'),
('5','cumque','2008-04-07 10:11:54','1979-10-27 14:21:46'),
('6','aut','1983-10-29 21:40:15','1983-05-31 22:08:12'),
('7','quia','1981-09-17 05:46:45','1996-03-27 10:41:45'),
('8','corporis','1987-09-06 09:41:21','1971-12-23 10:46:57'),
('9','asperiores','1982-11-06 22:05:16','1992-04-08 07:21:28'),
('10','aspernatur','1987-07-21 09:26:55','1973-09-01 13:38:51'); 

INSERT INTO `media` VALUES ('1','1','1','Qui aut ipsum distinctio quis ipsa beatae. At et voluptate officia est voluptatibus.','aut','640219',NULL,'1984-01-03 22:08:37','2006-11-13 14:32:57'),
('2','2','2','Hic soluta maiores explicabo. Nesciunt exercitationem consequatur illum nemo ab. Amet ducimus est cum omnis et est temporibus perspiciatis. Qui vitae delectus cupiditate consequuntur labore voluptatem.','inventore','74681',NULL,'1996-07-22 03:33:46','2009-08-08 07:41:40'),
('3','3','3','Recusandae modi ut sed rem quis odit sint. Repellendus ex sint facilis vero sit. Cum aliquid quas ut aut.','hic','0',NULL,'1979-05-19 16:56:02','2015-04-12 01:43:59'),
('4','4','4','Possimus facere explicabo occaecati et. Sint nihil labore inventore possimus molestiae. Consectetur eos non consequuntur tenetur.','soluta','1240',NULL,'2015-01-05 13:55:17','1974-03-02 12:49:05'),
('5','5','5','Et dolorem maxime voluptatem et. Iste ea corporis dolores optio. Eveniet quo ullam distinctio sequi qui nam vel. Est aut assumenda voluptatem recusandae eum et saepe.','ea','34',NULL,'1974-03-31 16:12:18','1989-01-28 12:50:03'),
('6','6','6','Rerum rerum aliquam sed ratione alias praesentium impedit. Reprehenderit ipsa harum exercitationem et. Vero dolores facere cum rerum et molestias. Fuga tempora molestiae maxime.','vero','2',NULL,'1982-12-25 12:29:22','2001-11-11 07:53:17'),
('7','7','7','Omnis ea at aliquid sunt eos porro sunt quis. Quidem sint odit ullam fugit magnam quaerat. Est soluta facilis corporis amet libero saepe velit repellat.','voluptas','744614',NULL,'1990-07-22 10:32:43','1975-11-05 14:42:12'),
('8','8','8','Iure numquam quia dolorum et. Dolorem provident et praesentium saepe magnam. Fugit iure nobis odit nam.','mollitia','6093790',NULL,'1980-08-13 23:26:26','2006-02-04 22:54:37'),
('9','9','9','Tenetur qui temporibus commodi sunt voluptas eveniet animi. Quasi fugiat omnis reiciendis occaecati. Voluptatem ipsum iure dolor sequi.','nihil','9667',NULL,'2006-03-02 14:25:52','1983-06-10 15:31:02'),
('10','10','10','Aut dolorem possimus in doloribus omnis et eos non. Eaque aut velit ullam. Et delectus sapiente unde omnis aut voluptas.','unde','7',NULL,'1970-04-15 02:04:59','2007-01-02 18:23:19'); 


INSERT INTO `messages` VALUES ('1','1','1','Accusamus ad quidem voluptas molestiae sit nemo et molestias. Est modi placeat hic necessitatibus totam ut. Beatae nulla adipisci veniam iure qui doloremque.','1991-05-27 08:07:08','no'),
('2','2','2','Quo eaque nulla culpa recusandae. Asperiores impedit explicabo consectetur aut. Et autem facilis voluptas ab tempore omnis.','1976-10-09 03:31:21','no'),
('3','3','3','Ducimus veritatis eum iste sit. Vel quia enim sapiente aut et porro optio. Minus iste et distinctio veritatis. Earum ut sit molestias et.','2003-01-15 21:21:12','no'),
('4','4','4','Velit quibusdam autem beatae sunt aut corporis. Minima quo et impedit laboriosam voluptatem distinctio dolores. Sit nisi illo facere libero nobis. Adipisci ea aperiam numquam quam.','2001-12-10 19:01:32','no'),
('5','5','5','Enim expedita enim omnis vel explicabo nam aperiam. Sed qui officia et omnis asperiores expedita.','1990-08-15 19:48:17','no'),
('6','6','6','Sequi omnis autem corrupti fugiat enim quasi ut ea. Voluptatibus amet reiciendis id est. Asperiores ut omnis est iusto ducimus mollitia sint quos. Cumque hic vel corporis qui facere accusamus.','1971-05-25 00:34:38','no'),
('7','7','7','Sunt quas assumenda qui. Dolorem minus nulla exercitationem beatae et voluptatem voluptatibus. Omnis perspiciatis harum enim. Eos qui quaerat voluptatibus quam.','1995-06-14 03:03:34','no'),
('8','8','8','Et error molestiae ratione necessitatibus et sapiente ex. Quos quas ut voluptatem qui commodi distinctio tenetur. Reprehenderit sed voluptates commodi corrupti neque occaecati. Debitis et omnis quam nihil quam cumque inventore.','2014-11-25 13:39:06','no'),
('9','9','9','Nisi sint laboriosam nesciunt. Sit quo est corrupti alias quod. Perspiciatis eveniet iure eos aut ducimus qui libero. Minima aut autem dolor. Quia qui quaerat quia.','1978-03-06 15:11:45','no'),
('10','10','10','Nemo iure repellendus dolor odio voluptatibus ut. Suscipit voluptatem voluptatum et delectus. Qui assumenda praesentium id. Sed qui dolores similique quis. Amet eos ea et magni earum omnis.','1992-04-10 08:18:46','no'); 



INSERT INTO `users_communities` VALUES ('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','8'),
('9','9'),
('10','10'); 

-- Повторить все действия CRUD.

-- insert

insert into profiles values
('1', 'w','01.01.2000', null,now(),'Moscow')
;

insert into profiles
set
	user_id = 2,
	gender = 'm',
	birthday = '15.05.2015',
	created_at = now(),
	hometown = 'Kiev'
;

-- select

select *
from users
limit 5 offset 1;

select *
from users
where id > 1 and id < 5;

-- update
update friend_requests
set
	status = 'approved'
-- 	confirmed_at = now()
where
	status = 'requested'
;

update messages
set
	is_deleted = 'yes'
where from_user_id = 1
;

-- delete
delete from messages 
where is_deleted = 'yes'
;

-- truncate

truncate table messages
;

INSERT INTO `messages` VALUES ('1','1','1','Accusamus ad quidem voluptas molestiae sit nemo et molestias. Est modi placeat hic necessitatibus totam ut. Beatae nulla adipisci veniam iure qui doloremque.','1991-05-27 08:07:08','no'),
('2','2','2','Quo eaque nulla culpa recusandae. Asperiores impedit explicabo consectetur aut. Et autem facilis voluptas ab tempore omnis.','1976-10-09 03:31:21','no'),
('3','3','3','Ducimus veritatis eum iste sit. Vel quia enim sapiente aut et porro optio. Minus iste et distinctio veritatis. Earum ut sit molestias et.','2003-01-15 21:21:12','no'),
('4','4','4','Velit quibusdam autem beatae sunt aut corporis. Minima quo et impedit laboriosam voluptatem distinctio dolores. Sit nisi illo facere libero nobis. Adipisci ea aperiam numquam quam.','2001-12-10 19:01:32','no'),
('5','5','5','Enim expedita enim omnis vel explicabo nam aperiam. Sed qui officia et omnis asperiores expedita.','1990-08-15 19:48:17','no'),
('6','6','6','Sequi omnis autem corrupti fugiat enim quasi ut ea. Voluptatibus amet reiciendis id est. Asperiores ut omnis est iusto ducimus mollitia sint quos. Cumque hic vel corporis qui facere accusamus.','1971-05-25 00:34:38','no'),
('7','7','7','Sunt quas assumenda qui. Dolorem minus nulla exercitationem beatae et voluptatem voluptatibus. Omnis perspiciatis harum enim. Eos qui quaerat voluptatibus quam.','1995-06-14 03:03:34','no'),
('8','8','8','Et error molestiae ratione necessitatibus et sapiente ex. Quos quas ut voluptatem qui commodi distinctio tenetur. Reprehenderit sed voluptates commodi corrupti neque occaecati. Debitis et omnis quam nihil quam cumque inventore.','2014-11-25 13:39:06','no'),
('9','9','9','Nisi sint laboriosam nesciunt. Sit quo est corrupti alias quod. Perspiciatis eveniet iure eos aut ducimus qui libero. Minima aut autem dolor. Quia qui quaerat quia.','1978-03-06 15:11:45','no'),
('10','10','10','Nemo iure repellendus dolor odio voluptatibus ut. Suscipit voluptatem voluptatum et delectus. Qui assumenda praesentium id. Sed qui dolores similique quis. Amet eos ea et magni earum omnis.','1992-04-10 08:18:46','no'); 






