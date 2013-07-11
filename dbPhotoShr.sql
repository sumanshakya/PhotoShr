-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.12 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             8.0.0.4396
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for photoshare
DROP DATABASE IF EXISTS `photoshare`;
CREATE DATABASE IF NOT EXISTS `photoshare` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `photoshare`;


-- Dumping structure for table photoshare.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.category: ~21 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `category_name`) VALUES
	(1, 'Uncategorized'),
	(2, 'Abstract'),
	(3, 'Animals'),
	(4, 'Black and White'),
	(5, 'Celebrities'),
	(6, 'City and Architecture'),
	(7, 'Commercial'),
	(8, 'Concert'),
	(9, 'Family'),
	(10, 'Fashion'),
	(11, 'Film'),
	(12, 'Fine Art'),
	(13, 'Food'),
	(14, 'Journalism'),
	(15, 'Landscapes'),
	(16, 'Macro'),
	(17, 'Nature'),
	(18, 'People'),
	(19, 'Sport'),
	(20, 'Street'),
	(21, 'Wedding');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Dumping structure for table photoshare.collection
DROP TABLE IF EXISTS `collection`;
CREATE TABLE IF NOT EXISTS `collection` (
  `collection_id` int(10) NOT NULL AUTO_INCREMENT,
  `collection_name` text NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  PRIMARY KEY (`collection_id`),
  KEY `FK_collection_users` (`created_by`),
  CONSTRAINT `FK_collection_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.collection: ~54 rows (approximately)
/*!40000 ALTER TABLE `collection` DISABLE KEYS */;
INSERT INTO `collection` (`collection_id`, `collection_name`, `created_date`, `created_by`) VALUES
	(1, 'HDR', '2013-06-27 01:05:18', 4),
	(2, 'Landscape', '2013-06-27 01:07:28', 4),
	(3, 'Sunset', '2013-06-27 01:13:19', 3),
	(4, 'Me and my dog walking.', '2013-06-27 01:20:29', 4),
	(6, 'Me and my dog.', '2013-06-27 01:21:36', 4),
	(7, 'Photo taken by Nikon camera', '2013-06-27 01:23:46', 4),
	(8, 'Edited photos', '2013-06-27 01:24:55', 4),
	(10, 'Light', '2013-06-27 01:27:40', 5),
	(12, 'HDR sets', '2013-06-27 01:28:29', 5),
	(13, 'Panaroma', '2013-06-27 01:29:18', 5),
	(15, 'Unique photos', '2013-06-27 01:32:04', 8),
	(16, 'Sony photos', '2013-06-27 01:32:39', 8),
	(17, 'Holiday photos', '2013-06-27 01:34:11', 7),
	(18, 'Church photos', '2013-06-27 01:35:18', 7),
	(19, 'Panaroma', '2013-06-27 01:35:42', 7),
	(20, 'Christmas ', '2013-06-27 01:38:06', 7),
	(21, 'Panaroma photo of Berlin.', '2013-06-27 01:41:09', 7),
	(22, 'Landscape features', '2013-06-27 01:44:21', 7),
	(24, 'Home sweet home', '2013-06-27 01:47:46', 9),
	(25, 'Wondering', '2013-06-27 01:48:52', 9),
	(26, 'Streets of Berlin', '2013-06-27 01:50:23', 9),
	(28, 'Mountain ', '2013-06-27 01:55:59', 9),
	(29, 'Winter', '2013-06-27 01:56:36', 9),
	(30, 'Street Photo', '2013-06-27 01:59:49', 9),
	(31, 'Birds', '2013-06-27 02:01:46', 6),
	(32, 'Play ground', '2013-06-27 02:02:23', 6),
	(33, 'Mountain photos', '2013-06-27 02:03:56', 1),
	(34, 'City groups.', '2013-06-27 02:05:23', 1),
	(35, 'Little bird', '2013-06-27 02:08:21', 1),
	(36, 'Beautiful City.', '2013-06-27 02:11:38', 1),
	(37, 'Birds', '2013-06-27 02:13:19', 1),
	(38, 'My HDR photos', '2013-06-27 02:13:49', 1),
	(39, 'Panaroma', '2013-06-27 02:16:50', 2),
	(40, 'Black and White', '2013-06-27 02:17:20', 2),
	(41, 'Panaroma ', '2013-06-27 02:18:06', 2),
	(42, 'The church.', '2013-06-27 02:22:17', 3),
	(43, 'Churchs', '2013-06-27 02:22:48', 3),
	(44, 'Black and White', '2013-06-27 02:23:08', 3),
	(45, 'HIghways ', '2013-06-27 02:23:35', 3),
	(46, 'Back light photos', '2013-06-27 02:29:06', 5),
	(47, 'Back light', '2013-06-27 02:30:23', 5),
	(48, 'Home', '2013-06-27 02:33:11', 6),
	(51, 'Reflection', '2013-06-27 02:34:13', 6),
	(53, 'Sunshine', '2013-06-27 02:42:44', 8),
	(54, 'My recent trip to Passau', '2013-06-27 08:57:46', 11),
	(58, 'Black and white', '2013-06-27 09:03:28', 11),
	(63, 'BW', '2013-06-27 09:14:28', 11),
	(64, 'People', '2013-06-27 09:16:21', 11),
	(65, 'Stuttgart', '2013-06-27 09:18:25', 11),
	(66, 'Passau', '2013-06-27 09:19:04', 11),
	(67, 'The Portrait Group', '2013-06-27 09:22:43', 11),
	(68, 'My howtown Passau', '2013-06-27 10:06:36', 6),
	(69, 'a test story', '2013-06-27 12:23:23', 11),
	(70, 'sunet in stuttgart', '2013-06-27 12:23:54', 11),
	(71, 'Nikon HDR', '2013-06-27 12:24:34', 11);
/*!40000 ALTER TABLE `collection` ENABLE KEYS */;


-- Dumping structure for table photoshare.collection_photos
DROP TABLE IF EXISTS `collection_photos`;
CREATE TABLE IF NOT EXISTS `collection_photos` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `photo_id` int(10) NOT NULL,
  `collection_id` int(10) NOT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`photo_id`,`collection_id`),
  UNIQUE KEY `photo_id_collection_id` (`photo_id`,`collection_id`),
  KEY `FK_group_photos_collection` (`collection_id`),
  CONSTRAINT `FK_group_photos_collection` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`collection_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_group_photos_photos` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.collection_photos: ~110 rows (approximately)
/*!40000 ALTER TABLE `collection_photos` DISABLE KEYS */;
INSERT INTO `collection_photos` (`id`, `photo_id`, `collection_id`, `added_on`) VALUES
	(1, 15, 1, '2013-06-27 01:06:05'),
	(2, 17, 1, '2013-06-27 01:06:05'),
	(3, 13, 2, '2013-06-27 01:08:00'),
	(5, 13, 4, '2013-06-27 01:20:29'),
	(7, 14, 6, '2013-06-27 01:21:36'),
	(8, 13, 7, '2013-06-27 01:23:46'),
	(9, 16, 7, '2013-06-27 01:23:46'),
	(10, 17, 7, '2013-06-27 01:23:46'),
	(11, 14, 8, '2013-06-27 01:24:56'),
	(12, 15, 8, '2013-06-27 01:24:56'),
	(14, 18, 10, '2013-06-27 01:27:40'),
	(15, 19, 10, '2013-06-27 01:27:40'),
	(18, 20, 12, '2013-06-27 01:28:29'),
	(19, 21, 12, '2013-06-27 01:28:29'),
	(20, 22, 13, '2013-06-27 01:29:18'),
	(23, 38, 15, '2013-06-27 01:32:04'),
	(24, 39, 15, '2013-06-27 01:32:04'),
	(25, 40, 15, '2013-06-27 01:32:04'),
	(26, 33, 16, '2013-06-27 01:32:39'),
	(27, 34, 16, '2013-06-27 01:32:39'),
	(28, 28, 17, '2013-06-27 01:34:12'),
	(29, 29, 17, '2013-06-27 01:34:12'),
	(30, 28, 18, '2013-06-27 01:35:18'),
	(31, 30, 18, '2013-06-27 01:35:18'),
	(32, 31, 19, '2013-06-27 01:35:42'),
	(33, 32, 19, '2013-06-27 01:35:42'),
	(34, 30, 20, '2013-06-27 01:38:06'),
	(35, 31, 21, '2013-06-27 01:41:09'),
	(36, 29, 22, '2013-06-27 01:44:21'),
	(38, 49, 24, '2013-06-27 01:47:46'),
	(39, 42, 25, '2013-06-27 01:48:52'),
	(40, 44, 26, '2013-06-27 01:50:23'),
	(42, 48, 28, '2013-06-27 01:55:59'),
	(43, 41, 29, '2013-06-27 01:56:55'),
	(44, 46, 29, '2013-06-27 01:56:55'),
	(45, 45, 1, '2013-06-27 01:57:38'),
	(46, 41, 1, '2013-06-27 01:57:43'),
	(47, 42, 1, '2013-06-27 01:57:52'),
	(48, 49, 2, '2013-06-27 01:58:14'),
	(49, 47, 2, '2013-06-27 01:58:20'),
	(50, 44, 30, '2013-06-27 02:00:00'),
	(51, 45, 30, '2013-06-27 02:00:00'),
	(52, 23, 30, '2013-06-27 02:01:10'),
	(53, 25, 31, '2013-06-27 02:01:56'),
	(54, 27, 32, '2013-06-27 02:02:30'),
	(55, 2, 31, '2013-06-27 02:04:20'),
	(56, 3, 32, '2013-06-27 02:04:41'),
	(57, 1, 34, '2013-06-27 02:05:31'),
	(58, 4, 34, '2013-06-27 02:05:31'),
	(59, 2, 35, '2013-06-27 02:08:21'),
	(60, 4, 36, '2013-06-27 02:11:38'),
	(61, 2, 37, '2013-06-27 02:13:19'),
	(62, 1, 38, '2013-06-27 02:13:49'),
	(63, 3, 38, '2013-06-27 02:13:49'),
	(64, 4, 38, '2013-06-27 02:13:49'),
	(65, 1, 1, '2013-06-27 02:14:23'),
	(66, 4, 1, '2013-06-27 02:14:23'),
	(67, 6, 39, '2013-06-27 02:16:50'),
	(68, 5, 40, '2013-06-27 02:17:20'),
	(69, 7, 40, '2013-06-27 02:17:20'),
	(70, 6, 41, '2013-06-27 02:18:15'),
	(71, 7, 1, '2013-06-27 02:18:38'),
	(72, 10, 42, '2013-06-27 02:22:17'),
	(73, 8, 43, '2013-06-27 02:22:48'),
	(74, 10, 43, '2013-06-27 02:22:48'),
	(75, 8, 44, '2013-06-27 02:23:08'),
	(76, 10, 44, '2013-06-27 02:23:08'),
	(77, 12, 45, '2013-06-27 02:23:35'),
	(78, 11, 33, '2013-06-27 02:24:07'),
	(79, 18, 46, '2013-06-27 02:29:06'),
	(80, 21, 1, '2013-06-27 02:29:51'),
	(81, 20, 1, '2013-06-27 02:29:57'),
	(82, 18, 47, '2013-06-27 02:30:31'),
	(83, 24, 48, '2013-06-27 02:33:11'),
	(88, 25, 51, '2013-06-27 02:34:13'),
	(89, 29, 2, '2013-06-27 02:36:57'),
	(91, 36, 53, '2013-06-27 02:42:51'),
	(92, 34, 2, '2013-06-27 02:43:17'),
	(94, 55, 54, '2013-06-27 08:57:46'),
	(95, 58, 54, '2013-06-27 08:57:46'),
	(105, 54, 58, '2013-06-27 09:03:28'),
	(106, 55, 58, '2013-06-27 09:03:28'),
	(107, 56, 58, '2013-06-27 09:03:28'),
	(108, 62, 58, '2013-06-27 09:03:28'),
	(123, 54, 63, '2013-06-27 09:14:28'),
	(124, 55, 63, '2013-06-27 09:14:28'),
	(125, 56, 63, '2013-06-27 09:14:28'),
	(126, 62, 63, '2013-06-27 09:14:28'),
	(128, 55, 64, '2013-06-27 09:16:21'),
	(129, 56, 64, '2013-06-27 09:16:21'),
	(130, 62, 64, '2013-06-27 09:16:21'),
	(131, 54, 65, '2013-06-27 09:18:25'),
	(132, 61, 65, '2013-06-27 09:18:25'),
	(134, 55, 66, '2013-06-27 09:19:05'),
	(135, 58, 66, '2013-06-27 09:19:05'),
	(137, 10, 1, '2013-06-27 10:04:25'),
	(138, 12, 1, '2013-06-27 10:04:25'),
	(139, 23, 68, '2013-06-27 10:06:36'),
	(140, 25, 68, '2013-06-27 10:06:36'),
	(141, 26, 68, '2013-06-27 10:06:36'),
	(142, 23, 34, '2013-06-27 10:07:09'),
	(143, 54, 69, '2013-06-27 12:23:23'),
	(144, 60, 69, '2013-06-27 12:23:23'),
	(145, 63, 69, '2013-06-27 12:23:23'),
	(146, 58, 70, '2013-06-27 12:23:54'),
	(147, 59, 70, '2013-06-27 12:23:54'),
	(148, 63, 70, '2013-06-27 12:23:54'),
	(149, 59, 71, '2013-06-27 12:24:51'),
	(150, 63, 71, '2013-06-27 12:24:51'),
	(151, 55, 2, '2013-06-27 12:25:15'),
	(152, 56, 67, '2013-06-27 15:35:02');
/*!40000 ALTER TABLE `collection_photos` ENABLE KEYS */;


-- Dumping structure for table photoshare.comments
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `comment_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0',
  `comment_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_text` text,
  PRIMARY KEY (`comment_id`),
  KEY `FK_comments_users` (`user_id`),
  CONSTRAINT `FK_comments_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.comments: ~29 rows (approximately)
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`comment_id`, `user_id`, `comment_datetime`, `comment_text`) VALUES
	(33, 11, '2013-06-27 09:31:16', 'wow ! NIce landscape'),
	(34, 11, '2013-06-27 09:41:20', 'Foggy'),
	(35, 11, '2013-06-27 09:42:16', 'Wonderful!'),
	(36, 11, '2013-06-27 09:42:57', 'Nice composition'),
	(37, 11, '2013-06-27 09:43:47', 'I love winter.'),
	(38, 11, '2013-06-27 09:45:21', 'where is this place ? gr8 shot btw'),
	(39, 11, '2013-06-27 09:45:49', 'night lights'),
	(40, 11, '2013-06-27 09:46:16', 'Berliner Dom, I remember this place :)'),
	(41, 11, '2013-06-27 09:46:36', 'wow ! Beautiful scenary'),
	(42, 11, '2013-06-27 09:47:41', 'Passau is such a beautiful place. Too bad to hear about the flooding :('),
	(43, 1, '2013-06-27 09:50:21', 'beautiful place'),
	(44, 1, '2013-06-27 09:50:59', 'nice shot'),
	(45, 1, '2013-06-27 09:51:29', 'Beautiful capture. Voted and favorited'),
	(46, 1, '2013-06-27 09:51:58', 'Nice processing'),
	(47, 1, '2013-06-27 09:52:29', 'wow. golden colors indeed'),
	(48, 1, '2013-06-27 09:52:46', 'you inspire me'),
	(49, 1, '2013-06-27 09:53:23', 'nice dreamy water flow'),
	(50, 1, '2013-06-27 09:54:39', 'I know this place .Is this Munchen Olympia Park ?'),
	(51, 3, '2013-06-27 09:56:52', 'great colors. V&F'),
	(52, 3, '2013-06-27 09:57:08', 'Nice BW Shot'),
	(53, 3, '2013-06-27 09:57:29', 'Heidelberg is a beautiful place'),
	(54, 3, '2013-06-27 09:57:51', 'wow! nice shot'),
	(56, 6, '2013-06-27 10:28:49', 'Nice collection'),
	(57, 11, '2013-06-27 10:39:49', 'nice autumn colors'),
	(58, 11, '2013-06-27 10:41:04', 'a bit noisy but nice shot'),
	(59, 11, '2013-06-27 10:43:11', 'nice shot'),
	(60, 11, '2013-06-27 12:05:38', 'comment test'),
	(61, 11, '2013-06-27 12:06:09', 'comment test'),
	(62, 11, '2013-06-27 15:34:14', 'sdalksa\r\n');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;


-- Dumping structure for table photoshare.exif_data
DROP TABLE IF EXISTS `exif_data`;
CREATE TABLE IF NOT EXISTS `exif_data` (
  `exif_id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_id` int(11) NOT NULL,
  `camera` varchar(250) DEFAULT NULL,
  `aperture` varchar(250) DEFAULT NULL,
  `shutter_speed` varchar(250) DEFAULT NULL,
  `iso` varchar(250) DEFAULT NULL,
  `date_taken` varchar(250) DEFAULT NULL,
  `focal_length` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`exif_id`),
  KEY `FK_exif_data_photos` (`photo_id`),
  FULLTEXT KEY `camera` (`camera`),
  CONSTRAINT `FK_exif_data_photos` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.exif_data: ~59 rows (approximately)
/*!40000 ALTER TABLE `exif_data` DISABLE KEYS */;
INSERT INTO `exif_data` (`exif_id`, `photo_id`, `camera`, `aperture`, `shutter_speed`, `iso`, `date_taken`, `focal_length`) VALUES
	(1, 1, NULL, NULL, NULL, NULL, '2013:06:09 19:05:55\0', NULL),
	(2, 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 3, NULL, NULL, NULL, NULL, '2013:06:09 19:05:46\0', NULL),
	(4, 4, NULL, NULL, NULL, NULL, '2013:06:09 19:05:48\0', NULL),
	(5, 5, NULL, NULL, NULL, NULL, '2013:06:09 19:06:05\0', NULL),
	(6, 6, NULL, NULL, NULL, NULL, '2013:06:09 19:05:55\0', NULL),
	(7, 7, NULL, NULL, NULL, NULL, '2013:06:09 19:05:49\0', NULL),
	(8, 8, NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 9, NULL, NULL, NULL, NULL, '2013:06:09 19:06:05\0', NULL),
	(10, 10, NULL, NULL, NULL, NULL, '2013:06:09 19:05:55\0', NULL),
	(11, 11, 'COOLPIX S520\0', 'F/5.6', '1/1398.83', 'ISO-64', '2013:06:09 19:28:46\0', '5.7'),
	(12, 12, NULL, NULL, NULL, NULL, '2013:06:09 19:05:59\0', NULL),
	(13, 13, 'NEX-3\0', 'F/4.5', '1/60.13', 'ISO-200', '2013:06:09 19:03:51\0', '36'),
	(14, 14, 'GT-I9300\0', NULL, NULL, NULL, '2013:06:09 19:05:43\0', NULL),
	(15, 15, NULL, NULL, NULL, NULL, '2013:06:09 19:05:54\0', NULL),
	(16, 16, 'NIKON D7000\0', 'F/5.6', '1/79.89', 'ISO-100', '2013:06:09 19:04:46\0', '70'),
	(17, 17, 'NIKON D7000\0', 'F/22', '1/199.47', 'ISO-100', '2013:06:09 19:05:10\0', '165'),
	(18, 18, 'NEX-3\0', 'F/3.5', '1/9.99', 'ISO-400', '2013:06:09 19:05:34\0', '18'),
	(19, 19, NULL, NULL, NULL, NULL, '2013:06:09 19:05:42\0', NULL),
	(20, 20, NULL, NULL, NULL, NULL, '2013:06:09 19:05:47\0', NULL),
	(21, 21, NULL, NULL, NULL, NULL, '2013:06:09 19:05:48\0', NULL),
	(22, 22, NULL, NULL, NULL, NULL, '2013:06:09 19:05:48\0', NULL),
	(23, 23, NULL, NULL, NULL, NULL, '2013:06:09 19:05:49\0', NULL),
	(24, 24, NULL, NULL, NULL, NULL, '2013:06:09 19:05:51\0', NULL),
	(25, 25, NULL, NULL, NULL, NULL, '2013:06:09 19:05:52\0', NULL),
	(26, 26, NULL, NULL, NULL, NULL, '2013:06:09 19:05:53\0', NULL),
	(27, 27, NULL, NULL, NULL, NULL, '2013:06:09 19:05:56\0', NULL),
	(28, 28, NULL, NULL, NULL, NULL, '2013:06:09 19:05:57\0', NULL),
	(29, 29, NULL, NULL, NULL, NULL, '2013:06:09 19:05:54\0', NULL),
	(30, 30, NULL, NULL, NULL, NULL, '2013:06:09 19:05:55\0', NULL),
	(31, 31, NULL, NULL, NULL, NULL, '2013:06:09 19:05:55\0', NULL),
	(32, 32, NULL, NULL, NULL, NULL, '2013:06:09 19:05:55\0', NULL),
	(33, 33, 'NIKON D7000\0', 'F/11', '1/0.04', 'ISO-160', '2013:06:09 18:37:01\0', '50'),
	(34, 34, 'NIKON D7000\0', 'F/11', '1/0.07', 'ISO-160', '2013:06:09 18:37:16\0', '50'),
	(35, 35, 'NIKON D7000\0', 'F/5.6', '1/8023.41', 'ISO-100', '2013:06:09 18:36:46\0', '50'),
	(36, 36, 'NIKON D7000\0', NULL, NULL, NULL, '2013:06:09 18:36:53\0', NULL),
	(37, 37, 'NIKON D7000\0', NULL, NULL, NULL, '2013:06:09 18:36:58\0', NULL),
	(38, 38, 'NIKON D7000\0', 'F/11', '1/0.04', 'ISO-160', '2013:06:09 18:37:22\0', '50'),
	(39, 39, 'NIKON D7000\0', 'F/11', '1/0.03', 'ISO-100', '2013:06:09 18:37:25\0', '50'),
	(40, 40, 'NIKON D7000\0', 'F/7.1', '1/0.03', 'ISO-1250', '2013:06:09 18:37:32\0', '50'),
	(41, 41, 'GT-I9300\0', 'F/2.6', '1/349.71', 'ISO-80', '2013:06:09 19:13:51\0', '3.7'),
	(42, 42, 'GT-I9300\0', 'F/2.6', '1/481.04', 'ISO-80', '2013:06:09 19:13:55\0', '3.7'),
	(43, 43, 'GT-I9300\0', NULL, NULL, NULL, '2013:06:09 19:14:04\0', NULL),
	(44, 44, 'GT-I9300\0', NULL, NULL, NULL, '2013:06:09 19:14:09\0', NULL),
	(45, 45, 'GT-I9300\0', NULL, NULL, NULL, '2013:06:09 19:14:15\0', NULL),
	(46, 46, 'GT-I9300\0', 'F/2.6', '1/109.9', 'ISO-80', '2013:06:09 19:13:24\0', '3.7'),
	(47, 47, 'COOLPIX S520\0', 'F/3.1', '1/439.59', 'ISO-64', '2013:06:09 19:28:20\0', '7.1'),
	(48, 48, 'COOLPIX S520\0', 'F/2.8', '1/797.86', 'ISO-64', '2013:06:09 19:28:29\0', '5.7'),
	(49, 49, 'COOLPIX S520\0', 'F/3.1', '1/439.59', 'ISO-64', '2013:06:09 19:28:21\0', '7.1'),
	(50, 50, 'COOLPIX S520\0', 'F/5.6', '1/439.59', 'ISO-64', '2013:06:09 19:28:40\0', '5.7'),
	(51, 51, 'COOLPIX S520\0', 'F/5.6', '1/1398.83', 'ISO-64', '2013:06:09 19:28:42\0', '5.7'),
	(52, 52, NULL, NULL, NULL, NULL, '2013:06:09 19:05:43\0', NULL),
	(54, 54, 'NIKON D7000\0', 'F/16', '1/0,04', 'ISO-100', '2013:06:09 19:47:25\0', '22'),
	(55, 55, 'NIKON D7000\0', 'F/1,8', '1/1251,98', 'ISO-100', '2013:05:05 12:07:12\0', '50'),
	(56, 56, 'NIKON D7000\0', NULL, NULL, NULL, '2013:06:09 19:14:22\0', NULL),
	(57, 57, 'NIKON D7000\0', 'F/7,1', '1/319,57', 'ISO-320', '2013:06:09 19:45:19\0', '210'),
	(58, 58, 'NIKON D7000\0', 'F/9', '1/797,86', 'ISO-100', '2013:02:16 12:02:01\0', '135'),
	(59, 59, 'NIKON D7000\0', 'F/5,6', '1/125,37', 'ISO-100', '2013:06:09 19:49:07\0', '45'),
	(60, 60, NULL, NULL, NULL, NULL, NULL, NULL),
	(61, 61, 'NIKON D7000\0', 'F/16', '1/0,1', 'ISO-100', '2013:06:09 19:47:52\0', '30'),
	(62, 62, 'NEX-3\0', 'F/3,5', '1/9,99', 'ISO-400', '2012:01:22 19:25:55\0', '18'),
	(63, 63, 'NIKON D7000\0', 'F/8', '1/2005,85', 'ISO-400', '2013:06:09 18:42:41\0', '18'),
	(64, 64, 'GT-I9300\0', NULL, NULL, NULL, '2013:06:25 21:19:09\0', NULL),
	(65, 65, 'GT-I9300\0', 'F/2,6', '1/16,68', 'ISO-400', '2013:05:17 20:54:16\0', '3,7'),
	(66, 66, 'NIKON D7000\0', 'F/8', '1/1002,93', 'ISO-100', '2013:05:15 03:00:51\0', '105');
/*!40000 ALTER TABLE `exif_data` ENABLE KEYS */;


-- Dumping structure for table photoshare.favorites
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE IF NOT EXISTS `favorites` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `photo_id` int(10) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `fav_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`photo_id`,`user_id`),
  UNIQUE KEY `photo_id_user_id` (`photo_id`,`user_id`),
  KEY `FK_favorites_users` (`user_id`),
  CONSTRAINT `FK_favorites_photos` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`),
  CONSTRAINT `FK_favorites_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.favorites: ~21 rows (approximately)
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` (`id`, `photo_id`, `user_id`, `fav_datetime`) VALUES
	(29, 47, 11, '2013-06-27 09:32:41'),
	(30, 45, 11, '2013-06-27 09:42:26'),
	(31, 31, 11, '2013-06-27 09:45:24'),
	(32, 27, 11, '2013-06-27 09:45:31'),
	(33, 28, 11, '2013-06-27 09:45:58'),
	(34, 24, 11, '2013-06-27 09:46:22'),
	(35, 23, 11, '2013-06-27 09:47:15'),
	(36, 47, 1, '2013-06-27 09:50:06'),
	(37, 31, 1, '2013-06-27 09:50:35'),
	(38, 61, 1, '2013-06-27 09:51:06'),
	(39, 58, 1, '2013-06-27 09:51:34'),
	(40, 59, 1, '2013-06-27 09:52:04'),
	(41, 56, 1, '2013-06-27 09:52:37'),
	(42, 34, 1, '2013-06-27 09:53:27'),
	(43, 29, 1, '2013-06-27 09:53:37'),
	(44, 59, 3, '2013-06-27 09:56:53'),
	(45, 56, 3, '2013-06-27 09:57:09'),
	(46, 60, 3, '2013-06-27 09:57:16'),
	(47, 23, 3, '2013-06-27 09:57:33'),
	(49, 2, 11, '2013-06-27 10:43:17'),
	(50, 51, 11, '2013-06-27 12:06:10'),
	(51, 1, 11, '2013-06-27 12:25:55');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;


-- Dumping structure for table photoshare.followers
DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `follower_who` int(10) DEFAULT NULL,
  `follower_whom` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `follower_who_follower_whom` (`follower_who`,`follower_whom`),
  KEY `FK__users_2` (`follower_whom`),
  CONSTRAINT `FK__users` FOREIGN KEY (`follower_who`) REFERENCES `users` (`id`),
  CONSTRAINT `FK__users_2` FOREIGN KEY (`follower_whom`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.followers: ~11 rows (approximately)
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `follower_who`, `follower_whom`) VALUES
	(5, 1, 7),
	(7, 1, 8),
	(6, 1, 11),
	(9, 3, 7),
	(8, 3, 11),
	(11, 6, 9),
	(10, 6, 11),
	(12, 11, 1),
	(3, 11, 4),
	(4, 11, 6),
	(1, 11, 9),
	(2, 11, 10);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;


-- Dumping structure for table photoshare.groups
DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` text,
  `collection_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_groups_collection` (`collection_id`),
  CONSTRAINT `FK_groups_collection` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.groups: ~12 rows (approximately)
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` (`id`, `description`, `collection_id`) VALUES
	(1, 'This group mainly concentrates on HDR photos.', 1),
	(2, 'Landscape photo funs.', 2),
	(3, 'Sunset photo group.', 3),
	(4, 'Winter photos', 29),
	(5, ' Here we are interested in collecting photos taken in the streets.', 30),
	(6, 'Birds only group', 31),
	(7, 'Play ground group', 32),
	(8, 'Mountain', 33),
	(9, 'Cities from the top', 34),
	(10, 'Pan aroma photo group ', 41),
	(11, 'Back light group', 47),
	(12, 'Sunshine photo groups', 53),
	(13, 'Hi everyone,\r\n   The purpose of The Portrait Group is to share, learn and discuss anything and everything about portraiture, including self-portraits.\r\nOnly portraits of people and animals are acceptable to post here.', 67),
	(14, 'Share any HDR photos taken from Nikon cameras', 71);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;


-- Dumping structure for table photoshare.group_members
DROP TABLE IF EXISTS `group_members`;
CREATE TABLE IF NOT EXISTS `group_members` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `group_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `joined_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id_user_id` (`group_id`,`user_id`),
  KEY `FK__gm_groups` (`group_id`),
  KEY `FK__gm_users` (`user_id`),
  CONSTRAINT `FK_group_members_groups` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK__gm_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.group_members: ~23 rows (approximately)
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` (`id`, `group_id`, `user_id`, `joined_date`) VALUES
	(1, 1, 4, '2013-06-27 01:05:18'),
	(2, 2, 4, '2013-06-27 01:07:28'),
	(3, 3, 3, '2013-06-27 01:13:19'),
	(4, 4, 9, '2013-06-27 01:56:37'),
	(5, 1, 9, '2013-06-27 01:57:32'),
	(6, 2, 9, '2013-06-27 01:58:08'),
	(7, 5, 9, '2013-06-27 01:59:49'),
	(8, 5, 6, '2013-06-27 02:01:05'),
	(9, 6, 6, '2013-06-27 02:01:46'),
	(10, 7, 6, '2013-06-27 02:02:23'),
	(11, 8, 1, '2013-06-27 02:03:56'),
	(12, 6, 1, '2013-06-27 02:04:16'),
	(13, 7, 1, '2013-06-27 02:04:36'),
	(14, 9, 1, '2013-06-27 02:05:23'),
	(15, 1, 1, '2013-06-27 02:14:13'),
	(16, 10, 2, '2013-06-27 02:18:06'),
	(17, 1, 2, '2013-06-27 02:18:32'),
	(18, 8, 3, '2013-06-27 02:24:02'),
	(19, 1, 5, '2013-06-27 02:29:46'),
	(20, 11, 5, '2013-06-27 02:30:23'),
	(21, 2, 7, '2013-06-27 02:36:51'),
	(22, 12, 8, '2013-06-27 02:42:44'),
	(23, 2, 8, '2013-06-27 02:43:10'),
	(24, 13, 11, '2013-06-27 09:22:43'),
	(25, 1, 3, '2013-06-27 10:04:17'),
	(26, 9, 6, '2013-06-27 10:07:04'),
	(27, 14, 11, '2013-06-27 12:24:34'),
	(28, 2, 11, '2013-06-27 12:25:03');
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;


-- Dumping structure for table photoshare.likes
DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  `like_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`user_id`,`photo_id`),
  UNIQUE KEY `index2` (`user_id`,`photo_id`),
  KEY `1_idx` (`user_id`),
  KEY `2_idx` (`photo_id`),
  CONSTRAINT `fk_like_photo` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.likes: ~21 rows (approximately)
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` (`id`, `user_id`, `photo_id`, `like_datetime`) VALUES
	(29, 11, 47, '2013-06-27 09:32:43'),
	(30, 11, 45, '2013-06-27 09:42:22'),
	(31, 11, 46, '2013-06-27 09:43:51'),
	(32, 11, 31, '2013-06-27 09:45:26'),
	(33, 11, 27, '2013-06-27 09:45:35'),
	(34, 11, 28, '2013-06-27 09:46:00'),
	(35, 11, 24, '2013-06-27 09:46:24'),
	(36, 11, 23, '2013-06-27 09:47:16'),
	(37, 1, 47, '2013-06-27 09:50:09'),
	(38, 1, 31, '2013-06-27 09:50:38'),
	(39, 1, 61, '2013-06-27 09:51:08'),
	(40, 1, 58, '2013-06-27 09:51:40'),
	(41, 1, 59, '2013-06-27 09:52:05'),
	(42, 1, 56, '2013-06-27 09:52:40'),
	(43, 1, 34, '2013-06-27 09:53:30'),
	(44, 1, 29, '2013-06-27 09:53:39'),
	(45, 3, 59, '2013-06-27 09:56:54'),
	(46, 3, 56, '2013-06-27 09:57:12'),
	(47, 3, 60, '2013-06-27 09:57:19'),
	(48, 3, 23, '2013-06-27 09:57:35'),
	(50, 11, 2, '2013-06-27 10:43:20'),
	(51, 11, 51, '2013-06-27 12:06:12'),
	(52, 11, 1, '2013-06-27 12:26:00');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;


-- Dumping structure for table photoshare.membership
DROP TABLE IF EXISTS `membership`;
CREATE TABLE IF NOT EXISTS `membership` (
  `membership_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `is_approved` enum('Y','N') NOT NULL DEFAULT 'Y',
  `joined_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`membership_id`),
  FULLTEXT KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.membership: ~10 rows (approximately)
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
INSERT INTO `membership` (`membership_id`, `username`, `password`, `email`, `is_approved`, `joined_date`) VALUES
	(1, 'Helen12', 'helen12', 'helu@yahoo.com', 'Y', '2013-06-26 18:43:53'),
	(2, 'Jhone13', 'jhone13', 'johne@yahoo.com', 'Y', '2013-06-26 18:54:05'),
	(3, 'jhone34', 'jhone34', 'jhn@yahoo.com', 'Y', '2013-06-26 22:57:04'),
	(4, 'Samru67', 'samru67', 'samru@gmail.com', 'Y', '2013-06-26 23:13:22'),
	(5, 'Samuel45', 'samuel45', 'Sami@tests.com', 'Y', '2013-06-26 23:26:50'),
	(6, 'Steve21', 'steve22', 'Stev@hotmail.com', 'Y', '2013-06-26 23:34:00'),
	(7, 'alan98', 'alan98', 'alan@gmail.com', 'Y', '2013-06-26 23:42:13'),
	(8, 'Tomy67', 'tomy67', 'Tomy@hotmail.com', 'Y', '2013-06-26 23:51:54'),
	(9, 'Emile89', 'emile89', 'emi@hotmail.com', 'Y', '2013-06-27 00:05:02'),
	(10, 'Jack87', 'jack87', 'jack@hot.com', 'Y', '2013-06-27 00:19:09'),
	(11, 'sumanshakya', 'suman.,', 'nqholder@hotmail.com', 'Y', '2013-06-27 08:42:25'),
	(12, 'test01', 'test01', 'test@test.com', 'Y', '2013-06-27 12:31:30');
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;


-- Dumping structure for table photoshare.photos
DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` text,
  `uploaded_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `photo_url_o` text NOT NULL,
  `photo_url_m` text NOT NULL,
  `photo_url_s` text NOT NULL,
  `photo_category` int(11) NOT NULL,
  `tags` text,
  `views_count` int(11) NOT NULL DEFAULT '0',
  `likes_count` int(10) NOT NULL DEFAULT '0',
  `comments_count` int(10) NOT NULL DEFAULT '0',
  `favs_count` int(10) NOT NULL DEFAULT '0',
  `popularity` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_photo_users` (`user_id`),
  KEY `fk_photos_category` (`photo_category`),
  FULLTEXT KEY `tags` (`tags`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `description` (`description`),
  CONSTRAINT `fk_photos_category` FOREIGN KEY (`photo_category`) REFERENCES `category` (`category_id`),
  CONSTRAINT `FK_photo_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.photos: ~62 rows (approximately)
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` (`id`, `name`, `description`, `uploaded_date`, `user_id`, `photo_url_o`, `photo_url_m`, `photo_url_s`, `photo_category`, `tags`, `views_count`, `likes_count`, `comments_count`, `favs_count`, `popularity`) VALUES
	(1, 'New year in Berlin', NULL, '2013-06-26 18:45:04', 1, '/Images/Uploads/1/1_20130626184504098_L.jpg', '/Images/Uploads/1/1_20130626184504098_M.jpg', '/Images/Uploads/1/1_20130626184504098_S.jpg', 6, 'Fireworks, New year, Germany, Nikon', 3, 1, 0, 1, 2),
	(2, 'Sparrow', NULL, '2013-06-26 18:47:28', 1, '/Images/Uploads/1/1_20130626184727867_L.jpg', '/Images/Uploads/1/1_20130626184727867_M.jpg', '/Images/Uploads/1/1_20130626184727867_S.jpg', 3, 'Bird, Animals, Nikon', 5, 1, 2, 1, 4),
	(3, 'Play ground', NULL, '2013-06-26 18:48:55', 1, '/Images/Uploads/1/1_20130626184855579_L.jpg', '/Images/Uploads/1/1_20130626184855579_M.jpg', '/Images/Uploads/1/1_20130626184855579_S.jpg', 6, 'Lights, Railroads, streests, Nikon', 0, 0, 0, 0, 0),
	(4, 'Wein', NULL, '2013-06-26 18:50:22', 1, '/Images/Uploads/1/1_20130626185022531_L.jpg', '/Images/Uploads/1/1_20130626185022531_M.jpg', '/Images/Uploads/1/1_20130626185022531_S.jpg', 6, 'Building, Streets, Light, Nikon', 1, 0, 0, 0, 0),
	(5, 'Christimas in wein', NULL, '2013-06-26 18:56:10', 2, '/Images/Uploads/2/2_20130626185610075_L.jpg', '/Images/Uploads/2/2_20130626185610075_M.jpg', '/Images/Uploads/2/2_20130626185610075_S.jpg', 4, 'Night, Light, People, Holiday, NIkon', 0, 0, 0, 0, 0),
	(6, 'Berlin city', NULL, '2013-06-26 18:59:24', 2, '/Images/Uploads/2/2_20130626185924843_L.jpg', '/Images/Uploads/2/2_20130626185924843_M.jpg', '/Images/Uploads/2/2_20130626185924843_S.jpg', 6, 'Lights, City, Street, Nikon', 0, 0, 0, 0, 0),
	(7, 'Passau Panaroma', NULL, '2013-06-26 19:12:18', 2, '/Images/Uploads/2/2_20130626191218042_L.jpg', '/Images/Uploads/2/2_20130626191218042_M.jpg', '/Images/Uploads/2/2_20130626191218042_S.jpg', 6, 'Germany, NIkon, Lights, Passau, NIkon', 1, 0, 0, 0, 0),
	(8, 'Cathedral', NULL, '2013-06-26 22:58:07', 3, '/Images/Uploads/3/3_20130626225807631_L.jpg', '/Images/Uploads/3/3_20130626225807631_M.jpg', '/Images/Uploads/3/3_20130626225807631_S.jpg', 6, 'Church, Building, People, Nikon', 0, 0, 0, 0, 0),
	(9, 'Wein at night', NULL, '2013-06-26 23:04:28', 3, '/Images/Uploads/3/3_20130626230428860_L.jpg', '/Images/Uploads/3/3_20130626230428860_M.jpg', '/Images/Uploads/3/3_20130626230428860_S.jpg', 4, 'Night, Building, Light, black and white', 0, 0, 0, 0, 0),
	(10, 'Church in Berlin', NULL, '2013-06-26 23:05:49', 3, '/Images/Uploads/3/3_20130626230549830_L.jpg', '/Images/Uploads/3/3_20130626230549830_M.jpg', '/Images/Uploads/3/3_20130626230549830_S.jpg', 6, 'Church, River, Building, Nikon', 1, 0, 0, 0, 0),
	(11, 'Cloudy mountain', NULL, '2013-06-26 23:07:02', 3, '/Images/Uploads/3/3_20130626230702042_L.jpg', '/Images/Uploads/3/3_20130626230702042_M.jpg', '/Images/Uploads/3/3_20130626230702042_S.jpg', 17, 'Cloud, Mountain, Snow, Nikon', 0, 0, 0, 0, 0),
	(12, 'Highway', NULL, '2013-06-26 23:12:33', 3, '/Images/Uploads/3/3_20130626231233627_L.jpg', '/Images/Uploads/3/3_20130626231233627_M.jpg', '/Images/Uploads/3/3_20130626231233627_S.jpg', 20, 'LIghts, Streets, Moon, Night, Nikon', 0, 0, 0, 0, 0),
	(13, 'Morning walk with my dog', NULL, '2013-06-26 23:14:40', 4, '/Images/Uploads/4/4_20130626231440190_L.jpg', '/Images/Uploads/4/4_20130626231440190_M.jpg', '/Images/Uploads/4/4_20130626231440190_S.jpg', 18, 'Animals, Pets, People, Streets, Morning, Nikon', 1, 0, 0, 0, 0),
	(14, 'Church in Berlin', NULL, '2013-06-26 23:17:13', 4, '/Images/Uploads/4/4_20130626231713252_L.jpg', '/Images/Uploads/4/4_20130626231713252_M.jpg', '/Images/Uploads/4/4_20130626231713252_S.jpg', 6, 'Church, Snow, Trees, Winter, Nikon', 0, 0, 0, 0, 0),
	(15, 'HDR', NULL, '2013-06-26 23:18:31', 4, '/Images/Uploads/4/4_20130626231830947_L.jpg', '/Images/Uploads/4/4_20130626231830947_M.jpg', '/Images/Uploads/4/4_20130626231830947_S.jpg', 2, 'Landcape, People, HDR, Nikon', 1, 0, 0, 0, 0),
	(16, 'Close ups', NULL, '2013-06-26 23:25:11', 4, '/Images/Uploads/4/4_20130626232510886_L.jpg', '/Images/Uploads/4/4_20130626232510886_M.jpg', '/Images/Uploads/4/4_20130626232510886_S.jpg', 1, 'Flowers, Out of focus, Nikon', 0, 0, 0, 0, 0),
	(17, 'Sunset ', NULL, '2013-06-26 23:26:08', 4, '/Images/Uploads/4/4_20130626232607834_L.jpg', '/Images/Uploads/4/4_20130626232607834_M.jpg', '/Images/Uploads/4/4_20130626232607834_S.jpg', 17, 'Bridge, Sunset, Nature, Nikon', 3, 0, 0, 0, 0),
	(18, 'Backlight ', NULL, '2013-06-26 23:27:42', 5, '/Images/Uploads/5/5_20130626232741480_L.jpg', '/Images/Uploads/5/5_20130626232741480_M.jpg', '/Images/Uploads/5/5_20130626232741480_S.jpg', 2, 'Light, People, Darkness, Nikon', 1, 0, 0, 0, 0),
	(19, 'Stars', NULL, '2013-06-26 23:30:26', 5, '/Images/Uploads/5/5_20130626233025685_L.jpg', '/Images/Uploads/5/5_20130626233025685_M.jpg', '/Images/Uploads/5/5_20130626233025685_S.jpg', 2, 'Stars, Light, Streets, Nikon', 1, 0, 0, 0, 0),
	(20, 'Berlin HDR', NULL, '2013-06-26 23:31:26', 5, '/Images/Uploads/5/5_20130626233125965_L.jpg', '/Images/Uploads/5/5_20130626233125965_M.jpg', '/Images/Uploads/5/5_20130626233125965_S.jpg', 6, 'Lights, HDR, Streets, Night, Nikon', 2, 0, 0, 0, 0),
	(21, 'Wein at night', NULL, '2013-06-26 23:32:21', 5, '/Images/Uploads/5/5_20130626233220948_L.jpg', '/Images/Uploads/5/5_20130626233220948_M.jpg', '/Images/Uploads/5/5_20130626233220948_S.jpg', 6, 'Night, HDR, Lights, People, Streets, Nikon', 0, 0, 0, 0, 0),
	(22, 'HDR 2', NULL, '2013-06-26 23:33:21', 5, '/Images/Uploads/5/5_20130626233320936_L.jpg', '/Images/Uploads/5/5_20130626233320936_M.jpg', '/Images/Uploads/5/5_20130626233320936_S.jpg', 6, 'Berlin, HDR, Lights, Houses, Sony', 0, 0, 0, 0, 0),
	(23, 'Panaroma', NULL, '2013-06-26 23:35:12', 6, '/Images/Uploads/6/6_20130626233512215_L.jpg', '/Images/Uploads/6/6_20130626233512215_M.jpg', '/Images/Uploads/6/6_20130626233512215_S.jpg', 6, 'Lights, Buildings, Blue sky, Mountains', 7, 2, 3, 2, 7),
	(24, 'Landscape, Switzerland', NULL, '2013-06-26 23:36:17', 6, '/Images/Uploads/6/6_20130626233617692_L.jpg', '/Images/Uploads/6/6_20130626233617692_M.jpg', '/Images/Uploads/6/6_20130626233617692_S.jpg', 15, 'Building, Field, Trees, Nikon', 2, 1, 1, 1, 3),
	(25, 'Reflection', NULL, '2013-06-26 23:37:07', 6, '/Images/Uploads/6/6_20130626233707505_L.jpg', '/Images/Uploads/6/6_20130626233707505_M.jpg', '/Images/Uploads/6/6_20130626233707505_S.jpg', 3, 'Birds, reflection, water, Nikon', 0, 0, 0, 0, 0),
	(26, 'Cloudy moment', NULL, '2013-06-26 23:38:03', 6, '/Images/Uploads/6/6_20130626233802880_L.jpg', '/Images/Uploads/6/6_20130626233802880_M.jpg', '/Images/Uploads/6/6_20130626233802880_S.jpg', 17, 'Cloud, Boat, Lake, Houses, Nikon', 1, 0, 0, 0, 0),
	(27, 'Play ground', NULL, '2013-06-26 23:39:47', 6, '/Images/Uploads/6/6_20130626233946769_L.jpg', '/Images/Uploads/6/6_20130626233946769_M.jpg', '/Images/Uploads/6/6_20130626233946769_S.jpg', 6, 'Lights, Rolls, Lights, Streets, Nikon', 2, 1, 1, 1, 3),
	(28, 'Church', NULL, '2013-06-26 23:43:00', 7, '/Images/Uploads/7/7_20130626234300543_L.jpg', '/Images/Uploads/7/7_20130626234300543_M.jpg', '/Images/Uploads/7/7_20130626234300543_S.jpg', 6, 'Cars, People, Building, Street, Nikon', 3, 1, 1, 1, 3),
	(29, 'Landscape', NULL, '2013-06-26 23:44:12', 7, '/Images/Uploads/7/7_20130626234412493_L.jpg', '/Images/Uploads/7/7_20130626234412493_M.jpg', '/Images/Uploads/7/7_20130626234412493_S.jpg', 15, 'River, cloud, Trees, HDR, Sony', 2, 1, 1, 1, 3),
	(30, 'Christimas in Berlin', NULL, '2013-06-26 23:45:31', 7, '/Images/Uploads/7/7_20130626234531533_L.jpg', '/Images/Uploads/7/7_20130626234531533_M.jpg', '/Images/Uploads/7/7_20130626234531533_S.jpg', 20, 'Streets, People, Lights, Christimas', 1, 0, 0, 0, 0),
	(31, 'HDR 3', NULL, '2013-06-26 23:46:22', 7, '/Images/Uploads/7/7_20130626234622254_L.jpg', '/Images/Uploads/7/7_20130626234622254_M.jpg', '/Images/Uploads/7/7_20130626234622254_S.jpg', 6, 'Light, HDR, Sony', 8, 2, 2, 2, 6),
	(32, 'HDR4', NULL, '2013-06-26 23:50:27', 7, '/Images/Uploads/7/7_20130626235027286_L.jpg', '/Images/Uploads/7/7_20130626235027286_M.jpg', '/Images/Uploads/7/7_20130626235027286_S.jpg', 20, 'Light, HDR, reflection, Nikon', 1, 0, 0, 0, 0),
	(33, 'River with HDR', NULL, '2013-06-26 23:53:37', 8, '/Images/Uploads/8/8_20130626235336345_L.jpg', '/Images/Uploads/8/8_20130626235336345_M.jpg', '/Images/Uploads/8/8_20130626235336345_S.jpg', 17, 'HDR, River, House, Lights, Sony', 4, 0, 0, 0, 0),
	(34, 'Medium Shoot River HDR', NULL, '2013-06-26 23:54:47', 8, '/Images/Uploads/8/8_20130626235447150_L.jpg', '/Images/Uploads/8/8_20130626235447150_M.jpg', '/Images/Uploads/8/8_20130626235447150_S.jpg', 17, 'House, Stream, Lights, Sony', 2, 1, 1, 1, 3),
	(35, 'Cloudy  photo', NULL, '2013-06-26 23:55:38', 8, '/Images/Uploads/8/8_20130626235538204_L.jpg', '/Images/Uploads/8/8_20130626235538204_M.jpg', '/Images/Uploads/8/8_20130626235538204_S.jpg', 17, 'Cloud, HDR, Lake, Nikon', 0, 0, 0, 0, 0),
	(36, 'Sunshine', NULL, '2013-06-26 23:56:43', 8, '/Images/Uploads/8/8_20130626235643238_L.jpg', '/Images/Uploads/8/8_20130626235643238_M.jpg', '/Images/Uploads/8/8_20130626235643238_S.jpg', 17, 'Sunshine, LIghts, Morning, Nikon', 1, 0, 0, 0, 0),
	(37, 'Pandora Inn', NULL, '2013-06-26 23:59:43', 8, '/Images/Uploads/8/8_20130626235943015_L.jpg', '/Images/Uploads/8/8_20130626235943015_M.jpg', '/Images/Uploads/8/8_20130626235943015_S.jpg', 15, 'House, Streets, River, Afternoon,  Sony', 1, 0, 0, 0, 0),
	(38, 'Home sweet home', NULL, '2013-06-27 00:00:53', 8, '/Images/Uploads/8/8_20130627000053326_L.jpg', '/Images/Uploads/8/8_20130627000053326_M.jpg', '/Images/Uploads/8/8_20130627000053326_S.jpg', 1, 'Light, House, River, Nikon', 0, 0, 0, 0, 0),
	(39, 'HDR 4', NULL, '2013-06-27 00:02:19', 8, '/Images/Uploads/8/8_20130627000218881_L.jpg', '/Images/Uploads/8/8_20130627000218881_M.jpg', '/Images/Uploads/8/8_20130627000218881_S.jpg', 15, 'HDR, Lights, Lake, Night, Sony', 2, 0, 0, 0, 0),
	(40, 'Greeny Light', NULL, '2013-06-27 00:03:36', 8, '/Images/Uploads/8/8_20130627000336078_L.jpg', '/Images/Uploads/8/8_20130627000336078_M.jpg', '/Images/Uploads/8/8_20130627000336078_S.jpg', 2, 'Lights, reflection, HDR, Water', 4, 0, 0, 0, 0),
	(41, 'City from the top', NULL, '2013-06-27 00:06:24', 9, '/Images/Uploads/9/9_20130627000623714_L.jpg', '/Images/Uploads/9/9_20130627000623714_M.jpg', '/Images/Uploads/9/9_20130627000623714_S.jpg', 6, 'Snow, Cloud, City, Building', 2, 0, 0, 0, 0),
	(42, 'Wondering', NULL, '2013-06-27 00:07:47', 9, '/Images/Uploads/9/9_20130627000747246_L.jpg', '/Images/Uploads/9/9_20130627000747246_M.jpg', '/Images/Uploads/9/9_20130627000747246_S.jpg', 18, 'People, city, cloud, Evening, Nikon', 3, 0, 0, 0, 0),
	(43, 'City highway', NULL, '2013-06-27 00:08:39', 9, '/Images/Uploads/9/9_20130627000838533_L.jpg', '/Images/Uploads/9/9_20130627000838533_M.jpg', '/Images/Uploads/9/9_20130627000838533_S.jpg', 20, 'Cars, streets, highway, lights', 0, 0, 0, 0, 0),
	(44, 'Berlin Streets', NULL, '2013-06-27 00:09:44', 9, '/Images/Uploads/9/9_20130627000944085_L.jpg', '/Images/Uploads/9/9_20130627000944085_M.jpg', '/Images/Uploads/9/9_20130627000944085_S.jpg', 20, 'Building, Light, Nikon', 3, 0, 0, 0, 0),
	(45, 'Streets of Berlin', NULL, '2013-06-27 00:12:39', 9, '/Images/Uploads/9/9_20130627001238540_L.jpg', '/Images/Uploads/9/9_20130627001238540_M.jpg', '/Images/Uploads/9/9_20130627001238540_S.jpg', 20, 'Light, Building, snow, Nikon', 4, 1, 1, 1, 3),
	(46, 'Snowdrift', NULL, '2013-06-27 00:13:49', 9, '/Images/Uploads/9/9_20130627001349193_L.jpg', '/Images/Uploads/9/9_20130627001349193_M.jpg', '/Images/Uploads/9/9_20130627001349193_S.jpg', 17, 'Snow, Trees, Streets, Sony', 2, 1, 1, 0, 2),
	(47, 'Landscape, Switzerland', NULL, '2013-06-27 00:15:46', 9, '/Images/Uploads/9/9_20130627001546533_L.jpg', '/Images/Uploads/9/9_20130627001546533_M.jpg', '/Images/Uploads/9/9_20130627001546533_S.jpg', 15, 'houses, landscape, Mountain, Nikon', 16, 2, 2, 2, 6),
	(48, 'X mountain', NULL, '2013-06-27 00:16:44', 9, '/Images/Uploads/9/9_20130627001644282_L.jpg', '/Images/Uploads/9/9_20130627001644282_M.jpg', '/Images/Uploads/9/9_20130627001644282_S.jpg', 17, 'cloud, sky, mountain, landscape', 2, 0, 0, 0, 0),
	(49, 'Streets, Switzerland', NULL, '2013-06-27 00:17:51', 9, '/Images/Uploads/9/9_20130627001751007_L.jpg', '/Images/Uploads/9/9_20130627001751007_M.jpg', '/Images/Uploads/9/9_20130627001751007_S.jpg', 20, 'Switzerland, streets, Houses, Nikon', 8, 0, 0, 0, 0),
	(50, 'The house below', NULL, '2013-06-27 00:20:57', 10, '/Images/Uploads/10/10_20130627002057223_L.jpg', '/Images/Uploads/10/10_20130627002057223_M.jpg', '/Images/Uploads/10/10_20130627002057223_S.jpg', 15, 'Mountain, house, Nikon', 1, 0, 0, 0, 0),
	(51, 'Mountainous', NULL, '2013-06-27 00:22:02', 10, '/Images/Uploads/10/10_20130627002202059_L.jpg', '/Images/Uploads/10/10_20130627002202059_M.jpg', '/Images/Uploads/10/10_20130627002202059_S.jpg', 17, 'Cloud, Mountain, Sony', 4, 1, 1, 1, 3),
	(52, 'XXX', NULL, '2013-06-27 01:09:02', 4, '/Images/Uploads/4/4_20130627010902259_L.jpg', '/Images/Uploads/4/4_20130627010902259_M.jpg', '/Images/Uploads/4/4_20130627010902259_S.jpg', 18, 'People, Nikon', 4, 0, 0, 0, 0),
	(54, 'Stuttgart Schloss', NULL, '2013-06-27 08:47:55', 11, '/Images/Uploads/11/11_20130627084754574_L.jpg', '/Images/Uploads/11/11_20130627084754574_M.jpg', '/Images/Uploads/11/11_20130627084754574_S.jpg', 6, 'Night, Black and white, Palace, Stuttgart, Schloss, Germany', 1, 0, 0, 0, 0),
	(55, 'Misty walk', NULL, '2013-06-27 08:49:18', 11, '/Images/Uploads/11/11_20130627084917846_L.jpg', '/Images/Uploads/11/11_20130627084917846_M.jpg', '/Images/Uploads/11/11_20130627084917846_S.jpg', 18, 'Black and white, people, walk, misty, fog, forest', 0, 0, 0, 0, 0),
	(56, 'couple', NULL, '2013-06-27 08:49:55', 11, '/Images/Uploads/11/11_20130627084954121_L.jpg', '/Images/Uploads/11/11_20130627084954121_M.jpg', '/Images/Uploads/11/11_20130627084954121_S.jpg', 18, 'couple, people, nikon, d7000, black and white', 10, 2, 2, 2, 6),
	(57, 'Early Spring', NULL, '2013-06-27 08:50:34', 11, '/Images/Uploads/11/11_20130627085033053_L.jpg', '/Images/Uploads/11/11_20130627085033053_M.jpg', '/Images/Uploads/11/11_20130627085033053_S.jpg', 17, 'flower, snow, nikon, d7000, spring', 0, 0, 0, 0, 0),
	(58, 'Fog over Passau', NULL, '2013-06-27 08:51:31', 11, '/Images/Uploads/11/11_20130627085130762_L.jpg', '/Images/Uploads/11/11_20130627085130762_M.jpg', '/Images/Uploads/11/11_20130627085130762_S.jpg', 15, 'Forest, Fog, Nikon', 2, 1, 2, 1, 4),
	(59, 'golden colors', NULL, '2013-06-27 08:52:46', 11, '/Images/Uploads/11/11_20130627085245822_L.jpg', '/Images/Uploads/11/11_20130627085245822_M.jpg', '/Images/Uploads/11/11_20130627085245822_S.jpg', 15, 'sunset, golden hour, green, nikon, HDR', 8, 2, 3, 2, 7),
	(60, 'Heidelberg Castle', NULL, '2013-06-27 08:53:30', 11, '/Images/Uploads/11/11_20130627085330058_L.jpg', '/Images/Uploads/11/11_20130627085330058_M.jpg', '/Images/Uploads/11/11_20130627085330058_S.jpg', 15, 'Heidelberg, Germany, Nikon, HDR, Castle', 3, 1, 1, 1, 3),
	(61, 'Stuutagrt Night life', NULL, '2013-06-27 08:54:57', 11, '/Images/Uploads/11/11_20130627085457147_L.jpg', '/Images/Uploads/11/11_20130627085457147_M.jpg', '/Images/Uploads/11/11_20130627085457147_S.jpg', 20, 'Stuttgart, germany, nikon, d7000, HDR, Street, Lights', 3, 1, 1, 1, 3),
	(62, 'Silhoutte', NULL, '2013-06-27 08:56:02', 11, '/Images/Uploads/11/11_20130627085602250_L.jpg', '/Images/Uploads/11/11_20130627085602250_M.jpg', '/Images/Uploads/11/11_20130627085602250_S.jpg', 18, 'dark, room, indoor, self-portrait, sony, nex3', 1, 0, 0, 0, 0),
	(63, 'sunset', NULL, '2013-06-27 12:21:50', 11, '/Images/Uploads/11/11_20130627122144340_L.jpg', '/Images/Uploads/11/11_20130627122144340_M.jpg', '/Images/Uploads/11/11_20130627122144340_S.jpg', 15, 'test, nikon, sunset', 0, 0, 0, 0, 0),
	(64, 'sunset', NULL, '2013-06-27 12:22:49', 11, '/Images/Uploads/11/11_20130627122248824_L.jpg', '/Images/Uploads/11/11_20130627122248824_M.jpg', '/Images/Uploads/11/11_20130627122248824_S.jpg', 15, 'sunset, stuttgart', 0, 0, 0, 0, 0),
	(65, 'asd', 'asd', '2013-06-27 12:31:52', 12, '/Images/Uploads/12/12_20130627123151902_L.JPG', '/Images/Uploads/12/12_20130627123151902_M.JPG', '/Images/Uploads/12/12_20130627123151902_S.JPG', 17, 'asdasd', 0, 0, 0, 0, 0),
	(66, 'ds', 'sad', '2013-06-27 15:35:43', 11, '/Images/Uploads/11/11_20130627153542131_L.jpg', '/Images/Uploads/11/11_20130627153542131_M.jpg', '/Images/Uploads/11/11_20130627153542131_S.jpg', 17, 'sadsa, sfsd', 0, 0, 0, 0, 0);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;


-- Dumping structure for table photoshare.photo_comments
DROP TABLE IF EXISTS `photo_comments`;
CREATE TABLE IF NOT EXISTS `photo_comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `comment_id` int(10) NOT NULL,
  `photo_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_photo_comments_photos` (`photo_id`),
  KEY `FK_photo_comments_comments` (`comment_id`),
  CONSTRAINT `FK_photo_comments_comments` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_photo_comments_photos` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.photo_comments: ~26 rows (approximately)
/*!40000 ALTER TABLE `photo_comments` DISABLE KEYS */;
INSERT INTO `photo_comments` (`id`, `comment_id`, `photo_id`) VALUES
	(33, 33, 47),
	(34, 34, 58),
	(35, 35, 45),
	(36, 36, 59),
	(37, 37, 46),
	(38, 38, 31),
	(39, 39, 27),
	(40, 40, 28),
	(41, 41, 24),
	(42, 42, 23),
	(43, 43, 47),
	(44, 44, 31),
	(45, 45, 61),
	(46, 46, 58),
	(47, 47, 59),
	(48, 48, 56),
	(49, 49, 34),
	(50, 50, 29),
	(51, 51, 59),
	(52, 52, 56),
	(53, 53, 60),
	(54, 54, 23),
	(56, 59, 2),
	(57, 60, 2),
	(58, 61, 51),
	(59, 62, 23);
/*!40000 ALTER TABLE `photo_comments` ENABLE KEYS */;


-- Dumping structure for table photoshare.sets
DROP TABLE IF EXISTS `sets`;
CREATE TABLE IF NOT EXISTS `sets` (
  `set_id` int(10) NOT NULL AUTO_INCREMENT,
  `collection_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`set_id`),
  KEY `FK__collection_set` (`collection_id`),
  CONSTRAINT `FK__collection_set` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`collection_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.sets: ~22 rows (approximately)
/*!40000 ALTER TABLE `sets` DISABLE KEYS */;
INSERT INTO `sets` (`set_id`, `collection_id`) VALUES
	(1, 7),
	(2, 8),
	(4, 10),
	(6, 12),
	(7, 13),
	(9, 15),
	(10, 16),
	(11, 17),
	(12, 18),
	(13, 19),
	(14, 37),
	(15, 38),
	(16, 40),
	(17, 43),
	(18, 44),
	(19, 45),
	(22, 51),
	(23, 63),
	(24, 64),
	(25, 65),
	(26, 66),
	(27, 70);
/*!40000 ALTER TABLE `sets` ENABLE KEYS */;


-- Dumping structure for procedure photoshare.spPhotoDelete
DROP PROCEDURE IF EXISTS `spPhotoDelete`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `spPhotoDelete`(IN `photoId` INT)
BEGIN
	DECLARE commentId INT;
	DECLARE no_rows BOOL;
	DECLARE curComments CURSOR FOR
		SELECT C.comment_id FROM comments AS C INNER JOIN photo_comments AS PC ON C.comment_id = PC.comment_id WHERE PC.photo_id = photoId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_rows = TRUE;
	
	START TRANSACTION;
	
 	-- delete exif_data
	DELETE FROM exif_data WHERE photo_id = photoId;
	 
	 	-- delete favorites
	DELETE FROM favorites WHERE photo_id = photoId;
	 
	 	-- delete from likes
	DELETE FROM likes WHERE photo_id = photoId;
	
	 -- delete from collections
	 DELETE FROM collection_photos WHERE photo_id = photoId;

	 	-- delete from comments
	 	-- need to use cursor
	 OPEN curComments;	 
		 cmt_loop: LOOP
		 
			 IF no_rows THEN
	        CLOSE curComments;
	        LEAVE cmt_loop;
		    END IF; 
	 	
	 
			FETCH curComments INTO commentId;
			DELETE FROM comments WHERE comment_id = commentId;	 
	 	 END LOOP cmt_loop;	
	
	-- delete main photo object
	DELETE FROM photos WHERE id = photoId;
		
	COMMIT;
END//
DELIMITER ;


-- Dumping structure for table photoshare.stories
DROP TABLE IF EXISTS `stories`;
CREATE TABLE IF NOT EXISTS `stories` (
  `story_id` int(10) NOT NULL AUTO_INCREMENT,
  `collection_id` int(10) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `tags` text,
  PRIMARY KEY (`story_id`),
  KEY `FK__collection` (`collection_id`),
  FULLTEXT KEY `tags` (`tags`),
  CONSTRAINT `FK__collection` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`collection_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.stories: ~19 rows (approximately)
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` (`story_id`, `collection_id`, `description`, `tags`) VALUES
	(1, 4, 'This photo was taking early Sunday morning with my dog. ', 'dog, People, Nikon'),
	(3, 6, 'eeeiejieiejei eiee', ''),
	(4, 20, 'Holiday Dreams lighting display. The new energy efficient L.E.D. lights were being promoted for the first time at the display.\r\nMy seventh Christmas card photo to friends and family.', 'Holiday, Lights, Nikon'),
	(5, 21, 'I did a stitch of 9 photos of that very scene using Johnno\'s 35/1.4 It came out quite nicely, but I haven\'t bothered to post it as I unfortunately didn\'t align the top and bottom rows of images and thus it\'s not rectangular.', ''),
	(6, 22, ' Landscape design and landscaping is influenced by many NZ iconic landscape features.', ''),
	(8, 24, 'Monday January 18th 2010\r\n\r\nCraig and I arrived back from holiday on Monday...\r\nAfter an 18 hour trip from Las Vegas...\r\nWe left Vegas 6pm Saturday...\r\nAnd touched down in Auckland @ 9am Monday morning....\r\nWhere on earth did Sunday go....?\r\nSure felt like a 2 day trip by the time we got home! LOL!!! %-)', ''),
	(9, 25, 'Here I was just wondering about nature.', 'People, nature, sky, Cloud'),
	(10, 26, 'This photo was taken in one of the busiest streets of Berlin', 'Streets, Berlin, Nikon'),
	(12, 28, ' This trail begin from the Carosello 3000 and descend trough the Federia Valley untill Livigno .', 'Mountain, Nikon'),
	(13, 35, 'Budgerigars, more commonly known as Budgies or Parakeets, are ideal pets both for first time bird owners and those who would just prefer a small bird. True to the typical traits of most parrots, Parakeets have the ability to learn to talk, come in an array of beautiful colors, and enjoy forming close bonds and interacting with their human caretakers. Those who are interested in a small, easy to care for pet should place these birds among their top choices.', 'Bird, Nikon'),
	(14, 36, 'Berlin is one of the most beautiful cities in the world. ', 'Berlin, city, light, HDR'),
	(15, 39, 'This photo is the best panorama type I have ever taken.', ''),
	(16, 42, 'By mid 1920, the need was felt for a new church to be built near the port, in the South Western part of Berline. The area had a growing population, though being still rural and there was a number of Hokkien speaking Catholics to be taken care of. ', 'Church, street, history, NIkon'),
	(17, 46, 'I like back light photos.', ''),
	(18, 48, 'There is no place like home...................................................', 'Nikon, home, house'),
	(20, 54, 'Hi i want to share some pictures i took during my recent trip to passau.\r\n\r\nEnjoy !', 'Passau, Germany, Nikon, D7000'),
	(24, 58, 'I have been interested in black and white photography. Here are some of my first attempt at shooting monochrome', ''),
	(29, 68, 'Here are some of the pictures of my howntown, Passsau.\r\n\r\nPassau is a town in Lower Bavaria, Germany. It is also known as the Dreiflüssestadt or "City of Three Rivers," because the Danube is joined at Passau by the Inn from the south and the Ilz from the north.', ''),
	(30, 69, 'a test description', 'test');
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;


-- Dumping structure for table photoshare.story_comments
DROP TABLE IF EXISTS `story_comments`;
CREATE TABLE IF NOT EXISTS `story_comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `comment_id` int(10) NOT NULL DEFAULT '0',
  `story_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK__comments` (`comment_id`),
  KEY `FK__stories` (`story_id`),
  CONSTRAINT `FK__comments` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`),
  CONSTRAINT `FK__stories` FOREIGN KEY (`story_id`) REFERENCES `stories` (`story_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.story_comments: ~2 rows (approximately)
/*!40000 ALTER TABLE `story_comments` DISABLE KEYS */;
INSERT INTO `story_comments` (`id`, `comment_id`, `story_id`) VALUES
	(1, 56, 20),
	(2, 57, 1),
	(3, 58, 4);
/*!40000 ALTER TABLE `story_comments` ENABLE KEYS */;


-- Dumping structure for table photoshare.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(200) DEFAULT NULL,
  `about` text,
  `gender` enum('Male','Female','Unspecified') NOT NULL DEFAULT 'Unspecified',
  `city` varchar(200) DEFAULT NULL,
  `country` varchar(200) DEFAULT NULL,
  `profile_photo` varchar(250) DEFAULT NULL,
  `membership_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_membership` (`membership_id`),
  FULLTEXT KEY `first_name` (`first_name`),
  FULLTEXT KEY `last_name` (`last_name`),
  CONSTRAINT `FK_users_membership` FOREIGN KEY (`membership_id`) REFERENCES `membership` (`membership_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.users: ~10 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `first_name`, `last_name`, `about`, `gender`, `city`, `country`, `profile_photo`, `membership_id`) VALUES
	(1, 'Helen', 'Bane', NULL, 'Female', 'Stuttgart', 'German', NULL, 1),
	(2, 'Jhone', 'Hawk', NULL, 'Male', 'Newyork', 'USA', NULL, 2),
	(3, 'Jhone', 'Eric', NULL, 'Male', 'London', 'UK', NULL, 3),
	(4, 'Samri ', 'Tewelde', NULL, 'Unspecified', 'Addis Abeba', 'Ethiopia', NULL, 4),
	(5, 'Samuel ', 'Jackson', NULL, 'Male', 'Chicago', 'USA', NULL, 5),
	(6, 'Steve', 'Martin', NULL, 'Male', 'Australia', 'Sydny', NULL, 6),
	(7, 'Alan', 'Smith', NULL, 'Male', 'Copenhagen', 'Denmark', NULL, 7),
	(8, 'Tome', 'Hanks', NULL, 'Male', 'eeeeeere', 'eere', NULL, 8),
	(9, NULL, NULL, NULL, 'Unspecified', NULL, NULL, NULL, 9),
	(10, NULL, NULL, NULL, 'Unspecified', NULL, NULL, NULL, 10),
	(11, 'Suman', 'Shakya', 'Student, Amateur photographer', 'Male', 'Stuttgart', 'Germany', '/Images/Profile/11_Shakya_S.jpg', 11),
	(12, NULL, NULL, NULL, 'Unspecified', NULL, NULL, NULL, 12);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


-- Dumping structure for table photoshare.user_activity
DROP TABLE IF EXISTS `user_activity`;
CREATE TABLE IF NOT EXISTS `user_activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0',
  `change_type` enum('NEWPHOTO','COMMENT','LIKED','FAV') NOT NULL,
  `activity_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `photo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_user_idx` (`user_id`),
  KEY `fk_activity_photo_idx` (`photo_id`),
  CONSTRAINT `fk_activity_photo` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;

-- Dumping data for table photoshare.user_activity: ~198 rows (approximately)
/*!40000 ALTER TABLE `user_activity` DISABLE KEYS */;
INSERT INTO `user_activity` (`id`, `user_id`, `change_type`, `activity_time`, `photo_id`) VALUES
	(1, 1, 'NEWPHOTO', '2013-06-26 18:45:04', 1),
	(2, 1, 'NEWPHOTO', '2013-06-26 18:47:28', 2),
	(3, 1, 'NEWPHOTO', '2013-06-26 18:48:55', 3),
	(4, 1, 'NEWPHOTO', '2013-06-26 18:50:22', 4),
	(5, 2, 'NEWPHOTO', '2013-06-26 18:56:10', 5),
	(6, 2, 'NEWPHOTO', '2013-06-26 18:59:24', 6),
	(7, 2, 'NEWPHOTO', '2013-06-26 19:12:18', 7),
	(8, 3, 'NEWPHOTO', '2013-06-26 22:58:07', 8),
	(9, 3, 'NEWPHOTO', '2013-06-26 23:04:28', 9),
	(10, 3, 'NEWPHOTO', '2013-06-26 23:05:49', 10),
	(11, 3, 'NEWPHOTO', '2013-06-26 23:07:02', 11),
	(12, 3, 'NEWPHOTO', '2013-06-26 23:12:33', 12),
	(13, 4, 'NEWPHOTO', '2013-06-26 23:14:40', 13),
	(14, 4, 'NEWPHOTO', '2013-06-26 23:17:13', 14),
	(15, 4, 'NEWPHOTO', '2013-06-26 23:18:31', 15),
	(16, 4, 'NEWPHOTO', '2013-06-26 23:25:11', 16),
	(17, 4, 'NEWPHOTO', '2013-06-26 23:26:08', 17),
	(18, 5, 'NEWPHOTO', '2013-06-26 23:27:42', 18),
	(19, 5, 'NEWPHOTO', '2013-06-26 23:30:26', 19),
	(20, 5, 'NEWPHOTO', '2013-06-26 23:31:26', 20),
	(21, 5, 'NEWPHOTO', '2013-06-26 23:32:21', 21),
	(22, 5, 'NEWPHOTO', '2013-06-26 23:33:21', 22),
	(23, 6, 'NEWPHOTO', '2013-06-26 23:35:12', 23),
	(24, 6, 'NEWPHOTO', '2013-06-26 23:36:17', 24),
	(25, 6, 'NEWPHOTO', '2013-06-26 23:37:07', 25),
	(26, 6, 'NEWPHOTO', '2013-06-26 23:38:03', 26),
	(27, 6, 'NEWPHOTO', '2013-06-26 23:39:47', 27),
	(28, 7, 'NEWPHOTO', '2013-06-26 23:43:00', 28),
	(29, 7, 'NEWPHOTO', '2013-06-26 23:44:12', 29),
	(30, 7, 'NEWPHOTO', '2013-06-26 23:45:31', 30),
	(31, 7, 'NEWPHOTO', '2013-06-26 23:46:22', 31),
	(32, 7, 'NEWPHOTO', '2013-06-26 23:50:27', 32),
	(33, 8, 'NEWPHOTO', '2013-06-26 23:53:37', 33),
	(34, 8, 'NEWPHOTO', '2013-06-26 23:54:47', 34),
	(35, 8, 'NEWPHOTO', '2013-06-26 23:55:38', 35),
	(36, 8, 'NEWPHOTO', '2013-06-26 23:56:43', 36),
	(37, 8, 'NEWPHOTO', '2013-06-26 23:59:43', 37),
	(38, 8, 'NEWPHOTO', '2013-06-27 00:00:53', 38),
	(39, 8, 'NEWPHOTO', '2013-06-27 00:02:19', 39),
	(40, 8, 'NEWPHOTO', '2013-06-27 00:03:36', 40),
	(41, 9, 'NEWPHOTO', '2013-06-27 00:06:24', 41),
	(42, 9, 'NEWPHOTO', '2013-06-27 00:07:47', 42),
	(43, 9, 'NEWPHOTO', '2013-06-27 00:08:39', 43),
	(44, 9, 'NEWPHOTO', '2013-06-27 00:09:44', 44),
	(45, 9, 'NEWPHOTO', '2013-06-27 00:12:39', 45),
	(46, 9, 'NEWPHOTO', '2013-06-27 00:13:49', 46),
	(47, 9, 'NEWPHOTO', '2013-06-27 00:15:46', 47),
	(48, 9, 'NEWPHOTO', '2013-06-27 00:16:44', 48),
	(49, 9, 'NEWPHOTO', '2013-06-27 00:17:51', 49),
	(50, 10, 'NEWPHOTO', '2013-06-27 00:20:57', 50),
	(51, 10, 'NEWPHOTO', '2013-06-27 00:22:02', 51),
	(52, 10, 'FAV', '2013-06-27 00:25:45', 31),
	(53, 10, 'LIKED', '2013-06-27 00:25:58', 31),
	(54, 10, 'LIKED', '2013-06-27 00:26:38', 46),
	(55, 10, 'FAV', '2013-06-27 00:26:41', 46),
	(56, 10, 'COMMENT', '2013-06-27 00:28:34', 46),
	(57, 1, 'COMMENT', '2013-06-27 00:30:00', 45),
	(58, 1, 'LIKED', '2013-06-27 00:30:05', 45),
	(59, 1, 'FAV', '2013-06-27 00:30:09', 45),
	(60, 1, 'COMMENT', '2013-06-27 00:31:15', 40),
	(61, 1, 'LIKED', '2013-06-27 00:31:21', 40),
	(62, 1, 'FAV', '2013-06-27 00:31:25', 40),
	(63, 1, 'COMMENT', '2013-06-27 00:32:14', 40),
	(64, 5, 'COMMENT', '2013-06-27 00:33:35', 47),
	(65, 5, 'LIKED', '2013-06-27 00:33:38', 47),
	(66, 5, 'FAV', '2013-06-27 00:33:42', 47),
	(67, 5, 'COMMENT', '2013-06-27 00:34:28', 41),
	(68, 5, 'COMMENT', '2013-06-27 00:34:31', 41),
	(69, 5, 'LIKED', '2013-06-27 00:34:41', 41),
	(70, 5, 'COMMENT', '2013-06-27 00:36:12', 31),
	(71, 5, 'LIKED', '2013-06-27 00:36:14', 31),
	(72, 5, 'FAV', '2013-06-27 00:36:17', 31),
	(73, 5, 'LIKED', '2013-06-27 00:36:48', 40),
	(74, 5, 'COMMENT', '2013-06-27 00:37:18', 40),
	(75, 5, 'FAV', '2013-06-27 00:37:32', 40),
	(76, 5, 'COMMENT', '2013-06-27 00:38:27', 33),
	(77, 5, 'LIKED', '2013-06-27 00:38:29', 33),
	(78, 5, 'FAV', '2013-06-27 00:38:32', 33),
	(79, 7, 'LIKED', '2013-06-27 00:39:11', 40),
	(80, 7, 'FAV', '2013-06-27 00:39:14', 40),
	(81, 7, 'COMMENT', '2013-06-27 00:39:52', 40),
	(82, 7, 'COMMENT', '2013-06-27 00:40:34', 20),
	(83, 7, 'LIKED', '2013-06-27 00:40:37', 20),
	(84, 7, 'FAV', '2013-06-27 00:40:41', 20),
	(85, 7, 'LIKED', '2013-06-27 00:42:30', 17),
	(86, 7, 'FAV', '2013-06-27 00:42:33', 17),
	(87, 7, 'COMMENT', '2013-06-27 00:42:59', 17),
	(88, 7, 'LIKED', '2013-06-27 00:44:34', 48),
	(89, 7, 'FAV', '2013-06-27 00:44:37', 48),
	(90, 7, 'COMMENT', '2013-06-27 00:44:54', 48),
	(91, 10, 'LIKED', '2013-06-27 00:48:38', 49),
	(92, 10, 'FAV', '2013-06-27 00:48:42', 49),
	(93, 10, 'COMMENT', '2013-06-27 00:49:01', 49),
	(94, 10, 'LIKED', '2013-06-27 00:49:18', 42),
	(95, 10, 'FAV', '2013-06-27 00:49:22', 42),
	(96, 10, 'COMMENT', '2013-06-27 00:49:52', 42),
	(97, 10, 'LIKED', '2013-06-27 00:50:21', 29),
	(98, 10, 'FAV', '2013-06-27 00:50:24', 29),
	(99, 10, 'COMMENT', '2013-06-27 00:50:45', 29),
	(100, 10, 'COMMENT', '2013-06-27 00:52:18', 32),
	(101, 10, 'LIKED', '2013-06-27 00:52:20', 32),
	(102, 10, 'FAV', '2013-06-27 00:52:23', 32),
	(103, 10, 'COMMENT', '2013-06-27 00:54:50', 30),
	(104, 10, 'LIKED', '2013-06-27 00:54:54', 30),
	(105, 10, 'FAV', '2013-06-27 00:54:57', 30),
	(106, 10, 'LIKED', '2013-06-27 00:55:22', 33),
	(107, 10, 'FAV', '2013-06-27 00:55:25', 33),
	(108, 10, 'COMMENT', '2013-06-27 00:55:57', 33),
	(109, 10, 'COMMENT', '2013-06-27 00:56:01', 33),
	(110, 10, 'LIKED', '2013-06-27 00:56:25', 39),
	(111, 10, 'FAV', '2013-06-27 00:56:28', 39),
	(112, 10, 'COMMENT', '2013-06-27 00:56:53', 39),
	(113, 10, 'COMMENT', '2013-06-27 00:58:11', 37),
	(114, 10, 'COMMENT', '2013-06-27 00:59:08', 44),
	(115, 10, 'LIKED', '2013-06-27 00:59:10', 44),
	(116, 10, 'FAV', '2013-06-27 00:59:13', 44),
	(117, 10, 'COMMENT', '2013-06-27 01:00:01', 20),
	(118, 10, 'FAV', '2013-06-27 01:00:06', 20),
	(119, 10, 'COMMENT', '2013-06-27 01:00:43', 36),
	(120, 10, 'LIKED', '2013-06-27 01:00:49', 36),
	(121, 4, 'COMMENT', '2013-06-27 01:02:07', 44),
	(122, 4, 'LIKED', '2013-06-27 01:02:09', 44),
	(123, 4, 'FAV', '2013-06-27 01:02:12', 44),
	(124, 4, 'LIKED', '2013-06-27 01:02:37', 47),
	(125, 4, 'FAV', '2013-06-27 01:02:40', 47),
	(126, 4, 'COMMENT', '2013-06-27 01:03:00', 47),
	(127, 4, 'COMMENT', '2013-06-27 01:03:40', 48),
	(128, 4, 'LIKED', '2013-06-27 01:03:44', 48),
	(129, 4, 'NEWPHOTO', '2013-06-27 01:09:02', 52),
	(130, 2, 'FAV', '2013-06-27 02:19:08', 52),
	(131, 2, 'LIKED', '2013-06-27 02:19:12', 52),
	(132, 2, 'COMMENT', '2013-06-27 02:19:29', 52),
	(133, 3, 'LIKED', '2013-06-27 02:24:21', 45),
	(134, 3, 'FAV', '2013-06-27 02:24:24', 45),
	(135, 3, 'COMMENT', '2013-06-27 02:24:56', 45),
	(136, 6, 'FAV', '2013-06-27 02:34:39', 49),
	(137, 6, 'COMMENT', '2013-06-27 02:35:04', 49),
	(138, 8, 'LIKED', '2013-06-27 02:43:43', 31),
	(139, 8, 'FAV', '2013-06-27 02:43:47', 31),
	(141, 11, 'NEWPHOTO', '2013-06-27 08:47:55', 54),
	(142, 11, 'NEWPHOTO', '2013-06-27 08:49:18', 55),
	(143, 11, 'NEWPHOTO', '2013-06-27 08:49:55', 56),
	(144, 11, 'NEWPHOTO', '2013-06-27 08:50:34', 57),
	(145, 11, 'NEWPHOTO', '2013-06-27 08:51:31', 58),
	(146, 11, 'NEWPHOTO', '2013-06-27 08:52:46', 59),
	(147, 11, 'NEWPHOTO', '2013-06-27 08:53:30', 60),
	(148, 11, 'NEWPHOTO', '2013-06-27 08:54:57', 61),
	(149, 11, 'NEWPHOTO', '2013-06-27 08:56:02', 62),
	(150, 11, 'FAV', '2013-06-27 09:24:26', 47),
	(151, 11, 'COMMENT', '2013-06-27 09:31:16', 47),
	(152, 11, 'FAV', '2013-06-27 09:32:41', 47),
	(153, 11, 'LIKED', '2013-06-27 09:32:43', 47),
	(154, 11, 'COMMENT', '2013-06-27 09:41:20', 58),
	(155, 11, 'COMMENT', '2013-06-27 09:42:16', 45),
	(156, 11, 'LIKED', '2013-06-27 09:42:22', 45),
	(157, 11, 'FAV', '2013-06-27 09:42:26', 45),
	(158, 11, 'COMMENT', '2013-06-27 09:42:57', 59),
	(159, 11, 'COMMENT', '2013-06-27 09:43:47', 46),
	(160, 11, 'LIKED', '2013-06-27 09:43:51', 46),
	(161, 11, 'COMMENT', '2013-06-27 09:45:21', 31),
	(162, 11, 'FAV', '2013-06-27 09:45:24', 31),
	(163, 11, 'LIKED', '2013-06-27 09:45:26', 31),
	(164, 11, 'FAV', '2013-06-27 09:45:31', 27),
	(165, 11, 'LIKED', '2013-06-27 09:45:35', 27),
	(166, 11, 'COMMENT', '2013-06-27 09:45:49', 27),
	(167, 11, 'FAV', '2013-06-27 09:45:58', 28),
	(168, 11, 'LIKED', '2013-06-27 09:46:00', 28),
	(169, 11, 'COMMENT', '2013-06-27 09:46:16', 28),
	(170, 11, 'FAV', '2013-06-27 09:46:22', 24),
	(171, 11, 'LIKED', '2013-06-27 09:46:24', 24),
	(172, 11, 'COMMENT', '2013-06-27 09:46:36', 24),
	(173, 11, 'FAV', '2013-06-27 09:47:15', 23),
	(174, 11, 'LIKED', '2013-06-27 09:47:16', 23),
	(175, 11, 'COMMENT', '2013-06-27 09:47:41', 23),
	(176, 1, 'FAV', '2013-06-27 09:50:06', 47),
	(177, 1, 'LIKED', '2013-06-27 09:50:09', 47),
	(178, 1, 'COMMENT', '2013-06-27 09:50:21', 47),
	(179, 1, 'FAV', '2013-06-27 09:50:35', 31),
	(180, 1, 'LIKED', '2013-06-27 09:50:38', 31),
	(181, 1, 'COMMENT', '2013-06-27 09:50:59', 31),
	(182, 1, 'FAV', '2013-06-27 09:51:06', 61),
	(183, 1, 'LIKED', '2013-06-27 09:51:08', 61),
	(184, 1, 'COMMENT', '2013-06-27 09:51:29', 61),
	(185, 1, 'FAV', '2013-06-27 09:51:34', 58),
	(186, 1, 'LIKED', '2013-06-27 09:51:40', 58),
	(187, 1, 'COMMENT', '2013-06-27 09:51:58', 58),
	(188, 1, 'FAV', '2013-06-27 09:52:04', 59),
	(189, 1, 'LIKED', '2013-06-27 09:52:05', 59),
	(190, 1, 'COMMENT', '2013-06-27 09:52:29', 59),
	(191, 1, 'FAV', '2013-06-27 09:52:37', 56),
	(192, 1, 'LIKED', '2013-06-27 09:52:40', 56),
	(193, 1, 'COMMENT', '2013-06-27 09:52:46', 56),
	(194, 1, 'COMMENT', '2013-06-27 09:53:23', 34),
	(195, 1, 'FAV', '2013-06-27 09:53:27', 34),
	(196, 1, 'LIKED', '2013-06-27 09:53:30', 34),
	(197, 1, 'FAV', '2013-06-27 09:53:37', 29),
	(198, 1, 'LIKED', '2013-06-27 09:53:39', 29),
	(199, 1, 'COMMENT', '2013-06-27 09:54:39', 29),
	(200, 3, 'COMMENT', '2013-06-27 09:56:52', 59),
	(201, 3, 'FAV', '2013-06-27 09:56:53', 59),
	(202, 3, 'LIKED', '2013-06-27 09:56:54', 59),
	(203, 3, 'COMMENT', '2013-06-27 09:57:08', 56),
	(204, 3, 'FAV', '2013-06-27 09:57:09', 56),
	(205, 3, 'LIKED', '2013-06-27 09:57:12', 56),
	(206, 3, 'FAV', '2013-06-27 09:57:16', 60),
	(207, 3, 'LIKED', '2013-06-27 09:57:19', 60),
	(208, 3, 'COMMENT', '2013-06-27 09:57:29', 60),
	(209, 3, 'FAV', '2013-06-27 09:57:33', 23),
	(210, 3, 'LIKED', '2013-06-27 09:57:35', 23),
	(211, 3, 'COMMENT', '2013-06-27 09:57:51', 23),
	(215, 11, 'COMMENT', '2013-06-27 10:43:11', 2),
	(216, 11, 'FAV', '2013-06-27 10:43:17', 2),
	(217, 11, 'LIKED', '2013-06-27 10:43:20', 2),
	(218, 11, 'COMMENT', '2013-06-27 12:05:39', 2),
	(219, 11, 'COMMENT', '2013-06-27 12:06:09', 51),
	(220, 11, 'FAV', '2013-06-27 12:06:10', 51),
	(221, 11, 'LIKED', '2013-06-27 12:06:12', 51),
	(222, 11, 'NEWPHOTO', '2013-06-27 12:21:50', 63),
	(223, 11, 'NEWPHOTO', '2013-06-27 12:22:49', 64),
	(224, 11, 'FAV', '2013-06-27 12:25:55', 1),
	(225, 11, 'LIKED', '2013-06-27 12:26:00', 1),
	(226, 12, 'NEWPHOTO', '2013-06-27 12:31:52', 65),
	(227, 11, 'COMMENT', '2013-06-27 15:34:14', 23),
	(228, 11, 'NEWPHOTO', '2013-06-27 15:35:43', 66);
/*!40000 ALTER TABLE `user_activity` ENABLE KEYS */;


-- Dumping structure for trigger photoshare.comment_activity
DROP TRIGGER IF EXISTS `comment_activity`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `comment_activity` AFTER INSERT ON `photo_comments` FOR EACH ROW BEGIN
	DECLARE userId INTEGER;
	DECLARE uploadDate TIMESTAMP;
	DECLARE daysSinceUpload INT;

	SET @changetype = 'COMMENT';
	
	-- get the id of user making the change
	SELECT user_id FROM comments WHERE comment_id = NEW.comment_id INTO userId;
	
-- log the change into user_activity / a change was made by a user on a photo 

	INSERT INTO user_activity (user_id,change_type,activity_time,photo_id)
	VALUES (userId,@changetype,NOW(), NEW.photo_id);
	
	-- update the comment count for the photo
	UPDATE photos SET comments_count = comments_count + 1 
	WHERE id = NEW.photo_id;
	
	-- UPDATE RATING FOR THE PHOTO
	
	SELECT uploaded_date FROM photos WHERE id = NEW.photo_id INTO uploadDate;	
	
	SELECT TIMESTAMPDIFF(DAY,uploadDate,NOW()) INTO daysSinceUpload;
	
	IF daysSinceUpload = 0 THEN
		SET daysSinceUpload = 1;
	END IF;
		
	UPDATE photos SET popularity = popularity + (1/daysSinceUpload) 
	WHERE id = NEW.photo_id;	
	
	-- END RATING
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for trigger photoshare.fav_activity
DROP TRIGGER IF EXISTS `fav_activity`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `fav_activity` AFTER INSERT ON `favorites` FOR EACH ROW BEGIN
	DECLARE uploadDate TIMESTAMP;
	DECLARE daysSinceUpload INT;
	
	SET @changetype = 'FAV';
	INSERT INTO user_activity (user_id,change_type,activity_time,photo_id)
	VALUES (NEW.user_id,@changetype, NEW.fav_datetime , NEW.photo_id);
	
	UPDATE photos SET favs_count = favs_count + 1 WHERE id = NEW.photo_id;
	
	SELECT uploaded_date FROM photos WHERE id = NEW.photo_id INTO uploadDate;
	
	
	SELECT TIMESTAMPDIFF(DAY,uploadDate,NOW()) INTO daysSinceUpload;
	
	IF daysSinceUpload = 0 THEN
		SET daysSinceUpload = 1;
	END IF;
		
	UPDATE photos SET popularity = popularity + (1/daysSinceUpload) 
	WHERE id = NEW.photo_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for trigger photoshare.like_activity
DROP TRIGGER IF EXISTS `like_activity`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `like_activity` AFTER INSERT ON `likes` FOR EACH ROW BEGIN
	DECLARE uploadDate TIMESTAMP;
	DECLARE daysSinceUpload INT;
	
	SET @changetype = 'LIKED';	
	INSERT INTO user_activity (user_id,change_type,activity_time,photo_id)
	VALUES (NEW.user_id,@changetype,NOW(), NEW.photo_id);

	UPDATE photos SET likes_count = likes_count + 1 WHERE id = NEW.photo_id;
	
	SELECT uploaded_date FROM photos WHERE id = NEW.photo_id INTO uploadDate;
	
	
	SELECT TIMESTAMPDIFF(DAY,uploadDate,NOW()) INTO daysSinceUpload;
	
	IF daysSinceUpload = 0 THEN
		SET daysSinceUpload = 1;
	END IF;
		
	UPDATE photos SET popularity = popularity + (1/daysSinceUpload) 
	WHERE id = NEW.photo_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for trigger photoshare.photo_after_upload
DROP TRIGGER IF EXISTS `photo_after_upload`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `photo_after_upload` AFTER INSERT ON `photos` FOR EACH ROW BEGIN
		SET @changetype = 'NEWPHOTO';
		INSERT INTO user_activity (user_id, change_type,activity_time,photo_id) VALUES (NEW.user_id, @changetype, NEW.uploaded_date, NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
