/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: u878102734_b1KuW
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
-- Dumping data for table `vms_schnittstelle`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `vms_schnittstelle` WRITE;
/*!40000 ALTER TABLE `vms_schnittstelle` DISABLE KEYS */;
INSERT INTO `vms_schnittstelle` VALUES (1,'gold-surfer-faucet','GSF-2026-ADCC',49600000.00000000,1,'2026-06-14 05:30:28');
INSERT INTO `vms_schnittstelle` VALUES (2,'wwdclub-fallback','73cd69d890cb00024182c8685aa50085',99900000.00000000,1,'2026-06-14 06:10:14');
INSERT INTO `vms_schnittstelle` VALUES (3,'wwdclub','NWOCBTP8Ns7HxkqaUA66b6kFBfYoNQv6',97500000.00000000,1,'2026-06-14 06:16:43');
INSERT INTO `vms_schnittstelle` VALUES (4,'wwdclub-v2','WWDCLUB-2026-API',99400000.00000000,1,'2026-06-14 06:17:27');
/*!40000 ALTER TABLE `vms_schnittstelle` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping data for table `vms_konten`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `vms_konten` WRITE;
/*!40000 ALTER TABLE `vms_konten` DISABLE KEYS */;
INSERT INTO `vms_konten` VALUES (1,'jogibernd','testpass123',3900000.00000000,0,'2026-06-14 05:30:28');
/*!40000 ALTER TABLE `vms_konten` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping data for table `vms_schnittstelle_buchungen`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `vms_schnittstelle_buchungen` WRITE;
/*!40000 ALTER TABLE `vms_schnittstelle_buchungen` DISABLE KEYS */;
INSERT INTO `vms_schnittstelle_buchungen` VALUES (1,1,1,100000.00000000,0.00000000,'send','Test-Auszahlung','TEST123','completed','2026-06-14 05:30:46');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (2,1,1,100000.00000000,100000.00000000,'send','Gold-Surfer-Faucet Test','5c417d28c8b6fa9d','completed','2026-06-14 05:35:40');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (3,1,1,100000.00000000,200000.00000000,'send','Auszahlung','TEST123','completed','2026-06-14 05:49:38');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (4,1,1,100000.00000000,300000.00000000,'send','WWDClub Test','31a21c3717ad0467','completed','2026-06-14 06:03:59');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (5,2,1,100000.00000000,400000.00000000,'send','WWDClub Test','70dd02418342ce62','completed','2026-06-14 06:10:14');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (6,3,1,100000.00000000,500000.00000000,'send','WWDClub Test','985950e41178b304','completed','2026-06-14 06:16:43');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (7,4,1,100000.00000000,600000.00000000,'send','WWDClub Test','5560e4f63fab3357','completed','2026-06-14 06:18:31');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (8,4,1,100000.00000000,700000.00000000,'send','WWDClub Test','ac71c3e463835017','completed','2026-06-14 06:19:18');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (9,4,1,100000.00000000,800000.00000000,'send','WWDClub Test','b709c59d4d770d7d','completed','2026-06-14 06:19:56');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (10,4,1,100000.00000000,900000.00000000,'send','Test','dea186ff225e6e9f','completed','2026-06-14 06:21:02');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (11,4,1,100000.00000000,1000000.00000000,'send','Test','74ad05364fca3d67','completed','2026-06-14 06:24:41');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (12,4,1,100000.00000000,1100000.00000000,'send','WWDClub Test','caf6b296fd1476dd','completed','2026-06-14 06:33:43');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (13,3,1,100000.00000000,1200000.00000000,'send','WWDClub Test','16aa1913a31bf744','completed','2026-06-14 06:35:34');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (14,3,1,100000.00000000,1300000.00000000,'send','WWDClub Test','3d17666477f94d96','completed','2026-06-14 06:37:26');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (15,3,1,100000.00000000,1400000.00000000,'send','Test','123','completed','2026-06-14 07:40:07');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (16,3,1,100000.00000000,1500000.00000000,'send','Test','123','completed','2026-06-14 07:44:10');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (17,3,1,100000.00000000,1600000.00000000,'send','GSC Transfer wwdclub.de','26d395b32f817d6e','completed','2026-06-14 07:46:17');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (18,3,1,1000000.00000000,1700000.00000000,'send','GSC Transfer wwdclub.de','c819e00f77df6f38','completed','2026-06-14 07:46:42');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (19,3,1,1000000.00000000,2700000.00000000,'send','GSC Transfer wwdclub.de','d66f04d9bac64f3e','completed','2026-06-14 07:56:00');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (20,3,1,100000.00000000,3700000.00000000,'send','GSC Transfer wwdclub.de','b74b43eeaf920809','completed','2026-06-14 07:56:10');
INSERT INTO `vms_schnittstelle_buchungen` VALUES (21,3,1,100000.00000000,3800000.00000000,'send','Test','TEST456','completed','2026-06-14 07:57:17');
/*!40000 ALTER TABLE `vms_schnittstelle_buchungen` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-14 10:05:05
