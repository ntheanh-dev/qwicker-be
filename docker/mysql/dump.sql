CREATE DATABASE  IF NOT EXISTS `deliverydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `deliverydb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: deliverydb
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add address',6,'add_address'),(22,'Can change address',6,'change_address'),(23,'Can delete address',6,'delete_address'),(24,'Can view address',6,'view_address'),(25,'Can add payment method',7,'add_paymentmethod'),(26,'Can change payment method',7,'change_paymentmethod'),(27,'Can delete payment method',7,'delete_paymentmethod'),(28,'Can view payment method',7,'view_paymentmethod'),(29,'Can add product category',8,'add_productcategory'),(30,'Can change product category',8,'change_productcategory'),(31,'Can delete product category',8,'delete_productcategory'),(32,'Can view product category',8,'view_productcategory'),(33,'Can add vehicle',9,'add_vehicle'),(34,'Can change vehicle',9,'change_vehicle'),(35,'Can delete vehicle',9,'delete_vehicle'),(36,'Can view vehicle',9,'view_vehicle'),(37,'Can add user',10,'add_user'),(38,'Can change user',10,'change_user'),(39,'Can delete user',10,'delete_user'),(40,'Can view user',10,'view_user'),(41,'Can add basic user',11,'add_basicuser'),(42,'Can change basic user',11,'change_basicuser'),(43,'Can delete basic user',11,'delete_basicuser'),(44,'Can view basic user',11,'view_basicuser'),(45,'Can add shipper',12,'add_shipper'),(46,'Can change shipper',12,'change_shipper'),(47,'Can delete shipper',12,'delete_shipper'),(48,'Can view shipper',12,'view_shipper'),(49,'Can add payment',13,'add_payment'),(50,'Can change payment',13,'change_payment'),(51,'Can delete payment',13,'delete_payment'),(52,'Can view payment',13,'view_payment'),(53,'Can add product',14,'add_product'),(54,'Can change product',14,'change_product'),(55,'Can delete product',14,'delete_product'),(56,'Can view product',14,'view_product'),(57,'Can add shipment',15,'add_shipment'),(58,'Can change shipment',15,'change_shipment'),(59,'Can delete shipment',15,'delete_shipment'),(60,'Can view shipment',15,'view_shipment'),(61,'Can add shipper more',16,'add_shippermore'),(62,'Can change shipper more',16,'change_shippermore'),(63,'Can delete shipper more',16,'delete_shippermore'),(64,'Can view shipper more',16,'view_shippermore'),(65,'Can add job',17,'add_job'),(66,'Can change job',17,'change_job'),(67,'Can delete job',17,'delete_job'),(68,'Can view job',17,'view_job'),(69,'Can add feedback',18,'add_feedback'),(70,'Can change feedback',18,'change_feedback'),(71,'Can delete feedback',18,'delete_feedback'),(72,'Can view feedback',18,'view_feedback'),(73,'Can add auction',19,'add_auction'),(74,'Can change auction',19,'change_auction'),(75,'Can delete auction',19,'delete_auction'),(76,'Can view auction',19,'view_auction'),(77,'Can add application',20,'add_application'),(78,'Can change application',20,'change_application'),(79,'Can delete application',20,'delete_application'),(80,'Can view application',20,'view_application'),(81,'Can add access token',21,'add_accesstoken'),(82,'Can change access token',21,'change_accesstoken'),(83,'Can delete access token',21,'delete_accesstoken'),(84,'Can view access token',21,'view_accesstoken'),(85,'Can add grant',22,'add_grant'),(86,'Can change grant',22,'change_grant'),(87,'Can delete grant',22,'delete_grant'),(88,'Can view grant',22,'view_grant'),(89,'Can add refresh token',23,'add_refreshtoken'),(90,'Can change refresh token',23,'change_refreshtoken'),(91,'Can delete refresh token',23,'delete_refreshtoken'),(92,'Can view refresh token',23,'view_refreshtoken'),(93,'Can add id token',24,'add_idtoken'),(94,'Can change id token',24,'change_idtoken'),(95,'Can delete id token',24,'delete_idtoken'),(96,'Can view id token',24,'view_idtoken'),(97,'Can add association',25,'add_association'),(98,'Can change association',25,'change_association'),(99,'Can delete association',25,'delete_association'),(100,'Can view association',25,'view_association'),(101,'Can add code',26,'add_code'),(102,'Can change code',26,'change_code'),(103,'Can delete code',26,'delete_code'),(104,'Can view code',26,'view_code'),(105,'Can add nonce',27,'add_nonce'),(106,'Can change nonce',27,'change_nonce'),(107,'Can delete nonce',27,'delete_nonce'),(108,'Can view nonce',27,'view_nonce'),(109,'Can add user social auth',28,'add_usersocialauth'),(110,'Can change user social auth',28,'change_usersocialauth'),(111,'Can delete user social auth',28,'delete_usersocialauth'),(112,'Can view user social auth',28,'view_usersocialauth'),(113,'Can add partial',29,'add_partial'),(114,'Can change partial',29,'change_partial'),(115,'Can delete partial',29,'delete_partial'),(116,'Can view partial',29,'view_partial'),(117,'Can add multi factor auth',30,'add_multifactorauth'),(118,'Can change multi factor auth',30,'change_multifactorauth'),(119,'Can delete multi factor auth',30,'delete_multifactorauth'),(120,'Can view multi factor auth',30,'view_multifactorauth'),(121,'Can add billing',31,'add_billing'),(122,'Can change billing',31,'change_billing'),(123,'Can delete billing',31,'delete_billing'),(124,'Can view billing',31,'view_billing'),(125,'Can add coupon',32,'add_coupon'),(126,'Can change coupon',32,'change_coupon'),(127,'Can delete coupon',32,'delete_coupon'),(128,'Can view coupon',32,'view_coupon');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_address`
--

DROP TABLE IF EXISTS `core_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `country` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `district` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `street` varchar(50) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `home_number` varchar(10) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `latitude` decimal(17,15) NOT NULL,
  `longitude` decimal(17,14) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_address`
--

