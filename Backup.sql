CREATE DATABASE  IF NOT EXISTS `urbaneats` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `urbaneats`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: urbaneats
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(10) NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `uq_customer_email` (`Email`),
  UNIQUE KEY `uq_customer_phone` (`Phone`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Emma','Carter','emma.carter@example.com','0411000001','2025-06-30 23:10:00'),(2,'James','Wilson','james.wilson@example.com','0411000002','2025-07-02 00:20:00'),(3,'Olivia','Brown','olivia.brown@example.com','0411000003','2025-07-05 02:00:00'),(4,'William','Taylor','william.taylor@example.com','0411000004','2025-07-09 22:30:00'),(5,'Sophia','Johnson','sophia.johnson@example.com','0411000005','2025-07-15 05:00:00'),(6,'Lucas','Martin','lucas.martin@example.com','0411000006','2025-07-18 06:45:00'),(7,'Amelia','Lee','amelia.lee@example.com','0411000007','2025-07-22 01:21:00'),(8,'Benjamin','Hall','ben.hall@example.com','0411000008','2025-07-25 04:00:00'),(9,'Charlotte','Young','charlotte.young@example.com','0411000009','2025-08-01 00:00:00'),(10,'Elijah','King','elijah.king@example.com','0411000010','2025-08-05 02:10:00'),(11,'Ava','Wright','ava.wright@example.com','0411000011','2025-08-08 03:20:00'),(12,'Henry','Scott','henry.scott@example.com','0411000012','2025-08-11 23:05:00'),(13,'Mia','Green','mia.green@example.com','0411000013','2025-08-15 07:50:00'),(14,'Jacob','Adams','jacob.adams@example.com','0411000014','2025-08-19 22:05:00'),(15,'Ella','Baker','ella.baker@example.com','0411000015','2025-08-25 03:40:00'),(16,'Logan','Campbell','logan.campbell@example.com','0411000016','2025-08-28 08:00:00'),(17,'Harper','Mitchell','harper.mitchell@example.com','0411000017','2025-08-31 21:50:00'),(18,'Michael','Parker','michael.parker@example.com','0411000018','2025-09-03 09:15:00'),(19,'Lily','Evans','lily.evans@example.com','0411000019','2025-09-07 01:11:00'),(20,'Daniel','Hughes','daniel.hughes@example.com','0411000020','2025-09-10 06:16:00');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `OrderItemID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Qty` int NOT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `TaxAmount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `LineTotal` decimal(10,2) GENERATED ALWAYS AS (((`Qty` * `UnitPrice`) + ifnull(`TaxAmount`,0))) STORED,
  PRIMARY KEY (`OrderItemID`),
  KEY `OrderID` (`OrderID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`),
  CONSTRAINT `ck_orderitem_price` CHECK ((`UnitPrice` >= 0)),
  CONSTRAINT `ck_orderitem_qty` CHECK ((`Qty` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` (`OrderItemID`, `OrderID`, `ProductID`, `Qty`, `UnitPrice`, `TaxAmount`) VALUES (1,1,101,2,3.50,0.70),(2,1,104,1,11.00,0.00),(3,2,102,2,4.50,0.90),(4,2,106,1,7.50,0.75),(5,2,103,1,3.80,0.38),(6,4,101,1,3.50,0.35),(7,4,105,1,13.50,1.35),(8,14,107,2,9.50,1.90),(9,14,102,1,4.50,0.45),(10,29,101,1,3.50,0.35),(11,8,102,2,4.50,0.90),(12,11,105,1,13.50,1.35),(13,18,101,1,3.50,0.35),(14,26,106,2,7.50,1.50),(15,30,103,3,3.80,1.14);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `OrderType` enum('Dine-in','Take away','Delivery') NOT NULL,
  `OrderDateTime` timestamp NULL DEFAULT NULL,
  `Status` enum('Finished','In progress','Cancelled','Refunded') NOT NULL DEFAULT 'In progress',
  `OutletID` int NOT NULL,
  `CustomerID` int DEFAULT NULL,
  `StaffID` int NOT NULL,
  `ReservationID` int DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `StaffID` (`StaffID`),
  KEY `ReservationID` (`ReservationID`),
  KEY `fk_orders_staff_outlet` (`OutletID`,`StaffID`),
  KEY `fk_orders_reservation_outlet` (`OutletID`,`ReservationID`),
  CONSTRAINT `fk_orders_reservation_outlet` FOREIGN KEY (`OutletID`, `ReservationID`) REFERENCES `reservation` (`OutletID`, `ReservationID`),
  CONSTRAINT `fk_orders_staff_outlet` FOREIGN KEY (`OutletID`, `StaffID`) REFERENCES `staff` (`OutletID`, `StaffID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`OutletID`) REFERENCES `outlet` (`OutletID`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`StaffID`) REFERENCES `staff` (`StaffID`),
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`ReservationID`) REFERENCES `reservation` (`ReservationID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'Dine-in','2025-09-15 02:35:00','Finished',1,3,4,1),(2,'Dine-in','2025-09-15 09:10:00','Finished',1,7,4,2),(3,'Dine-in','2025-09-15 22:40:00','Finished',2,1,8,4),(4,'Take away','2025-09-15 23:05:00','Finished',2,2,9,NULL),(5,'Delivery','2025-09-16 03:10:00','Finished',3,4,13,5),(6,'Dine-in','2025-09-16 09:35:00','Cancelled',3,5,13,6),(7,'Dine-in','2025-09-17 02:10:00','Finished',2,8,8,7),(8,'Dine-in','2025-09-17 08:55:00','Finished',1,9,4,8),(9,'Dine-in','2025-09-16 22:00:00','Finished',3,10,13,9),(10,'Take away','2025-09-16 23:00:00','Finished',1,12,5,NULL),(11,'Delivery','2025-09-17 10:10:00','Finished',2,6,10,NULL),(12,'Dine-in','2025-09-17 23:20:00','Finished',2,12,8,10),(13,'Dine-in','2025-09-18 03:40:00','In progress',1,13,4,11),(14,'Dine-in','2025-09-18 09:20:00','Finished',1,14,4,12),(15,'Dine-in','2025-09-18 08:10:00','Cancelled',3,15,13,13),(16,'Delivery','2025-09-18 02:15:00','Finished',3,16,13,NULL),(17,'Take away','2025-09-17 21:45:00','Finished',3,17,14,NULL),(18,'Dine-in','2025-09-18 03:05:00','Finished',3,11,13,NULL),(19,'Dine-in','2025-09-18 10:30:00','Finished',3,20,13,15),(20,'Take away','2025-09-18 00:10:00','Finished',2,18,9,NULL),(21,'Delivery','2025-09-18 22:15:00','Finished',1,19,1,NULL),(22,'Dine-in','2025-09-19 02:35:00','Finished',2,7,8,14),(23,'Dine-in','2025-09-19 03:10:00','Finished',3,3,13,NULL),(24,'Take away','2025-09-19 04:50:00','In progress',1,2,5,NULL),(25,'Delivery','2025-09-19 08:25:00','Finished',2,10,10,NULL),(26,'Dine-in','2025-09-19 09:40:00','Finished',1,15,4,NULL),(27,'Dine-in','2025-09-18 21:55:00','Finished',3,12,16,NULL),(28,'Take away','2025-09-18 23:35:00','Finished',3,9,14,NULL),(29,'Dine-in','2025-09-19 02:10:00','Finished',1,NULL,4,NULL),(30,'Dine-in','2025-09-16 03:05:00','Finished',3,4,13,5);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outlet`
--

DROP TABLE IF EXISTS `outlet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outlet` (
  `OutletID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone` varchar(10) NOT NULL,
  PRIMARY KEY (`OutletID`),
  UNIQUE KEY `uq_outlet_name` (`Name`),
  UNIQUE KEY `uq_outlet_address` (`Address`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outlet`
--

LOCK TABLES `outlet` WRITE;
/*!40000 ALTER TABLE `outlet` DISABLE KEYS */;
INSERT INTO `outlet` VALUES (1,'Urban Eats – CBD','10 George St, Sydney NSW','0291000001'),(2,'Urban Eats – Marsfield','5 Epping St, Newtown NSW','0291000002'),(3,'Urban Eats – Parramatta','15 George St, Parramatta NSW','0291000003');
/*!40000 ALTER TABLE `outlet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `PaymentDateTime` timestamp NULL DEFAULT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Method` enum('Cash','Card','Transfer') NOT NULL,
  `Status` enum('Approved','Declined','Refunded','Pending') NOT NULL DEFAULT 'Pending',
  `RefCode` varchar(100) DEFAULT NULL,
  `OrderID` int NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  CONSTRAINT `payment_chk_1` CHECK ((`Amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'2025-09-15 02:40:00',10.00,'Cash','Approved','O1-CASH',1),(2,'2025-09-15 02:41:00',5.50,'Card','Approved','O1-CARD',1),(3,'2025-09-15 09:12:00',5.00,'Card','Declined','O2-D1',2),(4,'2025-09-15 09:14:00',15.03,'Card','Approved','O2-APP',2),(5,'2025-09-18 09:45:00',23.40,'Card','Approved','O14-APP',14),(6,'2025-09-18 10:10:00',23.40,'Card','Refunded','O14-REF',14),(7,'2025-09-18 22:25:00',34.26,'Transfer','Approved','O21-APP',21),(8,'2025-09-19 04:55:00',8.00,'Cash','Pending','O24-PEND',24),(9,'2025-09-19 02:12:00',3.85,'Cash','Approved','O29-CASH',29),(10,'2025-09-16 03:20:00',12.75,'Card','Refunded','O30-APP',30),(11,'2025-09-19 03:55:00',12.54,'Cash','Approved','O30-CASH',30),(12,'2025-09-17 09:00:00',9.90,'Card','Approved','O8-CARD',8),(13,'2025-09-17 10:12:00',14.85,'Transfer','Approved','O11-TRF',11),(14,'2025-09-18 03:20:00',3.85,'Cash','Approved','O18-CASH',18),(15,'2025-09-19 09:45:00',16.50,'Card','Approved','O26-CARD',26);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `CategoryID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `uq_product_cat_name` (`CategoryID`,`Name`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `product_category` (`CategoryID`),
  CONSTRAINT `product_chk_1` CHECK ((`Price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (101,4,'Espresso','Single shot',3.50,1),(102,4,'Latte','Espresso with milk',4.50,1),(103,5,'Green Tea','Sencha',3.80,1),(104,6,'Avocado Toast','Sourdough + avo',11.00,1),(105,7,'Chicken Wrap','Grilled wrap',13.50,1),(106,8,'Cheesecake','NY style',7.50,1),(107,7,'Pumpkin Soup','Seasonal',9.50,0),(108,7,'Grilled Chicken','Grilled wrap',13.50,1),(109,8,'Red Velvet','Dairy',7.50,1),(110,8,'Cookies','NY style',5.50,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `ParentCategoryID` int DEFAULT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `ParentCategoryID` (`ParentCategoryID`,`Name`),
  CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`ParentCategoryID`) REFERENCES `product_category` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (3,'Dessert',NULL),(1,'Drink',NULL),(2,'Food',NULL),(4,'Coffee',1),(5,'Tea',1),(6,'Breakfast',2),(7,'Lunch',2),(8,'Cakes',3);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `OutletID` int NOT NULL,
  `ReceivedByStaffID` int DEFAULT NULL,
  `ReservationDateTime` datetime NOT NULL,
  `NumberOfPeople` int NOT NULL,
  `Status` enum('Pending','Served','Cancelled') NOT NULL DEFAULT 'Pending',
  `Notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ReservationID`),
  UNIQUE KEY `uq_res_outlet_res` (`OutletID`,`ReservationID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `fk_res_received_by_same_outlet` (`OutletID`,`ReceivedByStaffID`),
  CONSTRAINT `fk_res_received_by_same_outlet` FOREIGN KEY (`OutletID`, `ReceivedByStaffID`) REFERENCES `staff` (`OutletID`, `StaffID`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`OutletID`) REFERENCES `outlet` (`OutletID`),
  CONSTRAINT `reservation_chk_1` CHECK ((`NumberOfPeople` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,3,1,NULL,'2025-09-15 12:30:00',2,'Served','Nearby Window'),(2,7,1,NULL,'2025-09-15 19:00:00',4,'Served','Birthday'),(3,11,2,NULL,'2025-09-15 18:30:00',3,'Cancelled','Sick'),(4,1,2,NULL,'2025-09-16 08:30:00',2,'Served','Pre-work'),(5,4,3,NULL,'2025-09-16 13:00:00',5,'Served',NULL),(6,5,3,NULL,'2025-09-16 19:00:00',2,'Cancelled','Could not reach'),(7,8,2,NULL,'2025-09-17 12:00:00',2,'Served','Vegan'),(8,9,1,NULL,'2025-09-17 18:45:00',6,'Served','Anniversary'),(9,10,3,NULL,'2025-09-17 07:45:00',2,'Served',''),(10,12,2,NULL,'2025-09-18 09:15:00',2,'Pending',''),(11,13,1,NULL,'2025-09-18 13:30:00',3,'Served','Lactose free'),(12,14,1,NULL,'2025-09-18 19:00:00',4,'Served','Late arrival'),(13,15,3,NULL,'2025-09-18 18:00:00',2,'Cancelled','Heavy rain'),(14,17,2,NULL,'2025-09-19 12:30:00',2,'Pending',''),(15,20,3,NULL,'2025-09-19 19:30:00',5,'Pending','');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift`
--

DROP TABLE IF EXISTS `shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shift` (
  `ShiftID` int NOT NULL AUTO_INCREMENT,
  `OutletID` int NOT NULL,
  `ShiftDate` date NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `AssignedHours` decimal(5,2) GENERATED ALWAYS AS ((case when (`EndTime` < `StartTime`) then (timestampdiff(MINUTE,timestamp(`ShiftDate`,`StartTime`),timestamp((`ShiftDate` + interval 1 day),`EndTime`)) / 60.0) else (timestampdiff(MINUTE,timestamp(`ShiftDate`,`StartTime`),timestamp(`ShiftDate`,`EndTime`)) / 60.0) end)) STORED,
  PRIMARY KEY (`ShiftID`),
  UNIQUE KEY `uq_shift_outlet` (`OutletID`,`ShiftID`),
  CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`OutletID`) REFERENCES `outlet` (`OutletID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shift`
--

LOCK TABLES `shift` WRITE;
/*!40000 ALTER TABLE `shift` DISABLE KEYS */;
INSERT INTO `shift` (`ShiftID`, `OutletID`, `ShiftDate`, `StartTime`, `EndTime`) VALUES (1,1,'2025-09-15','06:00:00','14:00:00'),(2,1,'2025-09-15','14:00:00','22:00:00'),(3,1,'2025-09-16','07:00:00','15:00:00'),(4,1,'2025-09-16','18:00:00','23:00:00'),(5,1,'2025-09-17','22:00:00','02:00:00'),(6,2,'2025-09-15','07:00:00','13:00:00'),(7,2,'2025-09-15','13:00:00','19:00:00'),(8,2,'2025-09-16','08:00:00','16:00:00'),(9,2,'2025-09-17','17:00:00','23:00:00'),(10,2,'2025-09-18','22:00:00','03:00:00'),(11,3,'2025-09-15','06:30:00','12:30:00'),(12,3,'2025-09-15','12:30:00','20:30:00'),(13,3,'2025-09-16','06:30:00','14:30:00'),(14,3,'2025-09-16','14:30:00','22:30:00'),(15,3,'2025-09-17','22:00:00','01:00:00'),(16,3,'2025-09-18','07:00:00','13:00:00'),(17,3,'2025-09-18','13:00:00','21:00:00'),(18,3,'2025-09-19','06:00:00','14:00:00'),(19,1,'2025-09-18','07:00:00','15:00:00'),(20,1,'2025-09-18','15:00:00','22:00:00'),(21,1,'2025-09-19','07:00:00','15:00:00'),(22,1,'2025-09-19','15:00:00','22:00:00');
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `OutletID` int NOT NULL,
  `Role` enum('Manager','Kitchen','Hall','Barista') NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(10) NOT NULL,
  `StartDate` date NOT NULL,
  `Status` enum('Inactive','Active') DEFAULT 'Active',
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `uq_staff_outlet_staff` (`OutletID`,`StaffID`),
  UNIQUE KEY `uq_staff_email` (`Email`),
  UNIQUE KEY `uq_staff_phone` (`Phone`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`OutletID`) REFERENCES `outlet` (`OutletID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,1,'Manager','Ava','Nguyen','ava.nguyen@urbaneats.com','0400000001','2024-02-01','Active'),(2,1,'Kitchen','Liam','Tran','liam.tran@urbaneats.com','0400000002','2024-03-10','Active'),(3,1,'Kitchen','Noah','Pham','noah.pham@urbaneats.com','0400000003','2024-06-15','Active'),(4,1,'Hall','Mia','Le','mia.le@urbaneats.com','0400000004','2024-07-01','Active'),(5,1,'Barista','Jack','Vo','jack.vo@urbaneats.com','0400000005','2024-05-20','Active'),(6,1,'Hall','Jenny','Lu','jenny.lu@urbaneats.com','0400000335','2024-02-20','Inactive'),(7,1,'Hall','Jack','Truong','jack.truong@urbaneats.com','0400000215','2024-11-20','Inactive'),(8,2,'Manager','Isla','Ho','isla.ho@urbaneats.com','0400000011','2024-01-25','Active'),(9,2,'Kitchen','Ethan','Do','ethan.do@urbaneats.com','0400000012','2024-03-20','Active'),(10,2,'Hall','Sofia','Bui','sofia.bui@urbaneats.com','0400000013','2024-04-18','Active'),(11,2,'Barista','Leo','Dang','leo.dang@urbaneats.com','0400000014','2024-05-02','Active'),(12,2,'Kitchen','Zoe','Huynh','zoe.huynh@urbaneats.com','0400000015','2025-01-05','Active'),(13,3,'Manager','Oliver','Ng','oliver.ng@urbaneats.com','0400000021','2024-02-10','Active'),(14,3,'Kitchen','Grace','Ly','grace.ly@urbaneats.com','0400000022','2024-06-01','Active'),(15,3,'Hall','Henry','Vo','henry.vo@urbaneats.com','0400000023','2024-06-20','Active'),(16,3,'Barista','Chloe','Vu','chloe.vu@urbaneats.com','0400000024','2024-08-12','Active'),(17,3,'Kitchen','Mason','Le','mason.le@urbaneats.com','0400000025','2025-02-01','Active');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffshift`
--

DROP TABLE IF EXISTS `staffshift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffshift` (
  `StaffShiftID` int NOT NULL AUTO_INCREMENT,
  `OutletID` int NOT NULL,
  `ShiftID` int NOT NULL,
  `StaffID` int NOT NULL,
  `ActualStart` timestamp NULL DEFAULT NULL,
  `ActualEnd` timestamp NULL DEFAULT NULL,
  `ActualHours` decimal(6,2) GENERATED ALWAYS AS ((case when ((`ActualStart` is null) or (`ActualEnd` is null)) then NULL else (timestampdiff(SECOND,`ActualStart`,`ActualEnd`) / 3600.0) end)) STORED,
  PRIMARY KEY (`StaffShiftID`),
  UNIQUE KEY `uq_staff_shift` (`StaffID`,`ShiftID`),
  KEY `fk_staffshift_shift` (`OutletID`,`ShiftID`),
  KEY `fk_staffshift_staff` (`OutletID`,`StaffID`),
  CONSTRAINT `fk_staffshift_shift` FOREIGN KEY (`OutletID`, `ShiftID`) REFERENCES `shift` (`OutletID`, `ShiftID`),
  CONSTRAINT `fk_staffshift_staff` FOREIGN KEY (`OutletID`, `StaffID`) REFERENCES `staff` (`OutletID`, `StaffID`),
  CONSTRAINT `staffshift_chk_1` CHECK (((`ActualEnd` is null) or (`ActualEnd` >= `ActualStart`)))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffshift`
--

LOCK TABLES `staffshift` WRITE;
/*!40000 ALTER TABLE `staffshift` DISABLE KEYS */;
INSERT INTO `staffshift` (`StaffShiftID`, `OutletID`, `ShiftID`, `StaffID`, `ActualStart`, `ActualEnd`) VALUES (1,1,1,2,'2025-09-14 20:02:00','2025-09-15 03:58:00'),(2,1,1,4,'2025-09-14 20:05:00','2025-09-15 03:55:00'),(3,1,1,5,'2025-09-14 20:00:00','2025-09-15 04:00:00'),(4,1,2,1,'2025-09-15 04:00:00','2025-09-15 12:05:00'),(5,1,2,3,'2025-09-15 04:10:00','2025-09-15 11:55:00'),(6,1,3,4,'2025-09-15 21:00:00','2025-09-16 05:00:00'),(7,1,3,5,'2025-09-15 21:05:00','2025-09-16 04:58:00'),(8,1,4,2,'2025-09-16 08:05:00','2025-09-16 13:00:00'),(9,1,5,3,'2025-09-16 12:00:00','2025-09-16 16:00:00'),(10,2,6,10,'2025-09-14 21:00:00','2025-09-15 03:02:00'),(11,2,7,11,'2025-09-15 03:00:00','2025-09-15 09:00:00'),(12,2,8,8,'2025-09-15 22:00:00','2025-09-16 06:00:00'),(13,2,9,9,'2025-09-17 07:00:00','2025-09-17 13:00:00'),(14,2,10,11,'2025-09-17 12:00:00','2025-09-17 17:00:00'),(15,3,11,16,'2025-09-14 20:30:00','2025-09-15 02:30:00'),(16,3,12,15,'2025-09-15 02:30:00','2025-09-15 10:25:00'),(17,3,13,13,'2025-09-15 20:30:00','2025-09-16 04:35:00'),(18,3,14,14,'2025-09-16 04:30:00','2025-09-16 12:30:00'),(19,3,15,16,'2025-09-17 12:00:00','2025-09-17 15:00:00'),(20,3,16,13,'2025-09-17 21:00:00','2025-09-18 03:00:00'),(21,3,17,14,'2025-09-18 03:00:00','2025-09-18 11:00:00'),(22,3,18,13,'2025-09-18 20:00:00','2025-09-19 04:00:00'),(23,1,19,4,'2025-09-17 21:02:00','2025-09-18 04:56:00'),(24,1,19,5,'2025-09-17 21:00:00','2025-09-18 05:00:00'),(25,1,20,1,'2025-09-18 05:00:00','2025-09-18 12:05:00'),(26,1,20,2,'2025-09-18 05:10:00','2025-09-18 11:55:00'),(27,1,21,5,'2025-09-18 21:00:00','2025-09-19 05:00:00'),(28,1,21,3,'2025-09-18 21:05:00','2025-09-19 04:58:00'),(29,1,22,4,'2025-09-19 05:00:00','2025-09-19 11:59:00'),(30,1,22,1,'2025-09-19 05:02:00','2025-09-19 12:03:00');
/*!40000 ALTER TABLE `staffshift` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-23 15:56:22
