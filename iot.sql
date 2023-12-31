-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: iot
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add user',7,'add_user'),(26,'Can change user',7,'change_user'),(27,'Can delete user',7,'delete_user'),(28,'Can view user',7,'view_user'),(29,'Can add device',8,'add_device'),(30,'Can change device',8,'change_device'),(31,'Can delete device',8,'delete_device'),(32,'Can view device',8,'view_device'),(33,'Can add message',9,'add_message'),(34,'Can change message',9,'change_message'),(35,'Can delete message',9,'delete_message'),(36,'Can view message',9,'view_message');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` varchar(256) NOT NULL,
  `kind` varchar(128) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `last_activate_time` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_user_id_2c2d5731_fk_user_id` (`user_id`),
  CONSTRAINT `device_user_id_2c2d5731_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (17,'device1','杩欐槸涓€涓灞?,'瀹跺眳',0,'2023-12-20 07:24:44.325062',7),(18,'device2','鎵嬫満绉诲姩绔澶?,'鎵嬫満',0,'2023-12-25 09:22:33.415090',7),(19,'device3','鐢佃剳','鐢佃剳',0,'2023-12-25 09:25:31.440461',7),(20,'device4','杩欒繕鏄竴涓灞卙hh','瀹跺眳',0,'2023-12-20 06:39:17.915489',7);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
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
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'handler','device'),(9,'handler','message'),(7,'handler','user'),(6,'sessions','session');
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
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-12-07 15:52:03.478263'),(2,'auth','0001_initial','2023-12-07 15:52:03.779272'),(3,'admin','0001_initial','2023-12-07 15:52:03.863273'),(4,'admin','0002_logentry_remove_auto_add','2023-12-07 15:52:03.869273'),(5,'admin','0003_logentry_add_action_flag_choices','2023-12-07 15:52:03.875272'),(6,'contenttypes','0002_remove_content_type_name','2023-12-07 15:52:03.921272'),(7,'auth','0002_alter_permission_name_max_length','2023-12-07 15:52:03.975272'),(8,'auth','0003_alter_user_email_max_length','2023-12-07 15:52:03.992272'),(9,'auth','0004_alter_user_username_opts','2023-12-07 15:52:03.998273'),(10,'auth','0005_alter_user_last_login_null','2023-12-07 15:52:04.030272'),(11,'auth','0006_require_contenttypes_0002','2023-12-07 15:52:04.032272'),(12,'auth','0007_alter_validators_add_error_messages','2023-12-07 15:52:04.038273'),(13,'auth','0008_alter_user_username_max_length','2023-12-07 15:52:04.078272'),(14,'auth','0009_alter_user_last_name_max_length','2023-12-07 15:52:04.111276'),(15,'auth','0010_alter_group_name_max_length','2023-12-07 15:52:04.124273'),(16,'auth','0011_update_proxy_permissions','2023-12-07 15:52:04.131273'),(17,'auth','0012_alter_user_first_name_max_length','2023-12-07 15:52:04.167273'),(18,'sessions','0001_initial','2023-12-07 15:52:04.190276'),(19,'handler','0001_initial','2023-12-07 15:52:55.089363'),(20,'handler','0002_rename_statas_message_alert','2023-12-07 16:09:45.780685'),(21,'handler','0003_user_phone','2023-12-19 02:00:10.180287'),(22,'handler','0004_alter_user_name','2023-12-20 01:45:22.908834'),(23,'handler','0005_alter_device_kind','2023-12-20 06:36:17.130121');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alert` tinyint(1) NOT NULL,
  `info` varchar(128) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `time_stamp` datetime(6) NOT NULL,
  `value` int NOT NULL,
  `device_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `message_device_id_b6d137af_fk_device_id` (`device_id`),
  CONSTRAINT `message_device_id_b6d137af_fk_device_id` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (33,1,'world',40.000000,62.000000,'2023-12-20 06:58:14.709968',2,17),(34,1,'world',40.000000,62.000000,'2023-12-20 06:59:53.712825',2,17),(35,1,'world',41.000000,62.000000,'2023-12-20 06:59:57.050588',2,17),(36,1,'world',42.000000,63.000000,'2023-12-20 07:00:04.224289',2,17),(37,0,'world',42.000000,63.000000,'2023-12-20 07:00:11.638959',2,17),(38,0,'world',32.000000,65.000000,'2023-12-20 07:00:19.058364',2,17),(39,0,'world',32.000000,65.000000,'2023-12-20 07:24:43.295035',2,17),(40,0,'world',32.000000,65.000000,'2023-12-20 07:24:44.326062',2,17),(41,1,'world',40.000000,62.000000,'2023-12-25 09:22:17.403505',2,18),(42,1,'world',40.000000,63.000000,'2023-12-25 09:22:25.545736',2,18),(43,1,'world',40.000000,64.000000,'2023-12-25 09:22:28.924951',2,18),(44,1,'world',45.000000,64.000000,'2023-12-25 09:22:33.421086',2,18),(45,1,'world',45.000000,64.000000,'2023-12-25 09:25:22.045662',2,19),(46,0,'world',45.000000,64.000000,'2023-12-25 09:25:26.527436',2,19),(47,0,'world',46.000000,64.000000,'2023-12-25 09:25:31.443461',2,19),(48,1,'device 20 is abnormal',30.297972,120.209534,'2023-12-25 21:00:38.000000',4,20),(49,0,'device 20 is normal',30.150496,120.137326,'2023-12-25 21:00:39.000000',68,20),(50,0,'device 20 is normal',30.343119,120.301305,'2023-12-25 21:00:40.000000',64,20),(51,0,'device 20 is normal',30.312576,120.253339,'2023-12-25 21:00:41.000000',57,20),(52,1,'device 20 is abnormal',30.205237,120.118417,'2023-12-25 21:00:42.000000',77,20),(53,0,'device 20 is normal',30.218848,120.275962,'2023-12-25 21:00:43.000000',96,20),(54,0,'device 20 is normal',30.222637,120.267684,'2023-12-25 21:00:44.000000',8,20),(55,0,'device 20 is normal',30.170445,120.232274,'2023-12-25 21:00:45.000000',19,20),(56,0,'device 20 is normal',30.254683,120.302602,'2023-12-25 21:00:46.000000',60,20),(57,0,'device 20 is normal',30.195070,120.284878,'2023-12-25 21:00:47.000000',14,20),(58,1,'device 20 is abnormal',30.187895,120.137505,'2023-12-25 21:00:48.000000',40,20),(59,0,'device 20 is normal',30.239222,120.173651,'2023-12-25 21:00:49.000000',46,20),(60,0,'device 20 is normal',30.283842,120.123533,'2023-12-25 21:00:50.000000',53,20),(61,0,'device 20 is normal',30.348336,120.238459,'2023-12-25 21:00:51.000000',58,20),(62,1,'device 20 is abnormal',30.267981,120.272997,'2023-12-25 21:00:52.000000',75,20),(63,0,'device 20 is normal',30.158866,120.188550,'2023-12-25 21:00:53.000000',57,20),(64,0,'device 20 is normal',30.336827,120.190038,'2023-12-25 21:00:54.000000',35,20),(65,1,'device 20 is abnormal',30.180764,120.110564,'2023-12-25 21:00:55.000000',84,20),(66,0,'device 20 is normal',30.249892,120.190539,'2023-12-25 21:00:56.000000',73,20),(67,1,'device 20 is abnormal',30.220246,120.294172,'2023-12-25 21:00:57.000000',85,20),(68,0,'device 20 is normal',30.322406,120.250735,'2023-12-25 21:00:58.000000',31,20),(69,0,'device 20 is normal',30.216379,120.142812,'2023-12-25 21:00:59.000000',46,20),(70,0,'device 20 is normal',30.245166,120.122326,'2023-12-25 21:01:00.000000',53,20),(71,0,'device 20 is normal',30.181220,120.117903,'2023-12-25 21:01:01.000000',92,20),(72,1,'device 20 is abnormal',30.334661,120.236611,'2023-12-25 21:01:02.000000',83,20),(73,0,'device 20 is normal',30.238564,120.244641,'2023-12-25 21:01:03.000000',77,20),(74,0,'device 20 is normal',30.314811,120.274672,'2023-12-25 21:01:04.000000',96,20),(75,1,'device 20 is abnormal',30.192188,120.269970,'2023-12-25 21:01:05.000000',42,20),(76,0,'device 20 is normal',30.294896,120.249545,'2023-12-25 21:01:06.000000',99,20),(77,0,'device 20 is normal',30.219390,120.173657,'2023-12-25 21:01:07.000000',17,20),(78,1,'device 20 is abnormal',30.213229,120.226095,'2023-12-25 21:01:08.000000',21,20),(79,0,'device 20 is normal',30.328167,120.233361,'2023-12-25 21:01:09.000000',100,20),(80,1,'device 20 is abnormal',30.309381,120.137983,'2023-12-25 21:01:10.000000',50,20),(81,1,'device 20 is abnormal',30.283857,120.136360,'2023-12-25 21:01:11.000000',18,20),(82,1,'device 20 is abnormal',30.244195,120.253461,'2023-12-25 21:01:12.000000',64,20),(83,1,'device 20 is abnormal',30.268848,120.201580,'2023-12-25 21:15:56.000000',1,20),(84,0,'device 19 is normal',30.240409,120.267410,'2023-12-25 21:15:57.000000',39,19),(85,0,'device 19 is normal',30.246406,120.129035,'2023-12-25 21:15:58.000000',0,19),(86,1,'device 20 is abnormal',30.204533,120.293067,'2023-12-25 21:15:59.000000',53,20),(87,0,'device 19 is normal',30.316045,120.180861,'2023-12-25 21:16:00.000000',27,19),(88,1,'device 19 is abnormal',30.209924,120.305214,'2023-12-25 21:16:01.000000',52,19),(89,0,'device 20 is normal',30.240041,120.149542,'2023-12-25 21:16:02.000000',18,20),(90,1,'device 19 is abnormal',30.338706,120.169833,'2023-12-25 21:16:03.000000',56,19),(91,1,'device 19 is abnormal',30.153774,120.257323,'2023-12-25 21:16:04.000000',52,19),(92,0,'device 20 is normal',30.208780,120.304491,'2023-12-25 21:16:05.000000',9,20),(93,1,'device 19 is abnormal',30.279529,120.154622,'2023-12-25 21:16:06.000000',42,19),(94,0,'device 19 is normal',30.178214,120.163732,'2023-12-25 21:16:07.000000',20,19),(95,1,'device 20 is abnormal',30.307581,120.195738,'2023-12-25 21:16:08.000000',88,20),(96,0,'device 20 is normal',30.162756,120.181892,'2023-12-25 21:16:09.000000',40,20),(97,1,'device 19 is abnormal',30.234066,120.190842,'2023-12-25 21:16:10.000000',95,19),(98,0,'device 20 is normal',30.328073,120.297443,'2023-12-25 21:16:11.000000',41,20),(99,1,'device 20 is abnormal',30.293018,120.260107,'2023-12-25 21:16:12.000000',84,20),(100,1,'device 19 is abnormal',30.245937,120.207652,'2023-12-25 21:16:13.000000',40,19),(101,1,'device 20 is abnormal',30.154848,120.221453,'2023-12-25 21:16:14.000000',67,20),(102,0,'device 20 is normal',30.279757,120.301533,'2023-12-25 21:16:15.000000',34,20),(103,0,'device 19 is normal',30.203671,120.166010,'2023-12-25 21:16:16.000000',1,19),(104,1,'device 20 is abnormal',30.152214,120.253493,'2023-12-25 21:16:17.000000',21,20),(105,1,'device 20 is abnormal',30.217611,120.115505,'2023-12-25 21:16:18.000000',31,20),(106,0,'device 19 is normal',30.150266,120.237929,'2023-12-25 21:16:19.000000',5,19),(107,0,'device 19 is normal',30.207612,120.244615,'2023-12-25 21:16:20.000000',54,19),(108,0,'device 20 is normal',30.247971,120.135505,'2023-12-25 21:16:20.000000',24,20),(109,0,'device 20 is normal',30.276519,120.303988,'2023-12-25 21:16:21.000000',58,20),(110,0,'device 19 is normal',30.280384,120.139077,'2023-12-25 21:16:22.000000',16,19),(111,1,'device 19 is abnormal',30.344087,120.129470,'2023-12-25 21:16:23.000000',33,19),(112,1,'device 20 is abnormal',30.168600,120.272491,'2023-12-25 21:16:24.000000',24,20),(113,0,'device 19 is normal',30.348377,120.264432,'2023-12-25 21:16:25.000000',8,19),(114,0,'device 19 is normal',30.220783,120.275009,'2023-12-25 21:16:26.000000',52,19),(115,1,'device 20 is abnormal',30.162237,120.295577,'2023-12-25 21:16:27.000000',23,20),(116,1,'device 19 is abnormal',30.347878,120.186700,'2023-12-25 21:16:28.000000',90,19),(117,1,'device 19 is abnormal',30.236424,120.174536,'2023-12-25 21:16:29.000000',51,19),(118,1,'device 20 is abnormal',30.211934,120.119085,'2023-12-25 21:16:30.000000',67,20),(119,0,'device 19 is normal',30.160981,120.223723,'2023-12-25 21:16:31.000000',92,19),(120,0,'device 19 is normal',30.316355,120.168968,'2023-12-25 21:16:32.000000',62,19),(121,0,'device 20 is normal',30.182066,120.198139,'2023-12-25 21:16:33.000000',74,20),(122,0,'device 20 is normal',30.184529,120.230979,'2023-12-25 21:16:34.000000',75,20),(123,0,'device 19 is normal',30.273222,120.107194,'2023-12-25 21:16:35.000000',92,19),(124,1,'device 20 is abnormal',30.239136,120.303762,'2023-12-25 21:16:36.000000',74,20),(125,0,'device 20 is normal',30.320804,120.173557,'2023-12-25 21:16:37.000000',15,20),(126,0,'device 19 is normal',30.283707,120.121473,'2023-12-25 21:16:38.000000',1,19),(127,0,'device 20 is normal',30.337214,120.163631,'2023-12-25 21:16:39.000000',28,20),(128,0,'device 20 is normal',30.294330,120.162508,'2023-12-25 21:16:40.000000',92,20),(129,0,'device 19 is normal',30.312805,120.225572,'2023-12-25 21:16:41.000000',59,19),(130,0,'device 20 is normal',30.262819,120.167312,'2023-12-25 21:16:42.000000',17,20),(131,0,'device 20 is normal',30.181638,120.157439,'2023-12-25 21:16:43.000000',11,20),(132,0,'device 20 is normal',30.271602,120.112689,'2023-12-25 21:16:44.000000',93,20),(133,0,'device 19 is normal',30.225463,120.255701,'2023-12-25 21:16:45.000000',56,19),(134,1,'device 19 is abnormal',30.263015,120.301317,'2023-12-25 21:16:46.000000',44,19),(135,0,'device 20 is normal',30.210260,120.267125,'2023-12-25 21:16:47.000000',8,20),(136,0,'device 20 is normal',30.287426,120.289831,'2023-12-25 21:16:48.000000',100,20),(137,0,'device 19 is normal',30.167614,120.212537,'2023-12-25 21:16:48.000000',5,19),(138,1,'device 19 is abnormal',30.287855,120.255037,'2023-12-25 21:16:49.000000',67,19),(139,0,'device 20 is normal',30.164222,120.130156,'2023-12-25 21:16:50.000000',51,20),(140,1,'device 20 is abnormal',30.230668,120.152875,'2023-12-25 21:16:51.000000',70,20);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `phone` decimal(11,0) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_name_14c4b06b_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (7,'lufengjie','lufengjie','lufengjie@zju.com',18535541688);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-25 21:24:28
