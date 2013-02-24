RENAME TABLE  `admin_token` TO  `user_token`;
RENAME TABLE  `customer` TO  `user`;

ALTER TABLE  `user` ADD  `rights` TINYINT NOT NULL DEFAULT  '0';
ALTER TABLE  `user_token` DROP FOREIGN KEY  `admin_token_customer` ;
ALTER TABLE  `user_token` CHANGE  `customer_id`  `user_id` INT( 11 ) NOT NULL;
ALTER TABLE  `user_token` ADD FOREIGN KEY (  `user_id` ) REFERENCES  `user` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;


ALTER TABLE  `infoscreen` ADD  `group` INT NULL DEFAULT NULL AFTER  `id`;

# Add new linktable
CREATE TABLE  `infoscreen_link` (
`id` INT NOT NULL AUTO_INCREMENT ,
`user_id` INT NOT NULL ,
`infoscreen_id` INT NULL DEFAULT NULL ,
`infoscreen_group` INT NULL DEFAULT NULL ,
PRIMARY KEY (  `id` )
) ENGINE = INNODB ;

ALTER TABLE  `infoscreen_link` ADD INDEX  `user_id_index` (  `user_id` );
ALTER TABLE  `infoscreen_link` ADD FOREIGN KEY (  `user_id` ) REFERENCES  `user` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE  `infoscreen_link` ADD INDEX  `infoscreen_id_index` (  `infoscreen_id` );
ALTER TABLE  `infoscreen_link` ADD FOREIGN KEY (  `infoscreen_id` ) REFERENCES  `infoscreen` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE  `infoscreen` ADD INDEX  `infoscreen_group` (  `group` );
ALTER TABLE  `infoscreen_link` ADD INDEX  `infoscreen_group_index` (  `infoscreen_group` );
ALTER TABLE  `infoscreen_link` ADD FOREIGN KEY (  `infoscreen_group` ) REFERENCES  `infoscreen` (
`group`
) ON DELETE NO ACTION ON UPDATE CASCADE ;

# Copy old data
INSERT INTO infoscreen_link (user_id, infoscreen_id) SELECT customer_id, id  FROM infoscreen;


ALTER TABLE  `infoscreen` DROP FOREIGN KEY  `infoscreen_customer` ;
ALTER TABLE `infoscreen` DROP `customer_id`;