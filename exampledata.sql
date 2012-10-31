SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `controlbay` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `controlbay` ;

-- -----------------------------------------------------
-- Table `controlbay`.`customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`customer` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username` (`username` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `controlbay`.`admin_token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`admin_token` (
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
    REFERENCES `controlbay`.`customer` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `controlbay`.`infoscreen`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`infoscreen` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_id` INT(11) NOT NULL ,
  `title` VARCHAR(255) NOT NULL ,
  `alias` VARCHAR(255) NOT NULL ,
  `logo` VARCHAR(255) NULL DEFAULT NULL ,
  `color` VARCHAR(10) NULL DEFAULT NULL ,
  `lang` VARCHAR(10) NULL DEFAULT NULL ,
  `interval` INT(11) NOT NULL DEFAULT '15000' ,
  `hostname` VARCHAR(255) NOT NULL ,
  `pincode` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `customer_id` (`customer_id` ASC) ,
  INDEX `alias` (`alias` ASC) ,
  CONSTRAINT `infoscreen_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `controlbay`.`customer` (`id` )
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `controlbay`.`job`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`job` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(30) NOT NULL ,
  `javascript` VARCHAR(1000) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3;


-- -----------------------------------------------------
-- Table `controlbay`.`jobtab`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`jobtab` (
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
    REFERENCES `controlbay`.`infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `jobtab_job`
    FOREIGN KEY (`job_id` )
    REFERENCES `controlbay`.`job` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3;


-- -----------------------------------------------------
-- Table `controlbay`.`public_token`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`public_token` (
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
    REFERENCES `controlbay`.`infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `controlbay`.`turtle`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`turtle` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4;


-- -----------------------------------------------------
-- Table `controlbay`.`pane`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`pane` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT NOT NULL ,
  `type` VARCHAR(255) NOT NULL ,
  `title` VARCHAR(50) NULL ,
  `interval` INT NULL ,
  `group` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `pane_infoscreen` (`infoscreen_id` ASC) ,
  CONSTRAINT `pane_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `controlbay`.`infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `controlbay`.`turtle_instance`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`turtle_instance` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT NOT NULL ,
  `turtle_id` INT NOT NULL ,
  `pane_id` INT NOT NULL ,
  `colspan` INT NOT NULL DEFAULT 1 ,
  `order` INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `turtle_link_infoscreen` (`infoscreen_id` ASC) ,
  INDEX `turtle_link_turtle` (`turtle_id` ASC) ,
  INDEX `turtle_link_pane` (`pane_id` ASC) ,
  CONSTRAINT `turtle_link_infoscreen`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `controlbay`.`infoscreen` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turtle_link_turtle`
    FOREIGN KEY (`turtle_id` )
    REFERENCES `controlbay`.`turtle` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turtle_link_pane`
    FOREIGN KEY (`pane_id` )
    REFERENCES `controlbay`.`pane` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4;


-- -----------------------------------------------------
-- Table `controlbay`.`turtle_option`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controlbay`.`turtle_option` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `turtle_instance_id` INT NOT NULL ,
  `key` VARCHAR(20) NOT NULL ,
  `value` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `turtle_option_turtle_instance` (`turtle_instance_id` ASC) ,
  CONSTRAINT `turtle_option_turtle_link`
    FOREIGN KEY (`turtle_instance_id` )
    REFERENCES `controlbay`.`turtle_instance` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `controlbay`.`customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`customer` (`id`, `username`, `password`) VALUES (1, 'michiel', 'encrypted');

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`infoscreen`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`infoscreen` (`id`, `customer_id`, `title`, `alias`, `logo`, `color`, `lang`, `interval`, `hostname`, `pincode`) VALUES (1, 1, 'The Hub', 'hub', 'logo.jpg', '#FB8B1A', 'en', 15000, 'efikamx-5fb019', 111222);

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`job`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`job` (`id`, `name`, `javascript`) VALUES (1, 'screen_on', 'try{application.enableScreen(true);}catch(err){}window.location = $(\"base\").attr(\"href\") + infoScreen.alias; ');
INSERT INTO `controlbay`.`job` (`id`, `name`, `javascript`) VALUES (2, 'screen_off', 'try{application.enableScreen(false);}catch(err){}window.location = $(\"base\").attr(\"href\") + infoScreen.alias + \"/sleep/\";');

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`jobtab`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`jobtab` (`id`, `infoscreen_id`, `job_id`, `minutes`, `hours`, `day_of_month`, `month`, `day_of_week`) VALUES (1, 1, 1, '0', '7', '*', '*', '*');
INSERT INTO `controlbay`.`jobtab` (`id`, `infoscreen_id`, `job_id`, `minutes`, `hours`, `day_of_month`, `month`, `day_of_week`) VALUES (2, 1, 2, '0', '20', '*', '*', '*');

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`turtle`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`turtle` (`id`, `type`) VALUES (1, 'airport');
INSERT INTO `controlbay`.`turtle` (`id`, `type`) VALUES (2, 'nmbs');
INSERT INTO `controlbay`.`turtle` (`id`, `type`) VALUES (3, 'map');

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`pane`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`pane` (`id`, `infoscreen_id`, `type`, `title`, `interval`, `group`) VALUES (1, 1, 'list', NULL, NULL, NULL);
INSERT INTO `controlbay`.`pane` (`id`, `infoscreen_id`, `type`, `title`, `interval`, `group`) VALUES (2, 1, 'widget', 'Social', 1500, 1);
INSERT INTO `controlbay`.`pane` (`id`, `infoscreen_id`, `type`, `title`, `interval`, `group`) VALUES (3, 1, 'widget', 'News', 1500, 1);
INSERT INTO `controlbay`.`pane` (`id`, `infoscreen_id`, `type`, `title`, `interval`, `group`) VALUES (4, 1, 'widget', 'Location', 1500, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`turtle_instance`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`turtle_instance` (`id`, `infoscreen_id`, `turtle_id`, `pane_id`, `colspan`, `order`) VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO `controlbay`.`turtle_instance` (`id`, `infoscreen_id`, `turtle_id`, `pane_id`, `colspan`, `order`) VALUES (2, 1, 2, 1, 1, 2);
INSERT INTO `controlbay`.`turtle_instance` (`id`, `infoscreen_id`, `turtle_id`, `pane_id`, `colspan`, `order`) VALUES (3, 1, 3, 1, 1, 3);
INSERT INTO `controlbay`.`turtle_instance` (`id`, `infoscreen_id`, `turtle_id`, `pane_id`, `colspan`, `order`) VALUES (4, 1, 2, 2, 1, 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `controlbay`.`turtle_option`
-- -----------------------------------------------------
START TRANSACTION;
USE `controlbay`;
INSERT INTO `controlbay`.`turtle_option` (`id`, `turtle_instance_id`, `key`, `value`) VALUES (1, 1, 'location', 'Brussel');
INSERT INTO `controlbay`.`turtle_option` (`id`, `turtle_instance_id`, `key`, `value`) VALUES (2, 2, 'location', 'Gent');
INSERT INTO `controlbay`.`turtle_option` (`id`, `turtle_instance_id`, `key`, `value`) VALUES (3, 3, 'location', 'Mechelen');
INSERT INTO `controlbay`.`turtle_option` (`id`, `turtle_instance_id`, `key`, `value`) VALUES (4, 1, 'type', 'departures');
INSERT INTO `controlbay`.`turtle_option` (`id`, `turtle_instance_id`, `key`, `value`) VALUES (5, 4, 'location', 'Brussel');

COMMIT;
