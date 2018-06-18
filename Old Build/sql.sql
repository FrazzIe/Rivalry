-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table fxserver.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) DEFAULT NULL,
  `license` varchar(200) DEFAULT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `expire` varchar(50) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `banner` varchar(40) DEFAULT NULL,
  `permanent` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.bans_archive
CREATE TABLE IF NOT EXISTS `bans_archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) DEFAULT NULL,
  `license` varchar(200) DEFAULT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `expire` varchar(50) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `banner` varchar(40) DEFAULT NULL,
  `permanent` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `character_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(200) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `dob` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `wallet` int(11) DEFAULT '0',
  `bank` int(11) DEFAULT '0',
  `dirty_cash` int(11) DEFAULT '0',
  `timeplayed` int(11) DEFAULT '0',
  `position_x` float DEFAULT NULL,
  `position_y` float DEFAULT NULL,
  `position_z` float DEFAULT NULL,
  `weapon_license` varchar(20) DEFAULT 'false',
  `jail_time` varchar(20) DEFAULT '0',
  `job_id` int(11) DEFAULT '1',
  `drivers_license` varchar(20) DEFAULT 'false',
  PRIMARY KEY (`character_id`),
  KEY `fk_users_identifier` (`identifier`),
  CONSTRAINT `fk_users_identifier` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.doj
CREATE TABLE IF NOT EXISTS `doj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_police` (`character_id`),
  CONSTRAINT `doj_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.garages
CREATE TABLE IF NOT EXISTS `garages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `garage_id` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `slots` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_garages` (`character_id`),
  CONSTRAINT `fk_character_id_garages` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `canuse` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_inventory` (`character_id`),
  CONSTRAINT `fk_character_id_inventory` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.models
CREATE TABLE IF NOT EXISTS `models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `new` varchar(20) DEFAULT NULL,
  `clothing_drawables` mediumtext,
  `clothing_textures` mediumtext,
  `clothing_palette` mediumtext,
  `props_drawables` mediumtext,
  `props_textures` mediumtext,
  `overlays_drawables` mediumtext,
  `overlays_opacity` mediumtext,
  `overlays_colours` mediumtext,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_model` (`character_id`),
  CONSTRAINT `fk_character_id_model` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(75) DEFAULT NULL,
  `clothing_drawables` text,
  `clothing_textures` text,
  `clothing_palettes` text,
  `prop_drawables` text,
  `prop_textures` text,
  PRIMARY KEY (`id`),
  KEY `fk_outfits_character_id` (`character_id`),
  CONSTRAINT `fk_outfits_character_id` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.paramedic
CREATE TABLE IF NOT EXISTS `paramedic` (
  `unit` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `onduty` varchar(50) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`unit`),
  KEY `fk_character_id_paramedic` (`character_id`),
  CONSTRAINT `fk_character_id_paramedic` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.paramedic_models
CREATE TABLE IF NOT EXISTS `paramedic_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `new` varchar(20) DEFAULT NULL,
  `clothing_drawables` mediumtext,
  `clothing_textures` mediumtext,
  `clothing_palette` mediumtext,
  `props_drawables` mediumtext,
  `props_textures` mediumtext,
  `overlays_drawables` mediumtext,
  `overlays_opacity` mediumtext,
  `overlays_colours` mediumtext,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_paramedic_model` (`character_id`),
  CONSTRAINT `fk_character_id_paramedic_model` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.phone
CREATE TABLE IF NOT EXISTS `phone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) DEFAULT NULL,
  `character_id` int(11) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`),
  KEY `fk_character_id_phone` (`character_id`),
  CONSTRAINT `fk_character_id_phone` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.phone_contacts
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_phone_contacts` (`character_id`),
  CONSTRAINT `fk_character_id_phone_contacts` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_identifier` varchar(100) DEFAULT NULL,
  `source_number` varchar(100) DEFAULT NULL,
  `message` longtext,
  `target_identifier` varchar(100) DEFAULT NULL,
  `target_number` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.police
