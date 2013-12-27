-- This update adds the tables to add companies to clusters. 
-- This way domains can be added to filter on the reservations and a logo is present for the turtle.


--
-- company table
--
CREATE TABLE `company` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `domain` varchar(255) NOT NULL,
    `image_url` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
)


--
-- Cluster and company linking table
--
CREATE TABLE `cluster_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cluster_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cluster_id` (`cluster_id`),
  KEY `company_id` (`company_id`)
)

-- cluster_company constraints
ALTER TABLE `cluster_company`
  ADD CONSTRAINT `FK_CLUSTER_COMPANY-COMPANY` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CLUSTER_COMPANY-CLUSTER` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
