CREATE DATABASE  IF NOT EXISTS `addressbook_service` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `addressbook_service`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: addressbook_service
-- ------------------------------------------------------
-- Server version	5.7.32-log

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
-- Table structure for table `address_details`
--

DROP TABLE IF EXISTS `address_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_details` (
  `PersonId` int(10) unsigned NOT NULL,
  `Address` varchar(150) NOT NULL,
  `City` varchar(150) NOT NULL,
  `State` varchar(150) NOT NULL,
  `Zip` varchar(150) NOT NULL,
  KEY `PersonId` (`PersonId`),
  CONSTRAINT `address_details_ibfk_1` FOREIGN KEY (`PersonId`) REFERENCES `addressbook` (`PersonId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_details`
--

LOCK TABLES `address_details` WRITE;
/*!40000 ALTER TABLE `address_details` DISABLE KEYS */;
INSERT INTO `address_details` VALUES (1,'CST','Mumbai','Maharashtra','492792'),(2,'Nagar','Pune','Maharashtra','426312'),(3,'Karve','Pune','Maharashtra','463792'),(5,'K','Mumbai','Maharashtra','498792');
/*!40000 ALTER TABLE `address_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addressbook`
--

DROP TABLE IF EXISTS `addressbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook` (
  `PersonId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(150) NOT NULL,
  `LastName` varchar(150) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Email` varchar(150) NOT NULL,
  PRIMARY KEY (`PersonId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook`
--

LOCK TABLES `addressbook` WRITE;
/*!40000 ALTER TABLE `addressbook` DISABLE KEYS */;
INSERT INTO `addressbook` VALUES (1,'Terrisa','Sh','9876543210','ts@gm.com'),(2,'Bill','Sh','9876543211','bs@gm.com'),(3,'Mark','W','9876543212','mw@gm.com'),(5,'Gunjan','T','9876543213','gt@gm.com');
/*!40000 ALTER TABLE `addressbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addressbook_type`
--

DROP TABLE IF EXISTS `addressbook_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_type` (
  `TypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AddressbookName` varchar(20) NOT NULL,
  `AddressbookType` varchar(20) NOT NULL,
  PRIMARY KEY (`TypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_type`
--

LOCK TABLES `addressbook_type` WRITE;
/*!40000 ALTER TABLE `addressbook_type` DISABLE KEYS */;
INSERT INTO `addressbook_type` VALUES (1,'FamilyContact','Family'),(2,'FriendContact','Friend'),(3,'ProfessionContact','Profession');
/*!40000 ALTER TABLE `addressbook_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_type`
--

DROP TABLE IF EXISTS `contact_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_type` (
  `PersonId` int(10) unsigned NOT NULL,
  `TypeId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`PersonId`,`TypeId`),
  KEY `TypeId` (`TypeId`),
  CONSTRAINT `contact_type_ibfk_1` FOREIGN KEY (`PersonId`) REFERENCES `addressbook` (`PersonId`) ON DELETE CASCADE,
  CONSTRAINT `contact_type_ibfk_2` FOREIGN KEY (`TypeId`) REFERENCES `addressbook_type` (`TypeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_type`
--

LOCK TABLES `contact_type` WRITE;
/*!40000 ALTER TABLE `contact_type` DISABLE KEYS */;
INSERT INTO `contact_type` VALUES (1,1),(2,1),(1,2),(3,2),(5,3);
/*!40000 ALTER TABLE `contact_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-21 23:17:42
