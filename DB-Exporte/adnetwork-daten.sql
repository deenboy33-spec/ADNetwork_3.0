/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: u781690711_2spx8
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Dumping data for table `wp_ngm_user_accounts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `wp_ngm_user_accounts` WRITE;
/*!40000 ALTER TABLE `wp_ngm_user_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_ngm_user_accounts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping data for table `wp_ngm_transfers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `wp_ngm_transfers` WRITE;
/*!40000 ALTER TABLE `wp_ngm_transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_ngm_transfers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping data for table `wp_ngm_interface_downloads`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `wp_ngm_interface_downloads` WRITE;
/*!40000 ALTER TABLE `wp_ngm_interface_downloads` DISABLE KEYS */;
INSERT INTO `wp_ngm_interface_downloads` VALUES (1,'ADS-Media Interface','ADS-Media','ngm-bank_ads-media.php','Für ADS-Media Systeme (FSC, WWDClub, GSF)','[\"send\",\"receive\",\"rate\",\"sso\"]',0,1,'2026-04-04 23:32:29');
INSERT INTO `wp_ngm_interface_downloads` VALUES (2,'PHP Universal','PHP','ngm-bank_php_generic.php','Für alle PHP-Systeme','[\"send\",\"receive\",\"rate\",\"sso\"]',0,1,'2026-04-04 23:32:29');
INSERT INTO `wp_ngm_interface_downloads` VALUES (3,'WordPress Interface','WordPress','ngm-bank_wordpress.php','Für WordPress-Seiten','[\"rate\",\"sso\",\"receive\"]',0,1,'2026-04-04 23:32:29');
INSERT INTO `wp_ngm_interface_downloads` VALUES (4,'Balance Widget (JS)','JavaScript','ngm-bank-widget.js','Einbettbares JavaScript-Widget für eigenes Dashboard','[\"balance\",\"recent\",\"rate\"]',0,1,'2026-04-04 23:32:29');
/*!40000 ALTER TABLE `wp_ngm_interface_downloads` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping data for table `wp_ngm_member_payouts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `wp_ngm_member_payouts` WRITE;
/*!40000 ALTER TABLE `wp_ngm_member_payouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_ngm_member_payouts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-14 10:05:29
