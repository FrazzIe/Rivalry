-- --------------------------------------------------------
-- Host:                         209.222.98.202
-- Server version:               10.3.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for rivalryrp_neweco
CREATE DATABASE IF NOT EXISTS `rivalryrp_neweco` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rivalryrp_neweco`;

-- Dumping structure for table rivalryrp_neweco.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) DEFAULT NULL,
  `license` varchar(200) DEFAULT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `expire` varchar(50) DEFAULT NULL,
  `reason` mediumtext DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `banner` varchar(40) DEFAULT NULL,
  `permanent` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.bans_archive
CREATE TABLE IF NOT EXISTS `bans_archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) DEFAULT NULL,
  `license` varchar(200) DEFAULT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `expire` varchar(50) DEFAULT NULL,
  `reason` mediumtext DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `banner` varchar(40) DEFAULT NULL,
  `permanent` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `character_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(200) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `dob` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `wallet` int(11) DEFAULT 0,
  `bank` int(11) DEFAULT 0,
  `dirty_cash` int(11) DEFAULT 0,
  `timeplayed` int(11) DEFAULT 0,
  `position_x` float DEFAULT -891.9,
  `position_y` float DEFAULT -2342.44,
  `position_z` float DEFAULT -11.7327,
  `weapon_license` varchar(20) DEFAULT NULL,
  `jail_time` varchar(20) DEFAULT NULL,
  `job_id` int(11) DEFAULT 1,
  `drivers_license` varchar(50) DEFAULT 'false',
  `url` text DEFAULT NULL,
  `dead` bit(1) DEFAULT b'0',
  PRIMARY KEY (`character_id`),
  KEY `fk_identifier_characters` (`identifier`),
  CONSTRAINT `fk_identifier_characters` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3217 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.doj
CREATE TABLE IF NOT EXISTS `doj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_doj` (`character_id`),
  CONSTRAINT `doj_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.garages
CREATE TABLE IF NOT EXISTS `garages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `garage_id` int(11) DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `slots` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_garages` (`character_id`),
  CONSTRAINT `fk_character_id_garages` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4064 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `canuse` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_inventory` (`character_id`),
  CONSTRAINT `fk_character_id_inventory` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76131 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_arrest
CREATE TABLE IF NOT EXISTS `mdt_arrest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `officer_character_id` int(11) DEFAULT NULL,
  `offender_character_id` int(11) DEFAULT NULL,
  `sentence` int(11) DEFAULT 0,
  `fine` int(11) DEFAULT 0,
  `charges` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_arrest_officer_character` (`officer_character_id`),
  KEY `fk_arrest_offender_character` (`offender_character_id`),
  CONSTRAINT `fk_arrest_offender_character` FOREIGN KEY (`offender_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_arrest_officer_character` FOREIGN KEY (`officer_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_bolo
