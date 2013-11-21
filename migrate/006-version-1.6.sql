CREATE TABLE  `cluster` (
`id` INT NOT NULL AUTO_INCREMENT ,
`clustername` VARCHAR(255) NOT NULL ,
`password` VARCHAR(255) NOT NULL ,
`user_id` INT NOT NULL ,
PRIMARY KEY (  `id` ),
UNIQUE INDEX `clustername` (`clustername` ASC) 
) ENGINE = INNODB ;

ALTER TABLE  `cluster` ADD INDEX  `user_id_index` (  `user_id` );
ALTER TABLE  `cluster` ADD FOREIGN KEY (  `user_id` ) REFERENCES  `user` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;

CREATE TABLE  `cluster_infoscreen` (
`id` INT NOT NULL AUTO_INCREMENT ,
`cluster_id` INT NOT NULL ,
`infoscreen_id` INT NOT NULL ,
PRIMARY KEY (  `id` )
) ENGINE = INNODB ;

ALTER TABLE  `cluster_infoscreen` ADD INDEX  `cluster_id_index` (  `cluster_id` );
ALTER TABLE  `cluster_infoscreen` ADD FOREIGN KEY (  `cluster_id` ) REFERENCES  `cluster` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE  `cluster_infoscreen` ADD INDEX  `infoscreen_id_index` (  `infoscreen_id` );
ALTER TABLE  `cluster_infoscreen` ADD FOREIGN KEY (  `infoscreen_id` ) REFERENCES  `infoscreen` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;

