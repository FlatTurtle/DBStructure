# adding new turtles
INSERT INTO `flatturtle`.`turtle` (`id`, `name`, `type`, `allow_left`, `options`) VALUES (NULL, 'Offers', 'offers', '1', 'data'), (NULL, 'Price list', 'pricelist', '1', 'data'), (NULL, 'Week menu', 'weekmenu', '1', 'data'), (NULL, 'Info', 'info', '0', 'data'), (NULL, 'Calendar', 'calendar', 1, 'url, header');


# replacing power off crons
UPDATE  `flatturtle`.`job` SET  `javascript` =  'try {Power.enable();} catch (err) {}' WHERE  `job`.`id` =1;
UPDATE  `flatturtle`.`job` SET  `javascript` =  'try {Power.disable();} catch (err) {}' WHERE  `job`.`id` =2;

# adding zoom cron
INSERT INTO `flatturtle`.`job` (`id`, `name`, `javascript`) VALUES (NULL, 'zoom', 'try {document.body.style.zoom=0.66666;} catch (err) {}');
