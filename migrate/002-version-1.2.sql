# Add log table
CREATE  TABLE IF NOT EXISTS `log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `infoscreen_id` INT(11) NOT NULL ,
  `user_id` INT(11) NOT NULL ,
  `action` VARCHAR(55) NULL DEFAULT NULL ,
  `object` VARCHAR(55) NULL DEFAULT NULL ,
  `log` TEXT NULL DEFAULT NULL ,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `log_screen_link` (`infoscreen_id` ASC) ,
  INDEX `log_user_link` (`user_id` ASC) ,
  CONSTRAINT `log_screen_link`
    FOREIGN KEY (`infoscreen_id` )
    REFERENCES `infoscreen` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `log_user_link`
    FOREIGN KEY (`user_id` )
    REFERENCES `user` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
