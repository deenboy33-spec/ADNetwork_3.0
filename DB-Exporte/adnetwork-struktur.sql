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
-- Table structure for table `wp_actionscheduler_actions`
--

DROP TABLE IF EXISTS `wp_actionscheduler_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_actions` (
  `action_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hook` varchar(191) NOT NULL,
  `status` varchar(20) NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `args` varchar(191) DEFAULT NULL,
  `schedule` longtext DEFAULT NULL,
  `group_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `extended_args` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`),
  KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  KEY `args` (`args`),
  KEY `group_id` (`group_id`),
  KEY `last_attempt_gmt` (`last_attempt_gmt`),
  KEY `claim_id_status_priority_scheduled_date_gmt` (`claim_id`,`status`,`priority`,`scheduled_date_gmt`),
  KEY `status_last_attempt_gmt` (`status`,`last_attempt_gmt`),
  KEY `status_claim_id` (`status`,`claim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_actionscheduler_claims`
--

DROP TABLE IF EXISTS `wp_actionscheduler_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_claims` (
  `claim_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`claim_id`),
  KEY `date_created_gmt` (`date_created_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=845 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_actionscheduler_groups`
--

DROP TABLE IF EXISTS `wp_actionscheduler_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_groups` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `slug` (`slug`(191))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_actionscheduler_logs`
--

DROP TABLE IF EXISTS `wp_actionscheduler_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_logs` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` bigint(20) unsigned NOT NULL,
  `message` text NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`log_id`),
  KEY `action_id` (`action_id`),
  KEY `log_date_gmt` (`log_date_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_adnade_ptp`
--

DROP TABLE IF EXISTS `wp_adnade_ptp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_adnade_ptp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SessID` varchar(16) NOT NULL,
  `SubID` varchar(32) NOT NULL DEFAULT '',
  `Time` int(11) unsigned NOT NULL,
  `Amount` double(20,8) NOT NULL DEFAULT 0.00000000,
  `Credits` double(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `SessID` (`SessID`),
  KEY `SubID` (`SubID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_ai_insights_keyword_reports`
--

DROP TABLE IF EXISTS `wp_aioseo_ai_insights_keyword_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_ai_insights_keyword_reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `brands` longtext DEFAULT NULL,
  `brands_mentioned` int(11) DEFAULT 0,
  `results` longtext DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ndx_aioseo_ai_insights_keyword_reports_uuid` (`uuid`),
  KEY `ndx_aioseo_ai_insights_keyword_reports_keyword` (`keyword`),
  KEY `ndx_aioseo_ai_insights_keyword_reports_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_cache`
--

DROP TABLE IF EXISTS `wp_aioseo_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_cache` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(80) NOT NULL,
  `value` longtext NOT NULL,
  `is_object` tinyint(1) DEFAULT 0,
  `expiration` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndx_aioseo_cache_key` (`key`),
  KEY `ndx_aioseo_cache_expiration` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_crawl_cleanup_blocked_args`
--

DROP TABLE IF EXISTS `wp_aioseo_crawl_cleanup_blocked_args`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_crawl_cleanup_blocked_args` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` text DEFAULT NULL,
  `value` text DEFAULT NULL,
  `key_value_hash` varchar(40) DEFAULT NULL,
  `regex` varchar(150) DEFAULT NULL,
  `hits` int(20) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndx_aioseo_crawl_cleanup_blocked_args_key_value_hash` (`key_value_hash`),
  UNIQUE KEY `ndx_aioseo_crawl_cleanup_blocked_args_regex` (`regex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_crawl_cleanup_logs`
--

DROP TABLE IF EXISTS `wp_aioseo_crawl_cleanup_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_crawl_cleanup_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` text NOT NULL,
  `key` text NOT NULL,
  `value` text DEFAULT NULL,
  `hash` varchar(40) NOT NULL,
  `hits` int(20) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndx_aioseo_crawl_cleanup_logs_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_notifications`
--

DROP TABLE IF EXISTS `wp_aioseo_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(13) NOT NULL,
  `addon` varchar(64) DEFAULT NULL,
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `type` varchar(64) NOT NULL,
  `level` text NOT NULL,
  `notification_id` bigint(20) unsigned DEFAULT NULL,
  `notification_name` varchar(255) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `button1_label` varchar(255) DEFAULT NULL,
  `button1_action` varchar(255) DEFAULT NULL,
  `button2_label` varchar(255) DEFAULT NULL,
  `button2_action` varchar(255) DEFAULT NULL,
  `dismissed` tinyint(1) NOT NULL DEFAULT 0,
  `new` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndx_aioseo_notifications_slug` (`slug`),
  KEY `ndx_aioseo_notifications_dates` (`start`,`end`),
  KEY `ndx_aioseo_notifications_type` (`type`),
  KEY `ndx_aioseo_notifications_dismissed` (`dismissed`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_posts`
--

DROP TABLE IF EXISTS `wp_aioseo_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `keywords` mediumtext DEFAULT NULL,
  `keyphrases` longtext DEFAULT NULL,
  `page_analysis` longtext DEFAULT NULL,
  `primary_term` longtext DEFAULT NULL,
  `canonical_url` text DEFAULT NULL,
  `og_title` text DEFAULT NULL,
  `og_description` text DEFAULT NULL,
  `og_object_type` varchar(64) DEFAULT 'default',
  `og_image_type` varchar(64) DEFAULT 'default',
  `og_image_url` text DEFAULT NULL,
  `og_image_width` int(11) DEFAULT NULL,
  `og_image_height` int(11) DEFAULT NULL,
  `og_image_custom_url` text DEFAULT NULL,
  `og_image_custom_fields` text DEFAULT NULL,
  `og_video` varchar(255) DEFAULT NULL,
  `og_custom_url` text DEFAULT NULL,
  `og_article_section` text DEFAULT NULL,
  `og_article_tags` text DEFAULT NULL,
  `twitter_use_og` tinyint(1) DEFAULT 0,
  `twitter_card` varchar(64) DEFAULT 'default',
  `twitter_image_type` varchar(64) DEFAULT 'default',
  `twitter_image_url` text DEFAULT NULL,
  `twitter_image_custom_url` text DEFAULT NULL,
  `twitter_image_custom_fields` text DEFAULT NULL,
  `twitter_title` text DEFAULT NULL,
  `twitter_description` text DEFAULT NULL,
  `seo_score` int(11) NOT NULL DEFAULT 0,
  `schema` longtext DEFAULT NULL,
  `schema_type` varchar(20) DEFAULT 'default',
  `schema_type_options` longtext DEFAULT NULL,
  `pillar_content` tinyint(1) DEFAULT NULL,
  `robots_default` tinyint(1) NOT NULL DEFAULT 1,
  `robots_noindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noarchive` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nosnippet` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nofollow` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noimageindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noodp` tinyint(1) NOT NULL DEFAULT 0,
  `robots_notranslate` tinyint(1) NOT NULL DEFAULT 0,
  `robots_max_snippet` int(11) DEFAULT NULL,
  `robots_max_videopreview` int(11) DEFAULT NULL,
  `robots_max_imagepreview` varchar(20) DEFAULT 'large',
  `images` longtext DEFAULT NULL,
  `image_scan_date` datetime DEFAULT NULL,
  `priority` float DEFAULT NULL,
  `frequency` tinytext DEFAULT NULL,
  `videos` longtext DEFAULT NULL,
  `video_thumbnail` text DEFAULT NULL,
  `video_scan_date` datetime DEFAULT NULL,
  `local_seo` longtext DEFAULT NULL,
  `breadcrumb_settings` longtext DEFAULT NULL,
  `limit_modified_date` tinyint(1) NOT NULL DEFAULT 0,
  `options` longtext DEFAULT NULL,
  `ai` longtext DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ndx_aioseo_posts_post_id` (`post_id`),
  KEY `ndx_aioseo_posts_pillar_content` (`pillar_content`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_seo_analyzer_results`
--

DROP TABLE IF EXISTS `wp_aioseo_seo_analyzer_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_seo_analyzer_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data` text NOT NULL,
  `score` varchar(255) DEFAULT NULL,
  `competitor_url` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ndx_aioseo_seo_analyzer_results_competitor_url` (`competitor_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_writing_assistant_keywords`
--

DROP TABLE IF EXISTS `wp_aioseo_writing_assistant_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_writing_assistant_keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `country` varchar(10) NOT NULL DEFAULT 'us',
  `language` varchar(10) NOT NULL DEFAULT 'en',
  `progress` tinyint(3) DEFAULT 0,
  `keywords` mediumtext DEFAULT NULL,
  `competitors` mediumtext DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndx_aioseo_writing_assistant_keywords_uuid` (`uuid`),
  KEY `ndx_aioseo_writing_assistant_keywords_keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_aioseo_writing_assistant_posts`
--

DROP TABLE IF EXISTS `wp_aioseo_writing_assistant_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_aioseo_writing_assistant_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned DEFAULT NULL,
  `keyword_id` bigint(20) unsigned DEFAULT NULL,
  `content_analysis_hash` varchar(40) DEFAULT NULL,
  `content_analysis` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndx_aioseo_writing_assistant_posts_post_id` (`post_id`),
  KEY `ndx_aioseo_writing_assistant_posts_keyword_id` (`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT 0,
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT 0,
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_hostinger_reach_carts`
--

DROP TABLE IF EXISTS `wp_hostinger_reach_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_hostinger_reach_carts` (
  `hash` varchar(100) NOT NULL,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `items` longtext NOT NULL,
  `totals` text NOT NULL,
  `currency` varchar(3) NOT NULL,
  `status` varchar(100) NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`hash`),
  UNIQUE KEY `hash` (`hash`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_hostinger_reach_contact_lists`
--

DROP TABLE IF EXISTS `wp_hostinger_reach_contact_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_hostinger_reach_contact_lists` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_hostinger_reach_forms`
--

DROP TABLE IF EXISTS `wp_hostinger_reach_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_hostinger_reach_forms` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `form_id` varchar(255) NOT NULL,
  `form_title` varchar(255) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `contact_list_id` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `submissions` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `form_id` (`form_id`),
  KEY `contact_list_id` (`contact_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT 1,
  `link_rating` int(11) NOT NULL DEFAULT 0,
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_admin_bookings`
--

DROP TABLE IF EXISTS `wp_ngm_admin_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_admin_bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_type` varchar(50) NOT NULL DEFAULT 'manual_credit',
  `partner_slug` varchar(60) DEFAULT NULL,
  `amount` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `gsc_eur_rate` decimal(38,12) NOT NULL DEFAULT 0.000000000000,
  `note` varchar(255) DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_partner` (`partner_slug`),
  KEY `idx_date` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_instant_login`
--

DROP TABLE IF EXISTS `wp_ngm_instant_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_instant_login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `partner_id` int(10) unsigned NOT NULL,
  `refkey` varchar(64) NOT NULL,
  `secret` varchar(64) NOT NULL,
  `login_type` enum('basic','extended') NOT NULL DEFAULT 'basic',
  `auth_url` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `last_used` datetime DEFAULT NULL,
  `use_count` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `refkey` (`refkey`),
  KEY `idx_partner` (`partner_id`),
  KEY `idx_refkey` (`refkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_interface_downloads`
--

DROP TABLE IF EXISTS `wp_ngm_interface_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_interface_downloads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `platform` varchar(100) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `features` varchar(500) DEFAULT NULL,
  `downloads` int(10) unsigned NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_login_tokens`
--

DROP TABLE IF EXISTS `wp_ngm_login_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_login_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(64) NOT NULL,
  `refkey` varchar(64) NOT NULL,
  `wp_user_id` bigint(20) unsigned NOT NULL,
  `login_type` enum('basic','extended') NOT NULL DEFAULT 'basic',
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `idx_token` (`token`),
  KEY `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_marketplace`
--

DROP TABLE IF EXISTS `wp_ngm_marketplace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_marketplace` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ngm_user_id` bigint(20) unsigned NOT NULL,
  `username` varchar(100) NOT NULL,
  `system_slug` varchar(60) NOT NULL,
  `system_user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `queue_position` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('waiting','bidding','sold','removed') NOT NULL DEFAULT 'waiting',
  `note` text DEFAULT NULL,
  `min_bid_gsc` bigint(20) unsigned NOT NULL DEFAULT 0,
  `sold_to_user_id` bigint(20) unsigned DEFAULT NULL,
  `sold_for_gsc` bigint(20) unsigned DEFAULT NULL,
  `sold_at` datetime DEFAULT NULL,
  `registered_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_queue` (`queue_position`),
  KEY `idx_user` (`ngm_user_id`),
  KEY `idx_system` (`system_slug`,`system_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_marketplace_bids`
--

DROP TABLE IF EXISTS `wp_ngm_marketplace_bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_marketplace_bids` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) unsigned NOT NULL,
  `bidder_user_id` bigint(20) unsigned NOT NULL,
  `system_slug` varchar(60) NOT NULL,
  `amount_gsc` bigint(20) unsigned NOT NULL,
  `status` enum('open','accepted','rejected','refunded') NOT NULL DEFAULT 'open',
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_bid` (`listing_id`,`bidder_user_id`),
  KEY `idx_listing` (`listing_id`),
  KEY `idx_bidder` (`bidder_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_marketplace_reserve`
--

DROP TABLE IF EXISTS `wp_ngm_marketplace_reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_marketplace_reserve` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('income','payout') NOT NULL DEFAULT 'income',
  `amount_gsc` bigint(20) unsigned NOT NULL,
  `listing_id` bigint(20) unsigned DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_member_payouts`
--

DROP TABLE IF EXISTS `wp_ngm_member_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_member_payouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wp_user_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `amount_gsc` bigint(20) unsigned NOT NULL,
  `amount_payout` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `currency_slug` varchar(20) NOT NULL DEFAULT 'eur',
  `gsc_rate` decimal(38,12) NOT NULL DEFAULT 0.000000000000,
  `method` varchar(30) NOT NULL DEFAULT 'manual',
  `recipient` varchar(255) NOT NULL DEFAULT '',
  `status` enum('pending','processing','completed','failed','manual') NOT NULL DEFAULT 'pending',
  `api_response` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `requested_at` datetime NOT NULL DEFAULT current_timestamp(),
  `processed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wp_user_id` (`wp_user_id`),
  KEY `account_id` (`account_id`),
  KEY `status` (`status`),
  KEY `currency` (`currency_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_orders`
--

DROP TABLE IF EXISTS `wp_ngm_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `partner_id` int(10) unsigned NOT NULL,
  `gsc_amount` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `eur_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_method` varchar(50) NOT NULL DEFAULT 'bank',
  `purpose` varchar(255) DEFAULT NULL,
  `status` enum('pending','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `ordered_at` datetime NOT NULL DEFAULT current_timestamp(),
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_partner` (`partner_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_partners`
--

DROP TABLE IF EXISTS `wp_ngm_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_partners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(60) NOT NULL,
  `name` varchar(120) NOT NULL,
  `url` varchar(255) NOT NULL,
  `banner_url` varchar(500) DEFAULT NULL,
  `category` varchar(50) NOT NULL DEFAULT 'paid4',
  `description` text DEFAULT NULL,
  `language` varchar(5) NOT NULL DEFAULT 'de',
  `api_key` varchar(64) NOT NULL,
  `icon` varchar(10) NOT NULL DEFAULT '?',
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `is_replica` tinyint(4) NOT NULL DEFAULT 0,
  `ip_whitelist` text DEFAULT NULL,
  `webmaster_email` varchar(200) DEFAULT NULL,
  `transfer_limit` int(10) unsigned NOT NULL DEFAULT 0,
  `rate_limit_per_min` int(11) DEFAULT NULL,
  `gsc_supply` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `gsc_debt` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `gsc_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `balance_synced_at` datetime DEFAULT NULL,
  `balance_source` varchar(50) DEFAULT NULL,
  `last_sync` datetime DEFAULT NULL,
  `last_error` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_payout_requests`
--

DROP TABLE IF EXISTS `wp_ngm_payout_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_payout_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner_id` int(10) unsigned NOT NULL,
  `user_email` varchar(200) NOT NULL,
  `user_name` varchar(200) DEFAULT NULL,
  `amount_eur` decimal(10,4) NOT NULL,
  `amount_gsc` decimal(38,8) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_details` text DEFAULT NULL,
  `source_site` varchar(500) DEFAULT NULL,
  `source_payout_id` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `processed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_source` (`partner_id`,`source_payout_id`),
  KEY `partner_id` (`partner_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_payouts`
--

DROP TABLE IF EXISTS `wp_ngm_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_payouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `partner_id` bigint(20) unsigned NOT NULL,
  `method` enum('shimly','paypal','hub','sepa','manual') NOT NULL DEFAULT 'manual',
  `amount_gsc` bigint(20) unsigned NOT NULL DEFAULT 0,
  `amount_eur` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `recipient` varchar(255) NOT NULL DEFAULT '',
  `status` enum('pending','processing','completed','failed','manual') NOT NULL DEFAULT 'pending',
  `api_response` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `requested_at` datetime NOT NULL DEFAULT current_timestamp(),
  `processed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_id` (`partner_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_rally_participation`
--

DROP TABLE IF EXISTS `wp_ngm_rally_participation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_rally_participation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rally_id` int(10) unsigned NOT NULL,
  `platform` varchar(60) NOT NULL,
  `user_email` varchar(150) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `points` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `reported_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rally_user` (`rally_id`,`platform`,`user_email`),
  KEY `idx_rally` (`rally_id`),
  KEY `idx_email` (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_rally_payouts`
--

DROP TABLE IF EXISTS `wp_ngm_rally_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_rally_payouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rally_id` int(10) unsigned NOT NULL,
  `platform` varchar(60) NOT NULL,
  `user_email` varchar(150) NOT NULL,
  `place` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `amount_gsc` decimal(20,4) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_rally` (`rally_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_rallys`
--

DROP TABLE IF EXISTS `wp_ngm_rallys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_rallys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `type` varchar(40) NOT NULL DEFAULT 'umsatz',
  `description` text DEFAULT NULL,
  `platforms` varchar(255) NOT NULL DEFAULT 'all',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `reward_type` varchar(20) NOT NULL DEFAULT 'gsc',
  `reward_places` text NOT NULL DEFAULT '[]',
  `min_umsatz` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_by` int(10) unsigned NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_dates` (`start_date`,`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_rate_history`
--

DROP TABLE IF EXISTS `wp_ngm_rate_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_rate_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gsc_eur_rate` decimal(38,12) NOT NULL,
  `source` varchar(50) NOT NULL DEFAULT 'manual',
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_settings`
--

DROP TABLE IF EXISTS `wp_ngm_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` longtext NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_staking`
--

DROP TABLE IF EXISTS `wp_ngm_staking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_staking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `partner_id` int(10) unsigned NOT NULL,
  `staked_gsc` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `draws_used` tinyint(4) NOT NULL DEFAULT 0,
  `last_contribution` datetime DEFAULT NULL,
  `last_bonus_paid` datetime DEFAULT NULL,
  `total_bonus_paid` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `partner_id` (`partner_id`),
  KEY `idx_partner` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_staking_log`
--

DROP TABLE IF EXISTS `wp_ngm_staking_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_staking_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `partner_id` int(10) unsigned NOT NULL,
  `type` enum('contribution','draw','bonus') NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_partner` (`partner_id`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_supply_snapshots`
--

DROP TABLE IF EXISTS `wp_ngm_supply_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_supply_snapshots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `partner_slug` varchar(60) NOT NULL,
  `snapshot_date` date NOT NULL,
  `gsc_supply` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_snap` (`partner_slug`,`snapshot_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_transfers`
--

DROP TABLE IF EXISTS `wp_ngm_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_transfers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `partner_id` int(10) unsigned DEFAULT NULL,
  `direction` enum('in','out') DEFAULT NULL,
  `from_site` varchar(60) NOT NULL,
  `to_site` varchar(60) NOT NULL,
  `from_user` varchar(100) NOT NULL,
  `to_user` varchar(100) NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `fee` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `net_amount` decimal(38,8) NOT NULL,
  `gsc_eur_rate` decimal(38,12) NOT NULL DEFAULT 0.000000000000,
  `eur_value` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_partner_id` (`partner_id`),
  KEY `idx_from` (`from_site`),
  KEY `idx_to` (`to_site`),
  KEY `idx_date` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_user_accounts`
--

DROP TABLE IF EXISTS `wp_ngm_user_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_user_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wp_user_id` bigint(20) unsigned NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `account_type` enum('systemkonto','hauptkonto','sparkonto') NOT NULL DEFAULT 'hauptkonto',
  `balance_gsc` bigint(20) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `wp_user_id` (`wp_user_id`),
  KEY `account_type` (`account_type`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_ngm_user_deposits`
--

DROP TABLE IF EXISTS `wp_ngm_user_deposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_ngm_user_deposits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wp_user_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `amount_gsc` bigint(20) unsigned NOT NULL,
  `partner_slug` varchar(60) NOT NULL,
  `partner_tx_id` varchar(100) DEFAULT NULL,
  `partner_user` varchar(100) DEFAULT NULL,
  `status` enum('pending','confirmed','rejected') NOT NULL DEFAULT 'confirmed',
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_tx` (`partner_slug`,`partner_tx_id`),
  KEY `wp_user_id` (`wp_user_id`),
  KEY `account_id` (`account_id`),
  KEY `partner_slug` (`partner_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=28750 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=2398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT 0,
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(255) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT 0,
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `type_status_author` (`post_type`,`post_status`,`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=3590 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_srfm_entries`
--

DROP TABLE IF EXISTS `wp_srfm_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_srfm_entries` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `form_data` longtext DEFAULT NULL,
  `logs` longtext DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `submission_info` longtext DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `extras` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `idx_form_id` (`form_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_form_id_created_at_status` (`form_id`,`created_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_srfm_payments`
--

DROP TABLE IF EXISTS `wp_srfm_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_srfm_payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) unsigned DEFAULT NULL,
  `block_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `total_amount` decimal(26,8) NOT NULL,
  `refunded_amount` decimal(26,8) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `entry_id` bigint(20) unsigned NOT NULL,
  `gateway` varchar(20) NOT NULL,
  `type` varchar(30) NOT NULL,
  `mode` varchar(20) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `subscription_id` varchar(50) NOT NULL,
  `subscription_status` varchar(20) NOT NULL,
  `parent_subscription_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `payment_data` longtext DEFAULT NULL,
  `extra` longtext DEFAULT NULL,
  `log` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `srfm_txn_id` varchar(100) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_events`
--

DROP TABLE IF EXISTS `wp_statistics_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_events` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `page_id` bigint(20) DEFAULT NULL,
  `visitor_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `event_name` varchar(64) NOT NULL,
  `event_data` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `visitor_id` (`visitor_id`),
  KEY `page_id` (`page_id`),
  KEY `event_name` (`event_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_exclusions`
--

DROP TABLE IF EXISTS `wp_statistics_exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_exclusions` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `reason` varchar(180) DEFAULT NULL,
  `count` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `date` (`date`),
  KEY `reason` (`reason`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_historical`
--

DROP TABLE IF EXISTS `wp_statistics_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_historical` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(25) NOT NULL,
  `page_id` bigint(20) NOT NULL,
  `uri` varchar(190) NOT NULL,
  `value` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uri` (`uri`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_pages`
--

DROP TABLE IF EXISTS `wp_statistics_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_pages` (
  `page_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uri` varchar(190) NOT NULL,
  `type` varchar(180) NOT NULL,
  `date` date NOT NULL,
  `count` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `date_2` (`date`,`uri`),
  KEY `url` (`uri`),
  KEY `date` (`date`),
  KEY `id` (`id`),
  KEY `uri` (`uri`,`count`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_summary_totals`
--

DROP TABLE IF EXISTS `wp_statistics_summary_totals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_summary_totals` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `visitors` bigint(20) unsigned NOT NULL,
  `views` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_visitor`
--

DROP TABLE IF EXISTS `wp_statistics_visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_visitor` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `last_counter` date NOT NULL,
  `referred` text NOT NULL,
  `agent` varchar(180) NOT NULL,
  `platform` varchar(180) DEFAULT NULL,
  `version` varchar(180) DEFAULT NULL,
  `device` varchar(180) DEFAULT NULL,
  `model` varchar(180) DEFAULT NULL,
  `UAString` varchar(190) DEFAULT NULL,
  `ip` varchar(60) NOT NULL,
  `location` varchar(10) DEFAULT NULL,
  `user_id` bigint(40) NOT NULL,
  `hits` int(11) DEFAULT NULL,
  `honeypot` int(11) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `continent` varchar(50) DEFAULT NULL,
  `source_channel` varchar(50) DEFAULT NULL,
  `source_name` varchar(100) DEFAULT NULL,
  `first_page` bigint(20) unsigned DEFAULT NULL,
  `first_view` datetime DEFAULT NULL,
  `last_page` bigint(20) unsigned DEFAULT NULL,
  `last_view` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `date_ip_agent` (`last_counter`,`ip`,`agent`(50),`platform`(50),`version`(50)),
  KEY `agent` (`agent`),
  KEY `platform` (`platform`),
  KEY `version` (`version`),
  KEY `device` (`device`),
  KEY `model` (`model`),
  KEY `location` (`location`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_statistics_visitor_relationships`
--

DROP TABLE IF EXISTS `wp_statistics_visitor_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_statistics_visitor_relationships` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `visitor_id` bigint(20) NOT NULL,
  `page_id` bigint(20) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `visitor_id` (`visitor_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `term_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `count` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=8436 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(255) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT 0,
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=1814 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ad_categories`
--

DROP TABLE IF EXISTS `wp_wf_ad_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ad_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `requires_consent` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ad_flatrates`
--

DROP TABLE IF EXISTS `wp_wf_ad_flatrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ad_flatrates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ad_type` varchar(50) NOT NULL,
  `duration_days` int(11) NOT NULL DEFAULT 7,
  `reload_hours` int(11) unsigned NOT NULL DEFAULT 24,
  `duration_seconds` int(11) unsigned NOT NULL DEFAULT 90,
  `price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `max_reward` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `max_clicks` int(11) NOT NULL DEFAULT 1000,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_type` (`ad_type`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ad_prices`
--

DROP TABLE IF EXISTS `wp_wf_ad_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ad_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ad_type` varchar(50) NOT NULL,
  `min_clicks` int(11) NOT NULL DEFAULT 1000,
  `price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `max_reward` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reload_hours` int(11) unsigned NOT NULL DEFAULT 24,
  `duration_seconds` int(11) unsigned NOT NULL DEFAULT 60,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_type` (`ad_type`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ad_types`
--

DROP TABLE IF EXISTS `wp_wf_ad_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ad_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `output_active` tinyint(1) NOT NULL DEFAULT 1,
  `rotation` tinyint(1) NOT NULL DEFAULT 1,
  `bookable` tinyint(1) NOT NULL DEFAULT 1,
  `tracking` tinyint(1) NOT NULL DEFAULT 1,
  `min_clicks` int(11) NOT NULL DEFAULT 10,
  `banner_width` int(11) NOT NULL DEFAULT 0,
  `banner_height` int(11) NOT NULL DEFAULT 0,
  `has_rating` tinyint(1) NOT NULL DEFAULT 0,
  `uses_iframe` tinyint(1) NOT NULL DEFAULT 0,
  `reward_mode` varchar(20) NOT NULL DEFAULT 'click',
  `interface_bookable` tinyint(1) NOT NULL DEFAULT 0,
  `rotation_code` varchar(50) DEFAULT '',
  `user_bookable` tinyint(1) NOT NULL DEFAULT 1,
  `min_amount` int(11) NOT NULL DEFAULT 0,
  `min_reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `main_category` varchar(20) NOT NULL DEFAULT 'banner',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_adcell_programs`
--

DROP TABLE IF EXISTS `wp_wf_adcell_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_adcell_programs` (
  `program_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(500) NOT NULL DEFAULT '',
  `logo_url` varchar(500) NOT NULL DEFAULT '',
  `description` mediumtext DEFAULT NULL,
  `affiliate_status` varchar(32) NOT NULL DEFAULT 'notapplied',
  `category_ids` varchar(255) NOT NULL DEFAULT '',
  `extra` longtext DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`program_id`),
  KEY `idx_status` (`affiliate_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_adcell_promotions`
--

DROP TABLE IF EXISTS `wp_wf_adcell_promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_adcell_promotions` (
  `promotion_id` bigint(20) unsigned NOT NULL,
  `program_id` bigint(20) unsigned NOT NULL,
  `promotion_type` varchar(32) NOT NULL DEFAULT 'banner',
  `category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `width` int(10) unsigned NOT NULL DEFAULT 0,
  `height` int(10) unsigned NOT NULL DEFAULT 0,
  `banner_url` varchar(500) NOT NULL DEFAULT '',
  `clickout_link` varchar(500) NOT NULL DEFAULT '',
  `html_code` mediumtext DEFAULT NULL,
  `information` text DEFAULT NULL,
  `affiliate_status` varchar(32) NOT NULL DEFAULT 'notapplied',
  `change_time` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`promotion_id`),
  KEY `idx_program` (`program_id`),
  KEY `idx_type` (`promotion_type`),
  KEY `idx_size` (`width`,`height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_admin_notifications`
--

DROP TABLE IF EXISTS `wp_wf_admin_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_admin_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT 'info',
  `title` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `is_read` (`is_read`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_advent_calendar`
--

DROP TABLE IF EXISTS `wp_wf_advent_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_advent_calendar` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `year` smallint(4) unsigned NOT NULL,
  `day` tinyint(2) unsigned NOT NULL,
  `prize_type` varchar(20) NOT NULL DEFAULT 'nothing',
  `prize_value` decimal(15,2) NOT NULL DEFAULT 0.00,
  `prize_label` varchar(200) NOT NULL DEFAULT '',
  `sponsor_name` varchar(100) DEFAULT NULL,
  `sponsor_url` varchar(500) DEFAULT NULL,
  `sponsor_image` varchar(500) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `year_day` (`year`,`day`),
  KEY `year` (`year`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_advent_opens`
--

DROP TABLE IF EXISTS `wp_wf_advent_opens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_advent_opens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `prize_type` varchar(20) NOT NULL DEFAULT 'nothing',
  `prize_value` decimal(15,2) NOT NULL DEFAULT 0.00,
  `opened_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendar_user` (`calendar_id`,`user_id`),
  KEY `user_id` (`user_id`),
  KEY `calendar_id` (`calendar_id`),
  KEY `opened_at` (`opened_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_agency_invoices`
--

DROP TABLE IF EXISTS `wp_wf_agency_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_agency_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `agency_user_id` bigint(20) unsigned NOT NULL,
  `client_user_id` bigint(20) unsigned NOT NULL,
  `amount_euro` decimal(10,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'open',
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agency_user_id` (`agency_user_id`),
  KEY `client_user_id` (`client_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_agency_margins`
--

DROP TABLE IF EXISTS `wp_wf_agency_margins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_agency_margins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `agency_user_id` bigint(20) unsigned NOT NULL,
  `campaign_type` varchar(50) NOT NULL DEFAULT '',
  `margin_pct` decimal(5,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_type` (`agency_user_id`,`campaign_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_betteln_logs`
--

DROP TABLE IF EXISTS `wp_wf_betteln_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_betteln_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `clicker_ip` varchar(45) NOT NULL,
  `reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `clicked_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `clicked_at` (`clicked_at`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_campaign_delivery`
--

DROP TABLE IF EXISTS `wp_wf_campaign_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_campaign_delivery` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `ad_type` varchar(50) NOT NULL,
  `referer` text DEFAULT NULL,
  `reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `delivered_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `site_id` (`site_id`),
  KEY `user_id` (`user_id`),
  KEY `ad_type` (`ad_type`),
  KEY `delivered_at` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_campaign_flag_assignments`
--

DROP TABLE IF EXISTS `wp_wf_campaign_flag_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_campaign_flag_assignments` (
  `campaign_id` bigint(20) unsigned NOT NULL,
  `flag_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`campaign_id`,`flag_id`),
  KEY `flag_id` (`flag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_campaign_rejects`
--

DROP TABLE IF EXISTS `wp_wf_campaign_rejects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_campaign_rejects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `ad_type` varchar(50) NOT NULL,
  `referer` text DEFAULT NULL,
  `reject_reason` varchar(100) NOT NULL,
  `error_code` smallint(5) unsigned NOT NULL DEFAULT 0,
  `rejected_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `user_id` (`user_id`),
  KEY `ad_type` (`ad_type`),
  KEY `reject_reason` (`reject_reason`),
  KEY `error_code` (`error_code`),
  KEY `rejected_at` (`rejected_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_campaign_stats`
--

DROP TABLE IF EXISTS `wp_wf_campaign_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_campaign_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'banner',
  `user_id` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `country_code` char(2) DEFAULT '',
  `reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `clicked_at` datetime NOT NULL DEFAULT current_timestamp(),
  `campaign_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `user_id` (`user_id`),
  KEY `clicked_at` (`clicked_at`)
) ENGINE=InnoDB AUTO_INCREMENT=60824 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_campaigns`
--

DROP TABLE IF EXISTS `wp_wf_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_campaigns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(200) NOT NULL,
  `total_clicks` int(11) NOT NULL DEFAULT 0,
  `remaining_clicks` int(11) unsigned NOT NULL DEFAULT 0,
  `reload_seconds` int(11) NOT NULL DEFAULT 0,
  `reward_per_click` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `min_duration` int(11) NOT NULL DEFAULT 0,
  `banner_html` text DEFAULT NULL,
  `banner_url` varchar(500) DEFAULT NULL,
  `target_url` text NOT NULL,
  `target_language` varchar(10) NOT NULL DEFAULT '',
  `ad_category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `subject` text DEFAULT NULL,
  `body` text DEFAULT NULL,
  `blocked_countries` text DEFAULT NULL,
  `blocked_users` text DEFAULT NULL,
  `site_types` text DEFAULT NULL,
  `display_mode` tinyint(1) NOT NULL DEFAULT 1,
  `booking_type` char(2) DEFAULT 'st',
  `flatrate_cost` decimal(38,8) DEFAULT 0.00000000,
  `flatrate_id` int(11) DEFAULT NULL,
  `reported_reason` varchar(200) DEFAULT NULL,
  `frametest_result` varchar(20) DEFAULT 'untested',
  `frametest_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `external_id` varchar(100) DEFAULT NULL,
  `interface_id` bigint(20) unsigned DEFAULT NULL,
  `managed_by_agency` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `frametest_result` (`frametest_result`),
  KEY `target_language` (`target_language`),
  KEY `ad_category_id` (`ad_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_campaigns_archive`
--

DROP TABLE IF EXISTS `wp_wf_campaigns_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_campaigns_archive` (
  `id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `original_status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(200) NOT NULL,
  `total_clicks` int(11) NOT NULL DEFAULT 0,
  `remaining_clicks` int(11) unsigned NOT NULL DEFAULT 0,
  `reload_seconds` int(11) NOT NULL DEFAULT 0,
  `reward_per_click` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `min_duration` int(11) NOT NULL DEFAULT 0,
  `banner_html` text DEFAULT NULL,
  `target_url` text NOT NULL,
  `subject` text DEFAULT NULL,
  `body` text DEFAULT NULL,
  `blocked_countries` text DEFAULT NULL,
  `blocked_users` text DEFAULT NULL,
  `site_types` text DEFAULT NULL,
  `display_mode` tinyint(1) NOT NULL DEFAULT 1,
  `booking_type` char(2) DEFAULT 'st',
  `flatrate_cost` decimal(38,8) DEFAULT 0.00000000,
  `flatrate_id` int(11) DEFAULT NULL,
  `reported_reason` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `archived_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `original_status` (`original_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_cashback_clicks`
--

DROP TABLE IF EXISTS `wp_wf_cashback_clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_cashback_clicks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `shop_id` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '',
  `tracking_id` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracking_id` (`tracking_id`),
  KEY `user_id` (`user_id`),
  KEY `shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_cashback_shops`
--

DROP TABLE IF EXISTS `wp_wf_cashback_shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_cashback_shops` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `url` varchar(500) NOT NULL,
  `logo_url` varchar(500) DEFAULT '',
  `cashback_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `category` varchar(100) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `category` (`category`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_cashback_transactions`
--

DROP TABLE IF EXISTS `wp_wf_cashback_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_cashback_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `shop_id` bigint(20) unsigned NOT NULL,
  `click_id` bigint(20) unsigned DEFAULT NULL,
  `order_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `cashback_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `confirmed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `shop_id` (`shop_id`),
  KEY `status` (`status`),
  KEY `click_id` (`click_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_click_tracking`
--

DROP TABLE IF EXISTS `wp_wf_click_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_click_tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `campaign_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `interface_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(32) NOT NULL DEFAULT 'other',
  `ip_address` varchar(45) NOT NULL DEFAULT '',
  `country_code` char(2) NOT NULL DEFAULT '',
  `click_time` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(32) NOT NULL DEFAULT 'abgelehnt_fraud',
  `reward_gsc` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `reason` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `interface_id` (`interface_id`),
  KEY `click_time` (`click_time`),
  KEY `status` (`status`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_coinflip`
--

DROP TABLE IF EXISTS `wp_wf_coinflip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_coinflip` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `bet_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `choice` varchar(10) NOT NULL DEFAULT 'heads',
  `result` varchar(10) NOT NULL DEFAULT 'heads',
  `won` tinyint(1) NOT NULL DEFAULT 0,
  `payout` decimal(15,2) NOT NULL DEFAULT 0.00,
  `house_fee` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `won` (`won`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_country_blocks`
--

DROP TABLE IF EXISTS `wp_wf_country_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_country_blocks` (
  `cc2` char(2) NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `mode` enum('block','allow') NOT NULL DEFAULT 'block',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`cc2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_coupon_redemptions`
--

DROP TABLE IF EXISTS `wp_wf_coupon_redemptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_coupon_redemptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `redeemed_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_user` (`coupon_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_coupons`
--

DROP TABLE IF EXISTS `wp_wf_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `valid_until` datetime DEFAULT NULL,
  `total_amount` int(11) NOT NULL DEFAULT 0,
  `remaining` int(11) NOT NULL DEFAULT 0,
  `min_earned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `value` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `payout_type` varchar(20) NOT NULL DEFAULT 'balance',
  `redeem_condition` varchar(50) NOT NULL DEFAULT 'none',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_cron_stats`
--

DROP TABLE IF EXISTS `wp_wf_cron_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_cron_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `interface_slug` varchar(50) NOT NULL DEFAULT 'werbeflut',
  `ad_type` varchar(50) NOT NULL,
  `run_at` datetime NOT NULL,
  `campaign_count` int(11) NOT NULL DEFAULT 0,
  `avg_reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_value` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_clicks` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `interface_slug` (`interface_slug`),
  KEY `ad_type` (`ad_type`),
  KEY `run_at` (`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_deposits`
--

DROP TABLE IF EXISTS `wp_wf_deposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_deposits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `method` varchar(50) NOT NULL DEFAULT 'paypal',
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_dice`
--

DROP TABLE IF EXISTS `wp_wf_dice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_dice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `bet_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `direction` varchar(10) NOT NULL DEFAULT 'under',
  `target` int(11) NOT NULL DEFAULT 50,
  `roll` int(11) NOT NULL DEFAULT 0,
  `won` tinyint(1) NOT NULL DEFAULT 0,
  `multiplier` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `payout` decimal(15,2) NOT NULL DEFAULT 0.00,
  `house_fee` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `won` (`won`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_duplicate_suspects`
--

DROP TABLE IF EXISTS `wp_wf_duplicate_suspects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_duplicate_suspects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_1` bigint(20) unsigned NOT NULL,
  `user_id_2` bigint(20) unsigned NOT NULL,
  `reason` varchar(50) NOT NULL,
  `score` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `details` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `checked_by` bigint(20) unsigned DEFAULT NULL,
  `checked_at` datetime DEFAULT NULL,
  `detected_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `pair` (`user_id_1`,`user_id_2`),
  KEY `idx_status` (`status`),
  KEY `idx_user1` (`user_id_1`),
  KEY `idx_user2` (`user_id_2`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ebesucher_conversions`
--

DROP TABLE IF EXISTS `wp_wf_ebesucher_conversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ebesucher_conversions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `btp` decimal(15,4) NOT NULL DEFAULT 0.0000,
  `cashpoints` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `gsc` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `surflink_id` int(11) NOT NULL DEFAULT 0,
  `surflink_name` varchar(200) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ngm123` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ebesucher_surfs`
--

DROP TABLE IF EXISTS `wp_wf_ebesucher_surfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ebesucher_surfs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `reward` decimal(15,2) NOT NULL DEFAULT 0.00,
  `ip_address` varchar(45) NOT NULL DEFAULT '',
  `surfed_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `surfed_at` (`surfed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_email_blacklist`
--

DROP TABLE IF EXISTS `wp_wf_email_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_email_blacklist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_hash` char(64) NOT NULL,
  `email` varchar(255) NOT NULL,
  `reason` varchar(120) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_hash` (`email_hash`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_email_verifications`
--

DROP TABLE IF EXISTS `wp_wf_email_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_email_verifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `email` varchar(100) NOT NULL,
  `token` char(64) NOT NULL,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp(),
  `confirmed_at` datetime DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_token` (`token`),
  KEY `idx_user` (`user_id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_faq`
--

DROP TABLE IF EXISTS `wp_wf_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_faq` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` longtext NOT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `language` varchar(5) NOT NULL DEFAULT 'de',
  `category` varchar(100) NOT NULL DEFAULT '',
  `hits` int(11) NOT NULL DEFAULT 0,
  `rating` decimal(3,1) NOT NULL DEFAULT 0.0,
  `rating_count` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'published',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_api_projects`
--

DROP TABLE IF EXISTS `wp_wf_gsc_api_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_api_projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `url` varchar(500) DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `requests_used` int(11) NOT NULL DEFAULT 0,
  `volume_total` bigint(20) NOT NULL DEFAULT 0,
  `volume_today` bigint(20) NOT NULL DEFAULT 0,
  `volume_week` bigint(20) NOT NULL DEFAULT 0,
  `volume_month` bigint(20) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_shredder_entries`
--

DROP TABLE IF EXISTS `wp_wf_gsc_shredder_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_shredder_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `round_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `shares` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `round_id` (`round_id`),
  KEY `user_id` (`user_id`),
  KEY `round_user` (`round_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_shredder_rounds`
--

DROP TABLE IF EXISTS `wp_wf_gsc_shredder_rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_shredder_rounds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pool_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_burned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_shares` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `entries_count` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `started_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `ends_at` (`ends_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_staking`
--

DROP TABLE IF EXISTS `wp_wf_gsc_staking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_staking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `mode` enum('staking','advertising') NOT NULL DEFAULT 'staking',
  `locked_until` datetime NOT NULL,
  `source` enum('shimly','boostpoints','manual') NOT NULL DEFAULT 'shimly',
  `tx_ref` varchar(64) NOT NULL DEFAULT '',
  `status` enum('locked','released','cancelled') NOT NULL DEFAULT 'locked',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_locked` (`locked_until`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_supply_snapshots`
--

DROP TABLE IF EXISTS `wp_wf_gsc_supply_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_supply_snapshots` (
  `snapshot_date` date NOT NULL,
  `in_circulation` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_ever_minted` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_paid_out` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_burned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_in_vault` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `active_wallets` int(10) unsigned NOT NULL DEFAULT 0,
  `daily_minted` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `daily_burned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`snapshot_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_transactions`
--

DROP TABLE IF EXISTS `wp_wf_gsc_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned DEFAULT NULL,
  `to_user_id` bigint(20) unsigned DEFAULT NULL,
  `amount` decimal(38,8) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT '',
  `external_ref` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_vault_timelocks`
--

DROP TABLE IF EXISTS `wp_wf_gsc_vault_timelocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_vault_timelocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `label` varchar(200) NOT NULL DEFAULT '',
  `locked_until` datetime NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'locked',
  `released_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `locked_until` (`locked_until`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_gsc_wallets`
--

DROP TABLE IF EXISTS `wp_wf_gsc_wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_gsc_wallets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `vault_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_received` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_sent` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_burned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_homepage_ads`
--

DROP TABLE IF EXISTS `wp_wf_homepage_ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_homepage_ads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `type` varchar(20) NOT NULL DEFAULT 'banner',
  `format` varchar(20) NOT NULL DEFAULT '',
  `image_url` varchar(500) DEFAULT '',
  `link_url` varchar(500) DEFAULT '',
  `script_code` text DEFAULT NULL,
  `text` varchar(500) DEFAULT '',
  `clicks` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `booked_days` int(11) NOT NULL DEFAULT 0,
  `rest_days` int(11) NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `format` (`format`),
  KEY `user_id` (`user_id`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_interface_blocks`
--

DROP TABLE IF EXISTS `wp_wf_interface_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_interface_blocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `direction` varchar(10) NOT NULL DEFAULT 'inbound',
  `interface_id` bigint(20) unsigned DEFAULT NULL,
  `ad_type` varchar(50) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `external_id` varchar(100) NOT NULL DEFAULT '',
  `reason` varchar(200) NOT NULL DEFAULT '',
  `blocked_by` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `direction` (`direction`),
  KEY `interface_id` (`interface_id`),
  KEY `ad_type` (`ad_type`),
  KEY `external_id` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_interface_downloads`
--

DROP TABLE IF EXISTS `wp_wf_interface_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_interface_downloads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `file_url` varchar(500) NOT NULL,
  `version` varchar(20) DEFAULT NULL,
  `interface_slug` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_interface_log`
--

DROP TABLE IF EXISTS `wp_wf_interface_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_interface_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `interface_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `message` text DEFAULT NULL,
  `response_code` varchar(20) DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `interface_id` (`interface_id`),
  KEY `action` (`action`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_interface_stats`
--

DROP TABLE IF EXISTS `wp_wf_interface_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_interface_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `interface_name` varchar(50) NOT NULL,
  `ad_type` varchar(50) NOT NULL,
  `clicks` int(11) NOT NULL DEFAULT 0,
  `revenue` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_interface_type` (`date`,`interface_name`,`ad_type`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_interfaces`
--

DROP TABLE IF EXISTS `wp_wf_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_interfaces` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `api_url` varchar(500) DEFAULT '',
  `api_id` varchar(100) DEFAULT '',
  `api_password` varchar(200) DEFAULT '',
  `project_id` varchar(100) DEFAULT '',
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_premium` tinyint(1) NOT NULL DEFAULT 0,
  `sync_interval_minutes` int(11) NOT NULL DEFAULT 60,
  `last_sync` datetime DEFAULT NULL,
  `total_synced` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `is_active` (`is_active`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ip_blocks`
--

DROP TABLE IF EXISTS `wp_wf_ip_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ip_blocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip_range` varchar(50) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `blocked_by` varchar(100) DEFAULT 'admin',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_range` (`ip_range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_jackpot`
--

DROP TABLE IF EXISTS `wp_wf_jackpot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_jackpot` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `source` varchar(50) NOT NULL,
  `contributed_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `source` (`source`),
  KEY `contributed_by` (`contributed_by`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_jackpot_winners`
--

DROP TABLE IF EXISTS `wp_wf_jackpot_winners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_jackpot_winners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `trigger_type` varchar(50) NOT NULL DEFAULT 'random',
  `won_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `trigger_type` (`trigger_type`),
  KEY `won_at` (`won_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_klick4win`
--

DROP TABLE IF EXISTS `wp_wf_klick4win`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_klick4win` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `prize` decimal(15,2) NOT NULL DEFAULT 0.00,
  `won` tinyint(1) NOT NULL DEFAULT 0,
  `rolled_number` int(11) NOT NULL DEFAULT 0,
  `winning_number` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `won` (`won`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_leads_billing`
--

DROP TABLE IF EXISTS `wp_wf_leads_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_leads_billing` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `leads_count` int(11) NOT NULL DEFAULT 0,
  `total_earned` decimal(15,2) NOT NULL DEFAULT 0.00,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'open',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `period_start` (`period_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_leads_categories`
--

DROP TABLE IF EXISTS `wp_wf_leads_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_leads_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_leads_networks`
--

DROP TABLE IF EXISTS `wp_wf_leads_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_leads_networks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `api_url` varchar(500) DEFAULT '',
  `api_key` varchar(200) DEFAULT '',
  `commission_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ledger_blocks`
--

DROP TABLE IF EXISTS `wp_wf_ledger_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ledger_blocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `block_height` bigint(20) unsigned NOT NULL,
  `prev_hash` char(64) NOT NULL,
  `block_hash` char(64) NOT NULL,
  `transfer_id` varchar(64) NOT NULL,
  `payload_json` longtext NOT NULL,
  `source_site` varchar(100) NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_block_height` (`block_height`),
  UNIQUE KEY `uniq_block_hash` (`block_hash`),
  UNIQUE KEY `uniq_transfer` (`transfer_id`),
  KEY `idx_transfer` (`transfer_id`),
  KEY `idx_source` (`source_site`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_luckywheel_sectors`
--

DROP TABLE IF EXISTS `wp_wf_luckywheel_sectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_luckywheel_sectors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL DEFAULT 0,
  `label` varchar(100) NOT NULL DEFAULT '',
  `prize_type` varchar(20) NOT NULL DEFAULT 'nothing',
  `prize_value` decimal(15,2) NOT NULL DEFAULT 0.00,
  `color` varchar(7) NOT NULL DEFAULT 'CCCCCC',
  `probability` decimal(5,2) NOT NULL DEFAULT 0.00,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_luckywheel_spins`
--

DROP TABLE IF EXISTS `wp_wf_luckywheel_spins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_luckywheel_spins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `prize_type` varchar(20) NOT NULL DEFAULT 'nothing',
  `prize_value` decimal(15,2) NOT NULL DEFAULT 0.00,
  `sector` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`),
  KEY `prize_type` (`prize_type`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_mail_designs`
--

DROP TABLE IF EXISTS `wp_wf_mail_designs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_mail_designs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL DEFAULT '',
  `preview_html` mediumtext DEFAULT NULL,
  `html_skeleton` longtext DEFAULT NULL,
  `fields_schema` text DEFAULT NULL,
  `design_type` varchar(20) NOT NULL DEFAULT 'free',
  `shop_item_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `design_type` (`design_type`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_mail_queue`
--

DROP TABLE IF EXISTS `wp_wf_mail_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_mail_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `to_email` varchar(200) NOT NULL,
  `subject` varchar(400) NOT NULL DEFAULT '',
  `body` longtext NOT NULL,
  `headers` text DEFAULT NULL,
  `status` enum('pending','sent','failed') NOT NULL DEFAULT 'pending',
  `retries` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `sent_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_member_messages`
--

DROP TABLE IF EXISTS `wp_wf_member_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_member_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `direction` enum('to_member','from_member') NOT NULL DEFAULT 'to_member',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `is_read` (`is_read`),
  KEY `direction` (`direction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_membership_levels`
--

DROP TABLE IF EXISTS `wp_wf_membership_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_membership_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `price` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `currency` varchar(10) NOT NULL DEFAULT 'cashpoints',
  `duration_days` int(10) unsigned NOT NULL DEFAULT 30,
  `bonus_pct` decimal(5,2) NOT NULL DEFAULT 0.00,
  `ref_bonus_pct` decimal(5,2) NOT NULL DEFAULT 0.00,
  `max_sites` int(10) unsigned NOT NULL DEFAULT 5,
  `max_campaigns` int(10) unsigned NOT NULL DEFAULT 10,
  `features` text DEFAULT NULL,
  `priority` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `color` varchar(7) NOT NULL DEFAULT '#888888',
  `icon` varchar(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_priority` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_messages`
--

DROP TABLE IF EXISTS `wp_wf_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned NOT NULL,
  `receiver_id` bigint(20) unsigned NOT NULL,
  `subject` varchar(200) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_multisurf_sessions`
--

DROP TABLE IF EXISTS `wp_wf_multisurf_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_multisurf_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `worker_id` int(10) unsigned NOT NULL DEFAULT 0,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `duration` int(10) unsigned NOT NULL DEFAULT 15,
  `status` enum('active','completed','expired') NOT NULL DEFAULT 'active',
  `expires_at` datetime NOT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_worker` (`user_id`,`worker_id`),
  KEY `idx_user_status` (`user_id`,`status`),
  KEY `idx_expires` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6653 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_network_rallies`
--

DROP TABLE IF EXISTS `wp_wf_network_rallies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_network_rallies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_site` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '',
  `end_at` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_network_rally_applications`
--

DROP TABLE IF EXISTS `wp_wf_network_rally_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_network_rally_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rally_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `applied_at` datetime NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rally_id` (`rally_id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_news`
--

DROP TABLE IF EXISTS `wp_wf_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'draft',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `is_pinned` tinyint(1) NOT NULL DEFAULT 0,
  `published_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_newsletters`
--

DROP TABLE IF EXISTS `wp_wf_newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_newsletters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(200) NOT NULL,
  `body` longtext NOT NULL,
  `recipients_count` int(11) NOT NULL DEFAULT 0,
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'draft',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ngm123_api_projects`
--

DROP TABLE IF EXISTS `wp_wf_ngm123_api_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ngm123_api_projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `url` varchar(500) DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `requests_used` int(11) NOT NULL DEFAULT 0,
  `volume_total` bigint(20) NOT NULL DEFAULT 0,
  `volume_today` bigint(20) NOT NULL DEFAULT 0,
  `volume_week` bigint(20) NOT NULL DEFAULT 0,
  `volume_month` bigint(20) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ngm123_shredder_entries`
--

DROP TABLE IF EXISTS `wp_wf_ngm123_shredder_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ngm123_shredder_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `round_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `shares` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `round_id` (`round_id`),
  KEY `user_id` (`user_id`),
  KEY `round_user` (`round_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ngm123_shredder_rounds`
--

DROP TABLE IF EXISTS `wp_wf_ngm123_shredder_rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ngm123_shredder_rounds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pool_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_burned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_shares` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `entries_count` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `started_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `ends_at` (`ends_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ngm123_transactions`
--

DROP TABLE IF EXISTS `wp_wf_ngm123_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ngm123_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned DEFAULT NULL,
  `to_user_id` bigint(20) unsigned DEFAULT NULL,
  `amount` decimal(38,8) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT '',
  `external_ref` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ngm123_vault_timelocks`
--

DROP TABLE IF EXISTS `wp_wf_ngm123_vault_timelocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ngm123_vault_timelocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `label` varchar(200) NOT NULL DEFAULT '',
  `locked_until` datetime NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'locked',
  `released_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `locked_until` (`locked_until`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ngm123_wallets`
--

DROP TABLE IF EXISTS `wp_wf_ngm123_wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ngm123_wallets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `vault_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_received` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_sent` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_burned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_paidmails`
--

DROP TABLE IF EXISTS `wp_wf_paidmails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_paidmails` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp(),
  `clicked_at` datetime DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `user_id` (`user_id`),
  KEY `deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=12001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_payment_interfaces`
--

DROP TABLE IF EXISTS `wp_wf_payment_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_payment_interfaces` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `provider_id` varchar(100) DEFAULT '',
  `provider_password` varchar(255) DEFAULT '',
  `provider_key` varchar(255) DEFAULT '',
  `text_deposit` varchar(200) NOT NULL DEFAULT '',
  `text_payout` varchar(200) NOT NULL DEFAULT '',
  `min_deposit` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `min_payout` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `rate_deposit` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `rate_payout` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `rate_euro` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `fee_per_batch` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `deposit_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `payout_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_payouts`
--

DROP TABLE IF EXISTS `wp_wf_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_payouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL,
  `method` varchar(50) NOT NULL DEFAULT 'bank',
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `payment_details` text DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ngm_hub_ref` varchar(100) DEFAULT NULL,
  `ngm_forwarded_at` datetime DEFAULT NULL,
  `ngm_forward_status` varchar(20) DEFAULT NULL,
  `ngm_forward_error` text DEFAULT NULL,
  `gsc_amount` decimal(38,8) DEFAULT NULL,
  `currency` varchar(20) NOT NULL DEFAULT 'euro',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_plus_lotto_draws`
--

DROP TABLE IF EXISTS `wp_wf_plus_lotto_draws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_plus_lotto_draws` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `draw_date` datetime DEFAULT NULL,
  `numbers` varchar(30) DEFAULT NULL,
  `pool1` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool2` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool3` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool4` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool5` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `status` varchar(20) NOT NULL DEFAULT 'open',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_plus_lotto_tickets`
--

DROP TABLE IF EXISTS `wp_wf_plus_lotto_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_plus_lotto_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `draw_id` bigint(20) unsigned NOT NULL,
  `numbers` varchar(30) NOT NULL,
  `matches` tinyint(3) unsigned DEFAULT NULL,
  `prize` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `is_dauerticket` tinyint(1) NOT NULL DEFAULT 0,
  `bought_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_draw` (`draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_plusacc_orders`
--

DROP TABLE IF EXISTS `wp_wf_plusacc_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_plusacc_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `plan_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(10) NOT NULL DEFAULT 'cashpoints',
  `duration_days` int(11) NOT NULL DEFAULT 0,
  `starts_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `payment_method` varchar(50) NOT NULL DEFAULT 'cashpoints',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_plusacc_plans`
--

DROP TABLE IF EXISTS `wp_wf_plusacc_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_plusacc_plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `duration_days` int(11) NOT NULL DEFAULT 30,
  `price_cashpoints` decimal(15,2) NOT NULL DEFAULT 0.00,
  `price_euro` decimal(10,2) NOT NULL DEFAULT 0.00,
  `features` text DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_plusacc_settings`
--

DROP TABLE IF EXISTS `wp_wf_plusacc_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_plusacc_settings` (
  `id` int(1) NOT NULL DEFAULT 1,
  `price_1m` decimal(10,2) NOT NULL DEFAULT 1.00,
  `price_1m_plus` decimal(10,2) NOT NULL DEFAULT 0.50,
  `price_3m` decimal(10,2) NOT NULL DEFAULT 2.00,
  `price_3m_plus` decimal(10,2) NOT NULL DEFAULT 1.00,
  `price_6m` decimal(10,2) NOT NULL DEFAULT 4.00,
  `price_6m_plus` decimal(10,2) NOT NULL DEFAULT 3.00,
  `price_12m` decimal(10,2) NOT NULL DEFAULT 8.00,
  `price_12m_plus` decimal(10,2) NOT NULL DEFAULT 6.00,
  `info_text` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_promo_actions`
--

DROP TABLE IF EXISTS `wp_wf_promo_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_promo_actions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ad_type` varchar(50) NOT NULL,
  `packages` int(11) NOT NULL DEFAULT 1,
  `clicks_views` int(11) NOT NULL DEFAULT 0,
  `reload_seconds` int(11) NOT NULL DEFAULT 0,
  `min_duration` int(11) NOT NULL DEFAULT 0,
  `value` decimal(15,6) NOT NULL DEFAULT 0.000000,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_type` (`ad_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_promo_banners`
--

DROP TABLE IF EXISTS `wp_wf_promo_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_promo_banners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `image_url` varchar(500) NOT NULL,
  `width` int(11) NOT NULL DEFAULT 0,
  `height` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_promo_bookings`
--

DROP TABLE IF EXISTS `wp_wf_promo_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_promo_bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `campaign_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(200) NOT NULL DEFAULT '',
  `ad_type` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `remaining` int(11) NOT NULL DEFAULT 0,
  `max_clicks_views` int(11) NOT NULL DEFAULT 0,
  `booked_days` int(11) NOT NULL DEFAULT 0,
  `rest_days` int(11) NOT NULL DEFAULT 0,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `package_id` (`package_id`),
  KEY `user_id` (`user_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `status` (`status`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_promo_flatrates`
--

DROP TABLE IF EXISTS `wp_wf_promo_flatrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_promo_flatrates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ad_type` varchar(50) NOT NULL,
  `duration_days` int(11) NOT NULL DEFAULT 0,
  `reload_seconds` int(11) NOT NULL DEFAULT 0,
  `min_duration` int(11) NOT NULL DEFAULT 0,
  `value` decimal(15,6) NOT NULL DEFAULT 0.000000,
  `max_clicks_views` int(11) NOT NULL DEFAULT 0,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ad_type` (`ad_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_promo_packages`
--

DROP TABLE IF EXISTS `wp_wf_promo_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_promo_packages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'action',
  `ad_type` varchar(50) NOT NULL,
  `max_clicks_views` int(11) NOT NULL DEFAULT 0,
  `reload_hours` int(11) NOT NULL DEFAULT 0,
  `duration_seconds` int(11) NOT NULL DEFAULT 0,
  `value_per_click` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `price` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `ad_type` (`ad_type`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_rallys`
--

DROP TABLE IF EXISTS `wp_wf_rallys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_rallys` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `period` varchar(20) NOT NULL DEFAULT 'monthly',
  `prize_mode` varchar(20) NOT NULL DEFAULT 'fixed',
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  `prizes` text NOT NULL,
  `payout_type` varchar(20) NOT NULL DEFAULT 'ad_balance',
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `end_at` (`end_at`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ref_levels`
--

DROP TABLE IF EXISTS `wp_wf_ref_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ref_levels` (
  `level` tinyint(2) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `commission_pct` decimal(5,2) NOT NULL DEFAULT 0.00,
  `commission_pct_plus` decimal(5,2) NOT NULL DEFAULT 0.00,
  `signup_bonus` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `signup_bonus_min_earned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `unlock_cost` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `unlock_cost_plus` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ref_sale_tiers`
--

DROP TABLE IF EXISTS `wp_wf_ref_sale_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ref_sale_tiers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `refs_from` int(10) unsigned NOT NULL DEFAULT 0,
  `refs_to` int(10) unsigned NOT NULL DEFAULT 0,
  `price` decimal(20,8) NOT NULL DEFAULT 0.00000000,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_ref_sales`
--

DROP TABLE IF EXISTS `wp_wf_ref_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_ref_sales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ref_user_id` bigint(20) unsigned NOT NULL,
  `buyer_id` bigint(20) unsigned DEFAULT NULL,
  `price` decimal(20,8) NOT NULL DEFAULT 0.00000000,
  `source` enum('user','admin') NOT NULL DEFAULT 'user',
  `status` enum('listed','sold','cancelled') NOT NULL DEFAULT 'listed',
  `direct_refs` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `sold_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_user_id` (`ref_user_id`),
  KEY `seller_id` (`seller_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_referrals`
--

DROP TABLE IF EXISTS `wp_wf_referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_referrals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `referrer_id` bigint(20) unsigned NOT NULL,
  `referred_id` bigint(20) unsigned NOT NULL,
  `level` tinyint(3) NOT NULL DEFAULT 1,
  `commission` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_commission` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `referral_pair` (`referrer_id`,`referred_id`),
  KEY `referred_id` (`referred_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1562 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_refverkauf_tiers`
--

DROP TABLE IF EXISTS `wp_wf_refverkauf_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_refverkauf_tiers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `refs_from` int(11) NOT NULL DEFAULT 0,
  `refs_to` int(11) NOT NULL DEFAULT 0,
  `price` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_reward_tiers_duration`
--

DROP TABLE IF EXISTS `wp_wf_reward_tiers_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_reward_tiers_duration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `duration_seconds` int(11) NOT NULL,
  `bonus_pct` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `duration_seconds` (`duration_seconds`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_reward_tiers_reload`
--

DROP TABLE IF EXISTS `wp_wf_reward_tiers_reload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_reward_tiers_reload` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reload_hours` int(11) NOT NULL,
  `bonus_pct` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reload_hours` (`reload_hours`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_savings_books`
--

DROP TABLE IF EXISTS `wp_wf_savings_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_savings_books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `interest_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `duration_days` int(11) NOT NULL DEFAULT 0,
  `started_at` datetime NOT NULL,
  `matures_at` datetime NOT NULL,
  `interest_earned` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `matures_at` (`matures_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_savings_types`
--

DROP TABLE IF EXISTS `wp_wf_savings_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_savings_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `min_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `max_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `interest_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `duration_days` int(11) NOT NULL DEFAULT 0,
  `max_per_user` int(11) NOT NULL DEFAULT 1,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_searchgame`
--

DROP TABLE IF EXISTS `wp_wf_searchgame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_searchgame` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `reward` decimal(15,2) NOT NULL DEFAULT 0.00,
  `found_at` datetime NOT NULL,
  `page_url` varchar(500) DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `found_at` (`found_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_settings`
--

DROP TABLE IF EXISTS `wp_wf_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5747 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_shop_items`
--

DROP TABLE IF EXISTS `wp_wf_shop_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_shop_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(500) DEFAULT '',
  `price_cashpoints` decimal(15,2) NOT NULL DEFAULT 0.00,
  `category` varchar(100) NOT NULL DEFAULT '',
  `stock` int(11) NOT NULL DEFAULT -1,
  `sold` int(11) NOT NULL DEFAULT 0,
  `delivery_type` varchar(20) NOT NULL DEFAULT 'instant',
  `delivery_data` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `category` (`category`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_shop_orders`
--

DROP TABLE IF EXISTS `wp_wf_shop_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_shop_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `item_id` bigint(20) unsigned NOT NULL,
  `price_paid` decimal(15,2) NOT NULL DEFAULT 0.00,
  `delivery_type` varchar(20) NOT NULL DEFAULT 'instant',
  `delivery_data` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `delivered_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_shoutbox`
--

DROP TABLE IF EXISTS `wp_wf_shoutbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_shoutbox` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `message` text NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_site_applications`
--

DROP TABLE IF EXISTS `wp_wf_site_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_site_applications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `ad_type` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_adtype` (`site_id`,`ad_type`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_site_flag_assignments`
--

DROP TABLE IF EXISTS `wp_wf_site_flag_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_site_flag_assignments` (
  `site_id` bigint(20) unsigned NOT NULL,
  `flag_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`site_id`,`flag_id`),
  KEY `flag_id` (`flag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_site_flags`
--

DROP TABLE IF EXISTS `wp_wf_site_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_site_flags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` varchar(10) DEFAULT NULL,
  `default_allowed` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_site_meta`
--

DROP TABLE IF EXISTS `wp_wf_site_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_site_meta` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(100) NOT NULL,
  `meta_value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_meta_key` (`site_id`,`meta_key`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_site_types`
--

DROP TABLE IF EXISTS `wp_wf_site_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_site_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_sites`
--

DROP TABLE IF EXISTS `wp_wf_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_sites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `url` varchar(500) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `site_type` varchar(50) NOT NULL DEFAULT 'paid4virtual',
  `total_earned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `reward_mode` varchar(20) NOT NULL DEFAULT 'siteid_ip',
  `admin_note` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `site_type` (`site_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_sitetype_adtypes`
--

DROP TABLE IF EXISTS `wp_wf_sitetype_adtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_sitetype_adtypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_type` varchar(50) NOT NULL,
  `ad_type` varchar(50) NOT NULL,
  `allowed` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_pair` (`site_type`,`ad_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_sso_nonces`
--

DROP TABLE IF EXISTS `wp_wf_sso_nonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_sso_nonces` (
  `nonce` varchar(64) NOT NULL,
  `used_at` datetime NOT NULL,
  PRIMARY KEY (`nonce`),
  KEY `used_at_idx` (`used_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_surfbar_reloads`
--

DROP TABLE IF EXISTS `wp_wf_surfbar_reloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_surfbar_reloads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `reloaded_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id_campaign` (`user_id`,`campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30710 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_templates`
--

DROP TABLE IF EXISTS `wp_wf_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_type` varchar(20) NOT NULL DEFAULT 'mail',
  `template_key` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '',
  `subject` varchar(200) NOT NULL DEFAULT '',
  `body` longtext NOT NULL,
  `format` varchar(10) NOT NULL DEFAULT 'html',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_key` (`template_type`,`template_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_tickets`
--

DROP TABLE IF EXISTS `wp_wf_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'open',
  `admin_reply` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_tips`
--

DROP TABLE IF EXISTS `wp_wf_tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_tips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL DEFAULT 'tip',
  `title` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `image_url` varchar(500) NOT NULL DEFAULT '',
  `cta_label` varchar(80) NOT NULL DEFAULT '',
  `cta_url` varchar(500) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 100,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `audience` varchar(40) NOT NULL DEFAULT 'all',
  `published_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_active` (`active`,`sort_order`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_toplinks`
--

DROP TABLE IF EXISTS `wp_wf_toplinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_toplinks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `url` varchar(500) NOT NULL DEFAULT '',
  `title` varchar(100) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `status` enum('pending','active','rejected') NOT NULL DEFAULT 'pending',
  `reject_reason` varchar(255) NOT NULL DEFAULT '',
  `total_ratings` int(10) unsigned NOT NULL DEFAULT 0,
  `total_score` int(10) unsigned NOT NULL DEFAULT 0,
  `avg_rating` decimal(4,2) NOT NULL DEFAULT 0.00,
  `submitted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `approved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `total_score` (`total_score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_toplinks_ratings`
--

DROP TABLE IF EXISTS `wp_wf_toplinks_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_toplinks_ratings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `rating` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `rated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_rating` (`link_id`,`user_id`),
  KEY `link_id` (`link_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_transactions`
--

DROP TABLE IF EXISTS `wp_wf_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `currency` varchar(20) NOT NULL DEFAULT 'cp',
  `exchange_rate` decimal(38,12) DEFAULT NULL,
  `payment_currency` varchar(20) DEFAULT NULL,
  `payment_amount` decimal(38,8) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  `external_ref` varchar(128) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `confirmation_status` enum('pending','confirmed','failed') NOT NULL DEFAULT 'pending',
  `ledger_block_height` bigint(20) unsigned DEFAULT NULL,
  `ledger_block_hash` char(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_external_ref` (`external_ref`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=70251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_transfer_fee_burns`
--

DROP TABLE IF EXISTS `wp_wf_transfer_fee_burns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_transfer_fee_burns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` varchar(64) NOT NULL,
  `source_user_id` bigint(20) unsigned NOT NULL,
  `source_site` varchar(100) NOT NULL DEFAULT '',
  `partner` varchar(50) NOT NULL DEFAULT '',
  `amount` decimal(38,8) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_transfer` (`transfer_id`),
  KEY `idx_user` (`source_user_id`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_transfer_partners`
--

DROP TABLE IF EXISTS `wp_wf_transfer_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_transfer_partners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `api_key` varchar(64) NOT NULL DEFAULT '',
  `icon` varchar(10) NOT NULL DEFAULT '?',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_success` datetime DEFAULT NULL,
  `last_error` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_transfer_verifications`
--

DROP TABLE IF EXISTS `wp_wf_transfer_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_transfer_verifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `partner_slug` varchar(100) NOT NULL,
  `token` varchar(128) NOT NULL,
  `status` enum('pending','verified','expired') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `verified_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_url_blacklist`
--

DROP TABLE IF EXISTS `wp_wf_url_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_url_blacklist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL,
  `reason` varchar(500) DEFAULT '',
  `added_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_url_reports`
--

DROP TABLE IF EXISTS `wp_wf_url_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_url_reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reported_url` varchar(500) NOT NULL,
  `begging_ref` varchar(100) NOT NULL DEFAULT '',
  `visitor_ip` varchar(45) NOT NULL DEFAULT '',
  `reason` text DEFAULT NULL,
  `status` enum('new','reviewed','dismissed') NOT NULL DEFAULT 'new',
  `reported_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_user_ad_consent`
--

DROP TABLE IF EXISTS `wp_wf_user_ad_consent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_user_ad_consent` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `consented` tinyint(1) NOT NULL DEFAULT 0,
  `consented_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `reminder_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_cat` (`user_id`,`category_id`),
  KEY `user_id` (`user_id`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_user_bank_accounts`
--

DROP TABLE IF EXISTS `wp_wf_user_bank_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_user_bank_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `iban` varchar(34) NOT NULL,
  `bic` varchar(11) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_holder` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `verified_at` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_default` (`user_id`,`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_user_flag_filters`
--

DROP TABLE IF EXISTS `wp_wf_user_flag_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_user_flag_filters` (
  `user_id` bigint(20) unsigned NOT NULL,
  `flag_id` bigint(20) unsigned NOT NULL,
  `allowed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`flag_id`),
  KEY `flag_id` (`flag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_user_memberships`
--

DROP TABLE IF EXISTS `wp_wf_user_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_user_memberships` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) unsigned NOT NULL,
  `started_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `auto_renew` tinyint(1) NOT NULL DEFAULT 0,
  `payment_method` varchar(30) DEFAULT NULL,
  `transaction_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_level` (`level_id`),
  KEY `idx_expires` (`expires_at`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_user_roles`
--

DROP TABLE IF EXISTS `wp_wf_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_user_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `role` varchar(30) NOT NULL,
  `granted_by` bigint(20) unsigned DEFAULT NULL,
  `granted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `meta` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_role` (`user_id`,`role`),
  KEY `idx_role` (`role`),
  KEY `idx_status` (`status`),
  KEY `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_user_tips_seen`
--

DROP TABLE IF EXISTS `wp_wf_user_tips_seen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_user_tips_seen` (
  `user_id` bigint(20) unsigned NOT NULL,
  `tip_id` bigint(20) unsigned NOT NULL,
  `seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `dismissed` tinyint(1) NOT NULL DEFAULT 0,
  `clicked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`tip_id`),
  KEY `idx_seen` (`seen_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_users`
--

DROP TABLE IF EXISTS `wp_wf_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wp_user_id` bigint(20) unsigned DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL DEFAULT '',
  `referrer_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `first_name` varchar(50) DEFAULT '',
  `last_name` varchar(50) DEFAULT '',
  `street` varchar(100) DEFAULT '',
  `zip` varchar(10) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `company` varchar(200) DEFAULT '',
  `balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `ad_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `lead_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `lead_ad_balance` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_earned` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_paid_out` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `total_deposited` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `payout_count` int(11) NOT NULL DEFAULT 0,
  `last_payout_at` datetime DEFAULT NULL,
  `signup_bonus_claimed` tinyint(1) NOT NULL DEFAULT 0,
  `is_plus` tinyint(1) NOT NULL DEFAULT 0,
  `plus_expires_at` datetime DEFAULT NULL,
  `paidmail_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `api_password` varchar(100) DEFAULT NULL,
  `api_password_hash` varchar(255) DEFAULT NULL,
  `api_password_set_at` datetime DEFAULT NULL,
  `api_password_last_used` datetime DEFAULT NULL,
  `api_free_requests` int(11) NOT NULL DEFAULT 0,
  `api_paid_requests` int(11) NOT NULL DEFAULT 0,
  `transfer_password` varchar(255) DEFAULT NULL,
  `transfer_pw_hash` varchar(255) DEFAULT NULL,
  `transfer_pw_set_at` datetime DEFAULT NULL,
  `transfer_pw_expires_at` datetime DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT '',
  `last_ip` varchar(45) DEFAULT '',
  `last_active_at` datetime DEFAULT NULL,
  `registered_at` datetime NOT NULL DEFAULT current_timestamp(),
  `agreed_tos` tinyint(1) NOT NULL DEFAULT 0,
  `agreed_privacy` tinyint(1) NOT NULL DEFAULT 0,
  `agb_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `agb_confirmed_at` datetime DEFAULT NULL,
  `sponsor_account_id` int(10) unsigned DEFAULT NULL,
  `klamm_id` varchar(100) DEFAULT NULL,
  `klamm_ef_id` varchar(100) DEFAULT NULL,
  `klamm_ef_text` varchar(255) DEFAULT NULL,
  `ebesucher_id` varchar(100) DEFAULT NULL,
  `shimly_id` varchar(100) DEFAULT NULL,
  `shimly_boost_id` varchar(100) DEFAULT NULL,
  `paypal_email` varchar(200) DEFAULT NULL,
  `bank_iban` varchar(50) DEFAULT NULL,
  `bank_bic` varchar(20) DEFAULT NULL,
  `bank_owner` varchar(100) DEFAULT NULL,
  `faucetpay_email` varchar(200) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` datetime DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `nickname` varchar(30) DEFAULT NULL,
  `notify_new_refs` tinyint(1) NOT NULL DEFAULT 1,
  `notify_payouts` tinyint(1) NOT NULL DEFAULT 1,
  `notify_balance_warning` tinyint(1) NOT NULL DEFAULT 1,
  `notify_campaign_increase` tinyint(1) NOT NULL DEFAULT 1,
  `notify_campaign_delete` tinyint(1) NOT NULL DEFAULT 1,
  `notify_campaign_expire` tinyint(1) NOT NULL DEFAULT 1,
  `notify_newsletter_offers` tinyint(1) NOT NULL DEFAULT 1,
  `user_role` varchar(20) NOT NULL DEFAULT 'publisher',
  `is_sponsor` tinyint(1) NOT NULL DEFAULT 0,
  `is_agency` tinyint(1) NOT NULL DEFAULT 0,
  `managed_by` bigint(20) unsigned DEFAULT NULL,
  `tax_id` varchar(50) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `delete_requested` tinyint(1) NOT NULL DEFAULT 0,
  `delete_requested_at` datetime DEFAULT NULL,
  `site_language` varchar(10) NOT NULL DEFAULT 'de',
  `preferred_ad_lang` varchar(200) NOT NULL DEFAULT 'de,en',
  `daily_mail_limit` smallint(5) unsigned NOT NULL DEFAULT 0,
  `vacation_mode` tinyint(1) NOT NULL DEFAULT 0,
  `vacation_start` date DEFAULT NULL,
  `vacation_end` date DEFAULT NULL,
  `country` varchar(5) DEFAULT 'DE',
  `tax_number` varchar(50) DEFAULT NULL,
  `tax_class` varchar(20) DEFAULT NULL,
  `tax_country` varchar(5) DEFAULT 'DE',
  `vat_id` varchar(50) DEFAULT NULL,
  `api_key` varchar(100) DEFAULT NULL,
  `api_calls_free` int(11) NOT NULL DEFAULT 1000,
  `api_calls_paid` int(11) NOT NULL DEFAULT 0,
  `private_homepage` tinyint(1) NOT NULL DEFAULT 0,
  `is_vat_exempt` tinyint(1) NOT NULL DEFAULT 0,
  `auto_shimly_payout` tinyint(1) NOT NULL DEFAULT 0,
  `avatar_url` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `social_twitter` varchar(100) DEFAULT NULL,
  `social_instagram` varchar(100) DEFAULT NULL,
  `social_youtube` varchar(100) DEFAULT NULL,
  `social_tiktok` varchar(100) DEFAULT NULL,
  `social_website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `referrer_id` (`referrer_id`),
  KEY `wp_user_id` (`wp_user_id`),
  KEY `status` (`status`),
  KEY `user_role` (`user_role`),
  KEY `delete_requested` (`delete_requested`)
) ENGINE=InnoDB AUTO_INCREMENT=1817 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_vcheck_log`
--

DROP TABLE IF EXISTS `wp_wf_vcheck_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_vcheck_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) unsigned NOT NULL,
  `error_code` smallint(5) unsigned NOT NULL DEFAULT 0,
  `campaign_id` bigint(20) unsigned DEFAULT NULL,
  `url_called` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `error_code` (`error_code`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_visitexchange_log`
--

DROP TABLE IF EXISTS `wp_wf_visitexchange_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_visitexchange_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `surfer_user_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned NOT NULL,
  `credited` tinyint(1) NOT NULL DEFAULT 0,
  `ip_address` varchar(45) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `surfer_user_id` (`surfer_user_id`),
  KEY `site_id` (`site_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_visitexchange_sites`
--

DROP TABLE IF EXISTS `wp_wf_visitexchange_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_visitexchange_sites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `url` varchar(500) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '',
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `credits` int(11) NOT NULL DEFAULT 0,
  `visits_received` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_vouchers`
--

DROP TABLE IF EXISTS `wp_wf_vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_vouchers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'cashpoints',
  `value` decimal(15,2) NOT NULL DEFAULT 0.00,
  `redeemed_by` bigint(20) unsigned DEFAULT NULL,
  `redeemed_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `status` (`status`),
  KEY `type` (`type`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_werbecounter`
--

DROP TABLE IF EXISTS `wp_wf_werbecounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_werbecounter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `target_url` text NOT NULL,
  `reload_hours` int(11) NOT NULL DEFAULT 1,
  `total_amount` int(11) NOT NULL DEFAULT 0,
  `remaining_amount` int(11) NOT NULL DEFAULT 0,
  `external_sponsor` varchar(200) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_werbecounter_logs`
--

DROP TABLE IF EXISTS `wp_wf_werbecounter_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_werbecounter_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `counter_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `reward` decimal(38,8) NOT NULL DEFAULT 0.00000000,
  `logged_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `counter_id` (`counter_id`),
  KEY `user_id` (`user_id`),
  KEY `logged_at` (`logged_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wf_werbemittel`
--

DROP TABLE IF EXISTS `wp_wf_werbemittel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wf_werbemittel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `image_url` varchar(500) NOT NULL DEFAULT '',
  `alt_text` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_lotto_draws`
--

DROP TABLE IF EXISTS `wp_wfg_lotto_draws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_lotto_draws` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `draw_date` datetime DEFAULT NULL,
  `numbers` varchar(100) DEFAULT NULL,
  `jackpot` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `rollover` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `winners` int(10) unsigned NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'open',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_lotto_tickets`
--

DROP TABLE IF EXISTS `wp_wfg_lotto_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_lotto_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `draw_id` bigint(20) unsigned DEFAULT NULL,
  `numbers` varchar(100) NOT NULL,
  `matches` tinyint(3) unsigned DEFAULT NULL,
  `prize` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `bought_at` datetime NOT NULL DEFAULT current_timestamp(),
  `is_dauerlos` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_draw` (`draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_plays`
--

DROP TABLE IF EXISTS `wp_wfg_plays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_plays` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `game` varchar(20) NOT NULL,
  `bet` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `win` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `result` varchar(50) NOT NULL DEFAULT '',
  `details` text DEFAULT NULL,
  `played_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_game` (`game`),
  KEY `idx_played` (`played_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_plus_lotto_draws`
--

DROP TABLE IF EXISTS `wp_wfg_plus_lotto_draws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_plus_lotto_draws` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `draw_date` datetime NOT NULL,
  `numbers` varchar(30) DEFAULT NULL,
  `pool1` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool2` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool3` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool4` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `pool5` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `status` varchar(20) NOT NULL DEFAULT 'open',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_plus_lotto_tickets`
--

DROP TABLE IF EXISTS `wp_wfg_plus_lotto_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_plus_lotto_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `draw_id` bigint(20) unsigned NOT NULL,
  `numbers` varchar(30) NOT NULL,
  `matches` tinyint(3) unsigned DEFAULT NULL,
  `prize` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `is_dauerticket` tinyint(1) NOT NULL DEFAULT 0,
  `bought_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_draw` (`draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_quiz_questions`
--

DROP TABLE IF EXISTS `wp_wfg_quiz_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_quiz_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer_a` varchar(255) NOT NULL,
  `answer_b` varchar(255) NOT NULL,
  `answer_c` varchar(255) NOT NULL,
  `answer_d` varchar(255) NOT NULL,
  `correct` char(1) NOT NULL DEFAULT 'a',
  `category` varchar(50) DEFAULT 'general',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_cat` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_transfer_partners`
--

DROP TABLE IF EXISTS `wp_wfg_transfer_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_transfer_partners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `api_key` varchar(64) NOT NULL,
  `icon` varchar(10) NOT NULL DEFAULT '?',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_success` datetime DEFAULT NULL,
  `last_error` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_wfg_transfer_verifications`
--

DROP TABLE IF EXISTS `wp_wfg_transfer_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wfg_transfer_verifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `partner_slug` varchar(50) NOT NULL,
  `partner_name` varchar(100) NOT NULL,
  `partner_user_id` varchar(100) NOT NULL,
  `status` enum('pending','verified','revoked') NOT NULL DEFAULT 'pending',
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_partner` (`user_id`,`partner_slug`),
  KEY `idx_user` (`user_id`),
  KEY `idx_partner` (`partner_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-14 10:05:29