CREATE TABLE IF NOT EXISTS `mdt_bolo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `officer_character_id` int(11) DEFAULT NULL,
  `offender_name` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `expire` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_arrest_officer_character` (`officer_character_id`),
  CONSTRAINT `fk_bolo_officer_character` FOREIGN KEY (`officer_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_citation
CREATE TABLE IF NOT EXISTS `mdt_citation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `officer_character_id` int(11) DEFAULT NULL,
  `offender_character_id` int(11) DEFAULT NULL,
  `fine` int(11) DEFAULT NULL,
  `charges` text DEFAULT NULL,
  `plate` varchar(8) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `street` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_citation_offender_character` (`offender_character_id`),
  KEY `fk_citation_officer_character` (`officer_character_id`),
  CONSTRAINT `fk_citation_offender_character` FOREIGN KEY (`offender_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_citation_officer_character` FOREIGN KEY (`officer_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_death
CREATE TABLE IF NOT EXISTS `mdt_death` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `medic_character_id` int(11) DEFAULT NULL,
  `patient_character_id` int(11) DEFAULT NULL,
  `external` text DEFAULT NULL,
  `internal` text DEFAULT NULL,
  `lab_data` text DEFAULT NULL,
  `items` text DEFAULT NULL,
  `opinion` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_patient_medic_character` (`medic_character_id`),
  KEY `fk_patient_patient_character` (`patient_character_id`),
  CONSTRAINT `fk_death_medic_character` FOREIGN KEY (`medic_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_death_patient_character` FOREIGN KEY (`patient_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_license
CREATE TABLE IF NOT EXISTS `mdt_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `citizen_character_id` int(11) DEFAULT NULL,
  `officer_character_id` int(11) DEFAULT NULL,
  `license_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_license_citizen_character_id` (`citizen_character_id`),
  KEY `fk_license_officer_character_id` (`officer_character_id`),
  CONSTRAINT `fk_license_citizen_character_id` FOREIGN KEY (`citizen_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_license_officer_character_id` FOREIGN KEY (`officer_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_notepad
CREATE TABLE IF NOT EXISTS `mdt_notepad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `lsfd` text DEFAULT NULL,
  `lspd` text DEFAULT NULL,
  `doj` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notepad_character_id` (`character_id`),
  CONSTRAINT `fk_notepad_character_id` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_patient
CREATE TABLE IF NOT EXISTS `mdt_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `medic_character_id` int(11) DEFAULT NULL,
  `patient_character_id` int(11) DEFAULT NULL,
  `injuries` text DEFAULT NULL,
  `treatment` text DEFAULT NULL,
  `hospitalized` bit(1) DEFAULT NULL,
  `life_support` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_patient_medic_character` (`medic_character_id`),
  KEY `fk_patient_patient_character` (`patient_character_id`),
  CONSTRAINT `fk_patient_medic_character` FOREIGN KEY (`medic_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_patient_patient_character` FOREIGN KEY (`patient_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_police_report
CREATE TABLE IF NOT EXISTS `mdt_police_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `character_id` int(11) DEFAULT NULL,
  `suspects_involved` text DEFAULT NULL,
  `officers_involved` text DEFAULT NULL,
  `incident_timestamp` timestamp NULL DEFAULT NULL,
  `incident` text DEFAULT NULL,
  `incident_details` text DEFAULT NULL,
  `incident_actions` text DEFAULT NULL,
  `incident_summary` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_police_report_character_id` (`character_id`),
  CONSTRAINT `fk_police_report_character_id` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mdt_warrant
CREATE TABLE IF NOT EXISTS `mdt_warrant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `officer_character_id` int(11) DEFAULT NULL,
  `offender_character_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `charges` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_warrant_offender_character` (`offender_character_id`),
  KEY `fk_warrant_officer_character` (`officer_character_id`),
  CONSTRAINT `fk_warrant_offender_character` FOREIGN KEY (`offender_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_warrant_officer_character` FOREIGN KEY (`officer_character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.mechanic
CREATE TABLE IF NOT EXISTS `mechanic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mcc_car` (`character_id`),
  CONSTRAINT `fk_mcc_car` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.outfit
CREATE TABLE IF NOT EXISTS `outfit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL DEFAULT 0,
  `model` varchar(100) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `clothing_drawable` tinytext DEFAULT NULL,
  `clothing_texture` tinytext DEFAULT NULL,
  `prop_drawable` tinytext DEFAULT NULL,
  `prop_texture` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_outfit` (`character_id`),
  CONSTRAINT `fk_character_id_outfit` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10160 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.paramedic
CREATE TABLE IF NOT EXISTS `paramedic` (
  `unit` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `onduty` varchar(50) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`unit`),
  KEY `fk_character_id_paramedic` (`character_id`),
  CONSTRAINT `fk_character_id_paramedic` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.phone
CREATE TABLE IF NOT EXISTS `phone` (
  `phone_number` varchar(50) NOT NULL,
  `character_id` int(11) DEFAULT NULL,
  `has` bit(1) DEFAULT b'1',
  PRIMARY KEY (`phone_number`),
  KEY `fk_character_id_phone` (`character_id`),
  CONSTRAINT `fk_character_id_phone` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.phone_contacts
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_phone_contacts` (`character_id`),
  KEY `pcs_phe_number` (`phone_number`),
  KEY `pcs_phe_contact` (`contact_number`),
  CONSTRAINT `fk_character_id_phone_contacts` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `pcs_phe_contact` FOREIGN KEY (`contact_number`) REFERENCES `phone` (`phone_number`) ON DELETE CASCADE,
  CONSTRAINT `pcs_phe_number` FOREIGN KEY (`phone_number`) REFERENCES `phone` (`phone_number`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13382 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.phone_conversation
CREATE TABLE IF NOT EXISTS `phone_conversation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_number` varchar(50) DEFAULT NULL,
  `receiver_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pcn_phe` (`owner_number`),
  CONSTRAINT `pcn_phe` FOREIGN KEY (`owner_number`) REFERENCES `phone` (`phone_number`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3275 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_conversation_id` (`conversation_id`),
  CONSTRAINT `fk_conversation_id` FOREIGN KEY (`conversation_id`) REFERENCES `phone_conversation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40746 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.playercustomisation
CREATE TABLE IF NOT EXISTS `playercustomisation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `clothing_drawable` tinytext DEFAULT NULL,
  `clothing_texture` tinytext DEFAULT NULL,
  `prop_drawable` tinytext DEFAULT NULL,
  `prop_texture` tinytext DEFAULT NULL,
  `overlay_drawable` tinytext DEFAULT NULL,
  `overlay_opacity` tinytext DEFAULT NULL,
  `overlay_colour` tinytext DEFAULT NULL,
  `facial_feature` tinytext DEFAULT NULL,
  `head_blend` tinytext DEFAULT NULL,
  `hair_colour` tinytext DEFAULT NULL,
  `eye_colour` int(2) DEFAULT NULL,
  `highlight` bit(1) DEFAULT NULL,
  `tattoo` text DEFAULT NULL,
  `creator` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_playercustomisation` (`character_id`),
  CONSTRAINT `fk_character_id_playercustomisation` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9407 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.police
CREATE TABLE IF NOT EXISTS `police` (
  `unit` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `onduty` varchar(50) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`unit`),
  KEY `fk_character_id_police` (`character_id`),
  CONSTRAINT `fk_character_id_police` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.police_arrests
CREATE TABLE IF NOT EXISTS `police_arrests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(80) DEFAULT NULL,
  `officer_identifier` varchar(80) DEFAULT NULL,
  `officer_name` varchar(80) DEFAULT NULL,
  `offender_identifier` varchar(80) DEFAULT NULL,
  `offender_name` varchar(80) DEFAULT NULL,
  `sentenceORfine` varchar(60) DEFAULT NULL,
  `sentence` int(11) DEFAULT NULL,
  `fine` int(11) DEFAULT NULL,
  `charges` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7126 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.police_violations
CREATE TABLE IF NOT EXISTS `police_violations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(80) DEFAULT NULL,
  `officer_identifier` varchar(80) DEFAULT NULL,
  `officer_name` varchar(80) DEFAULT NULL,
  `offender_identifier` varchar(80) DEFAULT NULL,
  `offender_name` varchar(80) DEFAULT NULL,
  `fine` int(11) DEFAULT NULL,
  `violations` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2404 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.police_warrants
CREATE TABLE IF NOT EXISTS `police_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(80) DEFAULT NULL,
  `officer_name` varchar(60) DEFAULT NULL,
  `offender_name` varchar(60) DEFAULT NULL,
  `location` varchar(80) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=402 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_businesses_enterable
CREATE TABLE IF NOT EXISTS `properties_businesses_enterable` (
  `id` int(11) NOT NULL,
  `character_id` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT 'no',
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  `vault_locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_businesses_enterable` (`character_id`),
  CONSTRAINT `fk_character_id_businesses_enterable` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table rivalry_newecon.properties_businesses_enterable: ~6 rows (approximately)
/*!40000 ALTER TABLE `properties_businesses_enterable` DISABLE KEYS */;
INSERT INTO `properties_businesses_enterable` (`id`, `character_id`, `identifier`, `expire`, `cash`, `dirty`, `locked`, `vault_locked`) VALUES
  (1, NULL, 'no', '0', 6000, 0, 'true', 'true'),
  (2, NULL, 'no', '0', 4500, 0, 'true', 'true'),
  (3, NULL, 'no', '0', 0, 2, 'false', 'true'),
  (4, NULL, 'no', '0', 2500, 0, 'true', 'true'),
  (5, NULL, 'no', '0', 1000, 0, 'false', 'true'),
  (6, NULL, 'no', '0', 9000, 0, 'true', 'true');
/*!40000 ALTER TABLE `properties_businesses_enterable` ENABLE KEYS */;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_businesses_enterable_weapons
CREATE TABLE IF NOT EXISTS `properties_businesses_enterable_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) DEFAULT NULL,
  `sellprice` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ammo` varchar(20) DEFAULT NULL,
  `suppressor` varchar(20) NOT NULL DEFAULT 'false',
  `flashlight` varchar(20) NOT NULL DEFAULT 'false',
  `extended_clip` varchar(20) NOT NULL DEFAULT 'false',
  `scope` varchar(20) NOT NULL DEFAULT 'false',
  `grip` varchar(20) NOT NULL DEFAULT 'false',
  `advanced_scope` varchar(20) NOT NULL DEFAULT 'false',
  `skin` varchar(20) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;


-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_businesses_normal
CREATE TABLE IF NOT EXISTS `properties_businesses_normal` (
  `id` int(11) NOT NULL,
  `character_id` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT 'no',
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_businesses_normal` (`character_id`),
  CONSTRAINT `fk_character_id_businesses_normal` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table rivalry_newecon.properties_businesses_normal: ~74 rows (approximately)
/*!40000 ALTER TABLE `properties_businesses_normal` DISABLE KEYS */;
INSERT INTO `properties_businesses_normal` (`id`, `character_id`, `identifier`, `expire`, `cash`, `dirty`, `locked`) VALUES
  (1, NULL, 'no', '0', 1000, 0, 'true'),
  (2, NULL, 'no', '0', 1500, 0, 'true'),
  (3, NULL, 'no', '0', 250, 0, 'true'),
  (4, NULL, 'no', '0', 2000, 0, 'true'),
  (5, NULL, 'no', '0', 1500, 527, 'true'),
  (6, NULL, 'no', '0', 0, 0, 'true'),
  (7, NULL, 'no', '0', 1000, 0, 'true'),
  (8, NULL, 'no', '0', 300, 0, 'true'),
  (9, NULL, 'no', '0', 500, 0, 'true'),
  (10, NULL, 'no', '0', 1000, 940, 'true'),
  (11, NULL, 'no', '0', 900, 0, 'true'),
  (12, NULL, 'no', '0', 1000, 0, 'true'),
  (13, NULL, 'no', '0', 400, 0, 'true'),
  (14, NULL, 'no', '0', 1000, 0, 'true'),
  (15, NULL, 'no', '0', 1000, 0, 'true'),
  (16, NULL, 'no', '0', 1000, 0, 'true'),
  (17, NULL, 'no', '0', 500, 0, 'true'),
  (18, NULL, 'no', '0', 1000, 1000, 'true'),
  (19, NULL, 'no', '0', 1000, 0, 'true'),
  (20, NULL, 'no', '0', 0, 0, 'true'),
  (21, NULL, 'no', '0', 300, 0, 'true'),
  (22, NULL, 'no', '0', 1000, 1000, 'true'),
  (23, NULL, 'no', '0', 1000, 0, 'true'),
  (24, NULL, 'no', '0', 300, 0, 'true'),
  (25, NULL, 'no', '0', 1000, 0, 'true'),
  (26, NULL, 'no', '0', 1000, 0, 'true'),
  (27, NULL, 'no', '0', 300, 0, 'true'),
  (28, NULL, 'no', '0', 700, 0, 'true'),
  (29, NULL, 'no', '0', 900, 0, 'true'),
  (30, NULL, 'no', '0', 375, 0, 'true'),
  (31, NULL, 'no', '0', 625, 0, 'true'),
  (32, NULL, 'no', '0', 875, 1500, 'true'),
  (33, NULL, 'no', '0', 1500, 0, 'true'),
  (34, NULL, 'no', '0', 1500, 0, 'true'),
  (35, NULL, 'no', '0', 0, 0, 'true'),
  (36, NULL, 'no', '0', 1500, 0, 'true'),
  (37, NULL, 'no', '0', 1000, 0, 'true'),
  (38, NULL, 'no', '0', 1500, 0, 'true'),
  (39, NULL, 'no', '0', 250, 0, 'true'),
  (40, NULL, 'no', '0', 1375, 0, 'true'),
  (41, NULL, 'no', '0', 500, 0, 'true'),
  (42, NULL, 'no', '0', 1500, 0, 'true'),
  (43, NULL, 'no', '0', 1500, 0, 'true'),
  (44, NULL, 'no', '0', 600, 0, 'true'),
  (45, NULL, 'no', '0', 2000, 2000, 'true'),
  (46, NULL, 'no', '0', 1500, 0, 'true'),
  (47, NULL, 'no', '0', 1500, 0, 'true'),
  (48, NULL, 'no', '0', 4500, 0, 'true'),
  (49, NULL, 'no', '0', 2000, 0, 'true'),
  (50, NULL, 'no', '0', 0, 0, 'true'),
  (51, NULL, 'no', '0', 400, 0, 'true'),
  (52, NULL, 'no', '0', 600, 0, 'true'),
  (53, NULL, 'no', '0', 500, 0, 'true'),
  (54, NULL, 'no', '0', 2500, 0, 'true'),
  (55, NULL, 'no', '0', 150, 636, 'true'),
  (56, NULL, 'no', '0', 0, 671, 'true'),
  (57, NULL, 'no', '0', 1125, 200, 'true'),
  (58, NULL, 'no', '0', 450, 0, 'true'),
  (59, NULL, 'no', '0', 300, 0, 'true'),
  (60, NULL, 'no', '0', 400, 0, 'true'),
  (61, NULL, 'no', '0', 250, 3000, 'true'),
  (62, NULL, 'no', '0', 400, 0, 'true'),
  (63, NULL, 'no', '0', 450, 483, 'true'),
  (64, NULL, 'no', '0', 250, 0, 'true'),
  (65, NULL, 'no', '0', 1350, 0, 'true'),
  (66, NULL, 'no', '0', 1500, 0, 'true'),
  (67, NULL, 'no', '0', 600, 0, 'true'),
  (68, NULL, 'no', '0', 2000, 0, 'true'),
  (69, NULL, 'no', '0', 2100, 0, 'true'),
  (70, NULL, 'no', '0', 1000, 0, 'true'),
  (71, NULL, 'no', '0', 2000, 0, 'true'),
  (72, NULL, 'no', '0', 2000, 4000, 'true'),
  (73, NULL, 'no', '0', 1250, 4000, 'true'),
  (74, NULL, 'no', '0', 1000, 0, 'true');
/*!40000 ALTER TABLE `properties_businesses_normal` ENABLE KEYS */;
-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_businesses_normal_weapons
CREATE TABLE IF NOT EXISTS `properties_businesses_normal_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) DEFAULT NULL,
  `sellprice` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ammo` varchar(20) DEFAULT NULL,
  `suppressor` varchar(20) NOT NULL DEFAULT 'false',
  `flashlight` varchar(20) NOT NULL DEFAULT 'false',
  `extended_clip` varchar(20) NOT NULL DEFAULT 'false',
  `scope` varchar(20) NOT NULL DEFAULT 'false',
  `grip` varchar(20) NOT NULL DEFAULT 'false',
  `advanced_scope` varchar(20) NOT NULL DEFAULT 'false',
  `skin` varchar(20) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=341 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_houses_enterable
CREATE TABLE IF NOT EXISTS `properties_houses_enterable` (
  `id` int(11) NOT NULL,
  `character_id` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  `vault_locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_houses_enterable` (`character_id`),
  CONSTRAINT `fk_character_id_houses_enterable` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table rivalry_newecon.properties_houses_enterable: ~14 rows (approximately)
/*!40000 ALTER TABLE `properties_houses_enterable` DISABLE KEYS */;
INSERT INTO `properties_houses_enterable` (`id`, `character_id`, `identifier`, `expire`, `cash`, `dirty`, `locked`, `vault_locked`) VALUES
  (1, NULL, 'no', '0', 0, 0, 'true', 'true'),
  (2, NULL, 'no', '0', 0, 0, 'true', 'true'),
  (3, NULL, 'no', '0', 0, 21396, 'false', 'true'),
  (4, NULL, 'no', '0', 6900, 2831, 'true', 'true'),
  (5, NULL, 'no', '0', 0, 0, 'true', 'true'),
  (6, NULL, 'no', '0', 0, 0, 'true', 'false'),
  (7, NULL, 'no', '0', 0, 0, 'true', 'true'),
  (8, NULL, 'no', '0', 0, 17721, 'true', 'true'),
  (9, NULL, 'no', '0', 0, 0, 'false', 'true'),
  (10, NULL, 'no', '0', 0, 0, 'false', 'true'),
  (11, NULL, 'no', '0', 0, 0, 'true', 'true'),
  (12, NULL, 'no', '0', 0, 3913, 'true', 'true'),
  (13, NULL, 'no', '0', 0, 32446, 'true', 'true'),
  (14, NULL, 'no', '0', 0, 19056, 'true', 'true');
/*!40000 ALTER TABLE `properties_houses_enterable` ENABLE KEYS */;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_houses_enterable_weapons
CREATE TABLE IF NOT EXISTS `properties_houses_enterable_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) DEFAULT NULL,
  `sellprice` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ammo` varchar(20) DEFAULT NULL,
  `suppressor` varchar(20) NOT NULL DEFAULT 'false',
  `flashlight` varchar(20) NOT NULL DEFAULT 'false',
  `extended_clip` varchar(20) NOT NULL DEFAULT 'false',
  `scope` varchar(20) NOT NULL DEFAULT 'false',
  `grip` varchar(20) NOT NULL DEFAULT 'false',
  `advanced_scope` varchar(20) NOT NULL DEFAULT 'false',
  `skin` varchar(20) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_houses_normal
CREATE TABLE IF NOT EXISTS `properties_houses_normal` (
  `id` int(11) NOT NULL,
  `character_id` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT 'no',
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_houses_normal` (`character_id`),
  CONSTRAINT `fk_character_id_houses_normal` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rivalry_newecon.properties_houses_normal: ~56 rows (approximately)
/*!40000 ALTER TABLE `properties_houses_normal` DISABLE KEYS */;
INSERT INTO `properties_houses_normal` (`id`, `character_id`, `identifier`, `expire`, `cash`, `dirty`, `locked`) VALUES
  (1, NULL, 'no', '0', 0, 73, 'true'),
  (2, NULL, 'no', '0', 1, 0, 'false'),
  (3, NULL, 'no', '0', 0, 3500, 'true'),
  (4, NULL, 'no', '0', 0, 0, 'true'),
  (5, NULL, 'no', '0', 0, 0, 'true'),
  (6, NULL, 'no', '0', 0, 0, 'true'),
  (7, NULL, 'no', '0', 0, 0, 'true'),
  (8, NULL, 'no', '0', 10000, 49000, 'true'),
  (9, NULL, 'no', '0', 0, 0, 'true'),
  (10, NULL, 'no', '0', 1000, 3261, 'true'),
  (11, NULL, 'no', '0', 0, 129, 'true'),
  (12, NULL, 'no', '0', 2580, 0, 'true'),
  (13, NULL, 'no', '0', 0, 0, 'true'),
  (14, NULL, 'no', '0', 0, 0, 'true'),
  (15, NULL, 'no', '0', 0, 2974, 'true'),
  (16, NULL, 'no', '0', 0, 15984, 'true'),
  (17, NULL, 'no', '0', 0, 144, 'true'),
  (18, NULL, 'no', '0', 900, 17211, 'true'),
  (19, NULL, 'no', '0', 10000, 49628, 'true'),
  (20, NULL, 'no', '0', 9855, 6992, 'true'),
  (21, NULL, 'no', '0', 10000, 50000, 'true'),
  (22, NULL, 'no', '0', 0, 27457, 'true'),
  (23, NULL, 'no', '0', 0, 0, 'false'),
  (24, NULL, 'no', '0', 0, 0, 'true'),
  (25, NULL, 'no', '0', 0, 15000, 'true'),
  (26, NULL, 'no', '0', 0, 0, 'true'),
  (27, NULL, 'no', '0', 0, 0, 'true'),
  (28, NULL, 'no', '0', 0, 683, 'true'),
  (29, NULL, 'no', '0', 0, 0, 'true'),
  (30, NULL, 'no', '0', 4000, 9666, 'true'),
  (31, NULL, 'no', '0', 0, 0, 'true'),
  (32, NULL, 'no', '0', 0, 0, 'true'),
  (33, NULL, 'no', '0', 0, 21177, 'true'),
  (34, NULL, 'no', '0', 0, 992, 'true'),
  (35, NULL, 'no', '0', 0, 0, 'true'),
  (36, NULL, 'no', '0', 0, 0, 'true'),
  (37, NULL, 'no', '0', 0, 4485, 'true'),
  (38, NULL, 'no', '0', 0, 13828, 'true'),
  (39, NULL, 'no', '0', 0, 0, 'true'),
  (40, NULL, 'no', '0', 0, 17682, 'true'),
  (41, NULL, 'no', '0', 0, 39475, 'true'),
  (42, NULL, 'no', '0', 9000, 34332, 'true'),
  (43, NULL, 'no', '0', 0, 0, 'true'),
  (44, NULL, 'no', '0', 0, 0, 'true'),
  (45, NULL, 'no', '0', 2545, 4604, 'true'),
  (46, NULL, 'no', '0', 0, 0, 'true'),
  (47, NULL, 'no', '0', 0, 0, 'true'),
  (48, NULL, 'no', '0', 0, 257, 'true'),
  (49, NULL, 'no', '0', 2, 44581, 'true'),
  (50, NULL, 'no', '0', 0, 25842, 'true'),
  (51, NULL, 'no', '0', 0, 10482, 'true'),
  (52, NULL, 'no', '0', 0, 0, 'true'),
  (53, NULL, 'no', '0', 0, 13977, 'true'),
  (54, NULL, 'no', '0', 0, 0, 'true'),
  (55, NULL, 'no', '0', 0, 12505, 'true'),
  (56, NULL, 'no', '0', 0, 20006, 'true');
/*!40000 ALTER TABLE `properties_houses_normal` ENABLE KEYS */;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.properties_houses_normal_weapons
CREATE TABLE IF NOT EXISTS `properties_houses_normal_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) DEFAULT NULL,
  `sellprice` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ammo` varchar(20) DEFAULT NULL,
  `suppressor` varchar(20) NOT NULL DEFAULT 'false',
  `flashlight` varchar(20) NOT NULL DEFAULT 'false',
  `extended_clip` varchar(20) NOT NULL DEFAULT 'false',
  `scope` varchar(20) NOT NULL DEFAULT 'false',
  `grip` varchar(20) NOT NULL DEFAULT 'false',
  `advanced_scope` varchar(20) NOT NULL DEFAULT 'false',
  `skin` varchar(20) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1359 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.scrap_stockpile
CREATE TABLE IF NOT EXISTS `scrap_stockpile` (
  `id` int(11) NOT NULL,
  `total` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(200) CHARACTER SET latin1 NOT NULL,
  `license` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `timestamp` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `lastplayed` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `power_level` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `group` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `plate` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `garage_id` int(11) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `instance` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `cost` varchar(50) DEFAULT NULL,
  `primary_colour` int(11) unsigned DEFAULT NULL,
  `secondary_colour` int(11) DEFAULT NULL,
  `pearlescent_colour` int(11) DEFAULT NULL,
  `wheel_colour` int(11) DEFAULT NULL,
  `smoke_colour` tinytext DEFAULT NULL,
  `plate_colour` int(11) DEFAULT NULL,
  `neon_colour` tinytext DEFAULT NULL,
  `tint_colour` int(11) DEFAULT NULL,
  `mod0` int(11) DEFAULT NULL,
  `mod1` int(11) DEFAULT NULL,
  `mod2` int(11) DEFAULT NULL,
  `mod3` int(11) DEFAULT NULL,
  `mod4` int(11) DEFAULT NULL,
  `mod5` int(11) DEFAULT NULL,
  `mod6` int(11) DEFAULT NULL,
  `mod7` int(11) DEFAULT NULL,
  `mod8` int(11) DEFAULT NULL,
  `mod10` int(11) DEFAULT NULL,
  `mod11` int(11) DEFAULT NULL,
  `mod12` int(11) DEFAULT NULL,
  `mod13` int(11) DEFAULT NULL,
  `mod14` int(11) DEFAULT NULL,
  `mod15` int(11) DEFAULT NULL,
  `mod16` int(11) DEFAULT NULL,
  `mod23` int(11) DEFAULT NULL,
  `mod24` int(11) DEFAULT NULL,
  `mod25` int(11) DEFAULT NULL,
  `mod26` int(11) DEFAULT NULL,
  `mod27` int(11) DEFAULT NULL,
  `mod28` int(11) DEFAULT NULL,
  `mod29` int(11) DEFAULT NULL,
  `mod30` int(11) DEFAULT NULL,
  `mod31` int(11) DEFAULT NULL,
  `mod32` int(11) DEFAULT NULL,
  `mod33` int(11) DEFAULT NULL,
  `mod34` int(11) DEFAULT NULL,
  `mod35` int(11) DEFAULT NULL,
  `mod36` int(11) DEFAULT NULL,
  `mod37` int(11) DEFAULT NULL,
  `mod38` int(11) DEFAULT NULL,
  `mod39` int(11) DEFAULT NULL,
  `mod40` int(11) DEFAULT NULL,
  `mod41` int(11) DEFAULT NULL,
  `mod42` int(11) DEFAULT NULL,
  `mod43` int(11) DEFAULT NULL,
  `mod44` int(11) DEFAULT NULL,
  `mod45` int(11) DEFAULT NULL,
  `mod46` int(11) DEFAULT NULL,
  `mod48` int(11) DEFAULT NULL,
  `tyre_smoke` varchar(20) DEFAULT NULL,
  `xenon_lights` varchar(20) DEFAULT NULL,
  `turbo` varchar(20) DEFAULT NULL,
  `custom_wheels` varchar(20) DEFAULT NULL,
  `custom_wheels2` varchar(20) DEFAULT NULL,
  `bulletproof_wheels` varchar(20) DEFAULT NULL,
  `wheeltype` int(11) DEFAULT NULL,
  `neon0` varchar(20) DEFAULT NULL,
  `neon1` varchar(20) DEFAULT NULL,
  `neon2` varchar(20) DEFAULT NULL,
  `neon3` varchar(20) DEFAULT NULL,
  `engine_health` float DEFAULT NULL,
  `petrol_health` float DEFAULT NULL,
  `vehicle_health` float DEFAULT NULL,
  `body_health` float DEFAULT NULL,
  `insurance` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `fk_character_id_vehicles` (`character_id`),
  CONSTRAINT `fk_character_id_vehicles` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12598 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.vehicle_inventory
CREATE TABLE IF NOT EXISTS `vehicle_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `canuse` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8845 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.vehicle_weapon_inventory
CREATE TABLE IF NOT EXISTS `vehicle_weapon_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `sellprice` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ammo` varchar(20) DEFAULT NULL,
  `suppressor` varchar(20) NOT NULL DEFAULT 'false',
  `flashlight` varchar(20) NOT NULL DEFAULT 'false',
  `extended_clip` varchar(20) NOT NULL DEFAULT 'false',
  `scope` varchar(20) NOT NULL DEFAULT 'false',
  `grip` varchar(20) NOT NULL DEFAULT 'false',
  `advanced_scope` varchar(20) NOT NULL DEFAULT 'false',
  `skin` varchar(20) DEFAULT NULL,
  `locked` varchar(50) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5780 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.weapons
CREATE TABLE IF NOT EXISTS `weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `sellprice` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ammo` varchar(20) DEFAULT NULL,
  `suppressor` varchar(20) NOT NULL DEFAULT 'false',
  `flashlight` varchar(20) NOT NULL DEFAULT 'false',
  `extended_clip` varchar(20) NOT NULL DEFAULT 'false',
  `scope` varchar(20) NOT NULL DEFAULT 'false',
  `grip` varchar(20) NOT NULL DEFAULT 'false',
  `advanced_scope` varchar(20) NOT NULL DEFAULT 'false',
  `skin` varchar(20) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_weapons` (`character_id`),
  CONSTRAINT `fk_character_id_weapons` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14445 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table rivalryrp_neweco.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