CREATE TABLE IF NOT EXISTS `police` (
  `unit` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `onduty` varchar(50) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`unit`),
  KEY `fk_character_id_police` (`character_id`),
  CONSTRAINT `fk_character_id_police` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.police_arrests
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
  `charges` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.police_models
CREATE TABLE IF NOT EXISTS `police_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `new` varchar(20) DEFAULT NULL,
  `clothing_drawables` mediumtext,
  `clothing_textures` mediumtext,
  `clothing_palette` mediumtext,
  `props_drawables` mediumtext,
  `props_textures` mediumtext,
  `overlays_drawables` mediumtext,
  `overlays_opacity` mediumtext,
  `overlays_colours` mediumtext,
  PRIMARY KEY (`id`),
  KEY `fk_character_id_police_models` (`character_id`),
  CONSTRAINT `fk_character_id_police_models` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.police_violations
CREATE TABLE IF NOT EXISTS `police_violations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(80) DEFAULT NULL,
  `officer_identifier` varchar(80) DEFAULT NULL,
  `officer_name` varchar(80) DEFAULT NULL,
  `offender_identifier` varchar(80) DEFAULT NULL,
  `offender_name` varchar(80) DEFAULT NULL,
  `fine` int(11) DEFAULT NULL,
  `violations` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.police_warrants
CREATE TABLE IF NOT EXISTS `police_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(80) DEFAULT NULL,
  `officer_name` varchar(60) DEFAULT NULL,
  `offender_name` varchar(60) DEFAULT NULL,
  `location` varchar(80) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_businesses_enterable
CREATE TABLE IF NOT EXISTS `properties_businesses_enterable` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `character_id` int(11) DEFAULT NULL,
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  `vault_locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_businesses_enterable` (`character_id`),
  CONSTRAINT `fk_character_id_businesses_enterable` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_businesses_enterable_weapons
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_businesses_normal
CREATE TABLE IF NOT EXISTS `properties_businesses_normal` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `character_id` int(11) DEFAULT NULL,
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_businesses_normal` (`character_id`),
  CONSTRAINT `fk_character_id_businesses_normal` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_businesses_normal_weapons
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_houses_enterable
CREATE TABLE IF NOT EXISTS `properties_houses_enterable` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `character_id` int(11) DEFAULT NULL,
  `expire` varchar(100) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `dirty` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  `vault_locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `fk_character_id_houses_enterable` (`character_id`),
  CONSTRAINT `fk_character_id_houses_enterable` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_houses_enterable_weapons
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_houses_normal
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

-- Data exporting was unselected.
-- Dumping structure for table fxserver.properties_houses_normal_weapons
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(200) NOT NULL,
  `license` varchar(200) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `lastplayed` varchar(50) DEFAULT NULL,
  `power_level` varchar(50) DEFAULT NULL,
  `group` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `plate` int(8) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) DEFAULT NULL,
  `garage_id` int(11) DEFAULT NULL,
  `cost` varchar(50) NOT NULL,
  `type` varchar(100) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `primary_colour` int(11) DEFAULT NULL,
  `secondary_colour` int(11) NOT NULL,
  `pearlescent_colour` int(11) DEFAULT NULL,
  `wheel_colour` int(11) DEFAULT NULL,
  `smoke_colour` tinytext,
  `plate_colour` int(11) DEFAULT NULL,
  `neon_colour` tinytext,
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
  CONSTRAINT `fk_character_id_vehicles` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.vehicle_inventory
CREATE TABLE IF NOT EXISTS `vehicle_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `canuse` int(11) DEFAULT NULL,
  `locked` varchar(50) DEFAULT 'true',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.vehicle_weapon_inventory
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.weapons
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
  PRIMARY KEY (`id`),
  KEY `fk_character_id_weapons` (`character_id`),
  CONSTRAINT `fk_character_id_weapons` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table fxserver.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
