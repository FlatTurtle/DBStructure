SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username` (`username` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `admin_token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `admin_token` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_id` INT(11) NOT NULL ,
  `ip` VARCHAR(255) NOT NULL ,
  `token` VARCHAR(255) NOT NULL ,
  `expiration` VARCHAR(255) NOT NULL ,
  `user_agent` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `admin_token_customer` (`customer_id` ASC) ,
  CONSTRAINT `admin_token_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `infoscreen`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `infoscreen` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_id` INT(11) NOT NULL ,
  `title` VARCHAR(255) NOT NULL ,
  `alias` VARCHAR(255) NOT NULL ,
  `hostname` VARCHAR(255) NULL DEFAULT NULL ,
  `version` VARCHAR(45) NOT NULL DEFAULT 'stable' ,
  `logo` VARCHAR(255) NULL DEFAULT NULL ,
  `color` VARCHAR(10) NULL DEFAULT NULL ,
  `lang` VARCHAR(10) NULL DEFAULT NULL ,
  `pincode` INT(11) NULL DEFAULT NULL ,
  `location` VARCHAR(255) NULL DEFAULT NULL ,
  `latitude` DOUBLE NULL DEFAULT NULL ,
  `longitude` DOUBLE NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `alias` (`alias` ASC) ,
  UNIQUE INDEX `pincode` (`pincode` ASC) ,
  UNIQUE INDEX `hostname` (`hostname` ASC) ,
  INDEX `customer_id` (`customer_id` ASC) ,
  CONSTRAINT `infoscreen_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`id` )
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `job`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `job` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(30) NOT NULL ,
  `javascript` VARCHAR(1000) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3;


-- -----------------------------------------------------
-- Table `jobtab`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `jobtab` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT(11) NOT NULL ,
  `job_id` INT(11) NOT NULL ,
  `minutes` VARCHAR(50) NOT NULL ,
  `hours` VARCHAR(50) NOT NULL ,
  `day_of_month` VARCHAR(50) NOT NULL ,
  `month` VARCHAR(50) NOT NULL ,
  `day_of_week` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `infoscreen_id` (`infoscreen_id` ASC) ,
  INDEX `job_id` (`job_id` ASC) ,
  INDEX `jobtab_infoscreen` (`infoscreen_id` ASC) ,
  INDEX `jobtab_job` (`job_id` ASC) ,
  CONSTRAINT `jobtab_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `jobtab_job`
    FOREIGN KEY (`job_id` )
    REFERENCES `job` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3;


-- -----------------------------------------------------
-- Table `public_token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public_token` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT(11) NOT NULL ,
  `ip` VARCHAR(255) NOT NULL ,
  `token` VARCHAR(255) NOT NULL ,
  `expiration` DATETIME NOT NULL ,
  `user_agent` VARCHAR(255) NOT NULL ,
  `role` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `public_token_infoscreen` (`infoscreen_id` ASC) ,
  CONSTRAINT `public_token_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `turtle`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `turtle` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `type` VARCHAR(255) NOT NULL ,
  `allow_left` TINYINT NOT NULL DEFAULT 0 ,
  `options` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 17;


