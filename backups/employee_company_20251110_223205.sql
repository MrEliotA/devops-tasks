/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: employee_company
-- ------------------------------------------------------
-- Server version	10.11.13-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `employee_company`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `employee_company` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `employee_company`;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) NOT NULL,
  `department_head` varchar(10) DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_name` (`department_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES
(1,'Engineering','EMP1001',2500000.00,'2025-11-10 22:21:20'),
(2,'Marketing','EMP1002',800000.00,'2025-11-10 22:21:20'),
(3,'Sales','EMP1003',1200000.00,'2025-11-10 22:21:20'),
(4,'HR','EMP1004',600000.00,'2025-11-10 22:21:20'),
(5,'Finance','EMP1005',400000.00,'2025-11-10 22:21:20'),
(6,'Operations','EMP1006',1000000.00,'2025-11-10 22:21:20'),
(7,'IT Support','EMP1007',750000.00,'2025-11-10 22:21:20');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_reports`
--

DROP TABLE IF EXISTS `employee_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_reports` (
  `employee_id` varchar(10) NOT NULL,
  `name` varchar(101) NOT NULL,
  `department` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `status` enum('Active','Inactive','On Leave') NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_reports`
--

LOCK TABLES `employee_reports` WRITE;
/*!40000 ALTER TABLE `employee_reports` DISABLE KEYS */;
INSERT INTO `employee_reports` VALUES
('EMP1575','George Martin','IT Support',63178.00,'Active'),
('EMP1600','Sarah Taylor','Finance',80157.00,'Active'),
('EMP1696','Jane Williams','Operations',74893.00,'Active'),
('EMP1882','Susan Jackson','Marketing',59584.00,'Active'),
('EMP2239','Donald Martinez','Engineering',62713.00,'Active'),
('EMP2276','Andrew Rivera','Engineering',96910.00,'Active'),
('EMP2346','Elizabeth Nguyen','IT Support',69202.00,'Active'),
('EMP2389','James Baker','Operations',65193.00,'Active'),
('EMP2567','Mark Brown','Operations',70871.00,'Active'),
('EMP2628','Christopher Wright','Finance',75769.00,'Active'),
('EMP2755','Brian Hernandez','Finance',66111.00,'Active'),
('EMP3374','Kenneth Lopez','HR',59073.00,'Active'),
('EMP3495','Barbara Lewis','IT Support',80373.00,'Active'),
('EMP3565','John Miller','Sales',68249.00,'Active'),
('EMP3689','Kimberly Thompson','Operations',78970.00,'Active'),
('EMP3692','Anthony Harris','Marketing',48221.00,'Active'),
('EMP4458','Patricia Moore','Operations',82065.00,'Active'),
('EMP4535','Susan Nguyen','Marketing',79254.00,'Active'),
('EMP4707','Daniel Garcia','Finance',74055.00,'Active'),
('EMP6344','Elizabeth Hall','IT Support',83571.00,'Active'),
('EMP6350','Donna Miller','IT Support',72989.00,'Active'),
('EMP6362','Joseph Moore','Operations',76178.00,'Active'),
('EMP6450','Robert Green','HR',61798.00,'Active'),
('EMP6668','Anthony Baker','Marketing',77372.00,'Active'),
('EMP6778','Edward Harris','IT Support',55998.00,'Active'),
('EMP7231','William Wright','Finance',68750.00,'Active'),
('EMP7269','Andrew Flores','Engineering',77399.00,'Active'),
('EMP7433','Sharon Campbell','IT Support',78812.00,'Active'),
('EMP7610','Patricia Roberts','HR',60229.00,'Active'),
('EMP7618','Edward Hall','Operations',54219.00,'Active'),
('EMP7737','Carol Mitchell','Finance',58238.00,'Active'),
('EMP7765','Jane Baker','IT Support',80853.00,'Active'),
('EMP8205','Betty Roberts','Marketing',52458.00,'Active'),
('EMP8225','Elizabeth Campbell','Marketing',79407.00,'Active'),
('EMP8256','Emily Harris','Finance',87657.00,'Active'),
('EMP8424','Sarah Harris','Finance',89795.00,'Active'),
('EMP8610','James King','Engineering',72307.00,'Active'),
('EMP8857','Carol Johnson','Operations',55292.00,'Active'),
('EMP9344','Donna Jones','HR',48796.00,'Active'),
('EMP9579','James Wright','Operations',70358.00,'Active'),
('EMP9949','Karen Carter','Finance',87639.00,'Active');
/*!40000 ALTER TABLE `employee_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `employee_summary`
--

DROP TABLE IF EXISTS `employee_summary`;
/*!50001 DROP VIEW IF EXISTS `employee_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `employee_summary` AS SELECT
 1 AS `employee_id`,
  1 AS `full_name`,
  1 AS `email`,
  1 AS `department`,
  1 AS `position`,
  1 AS `salary`,
  1 AS `hire_date`,
  1 AS `status`,
  1 AS `days_employed` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `department` varchar(50) NOT NULL,
  `position` varchar(100) NOT NULL,
  `hire_date` date NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `manager_id` varchar(10) DEFAULT NULL,
  `status` enum('Active','Inactive','On Leave') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_department` (`department`),
  KEY `idx_status` (`status`),
  KEY `idx_hire_date` (`hire_date`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES
(1,'EMP9579','James','Wright','james.wright@company.com','+1-283-497-4393','Operations','Process Analyst','2020-11-19',70358.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(2,'EMP5619','Ruth','Garcia','ruth.garcia@company.com','+1-816-677-4132','Finance','Controller','2024-05-05',80426.00,NULL,'On Leave','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(3,'EMP8256','Emily','Harris','emily.harris@company.com','+1-349-982-9425','Finance','Budget Analyst','2023-01-29',87657.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(4,'EMP1575','George','Martin','george.martin@company.com','+1-240-468-6662','IT Support','System Administrator','2022-07-12',63178.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(5,'EMP6668','Anthony','Baker','anthony.baker@company.com','+1-764-223-8753','Marketing','SEO Specialist','2021-03-01',77372.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(6,'EMP7433','Sharon','Campbell','sharon.campbell@company.com','+1-718-736-1689','IT Support','Network Engineer','2022-09-25',78812.00,'EMP6668','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(7,'EMP6344','Elizabeth','Hall','elizabeth.hall@company.com','+1-922-386-9236','IT Support','Network Engineer','2022-02-08',83571.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(8,'EMP7618','Edward','Hall','edward.hall@company.com','+1-464-448-2045','Operations','Process Analyst','2024-06-17',54219.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(9,'EMP6350','Donna','Miller','donna.miller@company.com','+1-832-940-6712','IT Support','Help Desk Technician','2022-02-20',72989.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(10,'EMP7737','Carol','Mitchell','carol.mitchell@company.com','+1-726-361-4103','Finance','Controller','2022-01-16',58238.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(11,'EMP1600','Sarah','Taylor','sarah.taylor@company.com','+1-507-344-7112','Finance','Finance Manager','2022-09-16',80157.00,'EMP9579','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(12,'EMP7269','Andrew','Flores','andrew.flores@company.com','+1-976-811-6108','Engineering','DevOps Engineer','2025-08-25',77399.00,'EMP1575','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(13,'EMP8225','Elizabeth','Campbell','elizabeth.campbell@company.com','+1-724-458-4722','Marketing','SEO Specialist','2021-04-29',79407.00,'EMP1575','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(14,'EMP3495','Barbara','Lewis','barbara.lewis@company.com','+1-675-562-1612','IT Support','System Administrator','2021-04-30',80373.00,'EMP6344','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(15,'EMP2276','Andrew','Rivera','andrew.rivera@company.com','+1-764-341-8152','Engineering','Software Engineer','2021-02-27',96910.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(16,'EMP4458','Patricia','Moore','patricia.moore@company.com','+1-999-993-6467','Operations','Operations Manager','2025-01-01',82065.00,'EMP6668','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(17,'EMP2755','Brian','Hernandez','brian.hernandez@company.com','+1-254-907-5661','Finance','Budget Analyst','2022-01-31',66111.00,'EMP6344','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(18,'EMP7231','William','Wright','william.wright@company.com','+1-293-238-2915','Finance','Finance Manager','2025-04-06',68750.00,'EMP2755','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(19,'EMP8610','James','King','james.king@company.com','+1-995-535-2752','Engineering','QA Engineer','2023-01-31',72307.00,'EMP4458','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(20,'EMP2239','Donald','Martinez','donald.martinez@company.com','+1-705-773-3541','Engineering','Senior Developer','2021-08-12',62713.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(21,'EMP2389','James','Baker','james.baker@company.com','+1-888-261-3049','Operations','Logistics Coordinator','2022-09-03',65193.00,'EMP2239','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(22,'EMP4366','Jessica','Miller','jessica.miller@company.com','+1-523-487-3748','IT Support','Network Engineer','2024-05-19',52173.00,'EMP8225','Inactive','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(23,'EMP2628','Christopher','Wright','christopher.wright@company.com','+1-707-207-2541','Finance','Accountant','2022-04-10',75769.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(24,'EMP3837','Robert','Perez','robert.perez@company.com','+1-784-905-8482','HR','Compensation Analyst','2020-12-09',54382.00,'EMP7231','Inactive','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(25,'EMP9344','Donna','Jones','donna.jones@company.com','+1-370-719-1491','HR','Training Specialist','2021-06-05',48796.00,'EMP7618','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(26,'EMP8424','Sarah','Harris','sarah.harris@company.com','+1-457-653-4159','Finance','Financial Analyst','2025-01-17',89795.00,'EMP9344','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(27,'EMP2346','Elizabeth','Nguyen','elizabeth.nguyen@company.com','+1-838-459-6559','IT Support','Help Desk Technician','2021-08-08',69202.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(28,'EMP6450','Robert','Green','robert.green@company.com','+1-655-795-1375','HR','Recruiter','2021-02-03',61798.00,'EMP2346','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(29,'EMP3692','Anthony','Harris','anthony.harris@company.com','+1-845-753-5814','Marketing','Content Writer','2025-04-03',48221.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(30,'EMP3374','Kenneth','Lopez','kenneth.lopez@company.com','+1-362-674-9477','HR','HR Manager','2023-04-07',59073.00,'EMP8424','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(31,'EMP4707','Daniel','Garcia','daniel.garcia@company.com','+1-611-363-9089','Finance','Budget Analyst','2025-05-02',74055.00,'EMP9579','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(32,'EMP1882','Susan','Jackson','susan.jackson@company.com','+1-440-937-5244','Marketing','Brand Manager','2022-06-15',59584.00,'EMP2276','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(33,'EMP3565','John','Miller','john.miller@company.com','+1-846-302-9358','Sales','Business Development','2023-01-07',68249.00,'EMP1600','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(34,'EMP3689','Kimberly','Thompson','kimberly.thompson@company.com','+1-483-708-9271','Operations','Operations Manager','2023-01-22',78970.00,'EMP6450','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(35,'EMP7610','Patricia','Roberts','patricia.roberts@company.com','+1-624-560-4826','HR','HR Manager','2020-11-29',60229.00,'EMP2276','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(36,'EMP4294','Kevin','Martin','kevin.martin@company.com','+1-386-953-2225','IT Support','Help Desk Technician','2023-02-24',81195.00,'EMP7610','Inactive','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(37,'EMP9949','Karen','Carter','karen.carter@company.com','+1-770-983-8251','Finance','Controller','2021-02-21',87639.00,'EMP3692','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(38,'EMP9893','Barbara','Mitchell','barbara.mitchell@company.com','+1-754-342-5259','Engineering','DevOps Engineer','2023-05-16',96709.00,'EMP9949','On Leave','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(39,'EMP9637','George','Sanchez','george.sanchez@company.com','+1-274-270-6189','Operations','Operations Specialist','2023-12-10',84422.00,'EMP7737','Inactive','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(40,'EMP1375','David','White','david.white@company.com','+1-232-751-6919','Operations','Supply Chain Analyst','2021-08-18',72266.00,'EMP3495','On Leave','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(41,'EMP1696','Jane','Williams','jane.williams@company.com','+1-677-460-3683','Operations','Process Analyst','2024-08-24',74893.00,'EMP6350','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(42,'EMP7765','Jane','Baker','jane.baker@company.com','+1-384-888-8411','IT Support','Database Administrator','2024-10-16',80853.00,'EMP7610','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(43,'EMP1478','Robert','Lewis','robert.lewis@company.com','+1-233-702-3027','IT Support','Network Engineer','2021-04-08',65792.00,'EMP4366','On Leave','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(44,'EMP2567','Mark','Brown','mark.brown@company.com','+1-516-349-1226','Operations','Logistics Coordinator','2021-02-07',70871.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(45,'EMP6778','Edward','Harris','edward.harris@company.com','+1-792-761-4758','IT Support','Database Administrator','2021-10-12',55998.00,'EMP9579','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(46,'EMP4535','Susan','Nguyen','susan.nguyen@company.com','+1-603-715-8487','Marketing','Brand Manager','2022-05-25',79254.00,'EMP4707','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(47,'EMP8857','Carol','Johnson','carol.johnson@company.com','+1-482-408-6986','Operations','Process Analyst','2025-06-09',55292.00,'EMP6350','Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(48,'EMP4199','Sandra','Martinez','sandra.martinez@company.com','+1-308-367-4149','Finance','Budget Analyst','2022-11-09',80810.00,'EMP3692','On Leave','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(49,'EMP6362','Joseph','Moore','joseph.moore@company.com','+1-330-963-4718','Operations','Process Analyst','2022-10-18',76178.00,NULL,'Active','2025-11-10 22:21:20','2025-11-10 22:21:20'),
(50,'EMP8205','Betty','Roberts','betty.roberts@company.com','+1-530-935-4953','Marketing','Content Writer','2022-09-15',52458.00,'EMP4707','Active','2025-11-10 22:21:20','2025-11-10 22:21:20');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'employee_company'
--

--
-- Dumping routines for database 'employee_company'
--

--
-- Current Database: `employee_company`
--

USE `employee_company`;

--
-- Final view structure for view `employee_summary`
--

/*!50001 DROP VIEW IF EXISTS `employee_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employee_summary` AS select `e`.`employee_id` AS `employee_id`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `full_name`,`e`.`email` AS `email`,`e`.`department` AS `department`,`e`.`position` AS `position`,`e`.`salary` AS `salary`,`e`.`hire_date` AS `hire_date`,`e`.`status` AS `status`,to_days(curdate()) - to_days(`e`.`hire_date`) AS `days_employed` from `employees` `e` order by `e`.`department`,`e`.`last_name` */;
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

-- Dump completed on 2025-11-10 22:32:05