LOCK TABLES `core_address` WRITE;
/*!40000 ALTER TABLE `core_address` DISABLE KEYS */;
INSERT INTO `core_address` VALUES (167,'Anh','073506362','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Kiệm','371',10.816674118627507,106.67741941096348),(168,'Em','0586396365','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','469',10.741081276718683,106.70178961935980),(169,'Anh Hoà','0548632652','Việt Nam','Hồ Chí Minh','Phường 6, Quận 3','Võ Văn Tần','97',10.776542261943176,106.69019845559328),(170,'Chị A','0548216395','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(171,'Anh Hoà','0548632652','Việt Nam','Hồ Chí Minh','Phường 6, Quận 3','Võ Văn Tần','97',10.776542261943176,106.69019845559328),(172,'Chị A','0548216395','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(173,'Anh C','0373549392','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Kiệm','371',10.816674118627507,106.67741941096348),(174,'Chị D','07548156392','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','19',10.733101626225203,106.69977633440382),(175,'Anh H','0758423165','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(176,'gl','868','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','469',10.741081276718683,106.70178961935980),(177,'Anh K','0451827365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(178,'Chị L','0758426136','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','469',10.741081276718683,106.70178961935980),(179,'bxx','878','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(180,'band','84678','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','3F',10.743350393821329,106.70153700786972),(181,'Theanh','0457816359','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','80 - 90',10.816517777190121,106.67991177213969),(182,'Chị B','04857946135','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','19',10.733101626225203,106.69977633440382),(183,'Anh K','0785486395','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(184,'Chị B','08754851635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','19',10.733101626225203,106.69977633440382),(185,'Anh K','0785486395','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(186,'Chị B','08754851635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','19',10.733101626225203,106.69977633440382),(187,'Anh U','0785481638','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Kiệm','371',10.816674118627507,106.67741941096348),(188,'Chị Y','0548670485','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','19',10.733101626225203,106.69977633440382),(189,'Anh O','046375062','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(190,'Chị L','0451278463','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','19',10.733101626225203,106.69977633440382),(191,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(192,'Thế Em','0780451863','Việt Nam','Hồ Chí Minh','Nhơn Đức, Nhà Bè',NULL,NULL,10.675584891564835,106.69065525750209),(193,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(198,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(199,'Thế Em','0780451863','Việt Nam','Hồ Chí Minh','Nhơn Đức, Nhà Bè',NULL,NULL,10.675584891564835,106.69065525750209),(200,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(201,'Thế Em','0780451863','Việt Nam','Hồ Chí Minh','Nhơn Đức, Nhà Bè',NULL,NULL,10.675584891564835,106.69065525750209),(202,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(203,'Thế Em','0780451863','Việt Nam','Hồ Chí Minh','Nhơn Đức, Nhà Bè',NULL,NULL,10.675584891564835,106.69065525750209),(204,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(205,'Thế Em','0780451863','Việt Nam','Hồ Chí Minh','Nhơn Đức, Nhà Bè',NULL,NULL,10.675584891564835,106.69065525750209),(206,'Thế Anh','0754861358','Việt Nam','Hồ Chí Minh','Bến Nghé, Quận 1','Công xã Paris','01',10.777185178129605,106.69524100828986),(207,'Thế Em','0780451863','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(210,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(211,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(212,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(213,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(214,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(215,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(216,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(217,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(218,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(219,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(220,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(221,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(222,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(223,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(224,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(225,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(226,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(227,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(228,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(229,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(230,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(231,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(232,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(233,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(234,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(235,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(236,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(237,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(238,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(239,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(240,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(241,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(242,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(243,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(244,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(245,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(246,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(247,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(248,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(249,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(250,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(251,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(252,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(253,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(254,'Anh Y','0754861365','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Thái Sơn','3',10.815476543222863,106.67795854392419),(255,'Chị L','078451635','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Văn Linh','702',10.729632024994975,106.69571359091915),(258,'Chị A','0373506362','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Kiệm','371',10.816674118627507,106.67741941096348),(259,'Anh B','075846392','Việt Nam','Hồ Chí Minh','Tân Hưng, Quận 7','Nguyễn Phú Thọ','469',10.741081276718683,106.70178961935980),(260,'Anh A','085639481','Việt Nam','Hồ Chí Minh','Phường 3, Gò Vấp','Nguyễn Kiệm','371',10.816674118627507,106.67741941096348),(261,'Chị K','078496832','Việt Nam','Hồ Chí Minh','Nhơn Đức, Nhà Bè',NULL,NULL,10.675584891564835,106.69065525750209);
/*!40000 ALTER TABLE `core_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_auction`
--

DROP TABLE IF EXISTS `core_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time_joined` datetime(6) NOT NULL,
  `job_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_auction_job_id_shipper_id_0692c474_uniq` (`job_id`,`shipper_id`),
  KEY `core_auction_shipper_id_fba52ff9_fk_core_user_id` (`shipper_id`),
  CONSTRAINT `core_auction_job_id_fa1e484f_fk_core_job_id` FOREIGN KEY (`job_id`) REFERENCES `core_job` (`id`),
  CONSTRAINT `core_auction_shipper_id_fba52ff9_fk_core_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auction`
--

LOCK TABLES `core_auction` WRITE;
/*!40000 ALTER TABLE `core_auction` DISABLE KEYS */;
INSERT INTO `core_auction` VALUES (41,'2024-02-24 16:16:53.942660',71,22),(45,'2024-02-24 17:45:45.164202',74,22),(46,'2024-02-24 17:45:57.013942',75,22),(47,'2024-02-24 17:46:55.219764',76,22),(48,'2024-02-24 17:47:04.646847',77,22),(51,'2024-02-24 18:03:59.133578',78,22),(52,'2024-02-24 20:40:42.409924',79,22),(53,'2024-02-24 20:40:51.164241',80,22),(54,'2024-02-24 20:40:54.372754',81,22),(55,'2024-02-24 20:40:59.189078',82,22),(56,'2024-02-27 16:21:55.297581',115,24);
/*!40000 ALTER TABLE `core_auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_coupon`
--

DROP TABLE IF EXISTS `core_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `start_at` date NOT NULL,
  `end_at` date NOT NULL,
  `percen_discount` decimal(3,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_coupon`
--

LOCK TABLES `core_coupon` WRITE;
/*!40000 ALTER TABLE `core_coupon` DISABLE KEYS */;
INSERT INTO `core_coupon` VALUES (1,'ABC','2024-02-23','2024-02-28',20);
/*!40000 ALTER TABLE `core_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_feedback`
--

DROP TABLE IF EXISTS `core_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `rating` int NOT NULL,
  `user_id` bigint NOT NULL,
  `shipper_id` bigint NOT NULL,
  `job_id` bigint NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_feedback_user_id_job_id_f376e633_uniq` (`user_id`,`job_id`),
  KEY `core_feedback_shipper_id_739dc470_fk_core_user_id` (`shipper_id`),
  KEY `core_feedback_job_id_c1676eea_fk_core_job_id` (`job_id`),
  CONSTRAINT `core_feedback_job_id_c1676eea_fk_core_job_id` FOREIGN KEY (`job_id`) REFERENCES `core_job` (`id`),
  CONSTRAINT `core_feedback_shipper_id_739dc470_fk_core_user_id` FOREIGN KEY (`shipper_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_feedback_user_id_630c6a53_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_feedback`
--

LOCK TABLES `core_feedback` WRITE;
/*!40000 ALTER TABLE `core_feedback` DISABLE KEYS */;
INSERT INTO `core_feedback` VALUES (11,'2024-02-24 17:11:49.762047',3,19,22,71,'Tình trạng phương tiện tốt'),(12,'2024-02-24 17:58:08.615014',5,20,22,77,'Phản hồi nhanh chóng'),(13,'2024-02-24 17:58:29.550198',4,20,22,76,'Phản hồi nhanh chóng, rất đúng giờ'),(14,'2024-02-24 17:58:45.323255',4,20,22,74,'Phản hồi nhanh chóng, rất đúng giờ'),(15,'2024-02-24 17:59:04.209213',4,20,22,75,'Phản hồi nhanh chóng, rất đúng giờ, rất đúng giờ, thái độ tốt');
/*!40000 ALTER TABLE `core_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_job`
--

DROP TABLE IF EXISTS `core_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_job` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `uuid` char(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `poster_id` bigint DEFAULT NULL,
  `payment_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `shipment_id` bigint DEFAULT NULL,
  `vehicle_id` bigint DEFAULT NULL,
  `winner_id` bigint DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_job_winner_id_c432c5fb_fk_core_user_id` (`winner_id`),
  KEY `core_job_payment_id_229d22c9_fk_core_payment_id` (`payment_id`),
  KEY `core_job_poster_id_151c933d_fk_core_user_id` (`poster_id`),
  KEY `core_job_product_id_fcbecf70_fk_core_product_id` (`product_id`),
  KEY `core_job_shipment_id_786860f3_fk_core_shipment_id` (`shipment_id`),
  KEY `core_job_vehicle_id_b00f7e18_fk_core_vehicle_id` (`vehicle_id`),
  CONSTRAINT `core_job_payment_id_229d22c9_fk_core_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `core_payment` (`id`),
  CONSTRAINT `core_job_poster_id_151c933d_fk_core_user_id` FOREIGN KEY (`poster_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_job_product_id_fcbecf70_fk_core_product_id` FOREIGN KEY (`product_id`) REFERENCES `core_product` (`id`),
  CONSTRAINT `core_job_shipment_id_786860f3_fk_core_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `core_shipment` (`id`),
  CONSTRAINT `core_job_vehicle_id_b00f7e18_fk_core_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `core_vehicle` (`id`),
  CONSTRAINT `core_job_winner_id_c432c5fb_fk_core_user_id` FOREIGN KEY (`winner_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_job`
--

LOCK TABLES `core_job` WRITE;
/*!40000 ALTER TABLE `core_job` DISABLE KEYS */;
INSERT INTO `core_job` VALUES (71,'2024-02-24 16:16:05.075952',1,'2024-02-24 16:16:05.075952','231c3f7d28ae4e089a5fdd889d8fc6d6',NULL,19,71,105,77,2,22,'5'),(74,'2024-02-24 17:31:54.465131',1,'2024-02-24 17:31:54.465131','74bebfadddf142cc98621f7e712b97c8',NULL,20,74,108,80,4,22,'5'),(75,'2024-02-24 17:36:44.687872',1,'2024-02-24 17:36:44.687872','74bebfadddf142cc98621f7e712b97c8',NULL,20,75,109,81,5,22,'5'),(76,'2024-02-24 17:37:49.278639',1,'2024-02-24 17:37:49.278639','74bebfadddf142cc98621f7e712b97c8',NULL,20,76,110,82,3,22,'5'),(77,'2024-02-24 17:44:37.128604',1,'2024-02-24 17:44:37.128604','74bebfadddf142cc98621f7e712b97c8',NULL,20,77,111,83,2,22,'5'),(78,'2024-02-24 18:00:41.039376',1,'2024-02-24 18:00:41.039376','e2faa906234a46668ecc5e9ce3540458',NULL,20,78,112,84,3,22,'5'),(79,'2024-02-24 20:08:44.110641',1,'2024-02-24 20:08:44.110641','e2faa906234a46668ecc5e9ce3540458',NULL,19,79,113,85,5,NULL,'1'),(80,'2024-02-24 20:23:26.736152',1,'2024-02-24 20:23:26.736152','e2faa906234a46668ecc5e9ce3540458',NULL,19,80,114,86,4,NULL,'1'),(81,'2024-02-24 20:30:23.976405',1,'2024-02-24 20:30:23.976405','e2faa906234a46668ecc5e9ce3540458',NULL,19,81,115,87,3,NULL,'1'),(82,'2024-02-24 20:38:02.856360',1,'2024-02-24 20:38:02.856360','e2faa906234a46668ecc5e9ce3540458',NULL,19,82,116,88,3,NULL,'1'),(83,'2024-02-24 21:01:55.154045',1,'2024-02-24 21:01:55.154045','bcf0a93db8c94f6380d9e477f320dfa8',NULL,20,83,117,96,3,NULL,'1'),(84,'2024-02-24 21:48:38.470121',1,'2024-02-24 21:48:38.470121','19d4279eefb0457badbaae12e278ebfd',NULL,20,85,120,99,3,NULL,'1'),(85,'2024-02-24 21:49:36.203593',1,'2024-02-24 21:49:36.203593','19d4279eefb0457badbaae12e278ebfd',NULL,20,86,121,100,3,NULL,'1'),(86,'2024-02-24 21:49:49.796499',1,'2024-02-24 21:49:49.796499','19d4279eefb0457badbaae12e278ebfd',NULL,20,87,122,101,3,NULL,'1'),(87,'2024-02-24 21:49:59.385316',1,'2024-02-24 21:49:59.385316','19d4279eefb0457badbaae12e278ebfd',NULL,20,88,123,102,3,NULL,'1'),(88,'2024-02-25 16:09:29.001808',1,'2024-02-25 16:09:29.001808','e7db8e91a9754d529a8dc2f1b44425b1','Hàng dễ vỡ',19,89,124,103,2,NULL,'1'),(90,'2024-02-25 21:08:09.065898',1,'2024-02-25 21:08:09.065898','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,91,126,105,3,NULL,'1'),(91,'2024-02-25 21:08:21.320662',1,'2024-02-25 21:08:21.320662','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,92,127,106,3,NULL,'1'),(92,'2024-02-25 21:08:30.089054',1,'2024-02-25 21:08:30.089054','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,93,128,107,3,NULL,'1'),(93,'2024-02-25 21:08:56.021722',1,'2024-02-25 21:08:56.021722','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,94,129,108,3,NULL,'1'),(94,'2024-02-25 21:09:07.435089',1,'2024-02-25 21:09:07.435303','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,95,130,109,3,NULL,'1'),(95,'2024-02-25 21:10:40.710696',1,'2024-02-25 21:10:40.710696','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,96,131,110,3,NULL,'1'),(96,'2024-02-25 21:11:57.405742',1,'2024-02-25 21:11:57.405796','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,97,132,111,3,NULL,'1'),(97,'2024-02-25 21:12:35.330860',1,'2024-02-25 21:12:35.330860','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,98,133,112,3,NULL,'1'),(98,'2024-02-25 21:12:47.802842',1,'2024-02-25 21:12:47.802842','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,99,134,113,3,NULL,'1'),(99,'2024-02-25 21:12:57.037094',1,'2024-02-25 21:12:57.037094','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,100,135,114,3,NULL,'1'),(100,'2024-02-25 21:13:08.009611',1,'2024-02-25 21:13:08.009611','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,101,136,115,3,NULL,'1'),(101,'2024-02-25 21:13:21.147911',1,'2024-02-25 21:13:21.147911','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,102,137,116,3,NULL,'1'),(102,'2024-02-25 21:13:45.694353',1,'2024-02-25 21:13:45.694519','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,103,138,117,3,NULL,'1'),(103,'2024-02-25 21:13:59.491708',1,'2024-02-25 21:13:59.491708','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,104,139,118,3,NULL,'1'),(104,'2024-02-25 21:14:25.492510',1,'2024-02-25 21:14:25.492510','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,105,140,119,3,NULL,'1'),(105,'2024-02-25 21:14:42.415487',1,'2024-02-25 21:14:42.415487','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,106,141,120,3,NULL,'1'),(106,'2024-02-25 21:14:58.845909',1,'2024-02-25 21:14:58.845909','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,107,142,121,3,NULL,'1'),(107,'2024-02-25 21:15:08.812276',1,'2024-02-25 21:15:08.812276','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,108,143,122,3,NULL,'1'),(108,'2024-02-25 21:15:23.241659',1,'2024-02-25 21:15:23.241659','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,109,144,123,3,NULL,'1'),(109,'2024-02-25 21:15:34.762058',1,'2024-02-25 21:15:34.762058','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,110,145,124,3,NULL,'1'),(110,'2024-02-25 21:15:45.404951',1,'2024-02-25 21:15:45.404951','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,111,146,125,3,NULL,'1'),(111,'2024-02-25 21:16:11.083733',1,'2024-02-25 21:16:11.083733','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,112,147,126,3,NULL,'1'),(112,'2024-02-25 21:16:45.229676',1,'2024-02-25 21:16:45.229676','097449578fc4499685929762975b856f','Hàng dễ vỡ',20,113,148,127,3,NULL,'1'),(114,'2024-02-27 10:15:49.637193',1,'2024-02-27 10:15:49.637193','9732a92841c347d3a856b31375b016da','Hàng dễ vỡ',19,115,150,129,2,NULL,'3'),(115,'2024-02-27 16:14:16.981277',1,'2024-02-27 16:14:16.981277','f1571bdc87d14a7498d7da3c3177c495','Hàng dễ vỡ',19,116,151,130,2,24,'2');
/*!40000 ALTER TABLE `core_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_payment`
--

DROP TABLE IF EXISTS `core_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(8,0) DEFAULT NULL,
  `is_poster_pay` tinyint(1) NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `method_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_payment_method_id_b06fdba4_fk_core_paymentmethod_id` (`method_id`),
  CONSTRAINT `core_payment_method_id_b06fdba4_fk_core_paymentmethod_id` FOREIGN KEY (`method_id`) REFERENCES `core_paymentmethod` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_payment`
--

LOCK TABLES `core_payment` WRITE;
/*!40000 ALTER TABLE `core_payment` DISABLE KEYS */;
INSERT INTO `core_payment` VALUES (71,177000,1,'2024-02-24 17:10:40.380080',2),(72,NULL,1,NULL,2),(73,NULL,1,NULL,2),(74,90000,1,'2024-02-24 17:55:40.222763',2),(75,97000,1,'2024-02-24 17:56:04.120479',2),(76,170000,1,'2024-02-24 17:56:14.512382',2),(77,243000,1,'2024-02-24 17:56:09.888905',2),(78,218000,1,'2024-02-24 18:02:33.309359',1),(79,NULL,1,NULL,2),(80,NULL,1,NULL,2),(81,NULL,1,NULL,2),(82,NULL,1,NULL,2),(83,NULL,1,NULL,2),(85,NULL,1,NULL,2),(86,NULL,1,NULL,2),(87,NULL,1,NULL,2),(88,NULL,1,NULL,2),(89,NULL,1,NULL,2),(91,NULL,1,NULL,2),(92,NULL,1,NULL,2),(93,NULL,1,NULL,2),(94,NULL,1,NULL,2),(95,NULL,1,NULL,2),(96,NULL,1,NULL,2),(97,NULL,1,NULL,2),(98,NULL,1,NULL,2),(99,NULL,1,NULL,2),(100,NULL,1,NULL,2),(101,NULL,1,NULL,2),(102,NULL,1,NULL,2),(103,NULL,1,NULL,2),(104,NULL,1,NULL,2),(105,NULL,1,NULL,2),(106,NULL,1,NULL,2),(107,NULL,1,NULL,2),(108,NULL,1,NULL,2),(109,NULL,1,NULL,2),(110,NULL,1,NULL,2),(111,NULL,1,NULL,2),(112,NULL,1,NULL,2),(113,NULL,1,NULL,2),(115,NULL,1,NULL,1),(116,NULL,1,NULL,2);
/*!40000 ALTER TABLE `core_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_paymentmethod`
--

DROP TABLE IF EXISTS `core_paymentmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_paymentmethod` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_paymentmethod`
--

LOCK TABLES `core_paymentmethod` WRITE;
/*!40000 ALTER TABLE `core_paymentmethod` DISABLE KEYS */;
INSERT INTO `core_paymentmethod` VALUES (1,'VnPay'),(2,'Tiền mặt');
/*!40000 ALTER TABLE `core_paymentmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_product`
--

DROP TABLE IF EXISTS `core_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `mass` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_product_category_id_b9d8ff9f_fk_core_productcategory_id` (`category_id`),
  CONSTRAINT `core_product_category_id_b9d8ff9f_fk_core_productcategory_id` FOREIGN KEY (`category_id`) REFERENCES `core_productcategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_product`
--

LOCK TABLES `core_product` WRITE;
/*!40000 ALTER TABLE `core_product` DISABLE KEYS */;
INSERT INTO `core_product` VALUES (105,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708766164/product/ezcno20pjvzk5bngzdk5.png','1',4),(106,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708769611/product/whqdf9hi0eow0d37im5a.png','1',1),(107,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708769699/product/suh2iqqfncolouv9xks1.png','1',1),(108,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708770714/product/mmq3plaplhlxnzpmryst.jpg','2',2),(109,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708771003/product/ng0wusel6enayr7lpjuh.jpg','2',2),(110,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708771068/product/m6bmcywvmbvzfrqyedb5.jpg','2',3),(111,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708771476/product/fvkcsiugjoyn4vkozpir.jpg','2',3),(112,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708772440/product/lr2tiobju684kwqiu1g3.jpg','3',3),(113,6,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708780123/product/s6nyopdurvz6p9wnf0oa.jpg','1',2),(114,6,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708781006/product/ggxv4gwzxevliwnpbull.jpg','2',5),(115,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708781423/product/ttbkp2xtkguylly9ecn7.jpg','1',3),(116,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708781881/product/wilx3qrdruskngq4dhka.jpg','1',4),(117,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708783314/product/bxzms7qnzlexoee63avc.jpg','1',2),(120,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708786117/product/qhlgdpalqe6flzmykejc.jpg','2',3),(121,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708786173/product/ylwa6rptcwvsvwe5kq3m.jpg','2',3),(122,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708786188/product/drgjynyietfj9v121ct7.jpg','2',3),(123,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708786198/product/vyfyjgrkoaxqayywsd8p.jpg','2',3),(124,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708852168/product/cljlcfco64oxxkbndz1w.jpg','1',4),(126,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870088/product/wts8nrokjbwvjhpkqchs.jpg','1',4),(127,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870100/product/clyo6b1okpbnermmz6lp.jpg','1',4),(128,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870109/product/pc26qpprxymgu5m0zddx.jpg','1',4),(129,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870135/product/tah9pqjsihwdowzuoscz.jpg','1',4),(130,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870146/product/yvpvtsx6v7zsqvf8o5p3.jpg','1',4),(131,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870239/product/ewsbn6nlgvmhngv0nfcm.jpg','1',4),(132,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870316/product/fwb2mimix4mmo5srpkux.jpg','1',4),(133,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870354/product/gopsw2aelyct9ewtskmp.jpg','1',4),(134,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870366/product/yprhewptdwnefuk9d9pf.jpg','1',4),(135,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870376/product/dplpgyilkevizonhs0zw.jpg','1',4),(136,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870386/product/hpfctcjwkukedd1tchci.jpg','1',4),(137,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870400/product/bwuvm6qk6i6yuzpt5zgm.jpg','1',4),(138,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870424/product/yx8buvlsutbsr3d037nd.jpg','1',4),(139,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870438/product/ctb9djxh57akhrdbuolf.jpg','1',4),(140,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870464/product/yfq7lvlstnsuxn98ziou.jpg','1',4),(141,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870481/product/chjvmtgxktc2d1s7eyqe.jpg','1',4),(142,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870497/product/e2ypw96v4wchgcwmdupr.jpg','1',4),(143,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870507/product/cis8oqwxfa0sxieoge9z.jpg','1',4),(144,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870522/product/wvval7itrhh6rrm4pk0n.jpg','1',4),(145,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870533/product/lxhegeflrlzcwsyc9dzh.jpg','1',4),(146,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870544/product/byacg98nz4quoz7yzvzh.jpg','1',4),(147,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870569/product/ejjxybvldd2u7euk5hjb.jpg','1',4),(148,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708870604/product/x5gnscav2iqrhp08hzeh.jpg','1',4),(150,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1709003749/product/lu6xp7wcpjhhq6a2vcxq.jpg','1',3),(151,1,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1709025256/product/vvkx7n1mix6zdwjtdhjl.jpg','1',3);
/*!40000 ALTER TABLE `core_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_productcategory`
--

DROP TABLE IF EXISTS `core_productcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_productcategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_productcategory`
--

LOCK TABLES `core_productcategory` WRITE;
/*!40000 ALTER TABLE `core_productcategory` DISABLE KEYS */;
INSERT INTO `core_productcategory` VALUES (1,'Thực phẩm & đồ uống'),(2,'Văn phòng phẩm'),(3,'Quần áo & Phụ kiện'),(4,'Đồ điện tử'),(5,'Nguyên liệu / Linh kiện'),(6,'Đồ gia dụng / Nội thất');
/*!40000 ALTER TABLE `core_productcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_shipment`
--

DROP TABLE IF EXISTS `core_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_shipment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(10) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `shipment_date` datetime(6) NOT NULL,
  `cost` decimal(8,0) DEFAULT NULL,
  `delivery_address_id` bigint DEFAULT NULL,
  `pick_up_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_shipment_delivery_address_id_9f410fee_fk_core_address_id` (`delivery_address_id`),
  KEY `core_shipment_pick_up_id_82e6bd27_fk_core_address_id` (`pick_up_id`),
  CONSTRAINT `core_shipment_delivery_address_id_9f410fee_fk_core_address_id` FOREIGN KEY (`delivery_address_id`) REFERENCES `core_address` (`id`),
  CONSTRAINT `core_shipment_pick_up_id_82e6bd27_fk_core_address_id` FOREIGN KEY (`pick_up_id`) REFERENCES `core_address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_shipment`
--

LOCK TABLES `core_shipment` WRITE;
/*!40000 ALTER TABLE `core_shipment` DISABLE KEYS */;
INSERT INTO `core_shipment` VALUES (77,'Now','2023-11-24 16:15:00.000000',177000,168,167),(80,'Now','2023-11-24 17:30:00.000000',90000,174,173),(81,'Now','2023-11-24 17:36:00.000000',97000,176,175),(82,'Now','2023-11-24 17:37:00.000000',170000,178,177),(83,'Now','2023-11-24 17:44:00.000000',243000,180,179),(84,'Now','2023-12-24 18:00:00.000000',218000,182,181),(85,'Now','2023-12-24 20:07:00.000000',206000,184,183),(86,'Now','2023-12-24 20:23:00.000000',206000,186,185),(87,'Now','2023-12-24 20:30:00.000000',106000,188,187),(88,'Now','2023-12-24 20:37:00.000000',158000,190,189),(96,'Now','2023-12-24 20:59:00.000000',177000,192,191),(99,'Now','2023-12-24 21:46:00.000000',92000,199,198),(100,'Now','2023-12-24 21:46:00.000000',92000,201,200),(101,'Now','2023-12-24 21:49:00.000000',92000,203,202),(102,'Now','2023-12-24 21:49:00.000000',92000,205,204),(103,'Now','2024-01-25 16:08:00.000000',202000,207,206),(105,'Now','2024-01-25 21:06:00.000000',122000,211,210),(106,'Now','2024-01-25 21:06:00.000000',122000,213,212),(107,'Now','2024-01-25 21:06:00.000000',122000,215,214),(108,'Now','2024-01-25 21:06:00.000000',122000,217,216),(109,'Now','2024-01-25 21:06:00.000000',122000,219,218),(110,'Now','2024-02-25 21:06:00.000000',122000,221,220),(111,'Now','2024-02-25 21:06:00.000000',122000,223,222),(112,'Now','2024-02-25 21:06:00.000000',122000,225,224),(113,'Now','2024-02-25 21:06:00.000000',122000,227,226),(114,'Now','2024-02-25 21:06:00.000000',122000,229,228),(115,'Now','2024-02-25 21:06:00.000000',122000,231,230),(116,'Now','2024-02-25 21:06:00.000000',122000,233,232),(117,'Now','2024-02-25 21:06:00.000000',122000,235,234),(118,'Now','2024-02-25 21:06:00.000000',122000,237,236),(119,'Now','2024-02-25 21:06:00.000000',122000,239,238),(120,'Now','2024-02-25 21:06:00.000000',122000,241,240),(121,'Now','2024-02-25 21:06:00.000000',122000,243,242),(122,'Now','2024-02-25 21:06:00.000000',122000,245,244),(123,'Now','2024-02-25 21:06:00.000000',122000,247,246),(124,'Now','2024-02-25 21:06:00.000000',122000,249,248),(125,'Now','2024-02-25 21:06:00.000000',122000,251,250),(126,'Now','2024-02-25 21:06:00.000000',122000,253,252),(127,'Now','2024-02-25 21:06:00.000000',122000,255,254),(129,'Now','2024-02-27 10:14:00.000000',149000,259,258),(130,'Now','2024-02-27 16:12:00.000000',149000,261,260);
/*!40000 ALTER TABLE `core_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_shippermore`
--

DROP TABLE IF EXISTS `core_shippermore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_shippermore` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cmnd` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `vehicle_number` varchar(20) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `vehicle_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `core_shippermore_vehicle_id_40ceff0c_fk_core_vehicle_id` (`vehicle_id`),
  CONSTRAINT `core_shippermore_user_id_9fffaa97_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_shippermore_vehicle_id_40ceff0c_fk_core_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `core_vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_shippermore`
--

LOCK TABLES `core_shippermore` WRITE;
/*!40000 ALTER TABLE `core_shippermore` DISABLE KEYS */;
INSERT INTO `core_shippermore` VALUES (8,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708765958/cmnd/i3e9ruzi25sqhjsuudwx.jpg','29A-63848',22,3),(10,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708767859/cmnd/w3xy3cblrtjnfnak8hjc.jpg','29B-54782',24,3),(11,'https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708964716/cmnd/mmtdrgvjppsx64gcwjsv.jpg','29B-63749',25,2);
/*!40000 ALTER TABLE `core_shippermore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user`
--

DROP TABLE IF EXISTS `core_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user`
--

LOCK TABLES `core_user` WRITE;
/*!40000 ALTER TABLE `core_user` DISABLE KEYS */;
INSERT INTO `core_user` VALUES (1,'pbkdf2_sha256$720000$jYcrLkn6eUODAlbUJ9P6wn$IgzRHJv52v+8OfbpdCpT9l/pl0jLOeLXpaJLj3bJNKs=','2024-02-27 16:00:23.852736',1,'admin','','','a@gmail.com',1,1,'2024-01-31 09:46:08.023709','2024-01-31 09:46:08.278074','2024-01-31 09:46:08.278074',0,'ADMIN',''),(19,'pbkdf2_sha256$720000$fblp7bp3FlWEJMCevje1FR$cRD/EVk67O2JTuqXLDfrrOC3fUuflhesL3cBSmCYCW4=',NULL,0,'theanh1','Anh','Nguyễn','b@gmail.com',0,1,'2024-02-24 15:32:48.992194','2024-02-24 15:32:49.220810','2024-02-24 15:32:49.220810',1,'BASIC_USER','https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708763568/avatar_user/zt5h2hmja4rv8iwif6ao.jpg'),(20,'pbkdf2_sha256$720000$tJXLDBEziI7XmtsKOsPrSx$v2tHA1pichG4cEUrtoDeWnZ8lYb/hbbv9BOmrkyhOUI=',NULL,0,'theanh2','Hiếu','Lê','c@gmail.com',0,1,'2024-02-24 15:50:40.128600','2024-02-24 15:50:40.373852','2024-02-24 15:50:40.373852',1,'BASIC_USER','https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708764639/avatar_user/zjwonef2b6zxpp4wcvut.jpg'),(22,'pbkdf2_sha256$720000$ISMGujHhjBTLUt9DqkXO4j$2ULlhYyXzkRxFpgjJ9xrsDvN01mXvOI2xqg3yua2SaQ=',NULL,0,'shipper1','Đức','Hồ','anhthenguyen.work@gmail.com',0,1,'2024-02-24 16:12:36.466419','2024-02-24 16:12:36.690438','2024-02-24 16:12:36.690438',1,'SHIPPER','https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708765956/avatar_user/geix25jf6le2obujba3x.jpg'),(24,'pbkdf2_sha256$720000$tz9HFTbPkktzw5jYDAuG6r$c2IHwTGtLaJOD6X1HQoTyIOanUBgDroWX1LuUoDNYO0=',NULL,0,'shipper2','Trịnh','Nguyễn','theanhmgt1011@gmail.com',0,1,'2024-02-24 16:44:14.495055','2024-02-24 16:44:14.744455','2024-02-24 16:44:14.744455',1,'SHIPPER','https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708767854/avatar_user/ihjavg73j2zk8r0juqqm.jpg'),(25,'pbkdf2_sha256$720000$qFsE3NTc5IclPVYnJegHbK$neY6x41SeFV45X8lsZGV8M6HrEIkeMcKn5MPds8a1yw=',NULL,0,'shipper5','Hùng','Nguyễn','b@gmail.com',0,1,'2024-02-26 23:25:11.211760','2024-02-26 23:25:11.446141','2024-02-26 23:25:11.446141',0,'SHIPPER','https://res.cloudinary.com/dqpo9h5s2/image/upload/v1708964711/avatar_user/lstplqtu09sim4vpv7bh.jpg');
/*!40000 ALTER TABLE `core_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_groups`
--

DROP TABLE IF EXISTS `core_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_user_groups_user_id_group_id_c82fcad1_uniq` (`user_id`,`group_id`),
  KEY `core_user_groups_group_id_fe8c697f_fk_auth_group_id` (`group_id`),
  CONSTRAINT `core_user_groups_group_id_fe8c697f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `core_user_groups_user_id_70b4d9b8_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_groups`
--

LOCK TABLES `core_user_groups` WRITE;
/*!40000 ALTER TABLE `core_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_user_permissions`
--

DROP TABLE IF EXISTS `core_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_user_user_permissions_user_id_permission_id_73ea0daa_uniq` (`user_id`,`permission_id`),
  KEY `core_user_user_permi_permission_id_35ccf601_fk_auth_perm` (`permission_id`),
  CONSTRAINT `core_user_user_permi_permission_id_35ccf601_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `core_user_user_permissions_user_id_085123d3_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_user_permissions`
--

LOCK TABLES `core_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `core_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_vehicle`
--

DROP TABLE IF EXISTS `core_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `icon` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `capacity` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_vehicle`
--

LOCK TABLES `core_vehicle` WRITE;
/*!40000 ALTER TABLE `core_vehicle` DISABLE KEYS */;
INSERT INTO `core_vehicle` VALUES (2,'Xe Máy','Vận chuyển mặt hàng nhỏ giá trị đến 3 triệu đồng','image/upload/v1706106196/vehicle_icon/gjisuqtnu1gl7rtpdron.png','0.5 x 0.4 x 0.5 Mét - Lên đến 30kg'),(3,'Xe Van 500 kg','Hoạt Động Tất Cả Khung Giờ | Chở Tối Đa 500Kg * 1.5CBM','image/upload/v1706106556/vehicle_icon/pkbqdybiilwiynh0yyxv.png','1.7 x 1.2 x 1.2 Mét Lên đến 500 kg'),(4,'Xe Van 1000 kg','Hoạt Động Tất Cả Khung Giờ | Chở Tối Đa 1000Kg * 4CBM','image/upload/v1706106626/vehicle_icon/rqqk1cvmbt7q5agsgdry.png','1.7 x 1.2 x 1.2 Mét Lên đến 500 kg'),(5,'Xe Tải 500kg','Giờ Cấm Tải 6H-9H & 16H-20H | Chở tối đa 500Kg & 1.5CBM','image/upload/v1706106669/vehicle_icon/lnnx9evnqsxy1gmygn23.png','1.9 x 1.4 x 1.4 Mét Lên đến 500 kg'),(6,'Xe Tải 1000kg','Giờ Cấm Tải 6H-9H & 16H-20H | Chở tối đa 1000Kg & 5CBM','image/upload/v1706106704/vehicle_icon/enknv9eqjzcdpc10jxxo.png','3 x 1.6 x 1.6 Mét Lên đến 1000 kg');
/*!40000 ALTER TABLE `core_vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_vietnamese_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_core_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-02-13 20:45:24.093535','2','Google Login',1,'[{\"added\": {}}]',20,1),(2,'2024-02-13 20:59:14.827076','2','Google Login',3,'',20,1),(3,'2024-02-13 20:59:52.892696','3','43gHy7F3c0yuueESpZlTa6HQkuRszhZQINL3S9I9',1,'[{\"added\": {}}]',20,1),(4,'2024-02-13 21:51:40.566301','3','43gHy7F3c0yuueESpZlTa6HQkuRszhZQINL3S9I9',3,'',20,1),(5,'2024-02-27 11:13:41.216993','1','Coupon object (1)',1,'[{\"added\": {}}]',32,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'core','address'),(19,'core','auction'),(11,'core','basicuser'),(32,'core','coupon'),(18,'core','feedback'),(17,'core','job'),(13,'core','payment'),(7,'core','paymentmethod'),(14,'core','product'),(8,'core','productcategory'),(15,'core','shipment'),(12,'core','shipper'),(16,'core','shippermore'),(10,'core','user'),(9,'core','vehicle'),(30,'drf_social_oauth2','multifactorauth'),(21,'oauth2_provider','accesstoken'),(20,'oauth2_provider','application'),(22,'oauth2_provider','grant'),(24,'oauth2_provider','idtoken'),(23,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(25,'social_django','association'),(26,'social_django','code'),(27,'social_django','nonce'),(29,'social_django','partial'),(28,'social_django','usersocialauth'),(31,'vnpay','billing');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-02-01 14:13:27.003092'),(2,'contenttypes','0002_remove_content_type_name','2024-02-01 14:13:27.129578'),(3,'auth','0001_initial','2024-02-01 14:13:27.682184'),(4,'auth','0002_alter_permission_name_max_length','2024-02-01 14:13:27.808642'),(5,'auth','0003_alter_user_email_max_length','2024-02-01 14:13:27.824375'),(6,'auth','0004_alter_user_username_opts','2024-02-01 14:13:27.824375'),(7,'auth','0005_alter_user_last_login_null','2024-02-01 14:13:27.840121'),(8,'auth','0006_require_contenttypes_0002','2024-02-01 14:13:27.856699'),(9,'auth','0007_alter_validators_add_error_messages','2024-02-01 14:13:27.872428'),(10,'auth','0008_alter_user_username_max_length','2024-02-01 14:13:27.903531'),(11,'auth','0009_alter_user_last_name_max_length','2024-02-01 14:13:27.919742'),(12,'auth','0010_alter_group_name_max_length','2024-02-01 14:13:27.951805'),(13,'auth','0011_update_proxy_permissions','2024-02-01 14:13:27.968098'),(14,'auth','0012_alter_user_first_name_max_length','2024-02-01 14:13:27.983136'),(15,'core','0001_initial','2024-02-01 14:13:31.419711'),(16,'admin','0001_initial','2024-02-01 14:13:31.784018'),(17,'admin','0002_logentry_remove_auto_add','2024-02-01 14:13:31.805961'),(18,'admin','0003_logentry_add_action_flag_choices','2024-02-01 14:13:31.816362'),(19,'oauth2_provider','0001_initial','2024-02-01 14:13:33.410283'),(20,'oauth2_provider','0002_auto_20190406_1805','2024-02-01 14:13:33.537330'),(21,'oauth2_provider','0003_auto_20201211_1314','2024-02-01 14:13:33.680023'),(22,'oauth2_provider','0004_auto_20200902_2022','2024-02-01 14:13:34.961559'),(23,'oauth2_provider','0005_auto_20211222_2352','2024-02-01 14:13:35.102266'),(24,'oauth2_provider','0006_alter_application_client_secret','2024-02-01 14:13:35.133528'),(25,'oauth2_provider','0007_application_post_logout_redirect_uris','2024-02-01 14:13:35.291561'),(26,'sessions','0001_initial','2024-02-01 14:13:35.386804'),(27,'core','0002_job_status_alter_job_uuid','2024-02-02 05:49:55.794468'),(28,'core','0003_remove_auction_comment_alter_job_uuid','2024-02-02 05:49:55.858975'),(29,'core','0004_alter_job_status_alter_job_uuid_alter_shipment_type_and_more','2024-02-02 14:08:10.431439'),(30,'core','0005_alter_job_status_alter_job_uuid','2024-02-03 08:02:50.615151'),(31,'core','0006_alter_job_status_alter_job_uuid','2024-02-03 08:11:28.363970'),(32,'core','0007_alter_job_uuid_alter_shipment_delivery_address_and_more','2024-02-06 08:14:29.017379'),(33,'core','0008_alter_job_payment_alter_job_poster_alter_job_product_and_more','2024-02-06 08:17:45.309714'),(34,'core','0009_rename_overall_rating_feedback_rating_and_more','2024-02-09 17:41:40.271317'),(35,'core','0010_alter_feedback_job_alter_job_uuid','2024-02-09 20:08:30.736211'),(36,'core','0011_feedback_comment_alter_job_uuid','2024-02-09 22:42:21.150710'),(37,'core','0012_alter_job_uuid_alter_feedback_unique_together','2024-02-09 23:56:34.745058'),(38,'core','0013_alter_job_uuid_alter_user_verified','2024-02-10 22:28:47.188843'),(39,'default','0001_initial','2024-02-13 16:27:47.619957'),(40,'social_auth','0001_initial','2024-02-13 16:27:47.626432'),(41,'default','0002_add_related_name','2024-02-13 16:27:47.651118'),(42,'social_auth','0002_add_related_name','2024-02-13 16:27:47.657825'),(43,'default','0003_alter_email_max_length','2024-02-13 16:27:47.680861'),(44,'social_auth','0003_alter_email_max_length','2024-02-13 16:27:47.687559'),(45,'default','0004_auto_20160423_0400','2024-02-13 16:27:47.705165'),(46,'social_auth','0004_auto_20160423_0400','2024-02-13 16:27:47.711172'),(47,'social_auth','0005_auto_20160727_2333','2024-02-13 16:27:47.753159'),(48,'social_django','0006_partial','2024-02-13 16:27:47.826479'),(49,'social_django','0007_code_timestamp','2024-02-13 16:27:47.988798'),(50,'social_django','0008_partial_timestamp','2024-02-13 16:27:48.134394'),(51,'social_django','0009_auto_20191118_0520','2024-02-13 16:27:48.246357'),(52,'social_django','0010_uid_db_index','2024-02-13 16:27:48.293129'),(53,'social_django','0011_alter_id_fields','2024-02-13 16:27:48.976124'),(54,'social_django','0012_usersocialauth_extra_data_new','2024-02-13 16:27:49.238895'),(55,'social_django','0013_migrate_extra_data','2024-02-13 16:27:49.265049'),(56,'social_django','0014_remove_usersocialauth_extra_data','2024-02-13 16:27:49.358519'),(57,'social_django','0015_rename_extra_data_new_usersocialauth_extra_data','2024-02-13 16:27:49.424205'),(58,'social_django','0004_auto_20160423_0400','2024-02-13 16:27:49.431422'),(59,'social_django','0005_auto_20160727_2333','2024-02-13 16:27:49.438157'),(60,'social_django','0003_alter_email_max_length','2024-02-13 16:27:49.445406'),(61,'social_django','0001_initial','2024-02-13 16:27:49.452758'),(62,'social_django','0002_add_related_name','2024-02-13 16:27:49.458888'),(63,'core','0014_alter_job_uuid_alter_user_role','2024-02-13 22:55:04.090801'),(64,'vnpay','0001_initial','2024-02-22 15:03:42.339333'),(65,'core','0015_alter_job_uuid_alter_user_avatar','2024-02-23 22:25:20.987140'),(66,'core','0016_alter_job_uuid_alter_shippermore_cmnd','2024-02-23 22:52:37.940534'),(67,'core','0017_coupon_alter_job_uuid','2024-02-27 10:51:24.834157');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0uuxa9zhh0pfd6isf6b7ife0mexlzow5','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZN4N:4iwTC_S5yygbsnQzu32abJgTKtmadBhTIUZvJAbwWe0','2024-02-26 10:33:23.875962'),('28usbd71xin5iuyf0bdfcmomfg0pqddo','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZoun:wYPKdFCxfJLYpNSK56VaXzxiqAar8O7N5JBAkM4_6Gc','2024-02-27 16:17:21.251048'),('4q6q39erhhh7st11pq2mfa7lse7cz5og','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1reoW9:g200gOXmyz2I1JsOFIHwk7PFX629ggJ2HpGv8X88kKg','2024-03-12 10:52:33.591737'),('66zjaifaa2s74sldygdn5ha7dv3qzh4p','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rdRL8:rrg9w5LZuuk3SBT8tk3pkynR58tV5p-SbJjLJizfRHc','2024-03-08 15:55:30.345816'),('6t7tuw0650382zzsshgypyk3gn5i5w5m','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZN36:8mjYe9i0bT7OduCdXQMwUYFrRIv87QaDvaNrbtTm3mY','2024-02-26 10:32:04.236039'),('esrsnyp9npm4rduw8wcrav0be0azxy30','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZBaW:n3j8fLyDqKQELDjhJMpiyVH5qSM4ZgiZ9Wtoeu9XnqA','2024-02-25 22:17:48.608475'),('jj9wwco94r3ad5vw6l7kf2b4bjl59xud','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1retK3:XSFhTPGp2s2LCoO7Uq6X2Rc-nRrY4Ak29H9vc_Hy2Xw','2024-03-12 16:00:23.867679'),('kxn3ppzbt7qveikku5wnaw6nsvpk5lzh','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZCn3:yKO3mLqLDtICuI4wR07TlrKv8P-85zDzQSzZOQHmoSE','2024-02-25 23:34:49.695682'),('ljupcj9gto71xb48t9wdvr8uvmac3qip','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZNDg:ECPEBhnVBSszk1ThkUs4e_ikh3ErHKthKgEKT7ysr4w','2024-02-26 10:43:00.929279'),('mgp5ihe2tvq78ukvxvjuxkjoj72zh3e4','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZMpT:fyKLOgitXRQaApyQaOG8Tl1tKVFxxbEGSQkE2BKXf1Q','2024-02-26 10:17:59.577090'),('ne0z0gff2tha5gxw81thiiyjrkfjd0ob','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rdMFh:pkendutB8gxkgR2uOt8VyZPf2kVTlifqvNKRetn5My0','2024-03-08 10:29:33.281767'),('ocq8b1g8z1l208vjl5l59frhd6n21c6y','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZNp9:mG4VXEi0vMEVSb7DkKUP16TGqTE-3_NBOfNpHb_q5n4','2024-02-26 11:21:43.199527'),('pcove4vs0ffp8weaz375fdx6pznvglbx','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rdo6C:7ODcTcx9e6ltah0vh830td43JUZh8T6V97JvqNgsnIU','2024-03-09 16:13:36.151885'),('sqp47mf8frwjk3peq0re22zkdc49uvmj','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rdM2w:9div3HNJ-ODXHHs0NiVryHinmb_vIswiZpV8tYvfhjg','2024-03-08 10:16:22.935982'),('wcr2kzi6bvwf67j9e5xr09ry18vgpjb4','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZDDE:Am_FJzdNm5cJPV0foNHoCq_ZsqZ1GJlR6ETKTCLlVpg','2024-02-26 00:01:52.073907'),('x54rl6gb4s0czqaykxhx835nnlea1mcb','.eJxVjEEOwiAQRe_C2pACUyAu3XsGMp0ZpGogKe3KeHdt0oVu_3vvv1TCbS1p67KkmdVZGXX63Sakh9Qd8B3rrWlqdV3mSe-KPmjX18byvBzu30HBXr71AGRgBKTReGdDJsloM_qIEpmRgs3OOAocogED3hGBs4PFjFnYiXp_AO02OHo:1rZMwY:gGdJD6rIZt-BZjRIRnWwj299MHHiYo47JSZXxCZ82kk','2024-02-26 10:25:18.466304');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=370 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (318,'zFhqQjeDiogoOVOZ5TkW9l0eZ38BEo','2024-02-25 01:35:29.996594','read write',1,19,'2024-02-24 15:35:29.997612','2024-02-24 15:35:29.997612',NULL,NULL),(319,'ervMTKIQn2LeCkcMUABbdC4qy9KZuw','2024-02-25 01:46:36.837487','read write',1,19,'2024-02-24 15:46:36.837487','2024-02-24 15:46:36.837487',NULL,NULL),(320,'gUVVtFzQnu0DDSNj7EAztHko8hJWJB','2024-02-25 01:50:41.069704','read write',1,20,'2024-02-24 15:50:41.070720','2024-02-24 15:50:41.070720',NULL,NULL),(321,'YuM8hIkziF8cWXDVqdhrjFaN8QIH1m','2024-02-25 02:12:39.553377','read write',1,22,'2024-02-24 16:12:39.554470','2024-02-24 16:12:39.554470',NULL,NULL),(322,'itAuqilvdXF2KiL0NjwckgRJz2Jr6h','2024-02-25 02:13:04.635311','read write',1,22,'2024-02-24 16:13:04.635311','2024-02-24 16:13:04.635311',NULL,NULL),(323,'Gy5oGd2b7kyCsLNAxZxugK4PQPXbOv','2024-02-25 02:14:07.642300','read write',1,22,'2024-02-24 16:14:07.642300','2024-02-24 16:14:07.642300',NULL,NULL),(324,'AHTdzNjjh9OohlA112oyNqguMdrQwg','2024-02-25 02:15:12.252322','read write',1,19,'2024-02-24 16:15:12.253420','2024-02-24 16:15:12.253420',NULL,NULL),(325,'kHjDShaoiprtwHeeC0pN5BinMaIw5P','2024-02-25 02:16:44.313641','read write',1,22,'2024-02-24 16:16:44.313641','2024-02-24 16:16:44.313641',NULL,NULL),(326,'pTcOM6ZbxT9sNqpmLnkaGE38NgDGoQ','2024-02-25 02:27:12.172671','read write',1,19,'2024-02-24 16:27:12.173687','2024-02-24 16:27:12.173687',NULL,NULL),(327,'cqboLfB2mfTzp2DZxdbHvG9CVnVxYQ','2024-02-25 02:44:20.532044','read write',1,24,'2024-02-24 16:44:20.532044','2024-02-24 16:44:20.532044',NULL,NULL),(328,'Cp98g0G0wHMfPBlr4LBh4zDKr3NMi5','2024-02-25 02:44:53.836330','read write',1,19,'2024-02-24 16:44:53.836330','2024-02-24 16:44:53.836330',NULL,NULL),(329,'hQtpsOA3EAGU4YyL3pUGFutmikb36l','2024-02-25 03:10:31.474846','read write',1,22,'2024-02-24 17:10:31.474846','2024-02-24 17:10:31.474846',NULL,NULL),(330,'2gW3bcffE7AWbB3NiZhgirc0zBsTKb','2024-02-25 03:11:08.980787','read write',1,19,'2024-02-24 17:11:08.981790','2024-02-24 17:11:08.981790',NULL,NULL),(331,'cq6v332Izkw9iX2aNBVTtue7ESeAp7','2024-02-25 03:12:17.292970','read write',1,19,'2024-02-24 17:12:17.293986','2024-02-24 17:12:17.293986',NULL,NULL),(332,'8l5OVimWVLSNINWa042NPlICu2olqN','2024-02-25 03:15:19.037838','read write',1,22,'2024-02-24 17:15:19.037966','2024-02-24 17:15:19.037966',NULL,NULL),(333,'vMAPuaSCFEwc11LuQu17Yp6Qp8oHNY','2024-02-25 03:16:20.923150','read write',1,22,'2024-02-24 17:16:20.924318','2024-02-24 17:16:20.924318',NULL,NULL),(334,'gzkGrdoZOFEBKcHiAUZWHTeugfOM80','2024-02-25 03:18:16.274267','read write',1,22,'2024-02-24 17:18:16.275292','2024-02-24 17:18:16.275292',NULL,NULL),(335,'fX6LAGVlheLOzAXaRa8lnghBYto0NR','2024-02-25 03:18:45.157592','read write',1,20,'2024-02-24 17:18:45.157592','2024-02-24 17:18:45.157592',NULL,NULL),(336,'zLrF8NiSIp9OK7fYOWqJ3Q3IgufZGu','2024-02-25 03:45:38.289061','read write',1,22,'2024-02-24 17:45:38.289119','2024-02-24 17:45:38.289119',NULL,NULL),(337,'k6Z9d07xXeIxnofAGnK14xpQkFHtCk','2024-02-25 03:45:51.880059','read write',1,22,'2024-02-24 17:45:51.881057','2024-02-24 17:45:51.881057',NULL,NULL),(338,'4ttGcmTRaWGhgYaEioyXoLgI23jwtG','2024-02-25 03:47:21.655919','read write',1,19,'2024-02-24 17:47:21.655919','2024-02-24 17:47:21.655919',NULL,NULL),(339,'ZbWjGIogbBmPL6nSsGjKInrRbyF7IQ','2024-02-25 03:47:48.447983','read write',1,20,'2024-02-24 17:47:48.449117','2024-02-24 17:47:48.449117',NULL,NULL),(340,'BAJ1x5zYArXCyXsaKo8U0yCUiYxrW8','2024-02-25 03:48:13.849009','read write',1,19,'2024-02-24 17:48:13.849009','2024-02-24 17:48:13.849009',NULL,NULL),(341,'PTgoy4QzENzmz4M9SMxnwP09S7uMdE','2024-02-25 03:48:46.184570','read write',1,22,'2024-02-24 17:48:46.185781','2024-02-24 17:48:46.185781',NULL,NULL),(342,'QlcQZCkMKtNSw4vrODnPty2VUR5TgN','2024-02-25 03:49:18.999806','read write',1,19,'2024-02-24 17:49:19.000949','2024-02-24 17:49:19.000949',NULL,NULL),(343,'HVPEAd3ufkNcZOjBelgFLDo362JeCY','2024-02-25 03:49:45.956303','read write',1,20,'2024-02-24 17:49:45.956303','2024-02-24 17:49:45.956303',NULL,NULL),(344,'D3HNY8npzQKXKdSz03CNLVlFZd0ZFd','2024-02-25 03:50:22.238015','read write',1,19,'2024-02-24 17:50:22.239020','2024-02-24 17:50:22.239020',NULL,NULL),(345,'ju9epAoFCB3OOMal1TAc0IqVk7rWbw','2024-02-25 03:51:20.928641','read write',1,20,'2024-02-24 17:51:20.928641','2024-02-24 17:51:20.928641',NULL,NULL),(346,'er4MOr09flhT04sUzqn75DYdRrTw0N','2024-02-25 03:55:31.967249','read write',1,22,'2024-02-24 17:55:31.967249','2024-02-24 17:55:31.967249',NULL,NULL),(347,'bzmyJAGxdYPF07xdCnXAXY7th0t6CT','2024-02-25 03:57:01.668362','read write',1,20,'2024-02-24 17:57:01.668362','2024-02-24 17:57:01.668362',NULL,NULL),(348,'uUKqKGTG1AK0i2eZtafLb2s8qZ0UWW','2024-02-25 04:03:48.592747','read write',1,24,'2024-02-24 18:03:48.592747','2024-02-24 18:03:48.592747',NULL,NULL),(349,'NaRL1SBrlV0NreFwC0L1f9tjS5azVq','2024-02-25 04:03:54.539004','read write',1,22,'2024-02-24 18:03:54.539004','2024-02-24 18:03:54.539004',NULL,NULL),(350,'08emp8gwQVSlBwx5qD9jwdmMay3g4P','2024-02-25 04:04:43.009756','read write',1,20,'2024-02-24 18:04:43.010961','2024-02-24 18:04:43.010961',NULL,NULL),(351,'C5MAEOmmnu4IZMuS30I912fM0Luhs3','2024-02-25 06:05:11.658881','read write',1,22,'2024-02-24 20:05:11.659984','2024-02-24 20:05:11.659984',NULL,NULL),(352,'pgAR8MCkaQqwgAiDLM4jBw1d8fHfvW','2024-02-25 06:06:44.142524','read write',1,20,'2024-02-24 20:06:44.143559','2024-02-24 20:06:44.143559',NULL,NULL),(353,'voABdeNfs27cKVpkXtnTamvcirUQ9k','2024-02-25 06:07:14.950579','read write',1,19,'2024-02-24 20:07:14.950579','2024-02-24 20:07:14.950579',NULL,NULL),(354,'uaAmLvjOAQlSOmkpc0Tbvd7wC51I8e','2024-02-25 06:40:38.535014','read write',1,22,'2024-02-24 20:40:38.535014','2024-02-24 20:40:38.535014',NULL,NULL),(355,'wAfkMAAq7h8rwhXwCFQlvPqgpb9Plw','2024-02-25 06:58:31.682976','read write',1,20,'2024-02-24 20:58:31.683983','2024-02-24 20:58:31.683983',NULL,NULL),(356,'slm7y5Jtyrao7hM7cv1Kow6D7r5WRh','2024-02-25 07:59:28.271956','read write',1,22,'2024-02-24 21:59:28.272930','2024-02-24 21:59:28.272930',NULL,NULL),(357,'Jl9P0VzsqPxbKvihGwrlVSUOVvImAr','2024-02-26 02:08:23.691874','read write',1,19,'2024-02-25 16:08:23.691874','2024-02-25 16:08:23.691874',NULL,NULL),(358,'jR7hviysVQYwHPeDJXyUMCj1hanhDQ','2024-02-26 07:06:11.007622','read write',1,20,'2024-02-25 21:06:11.008668','2024-02-25 21:06:11.008668',NULL,NULL),(359,'BziQujAfVzAeVO6RJzCeswaTx66xDL','2024-02-27 09:25:17.120127','read write',1,25,'2024-02-26 23:25:17.121320','2024-02-26 23:25:17.121320',NULL,NULL),(360,'dGjyKCo39Qp109Sjk87VNtXnxwTAPL','2024-02-27 09:25:40.963810','read write',1,25,'2024-02-26 23:25:40.965023','2024-02-26 23:25:40.965023',NULL,NULL),(361,'8F1L6LIjGagwmMcMxUqqR5ZttlNpDO','2024-02-27 20:13:56.162949','read write',1,19,'2024-02-27 10:13:56.162949','2024-02-27 10:13:56.162949',NULL,NULL),(362,'ZShL1Nz0MiIxn4f5yC8g6szjrx74ZJ','2024-02-28 00:15:48.865717','read write',1,19,'2024-02-27 14:15:48.865717','2024-02-27 14:15:48.865717',NULL,NULL),(363,'FlfhrhPr8flBqyuxwrrew3AWheKUIr','2024-02-28 01:49:03.681863','read write',1,24,'2024-02-27 15:49:03.681863','2024-02-27 15:49:03.681863',NULL,NULL),(364,'IYxrH4pS60EBFJIChvwxMPp285G14k','2024-02-28 02:11:51.288177','read write',1,19,'2024-02-27 16:11:51.288177','2024-02-27 16:11:51.289301',NULL,NULL),(365,'i3FiLGidl0xJxiH9eLfQuPMndjRD3H','2024-02-28 02:14:45.366431','read write',1,22,'2024-02-27 16:14:45.366431','2024-02-27 16:14:45.366431',NULL,NULL),(366,'zvloBDkJbgOvZlILj1R0JUsYn2Oa8M','2024-02-28 02:15:45.639089','read write',1,24,'2024-02-27 16:15:45.639089','2024-02-27 16:15:45.639089',NULL,NULL),(367,'kBa4D5SNzelL8DQTiUjUaMcPrFcBpI','2024-02-28 02:22:10.446907','read write',1,19,'2024-02-27 16:22:10.446907','2024-02-27 16:22:10.446907',NULL,NULL),(368,'LoyqLFjtPLedmXAcYHaSCY4MdPcFqD','2024-02-28 02:22:18.300385','read write',1,19,'2024-02-27 16:22:18.300385','2024-02-27 16:22:18.300385',NULL,NULL),(369,'00Q6DoqaMVUVRG53vCxJjXUAtiFjUh','2024-02-28 02:23:17.478098','read write',1,19,'2024-02-27 16:23:17.478098','2024-02-27 16:23:17.478098',NULL,NULL);
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `post_logout_redirect_uris` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_core_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (1,'RiYOr07gNa0xh6dbcnQKySftZ8KHnip88Cps9Jk8','','confidential','password','pbkdf2_sha256$720000$FK1GbVPIgycCelXq682SRn$sa+oYJSWputRldMT4cnn32dHUP3XGMRo4/qPcqpD6PA=','Msistore',1,0,'2024-01-31 09:49:19.949347','2024-01-31 09:49:19.949347','','');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `scope` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `claims` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refreshtoken_user_id_da837fce_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refreshtoken_user_id_da837fce_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=370 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (318,'2bpnJ1rEqo3NdwLXAYPKiN4tY5Ate1',318,1,19,'2024-02-24 15:35:30.010182','2024-02-24 15:35:30.010182',NULL),(319,'mbneYhCsfIIJ5ewO4pC2XpdOkXQu6y',319,1,19,'2024-02-24 15:46:36.850066','2024-02-24 15:46:36.850066',NULL),(320,'05lNh0pPWYr6PSR47abR0nuQoJWoux',320,1,20,'2024-02-24 15:50:41.074361','2024-02-24 15:50:41.074361',NULL),(321,'Xe6wlGYnRM5aRKIqXNYzKYmQWZ6nKb',321,1,22,'2024-02-24 16:12:39.555553','2024-02-24 16:12:39.555553',NULL),(322,'kNKtjbZ1ZuyUVgOywAn1R5zSrtLx8o',322,1,22,'2024-02-24 16:13:04.636512','2024-02-24 16:13:04.636512',NULL),(323,'9i83Z8qg4RqwIEHs0pLHN7ejuQqveT',323,1,22,'2024-02-24 16:14:07.644494','2024-02-24 16:14:07.644494',NULL),(324,'3a7Effs7B0nFxwNKbxr0PHXOZn3Pfp',324,1,19,'2024-02-24 16:15:12.254568','2024-02-24 16:15:12.254568',NULL),(325,'dGfUsL9HlxEzUdbiI9SRmXrMTgPHhC',325,1,22,'2024-02-24 16:16:44.315903','2024-02-24 16:16:44.315903',NULL),(326,'JEO36MlXWiKuh5h3yAoRdGeSqYm6Dr',326,1,19,'2024-02-24 16:27:12.174936','2024-02-24 16:27:12.174936',NULL),(327,'bT3cRH6MHKUlt4Pmm8uwqCDeOSa3S7',327,1,24,'2024-02-24 16:44:20.533972','2024-02-24 16:44:20.533972',NULL),(328,'BUXvti19o1dZlop1fR1ZMxUsUHIPpP',328,1,19,'2024-02-24 16:44:53.837388','2024-02-24 16:44:53.837388',NULL),(329,'qVWQi0kOiWPNoMwHqn37kU1YIg7CK8',329,1,22,'2024-02-24 17:10:31.475924','2024-02-24 17:10:31.475924',NULL),(330,'wWe5FHTQH1Ei2Rl9u3nGOSBbmYqsss',330,1,19,'2024-02-24 17:11:08.981790','2024-02-24 17:11:08.981790',NULL),(331,'iKJFJk70xd4yzCReqhGC0p4WpwCA2b',331,1,19,'2024-02-24 17:12:17.295205','2024-02-24 17:12:17.295205',NULL),(332,'EegEZnPN5dB0Yr0pV9dJaehouWouqr',332,1,22,'2024-02-24 17:15:19.039229','2024-02-24 17:15:19.039229',NULL),(333,'KWe4388bpv4FKu3w9gN46ZnFpa5vCk',333,1,22,'2024-02-24 17:16:20.925530','2024-02-24 17:16:20.925530',NULL),(334,'VKJowUU70PSsQtDuzpMnYRy8zwNxf2',334,1,22,'2024-02-24 17:18:16.276412','2024-02-24 17:18:16.276412',NULL),(335,'aPyl8NZhTmRDyIWvksePKu6RAfNR1f',335,1,20,'2024-02-24 17:18:45.158650','2024-02-24 17:18:45.158650',NULL),(336,'vgZecprRqEjSUc9KTOkSHj38jngbQ1',336,1,22,'2024-02-24 17:45:38.290197','2024-02-24 17:45:38.291251',NULL),(337,'j5yo7oHOGKx5IbhetJrB76RfWSIOa4',337,1,22,'2024-02-24 17:45:51.882637','2024-02-24 17:45:51.882637',NULL),(338,'NCTynxXYqPcZoq7cPh0YvXJphiSFDN',338,1,19,'2024-02-24 17:47:21.656998','2024-02-24 17:47:21.656998',NULL),(339,'adNOrULghXRSlbGu8MB1wMWfO1icdW',339,1,20,'2024-02-24 17:47:48.450193','2024-02-24 17:47:48.450193',NULL),(340,'ZAHi2vxxfJuqRizcnwQ00jWI2j9lZk',340,1,19,'2024-02-24 17:48:13.851144','2024-02-24 17:48:13.851144',NULL),(341,'4X5e8lkckULUGSpLfzoe0fbZvEwMc2',341,1,22,'2024-02-24 17:48:46.186901','2024-02-24 17:48:46.186901',NULL),(342,'gjiGFd4jN2efot2hi7vy0NFMbdWK6h',342,1,19,'2024-02-24 17:49:19.002062','2024-02-24 17:49:19.002062',NULL),(343,'r7pDD26uVoiUCiRH18vwcWDVOKlh5v',343,1,20,'2024-02-24 17:49:45.957469','2024-02-24 17:49:45.957469',NULL),(344,'1LIvAseGRnVdHfDVhVtgKLGf9Beu2r',344,1,19,'2024-02-24 17:50:22.240021','2024-02-24 17:50:22.240021',NULL),(345,'Rug4LQzf4PzJOZ0tGvY8WuQUM2DZny',345,1,20,'2024-02-24 17:51:20.930273','2024-02-24 17:51:20.930273',NULL),(346,'eJp5TmiNNIKUXmG0asowe7jbhz9WVw',346,1,22,'2024-02-24 17:55:31.968448','2024-02-24 17:55:31.968448',NULL),(347,'da59Vpjk8UBY4EvbJoljtsMePWm1X5',347,1,20,'2024-02-24 17:57:01.670630','2024-02-24 17:57:01.670630',NULL),(348,'ldue7aDfkpVtqQWafWSJloSuRaBR3L',348,1,24,'2024-02-24 18:03:48.593867','2024-02-24 18:03:48.593867',NULL),(349,'lxaRkRCVJNJWmiu2qJJwwGOlaTNtid',349,1,22,'2024-02-24 18:03:54.540026','2024-02-24 18:03:54.540026',NULL),(350,'ICavXlVOrqKmLFmYUsV6317L739cmT',350,1,20,'2024-02-24 18:04:43.012185','2024-02-24 18:04:43.012185',NULL),(351,'KfzV7112oV1TS8r9XxgteloAZSL1ou',351,1,22,'2024-02-24 20:05:11.672837','2024-02-24 20:05:11.672837',NULL),(352,'neC3eoMj0VcneamzhiY4qUQ0Vk6tpq',352,1,20,'2024-02-24 20:06:44.145759','2024-02-24 20:06:44.145759',NULL),(353,'nf9N0HT6w76TTKjBGEh464JoMPv7Ku',353,1,19,'2024-02-24 20:07:14.951686','2024-02-24 20:07:14.951686',NULL),(354,'B8KbJStWxf9goINFgmnoiJQdjPWeyD',354,1,22,'2024-02-24 20:40:38.536013','2024-02-24 20:40:38.536013',NULL),(355,'1niTi1kdPRqoQpqSa0S1GBY1r6WGae',355,1,20,'2024-02-24 20:58:31.694885','2024-02-24 20:58:31.694885',NULL),(356,'Tel5c38kE1l3jkwfko3FXDQLXM5x8P',356,1,22,'2024-02-24 21:59:28.285318','2024-02-24 21:59:28.285318',NULL),(357,'uCs5dPMQGLLL5wk7xIvTBIli7NjvTX',357,1,19,'2024-02-25 16:08:23.704778','2024-02-25 16:08:23.704778',NULL),(358,'5jRMJ5XIXGtkCiC1Gxoc9oFvM8xDIS',358,1,20,'2024-02-25 21:06:11.010669','2024-02-25 21:06:11.010669',NULL),(359,'4vYSfT0uBmgGmxl5qfEVyL66FgyjeO',359,1,25,'2024-02-26 23:25:17.142029','2024-02-26 23:25:17.142029',NULL),(360,'6qVJ7iDr8z6r78L94KkrTwq3Tweuae',360,1,25,'2024-02-26 23:25:40.966299','2024-02-26 23:25:40.966299',NULL),(361,'IYCaXTLHaTPJ8NdRyR4DMKdlnVCraV',361,1,19,'2024-02-27 10:13:56.194983','2024-02-27 10:13:56.194983',NULL),(362,'S1j78feBnAjdkQANRyBsMUrqdf288J',362,1,19,'2024-02-27 14:15:48.879395','2024-02-27 14:15:48.879395',NULL),(363,'Gt22LlLGFrA1waBgf15lpfBi3oROQr',363,1,24,'2024-02-27 15:49:03.697397','2024-02-27 15:49:03.697397',NULL),(364,'Kwlm8qFTL6edNd60SrgX6k1Vc6Ll16',364,1,19,'2024-02-27 16:11:51.290363','2024-02-27 16:11:51.290363',NULL),(365,'YQanbkepsBmDjaNjXtiUXR3Kjtxt0V',365,1,22,'2024-02-27 16:14:45.366431','2024-02-27 16:14:45.366431',NULL),(366,'gND0v05ZQamR6rymOkpUwdIAzLq43A',366,1,24,'2024-02-27 16:15:45.639089','2024-02-27 16:15:45.639089',NULL),(367,'wkVQiOxIjVrA0eg9dmI96SHBJRzYaV',367,1,19,'2024-02-27 16:22:10.446907','2024-02-27 16:22:10.446907',NULL),(368,'itSyN3UMgoeZupblyOksvraZhlk20Z',368,1,19,'2024-02-27 16:22:18.300385','2024-02-27 16:22:18.300385',NULL),(369,'hNEWF5VdYb87h6rIgH16nhlEbGFIHL',369,1,19,'2024-02-27 16:23:17.494146','2024-02-27 16:23:17.494146',NULL);
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_association`
--

DROP TABLE IF EXISTS `social_auth_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_auth_association` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `issued` int NOT NULL,
  `lifetime` int NOT NULL,
  `assoc_type` varchar(64) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_association`
--

LOCK TABLES `social_auth_association` WRITE;
/*!40000 ALTER TABLE `social_auth_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_code`
--

DROP TABLE IF EXISTS `social_auth_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_auth_code` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `code` varchar(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  KEY `social_auth_code_code_a2393167` (`code`),
  KEY `social_auth_code_timestamp_176b341f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_code`
--

LOCK TABLES `social_auth_code` WRITE;
/*!40000 ALTER TABLE `social_auth_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_nonce`
--

DROP TABLE IF EXISTS `social_auth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_auth_nonce` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `timestamp` int NOT NULL,
  `salt` varchar(65) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_nonce`
--

LOCK TABLES `social_auth_nonce` WRITE;
/*!40000 ALTER TABLE `social_auth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_partial`
--

DROP TABLE IF EXISTS `social_auth_partial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_auth_partial` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `next_step` smallint unsigned NOT NULL,
  `backend` varchar(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `data` json NOT NULL DEFAULT (_utf8mb3'{}'),
  PRIMARY KEY (`id`),
  KEY `social_auth_partial_token_3017fea3` (`token`),
  KEY `social_auth_partial_timestamp_50f2119f` (`timestamp`),
  CONSTRAINT `social_auth_partial_chk_1` CHECK ((`next_step` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_partial`
--

LOCK TABLES `social_auth_partial` WRITE;
/*!40000 ALTER TABLE `social_auth_partial` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_partial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_usersocialauth`
--

DROP TABLE IF EXISTS `social_auth_usersocialauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_auth_usersocialauth` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider` varchar(32) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `uid` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `extra_data` json NOT NULL DEFAULT (_utf8mb3'{}'),
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  KEY `social_auth_usersocialauth_user_id_17d28448_fk_core_user_id` (`user_id`),
  KEY `social_auth_usersocialauth_uid_796e51dc` (`uid`),
  CONSTRAINT `social_auth_usersocialauth_user_id_17d28448_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_usersocialauth`
--

LOCK TABLES `social_auth_usersocialauth` WRITE;
/*!40000 ALTER TABLE `social_auth_usersocialauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_usersocialauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vnpay_billing`
--

DROP TABLE IF EXISTS `vnpay_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vnpay_billing` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `pay_at` datetime(6) DEFAULT NULL,
  `reference_number` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `result_payment` varchar(50) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `pay_by_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vnpay_billing_pay_by_id_ab33259e_fk_core_user_id` (`pay_by_id`),
  CONSTRAINT `vnpay_billing_pay_by_id_ab33259e_fk_core_user_id` FOREIGN KEY (`pay_by_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vnpay_billing`
--

LOCK TABLES `vnpay_billing` WRITE;
/*!40000 ALTER TABLE `vnpay_billing` DISABLE KEYS */;
INSERT INTO `vnpay_billing` VALUES (18,'2024-02-24 18:00:47.693362','2024-02-24 18:00:47.693362',218000.00,'VND',NULL,'20240224180047','NEW',NULL,0,NULL,20),(19,'2024-02-27 10:15:54.193523','2024-02-27 10:15:54.193523',149000.00,'VND',NULL,'20240227101554','NEW',NULL,0,NULL,19),(20,'2024-02-27 10:18:20.012028','2024-02-27 10:18:20.012028',149000.00,'VND',NULL,'20240227101820','NEW',NULL,0,NULL,19),(21,'2024-02-27 14:16:17.308540','2024-02-27 14:16:17.308540',149000.00,'VND',NULL,'20240227141617','NEW',NULL,0,NULL,19),(22,'2024-02-27 14:18:50.968628','2024-02-27 14:18:50.968628',149000.00,'VND',NULL,'20240227141850','NEW',NULL,0,NULL,19),(23,'2024-02-27 14:20:35.674342','2024-02-27 14:20:35.674342',149000.00,'VND',NULL,'20240227142035','NEW',NULL,0,NULL,19),(24,'2024-02-27 16:24:28.450159','2024-02-27 16:24:28.450159',149000.00,'VND',NULL,'20240227162428','NEW',NULL,0,NULL,19);
/*!40000 ALTER TABLE `vnpay_billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-28 13:37:35