-- -----------------------------------------------------
-- Table `pane`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `pane` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT NOT NULL ,
  `type` VARCHAR(255) NOT NULL ,
  `colspan` SMALLINT NOT NULL DEFAULT 1 ,
  `duration` INT NOT NULL DEFAULT 15000 ,
  `title` VARCHAR(50) NULL ,
  `order` SMALLINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `pane_infoscreen` (`infoscreen_id` ASC) ,
  CONSTRAINT `pane_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `turtle_instance`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `turtle_instance` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT NOT NULL ,
  `turtle_id` INT NOT NULL ,
  `pane_id` INT NOT NULL ,
  `order` INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `turtle_link_infoscreen` (`infoscreen_id` ASC) ,
  INDEX `turtle_link_turtle` (`turtle_id` ASC) ,
  INDEX `turtle_link_pane` (`pane_id` ASC) ,
  CONSTRAINT `turtle_link_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turtle_link_turtle`
    FOREIGN KEY (`turtle_id` )
    REFERENCES `turtle` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turtle_link_pane`
    FOREIGN KEY (`pane_id` )
    REFERENCES `pane` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `turtle_option`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `turtle_option` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `turtle_instance_id` INT(11) NOT NULL ,
  `group` VARCHAR(45) NULL DEFAULT NULL ,
  `key` VARCHAR(45) NOT NULL ,
  `value` TEXT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `turtle_option_turtle_instance` (`turtle_instance_id` ASC) ,
  CONSTRAINT `turtle_option_turtle_link`
    FOREIGN KEY (`turtle_instance_id` )
    REFERENCES `turtle_instance` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `session`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `session` (
  `session_id` VARCHAR(40) NOT NULL DEFAULT 0 ,
  `ip_address` VARCHAR(16) NOT NULL DEFAULT 0 ,
  `user_agent` VARCHAR(120) NOT NULL ,
  `last_activity` INT(11) NOT NULL ,
  `user_data` TEXT NOT NULL ,
  PRIMARY KEY (`session_id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `plugin`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `plugin` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT NOT NULL ,
  `type` VARCHAR(255) NOT NULL ,
  `state` TEXT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `plugin_infoscreen` (`infoscreen_id` ASC) ,
  CONSTRAINT `plugin_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `option`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `option` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(64) NOT NULL COMMENT '	' ,
  `value` LONGTEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `customer` (`id`, `username`, `password`) VALUES (1, 'demo', 'encrypted');

COMMIT;

-- -----------------------------------------------------
-- Data for table `infoscreen`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `infoscreen` (`id`, `customer_id`, `title`, `alias`, `hostname`, `version`, `logo`, `color`, `lang`, `pincode`, `location`, `latitude`, `longitude`) VALUES (1, 1, 'Demo', 'demo', NULL, 'stable', NULL, '#c03636', 'en', NULL, NULL, NULL, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `job`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `job` (`id`, `name`, `javascript`) VALUES (1, 'screen_on', 'Power.enable();');
INSERT INTO `job` (`id`, `name`, `javascript`) VALUES (2, 'screen_off', 'Power.disable();');

COMMIT;

-- -----------------------------------------------------
-- Data for table `jobtab`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `jobtab` (`id`, `infoscreen_id`, `job_id`, `minutes`, `hours`, `day_of_month`, `month`, `day_of_week`) VALUES (1, 1, 1, '0', '7', '*', '*', '*');
INSERT INTO `jobtab` (`id`, `infoscreen_id`, `job_id`, `minutes`, `hours`, `day_of_month`, `month`, `day_of_week`) VALUES (2, 1, 2, '0', '20', '*', '*', '*');

COMMIT;

-- -----------------------------------------------------
-- Data for table `turtle`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (1, 'Airport', 'airport', 1, 'location, limit:5');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (2, 'NMBS', 'nmbs', 1, 'location, limit:5');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (3, 'Map', 'map', 0, 'location, zoom:12');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (4, 'De Lijn', 'delijn', 1, 'location, limit:5');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (5, 'Twitter', 'twitter', 0, 'search, limit');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (6, 'Finance', 'finance', 0, 'primary, secondary');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (7, 'RSS', 'rss', 0, 'feed, limit');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (8, 'Signage', 'signage', 0, 'data');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (9, 'Villo', 'villo', 1, 'name,location');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (10, 'Velo', 'velo', 1, 'location');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (11, 'MIVB', 'mivb', 1, 'location, limit:5');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (12, 'Weather', 'weather', 0, 'location');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (13, 'MapBox', 'mapbox', 0, 'location, zoom:12');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (14, 'Route', 'route', 0, 'from,to');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (15, 'Image', 'image', 0, 'url');
INSERT INTO `turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (16, 'Video', 'video', 0, 'location');

COMMIT;

-- -----------------------------------------------------
-- Data for table `pane`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `pane` (`id`, `infoscreen_id`, `type`, `colspan`, `duration`, `title`, `order`) VALUES (1, 1, 'list', 1, 15000, NULL, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `plugin`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `plugin` (`id`, `infoscreen_id`, `type`, `state`) VALUES (1, 1, 'clock', '1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `option`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `option` (`id`, `name`, `value`) VALUES (1, 'footer_rss', '{ \"name\":\"BBC EU News\", \"url\":\"http://feeds.bbci.co.uk/news/world/europe/rss.xml\" }');
INSERT INTO `option` (`id`, `name`, `value`) VALUES (2, 'footer_rss', '{ \"name\":\"Verkeer\", \"url\":\"http://www.verkeerscentrum.be/rss/4-INC|LOS|INF|PEVT.xml\" }');

COMMIT;
