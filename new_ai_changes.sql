-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for blood_management
CREATE DATABASE IF NOT EXISTS `blood_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blood_management`;

-- Dumping structure for table blood_management.advertisements
CREATE TABLE IF NOT EXISTS `advertisements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.advertisements: ~0 rows (approximately)

-- Dumping structure for table blood_management.blood_groups
CREATE TABLE IF NOT EXISTS `blood_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blood_groups_group_name_unique` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.blood_groups: ~8 rows (approximately)
INSERT INTO `blood_groups` (`id`, `group_name`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'A+ (A Positive)', 'Antigens on red cells: A\n\nAntibodies in plasma: Anti-B\n\nRh factor: Present (+)\n\nCan receive from: A+, A−, O+, O−\n\nCan donate to: A+, AB+\n\nCommonness: One of the most common blood types worldwide.\n\nInteresting fact: People with A+ are often “universal platelet donors.”', '2025-10-11 03:37:26', '2025-10-11 03:37:26'),
	(2, 'O+ (O Positive)', 'Antigens: None\n\nAntibodies: Anti-A and Anti-B\n\nRh factor: Present (+)\n\nCan receive from: O+, O−\n\nCan donate to: All positive blood types (A+, B+, AB+, O+)\n\nCommonness: The most common blood type (around 37% globally).\n\nInteresting fact: O+ donors are in constant demand in hospitals.', '2025-10-11 03:37:39', '2025-10-11 03:37:39'),
	(3, 'A−', 'Can be used for patients with A+ or A−.', '2025-10-26 04:48:13', '2025-10-26 04:48:13'),
	(4, 'B+', 'Can donate to B+ and AB+.', '2025-10-26 04:48:23', '2025-10-26 04:48:23'),
	(5, 'B−', 'Useful for B or AB blood groups.', '2025-10-26 04:48:30', '2025-10-26 04:48:30'),
	(6, 'AB+', 'Universal plasma donor and can receive from all (universal recipient).', '2025-10-26 04:48:41', '2025-10-26 04:48:41'),
	(7, 'AB−', 'Rare; can receive from all Rh− blood types.', '2025-10-26 04:48:52', '2025-10-26 04:48:52'),
	(8, 'O−', 'Universal blood donor, used in emergencies.', '2025-10-26 04:49:01', '2025-10-26 04:49:01');

-- Dumping structure for table blood_management.blood_issues
CREATE TABLE IF NOT EXISTS `blood_issues` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blood_request_id` bigint unsigned DEFAULT NULL,
  `patient_id` bigint unsigned NOT NULL,
  `blood_unit_id` bigint unsigned NOT NULL,
  `issue_date` datetime NOT NULL,
  `issued_by_user_id` bigint unsigned NOT NULL,
  `cross_match_status` enum('pending','passed','failed','not_performed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` enum('pending','paid','waived') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `adjustment_details` text COLLATE utf8mb4_unicode_ci,
  `receipt_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blood_issues_blood_unit_id_unique` (`blood_unit_id`),
  UNIQUE KEY `blood_issues_receipt_number_unique` (`receipt_number`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.blood_issues: ~0 rows (approximately)
INSERT INTO `blood_issues` (`id`, `blood_request_id`, `patient_id`, `blood_unit_id`, `issue_date`, `issued_by_user_id`, `cross_match_status`, `payment_status`, `total_amount`, `adjustment_details`, `receipt_number`, `created_at`, `updated_at`) VALUES
	(1, 4, 4, 1, '2025-10-20 16:18:18', 1, 'passed', 'pending', 2000.00, 'none', NULL, '2025-10-20 10:48:18', '2025-10-20 10:48:18'),
	(2, 9, 7, 4, '2025-11-01 00:00:00', 15, 'passed', 'paid', 20.00, 'please adjust', 'FG4D5D5D4G5', '2025-11-01 07:03:08', '2025-11-01 09:25:29');

-- Dumping structure for table blood_management.blood_requests
CREATE TABLE IF NOT EXISTS `blood_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned DEFAULT NULL,
  `requester_user_id` bigint unsigned DEFAULT NULL,
  `blood_group_id` bigint unsigned NOT NULL,
  `units_requested` int NOT NULL,
  `urgency_level` enum('routine','urgent','emergency') COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_date` date NOT NULL,
  `required_by_date` date DEFAULT NULL,
  `status` enum('pending','approved','fulfilled','rejected','canceled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.blood_requests: ~4 rows (approximately)
INSERT INTO `blood_requests` (`id`, `patient_id`, `requester_user_id`, `blood_group_id`, `units_requested`, `urgency_level`, `request_date`, `required_by_date`, `status`, `rejection_reason`, `description`, `created_at`, `updated_at`) VALUES
	(4, 4, NULL, 2, 100, 'urgent', '2025-10-11', '2025-10-18', 'fulfilled', NULL, 'need o+ positive blood request\n', '2025-10-11 04:53:36', '2025-10-20 10:48:18'),
	(5, 4, NULL, 1, 5, 'routine', '2025-10-21', NULL, 'approved', NULL, 'Need A postive for my brother ', '2025-10-20 11:04:05', '2025-10-20 11:15:00'),
	(6, 4, NULL, 1, 50, 'routine', '2025-10-23', '2025-10-24', 'approved', NULL, 'i want this in urgent btw ', '2025-10-23 12:01:51', '2025-10-26 10:30:26'),
	(7, 4, NULL, 2, 50, 'routine', '2025-10-23', '2025-10-24', 'canceled', NULL, 'kinda need for my brother ', '2025-10-23 12:02:43', '2025-10-23 12:06:25'),
	(8, 4, NULL, 4, 20, 'routine', '2025-10-25', '2025-10-31', 'approved', NULL, 'Imanhi blood request', '2025-10-26 10:29:10', '2025-10-26 10:30:30'),
	(9, 7, NULL, 4, 1, 'routine', '2025-11-01', '2026-02-20', 'approved', NULL, 'need blood asap', '2025-11-01 06:49:32', '2025-11-01 06:54:40');

-- Dumping structure for table blood_management.blood_units
CREATE TABLE IF NOT EXISTS `blood_units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `unique_bag_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `donor_id` bigint unsigned NOT NULL,
  `blood_group_id` bigint unsigned NOT NULL,
  `collection_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `component_type` enum('whole_blood','plasma','platelet','red_blood_cells') COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume_ml` int DEFAULT NULL,
  `collection_camp_id` bigint unsigned DEFAULT NULL,
  `status` enum('collected','test_awaited','tested','ready_for_issue','issued','expired','discarded','quarantined') COLLATE utf8mb4_unicode_ci NOT NULL,
  `serology_test_status` enum('pending','passed','failed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blood_units_unique_bag_id_unique` (`unique_bag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.blood_units: ~4 rows (approximately)
INSERT INTO `blood_units` (`id`, `unique_bag_id`, `donor_id`, `blood_group_id`, `collection_date`, `expiry_date`, `component_type`, `volume_ml`, `collection_camp_id`, `status`, `serology_test_status`, `storage_location`, `created_at`, `updated_at`) VALUES
	(1, '4545165', 1, 2, '2025-10-20', '2025-12-01', 'red_blood_cells', 20, 1, 'issued', 'passed', 'Fridge A Shelf 3', '2025-10-19 03:26:24', '2025-10-20 10:48:18'),
	(2, 'dgiowjpogt', 1, 1, '2025-10-25', '2025-12-06', 'whole_blood', 50, 1, 'quarantined', 'passed', 'Muawin Top Shelf', '2025-10-20 11:13:40', '2025-10-20 11:15:23'),
	(3, 'asdt432g', 1, 1, '2025-10-26', '2025-12-07', 'whole_blood', 300, 1, 'ready_for_issue', 'passed', 'Fridge A Shelf 3', '2025-10-26 10:31:00', '2025-10-26 10:34:47'),
	(4, 'etg156ad', 3, 4, '2025-11-11', '2025-12-11', 'platelet', 50, 2, 'ready_for_issue', 'passed', 'Fridge A  3532', '2025-10-26 10:31:25', '2025-11-01 07:00:26');

-- Dumping structure for table blood_management.camps
CREATE TABLE IF NOT EXISTS `camps` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `camp_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_id` bigint unsigned NOT NULL,
  `state_id` bigint unsigned NOT NULL,
  `organizer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facilities_available` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('upcoming','active','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.camps: ~0 rows (approximately)
INSERT INTO `camps` (`id`, `name`, `camp_date`, `start_time`, `end_time`, `address`, `city_id`, `state_id`, `organizer`, `facilities_available`, `description`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Muawin Camp', '2025-10-11', '13:00:00', '18:00:00', 'Tandalja road', 1, 1, 'Muawin ', 'blood donation', NULL, 'active', '2025-10-11 03:36:22', '2025-10-11 03:36:22'),
	(2, 'Ansar Camp', '2020-10-26', '10:00:00', '07:30:00', 'Bohemia Donor Center', 1, 1, 'Muawin ', 'Facilities should be available for confidential discussions between donors and social workers or the medical officer. Withdrawal of blood from donors without', 'A .mil website belongs to an official U.S. Department of Defense organization. \n# Blood Donor Centers The ASBP supports more than 20 Blood Donor Centers throughout the world.\n### Armed Services Blood Bank Center - NCR \n\n### Fort Bragg Blood Donor Center Blood Donor Center   \nBlood Donor Center   \nBlood Donor Center   \nArmed Services Blood Bank Center   \nBlood Donor Center   \n\n### Fort Bliss Blood Donor Center \n### Armed Services Blood Bank Center - San Antonio \n### Akeroyd Blood Donor Center Blood Donor Center   \n### Fort Leonard Wood Blood Donor Center \n### Wright-Patterson Blood Donor Center \n### Keesler Blood Donor Center \n### Tripler Army Medical Blood Donor Center \n### Armed Services Blood Bank Center-Okinawa \n### Armed Services Blood Bank Center-Europe', 'active', '2025-10-26 04:56:42', '2025-10-26 11:00:51');

-- Dumping structure for table blood_management.camp_staff
CREATE TABLE IF NOT EXISTS `camp_staff` (
  `camp_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `role_in_camp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`camp_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.camp_staff: ~0 rows (approximately)
INSERT INTO `camp_staff` (`camp_id`, `user_id`, `role_in_camp`, `created_at`, `updated_at`) VALUES
	(1, 2, 'blood collector', '2025-10-11 03:39:44', '2025-10-11 03:39:44');

-- Dumping structure for table blood_management.cities
CREATE TABLE IF NOT EXISTS `cities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `state_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cities_name_state_id_unique` (`name`,`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.cities: ~2 rows (approximately)
INSERT INTO `cities` (`id`, `state_id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Vadodara', '2025-10-11 03:34:51', '2025-10-11 03:35:02'),
	(2, 1, 'Ahmedabad', '2025-10-11 03:35:11', '2025-10-11 03:35:11'),
	(3, 1, 'Gandhinagar', '2025-10-26 04:57:04', '2025-10-26 04:57:04');

-- Dumping structure for table blood_management.donors
CREATE TABLE IF NOT EXISTS `donors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city_id` bigint unsigned NOT NULL,
  `state_id` bigint unsigned NOT NULL,
  `blood_group_id` bigint unsigned NOT NULL,
  `last_donation_date` date DEFAULT NULL,
  `eligible_to_donate_until` date DEFAULT NULL,
  `enrollment_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive','suspended','pending_verification') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending_verification',
  PRIMARY KEY (`id`),
  UNIQUE KEY `donors_user_id_unique` (`user_id`),
  UNIQUE KEY `donors_mobile_number_unique` (`mobile_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.donors: ~1 rows (approximately)
INSERT INTO `donors` (`id`, `user_id`, `first_name`, `last_name`, `mobile_number`, `gender`, `date_of_birth`, `address`, `city_id`, `state_id`, `blood_group_id`, `last_donation_date`, `eligible_to_donate_until`, `enrollment_number`, `created_at`, `updated_at`, `status`) VALUES
	(1, 8, 'Aliza', 'Rayees', '5454854545', 'male', '2009-01-05', 'tandalja road 301', 1, 1, 1, '2025-10-30', '2026-01-22', NULL, '2025-10-11 12:33:41', '2025-10-26 10:31:25', 'active'),
	(3, 16, 'Malik', 'malikbhai', '44854549685', 'male', '2003-02-20', 'besides taif nagar', 1, 1, 4, NULL, NULL, NULL, '2025-11-01 06:56:39', '2025-11-01 06:57:17', 'active');

-- Dumping structure for table blood_management.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table blood_management.galleries
CREATE TABLE IF NOT EXISTS `galleries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `camp_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.galleries: ~0 rows (approximately)

-- Dumping structure for table blood_management.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.migrations: ~0 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2025_09_24_000000_create_blood_groups_table', 1),
	(6, '2025_09_24_000001_create_states_table', 1),
	(7, '2025_09_24_000002_create_cities_table', 1),
	(8, '2025_09_24_000003_create_donors_table', 1),
	(9, '2025_09_24_000004_create_camps_table', 1),
	(10, '2025_09_24_000005_create_camp_staff_table', 1),
	(11, '2025_09_24_000006_create_blood_units_table', 1),
	(12, '2025_09_24_000007_create_serology_tests_table', 1),
	(13, '2025_09_24_000008_create_patients_table', 1),
	(14, '2025_09_24_000009_create_blood_requests_table', 1),
	(15, '2025_09_24_000010_create_blood_issues_table', 1),
	(16, '2025_09_24_000011_create_reserved_units_table', 1),
	(17, '2025_09_24_000012_create_transfusion_reactions_table', 1),
	(18, '2025_09_24_000013_create_galleries_table', 1),
	(19, '2025_09_24_000014_create_news_table', 1),
	(20, '2025_09_24_000015_create_advertisements_table', 1),
	(21, '2025_10_11_175936_add_pending_verification_to_donors_status_enum', 2),
	(22, '2025_10_19_135245_add_is_super_admin_to_users_table', 3),
	(23, '2025_10_20_094040_add_blood_request_id_to_reserved_units_table', 4),
	(24, '2025_10_20_103249_add_rejection_reason_to_blood_requests_table', 5);

-- Dumping structure for table blood_management.news
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `publication_date` date NOT NULL,
  `author_user_id` bigint unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.news: ~0 rows (approximately)

-- Dumping structure for table blood_management.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table blood_management.patients
CREATE TABLE IF NOT EXISTS `patients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `hospital_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patients_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.patients: ~1 rows (approximately)
INSERT INTO `patients` (`id`, `user_id`, `first_name`, `last_name`, `mobile_number`, `email`, `gender`, `date_of_birth`, `address`, `hospital_name`, `created_at`, `updated_at`) VALUES
	(4, 6, 'Imani Shah', 'Slater', '2323232323', 'ImaniShah22@gmail.com', 'male', '2020-10-01', 'Tandalja Vadodara', 'Muawin Hospital', '2025-10-11 04:53:36', '2025-10-23 12:27:22'),
	(7, 14, 'Farhan', 'saeed', '4825496554', 'farhansaeed22@gmail.com', 'male', '2000-08-08', 'tandalja a bleecker street besides madina restaurant', 'Surish Hospital', '2025-11-01 06:49:32', '2025-11-01 06:49:32');

-- Dumping structure for table blood_management.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table blood_management.reserved_units
CREATE TABLE IF NOT EXISTS `reserved_units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blood_unit_id` bigint unsigned NOT NULL,
  `patient_id` bigint unsigned NOT NULL,
  `reserved_by_user_id` bigint unsigned NOT NULL,
  `reservation_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `status` enum('active','fulfilled','expired','canceled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `blood_request_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reserved_units_blood_unit_id_unique` (`blood_unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.reserved_units: ~2 rows (approximately)
INSERT INTO `reserved_units` (`id`, `blood_unit_id`, `patient_id`, `reserved_by_user_id`, `reservation_date`, `expiration_date`, `status`, `created_at`, `updated_at`, `blood_request_id`) VALUES
	(1, 1, 4, 1, '2025-10-20 13:14:26', '2025-10-21 13:14:26', 'fulfilled', '2025-10-20 07:44:26', '2025-10-20 10:48:18', 4),
	(2, 2, 4, 1, '2025-10-20 16:45:23', '2025-10-21 16:45:23', 'active', '2025-10-20 11:15:23', '2025-10-20 11:15:23', 5),
	(3, 4, 7, 2, '2025-11-01 14:54:50', '2025-11-02 14:54:50', 'fulfilled', '2025-11-01 09:25:13', '2025-11-01 09:25:13', 9);

-- Dumping structure for table blood_management.serology_tests
CREATE TABLE IF NOT EXISTS `serology_tests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blood_unit_id` bigint unsigned NOT NULL,
  `test_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `result` enum('positive','negative','indeterminate') COLLATE utf8mb4_unicode_ci NOT NULL,
  `test_date` date NOT NULL,
  `tested_by_user_id` bigint unsigned DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.serology_tests: ~15 rows (approximately)
INSERT INTO `serology_tests` (`id`, `blood_unit_id`, `test_type`, `result`, `test_date`, `tested_by_user_id`, `notes`, `created_at`, `updated_at`) VALUES
	(1, 1, 'HIV', 'negative', '2025-10-20', 1, 'All samples have arrived possitive for this test type', '2025-10-20 03:28:10', '2025-10-20 03:28:25'),
	(2, 1, 'Syphilis', 'negative', '2025-10-15', 1, 'this is also negative', '2025-10-20 03:28:47', '2025-10-20 03:28:47'),
	(3, 1, 'Hepatitis B', 'negative', '2025-10-20', 1, 'somthing is weird', '2025-10-20 03:32:34', '2025-10-20 03:33:08'),
	(4, 1, 'Hepatitis C', 'negative', '2025-10-20', 1, 'this just cam today\n', '2025-10-20 03:32:51', '2025-10-20 03:32:51'),
	(5, 2, 'HIV', 'negative', '2025-10-30', 1, NULL, '2025-10-20 11:14:06', '2025-10-20 11:14:06'),
	(6, 2, 'Hepatitis B', 'negative', '2025-10-20', 1, NULL, '2025-10-20 11:14:14', '2025-10-20 11:14:14'),
	(7, 2, 'Hepatitis C', 'negative', '2025-10-20', 1, NULL, '2025-10-20 11:14:34', '2025-10-20 11:14:34'),
	(8, 2, 'Syphilis', 'negative', '2025-10-20', 1, NULL, '2025-10-20 11:14:40', '2025-10-20 11:14:40'),
	(9, 3, 'HIV', 'negative', '2025-10-26', 2, NULL, '2025-10-26 10:34:26', '2025-10-26 10:34:26'),
	(10, 3, 'Hepatitis B', 'negative', '2025-10-26', 2, NULL, '2025-10-26 10:34:32', '2025-10-26 10:34:32'),
	(11, 3, 'Hepatitis C', 'negative', '2025-10-26', 2, NULL, '2025-10-26 10:34:40', '2025-10-26 10:34:40'),
	(12, 3, 'Syphilis', 'negative', '2025-10-26', 2, NULL, '2025-10-26 10:34:47', '2025-10-26 10:34:47'),
	(13, 4, 'HIV', 'negative', '2026-02-20', 15, NULL, '2025-11-01 07:00:00', '2025-11-01 07:00:00'),
	(14, 4, 'Hepatitis B', 'negative', '2025-05-05', 15, NULL, '2025-11-01 07:00:10', '2025-11-01 07:00:10'),
	(15, 4, 'Hepatitis C', 'negative', '2025-06-06', 15, NULL, '2025-11-01 07:00:18', '2025-11-01 07:00:18'),
	(16, 4, 'Syphilis', 'negative', '2025-06-06', 15, NULL, '2025-11-01 07:00:26', '2025-11-01 07:00:26');

-- Dumping structure for table blood_management.states
CREATE TABLE IF NOT EXISTS `states` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `states_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.states: ~0 rows (approximately)
INSERT INTO `states` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Gujarat', '2025-10-11 03:34:40', '2025-10-11 03:34:40'),
	(2, 'Maharashtra ', '2025-10-26 04:57:19', '2025-10-26 04:57:19');

-- Dumping structure for table blood_management.transfusion_reactions
CREATE TABLE IF NOT EXISTS `transfusion_reactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `blood_unit_id` bigint unsigned DEFAULT NULL,
  `reaction_date` datetime NOT NULL,
  `reaction_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `severity` enum('mild','moderate','severe','fatal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reported_by_user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.transfusion_reactions: ~0 rows (approximately)

-- Dumping structure for table blood_management.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','donor','patient') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_super_admin` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blood_management.users: ~6 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `role`, `is_super_admin`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin77@gmail.com', NULL, 'admin', 1, '$2y$12$n8rN6LB7ioy1UKOIgwSzIORLH0cdjiuGR2qtGJOUQkkUnHEJXA77G', NULL, '2025-10-11 03:34:09', '2025-10-11 03:34:09'),
	(2, 'aren', 'aren77@gmail.com', NULL, 'admin', 0, '$2y$12$IX6nm3SYA.qXWOuhc6Dhte4lE/TFXgjbHc1.bEy.JO3pFjTYetAbS', NULL, '2025-10-11 03:39:29', '2025-10-11 03:39:29'),
	(6, 'Imani Shah Slater', 'ImaniShah22@gmail.com', NULL, 'patient', 0, '$2y$12$y95WY7IXUOP/nnqNJcDOjOn8J/GsK.HypVVyKWKBn9vNeWRcboOBe', '1eELKQcxjmC4e6RTq3X8HrQwh7461hpJd5HCWvsYn1bSXABT1XQ7nNTLsimz', '2025-10-11 04:53:36', '2025-10-11 04:53:53'),
	(8, 'Zaid', 'zaid77@gmail.com', NULL, 'donor', 0, '$2y$12$ZjIm.vQibemUq3WiN7Jvs.xjegoKaVQnZmz4JB3TG30T8A6r2qedy', NULL, '2025-10-11 12:33:41', '2025-10-25 07:56:02'),
	(14, 'Farhan saeed', 'farhansaeed22@gmail.com', NULL, 'patient', 0, '$2y$12$2/XvURbY2N.xSr5I9dCtxOMIS9wbYdBrXGB.TRBdGIX0DE3YOLyFe', '8i3udGY65pG9Imt3CIYRgyLNp3ceuprxDltXw7CLNQf1cWUldaqxvu9qQVIe', '2025-11-01 06:49:32', '2025-11-01 06:50:00'),
	(15, 'Faizan', 'faizan2@gmail.com', NULL, 'admin', 0, '$2y$12$76XzX3U1NvP6TcZEfMTaBuAEZdOqEUMaLPHnke3h16T/cXYWIosYy', NULL, '2025-11-01 06:52:30', '2025-11-01 06:52:30'),
	(16, 'Malik malikbhai', 'malik22@gmail.com', NULL, 'donor', 0, '$2y$12$22qSPKSZsuRLk19Cln1ni.zxLvMZ0MpyX/lHm9ukxLsQSJUZfbVEe', NULL, '2025-11-01 06:56:39', '2025-11-01 06:56:39');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
