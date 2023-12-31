-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: db_contruction
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.25-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `V_ProductReports`
--

DROP TABLE IF EXISTS `V_ProductReports`;
/*!50001 DROP VIEW IF EXISTS `V_ProductReports`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_ProductReports` AS SELECT 
 1 AS `product_id`,
 1 AS `product_code`,
 1 AS `product_name`,
 1 AS `qty_sales`,
 1 AS `unit`,
 1 AS `cost`,
 1 AS `revenue`,
 1 AS `profit`,
 1 AS `qty`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `V_todaySale`
--

DROP TABLE IF EXISTS `V_todaySale`;
/*!50001 DROP VIEW IF EXISTS `V_todaySale`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `V_todaySale` AS SELECT 
 1 AS `product_code`,
 1 AS `product_name`,
 1 AS `qty`,
 1 AS `cost`,
 1 AS `revenue`,
 1 AS `profit`,
 1 AS `sale_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `getAllProducts`
--

DROP TABLE IF EXISTS `getAllProducts`;
/*!50001 DROP VIEW IF EXISTS `getAllProducts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `getAllProducts` AS SELECT 
 1 AS `product_image`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `product_code`,
 1 AS `categoryName`,
 1 AS `brandName`,
 1 AS `unit`,
 1 AS `unit_price`,
 1 AS `price`,
 1 AS `qty`,
 1 AS `reorder_number`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tblBrands`
--

DROP TABLE IF EXISTS `tblBrands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblBrands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brandName` varchar(200) NOT NULL,
  `desc` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblBrands`
--

LOCK TABLES `tblBrands` WRITE;
/*!40000 ALTER TABLE `tblBrands` DISABLE KEYS */;
INSERT INTO `tblBrands` VALUES (1,'K cement',''),(2,'ស៊ីម៉ងត៍អូឌ','');
/*!40000 ALTER TABLE `tblBrands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblCategories`
--

DROP TABLE IF EXISTS `tblCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(250) NOT NULL,
  `desc` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblCategories`
--

LOCK TABLES `tblCategories` WRITE;
/*!40000 ALTER TABLE `tblCategories` DISABLE KEYS */;
INSERT INTO `tblCategories` VALUES (1,'others',''),(2,'ដែក',''),(3,'សុីម៉ងត៍',''),(4,'ផ្លែរកាត់ដែក ',''),(5,'ក្ដាបន្ទះពេជ្រ ស',''),(6,'ផ្លែរកាត់ការ៉ូ',''),(7,'ផ្លែរកាតបេតុង',''),(8,'ជក់លាបថ្នាំ','');
/*!40000 ALTER TABLE `tblCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblCurrency`
--

DROP TABLE IF EXISTS `tblCurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblCurrency` (
  `cur_id` int(11) NOT NULL AUTO_INCREMENT,
  `cur_kh` float NOT NULL,
  `cur_dollar` float NOT NULL,
  PRIMARY KEY (`cur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblCurrency`
--

LOCK TABLES `tblCurrency` WRITE;
/*!40000 ALTER TABLE `tblCurrency` DISABLE KEYS */;
INSERT INTO `tblCurrency` VALUES (1,4150,1);
/*!40000 ALTER TABLE `tblCurrency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblCustomers`
--

DROP TABLE IF EXISTS `tblCustomers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblCustomers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerName` varchar(100) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblCustomers`
--

LOCK TABLES `tblCustomers` WRITE;
/*!40000 ALTER TABLE `tblCustomers` DISABLE KEYS */;
INSERT INTO `tblCustomers` VALUES (1,'General',NULL,NULL,NULL);
/*!40000 ALTER TABLE `tblCustomers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblInvoice`
--

DROP TABLE IF EXISTS `tblInvoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblInvoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(250) DEFAULT NULL,
  `payment_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `money_change` float NOT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblInvoice`
--

LOCK TABLES `tblInvoice` WRITE;
/*!40000 ALTER TABLE `tblInvoice` DISABLE KEYS */;
INSERT INTO `tblInvoice` VALUES (8,'PSS20234508',1,12.5,0),(22,'PSS2023417022',1,37.5,0),(23,'PSS2023417023',2,37,0),(25,'PSS2023418025',1,37.5,0);
/*!40000 ALTER TABLE `tblInvoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblPayments`
--

DROP TABLE IF EXISTS `tblPayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblPayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblPayments`
--

LOCK TABLES `tblPayments` WRITE;
/*!40000 ALTER TABLE `tblPayments` DISABLE KEYS */;
INSERT INTO `tblPayments` VALUES (1,'Cash'),(2,'ABA');
/*!40000 ALTER TABLE `tblPayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblProductUnits`
--

DROP TABLE IF EXISTS `tblProductUnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblProductUnits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblProductUnits`
--

LOCK TABLES `tblProductUnits` WRITE;
/*!40000 ALTER TABLE `tblProductUnits` DISABLE KEYS */;
INSERT INTO `tblProductUnits` VALUES (1,'others'),(2,'ការ៉ុង'),(3,'តោន'),(4,'បន្ទះ'),(5,'សន្លឺក');
/*!40000 ALTER TABLE `tblProductUnits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblProducts`
--

DROP TABLE IF EXISTS `tblProducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblProducts` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT 0,
  `sub_id` int(11) DEFAULT 0,
  `unit_id` int(11) NOT NULL DEFAULT 0,
  `product_code` varchar(100) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `qty` int(11) DEFAULT 0,
  `unit_price` float DEFAULT 0,
  `price` float DEFAULT 0,
  `exp_date` date DEFAULT NULL,
  `product_image` varchar(250) DEFAULT NULL,
  `desc` varchar(250) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `reorder_number` int(11) DEFAULT 0,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblProducts`
--

LOCK TABLES `tblProducts` WRITE;
/*!40000 ALTER TABLE `tblProducts` DISABLE KEYS */;
INSERT INTO `tblProducts` VALUES (1,3,0,1,2,'OUD1122','សុីម៉ងត៍អូឌ',21,10,13,'2023-04-11','images/1679924742170cement.png','',1,20),(2,3,0,0,2,'KC02233','សុីម៉ងត៍KCement',51,10,12,'2023-04-04','images/1679929900945KCment.png','',1,10),(5,1,0,0,5,'2001203','Test',41,10,12,'2023-04-05','images/1680417444956IMG_7382.jpg','',1,2),(6,4,0,0,4,'HD-00001X','ផ្លែរកាត់ដែកHD',83,0.25,0.5,'2023-04-04','images/1680511385566IMG_7381.jpg','',1,25);
/*!40000 ALTER TABLE `tblProducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblRoles`
--

DROP TABLE IF EXISTS `tblRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblRoles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblRoles`
--

LOCK TABLES `tblRoles` WRITE;
/*!40000 ALTER TABLE `tblRoles` DISABLE KEYS */;
INSERT INTO `tblRoles` VALUES (1,'Admin'),(2,'User');
/*!40000 ALTER TABLE `tblRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblSaleDetails`
--

DROP TABLE IF EXISTS `tblSaleDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSaleDetails` (
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty_sales` int(11) NOT NULL,
  PRIMARY KEY (`sale_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblSaleDetails`
--

LOCK TABLES `tblSaleDetails` WRITE;
/*!40000 ALTER TABLE `tblSaleDetails` DISABLE KEYS */;
INSERT INTO `tblSaleDetails` VALUES (8,1,5),(8,2,5),(8,5,1),(8,6,1),(22,1,1),(22,2,1),(22,5,1),(22,6,1),(23,1,1),(23,2,1),(23,5,1),(25,1,1),(25,2,1),(25,5,1),(25,6,1);
/*!40000 ALTER TABLE `tblSaleDetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_qty` AFTER INSERT ON `tblSaleDetails` FOR EACH ROW UPDATE tblProducts SET qty = qty-new.qty_sales WHERE product_id = new.product_id AND (qty-new.qty_sales)>=0 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_sale
    AFTER UPDATE
    ON tblSaleDetails FOR EACH ROW
BEGIN
    UPDATE tblProducts SET tblProducts.qty = (tblProducts.qty+OLD.qty_sales)-NEW.qty_sales;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER delete_sale
    AFTER DELETE
    ON tblSaleDetails FOR EACH ROW
BEGIN
   UPDATE tblProducts SET tblProducts.qty = tblProducts.qty + OLD.qty_sales;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tblSales`
--

DROP TABLE IF EXISTS `tblSales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSales` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL,
  `sale_date` date NOT NULL,
  `desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  UNIQUE KEY `invoice_id` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblSales`
--

LOCK TABLES `tblSales` WRITE;
/*!40000 ALTER TABLE `tblSales` DISABLE KEYS */;
INSERT INTO `tblSales` VALUES (8,15,1,8,'2023-04-05',''),(22,4,1,22,'2023-04-17',''),(23,10,1,23,'2023-04-17',''),(25,4,1,25,'2023-04-18','');
/*!40000 ALTER TABLE `tblSales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblStatus`
--

DROP TABLE IF EXISTS `tblStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblStatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblStatus`
--

LOCK TABLES `tblStatus` WRITE;
/*!40000 ALTER TABLE `tblStatus` DISABLE KEYS */;
INSERT INTO `tblStatus` VALUES (1,'Enable'),(2,'Disable');
/*!40000 ALTER TABLE `tblStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblSupplies`
--

DROP TABLE IF EXISTS `tblSupplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblSupplies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supName` varchar(250) NOT NULL,
  `companyName` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `phone` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblSupplies`
--

LOCK TABLES `tblSupplies` WRITE;
/*!40000 ALTER TABLE `tblSupplies` DISABLE KEYS */;
INSERT INTO `tblSupplies` VALUES (1,'Jonh Doe','KCM','','','');
/*!40000 ALTER TABLE `tblSupplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblUsers`
--

DROP TABLE IF EXISTS `tblUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone_number` varchar(100) DEFAULT NULL,
  `token` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblUsers`
--

LOCK TABLES `tblUsers` WRITE;
/*!40000 ALTER TABLE `tblUsers` DISABLE KEYS */;
INSERT INTO `tblUsers` VALUES (4,1,1,'saochea','$2b$10$dvmZbdEisFdCzw4h60ulmOyzxcM4dNfHnKS6IF8.Tikic6fObwXZm','saocheaphan@gmail.com','09087456','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOjQsInVzZXJuYW1lIjoic2FvY2hlYSIsImVtYWlsIjoic2FvY2hlYXBoYW5AZ21haWwuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNjgxODk1MTE3LCJleHAiOjE2ODE5ODE1MTd9.y8FNrZUp7N_HuP4ahRZVuJShQ2uhB-d7cMLPYARYX3o'),(10,2,1,'chea@#','$2b$10$qJuBZLwHk0/gWvdZHBUch.GDp8m3ameNRz6Msi18yLrsfWZqVKdxu','dara@gmail.com','908755',NULL),(16,1,2,'netfighter','$2b$10$ErpcXibhWTRGZuw5mLCm7eAWukqrZACiexIWPaOuv/CZi52dJoWcm','','',NULL),(17,1,1,'mony','$2b$10$S57Le0bMoUAUwp7sxxroee8m8O2agC2yQ4Wk/z8gU0asodCTAgZp2','saocheaphan@gmail','',NULL);
/*!40000 ALTER TABLE `tblUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `V_ProductReports`
--

/*!50001 DROP VIEW IF EXISTS `V_ProductReports`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_ProductReports` AS select `tblProducts`.`product_id` AS `product_id`,`tblProducts`.`product_code` AS `product_code`,`tblProducts`.`product_name` AS `product_name`,sum(`tblSaleDetails`.`qty_sales`) AS `qty_sales`,`tblProductUnits`.`unit` AS `unit`,sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `cost`,sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` AS `revenue`,sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` - sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `profit`,`tblProducts`.`qty` AS `qty` from ((`tblSaleDetails` left join `tblProducts` on(`tblSaleDetails`.`product_id` = `tblProducts`.`product_id`)) join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) group by `tblSaleDetails`.`product_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `V_todaySale`
--

/*!50001 DROP VIEW IF EXISTS `V_todaySale`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_todaySale` AS select `tblProducts`.`product_code` AS `product_code`,`tblProducts`.`product_name` AS `product_name`,concat(sum(`tblSaleDetails`.`qty_sales`),' ( ',`tblProductUnits`.`unit`,' ) ') AS `qty`,sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `cost`,sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` AS `revenue`,sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` - sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `profit`,curdate() AS `sale_date` from (((`tblSales` join `tblSaleDetails` on(`tblSaleDetails`.`sale_id` = `tblSales`.`sale_id`)) join `tblProducts` on(`tblSaleDetails`.`product_id` = `tblProducts`.`product_id`)) left join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) where `tblSales`.`sale_date` = curdate() group by `tblProducts`.`product_code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `getAllProducts`
--

/*!50001 DROP VIEW IF EXISTS `getAllProducts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getAllProducts` AS select `tblProducts`.`product_image` AS `product_image`,`tblProducts`.`product_id` AS `product_id`,`tblProducts`.`product_name` AS `product_name`,`tblProducts`.`product_code` AS `product_code`,`tblCategories`.`categoryName` AS `categoryName`,`tblBrands`.`brandName` AS `brandName`,`tblProductUnits`.`unit` AS `unit`,`tblProducts`.`unit_price` AS `unit_price`,`tblProducts`.`price` AS `price`,`tblProducts`.`qty` AS `qty`,`tblProducts`.`reorder_number` AS `reorder_number` from (((`tblProducts` left join `tblCategories` on(`tblProducts`.`category_id` = `tblCategories`.`id`)) left join `tblBrands` on(`tblProducts`.`brand_id` = `tblBrands`.`id`)) left join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-19 16:05:32
