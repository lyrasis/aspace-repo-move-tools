# ************************************************************
# Sequel Ace SQL dump
# Version 20094
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 8.4.8)
# Database: merge_1
# Generation Time: 2026-02-16 18:55:59 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table accession
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accession`;

CREATE TABLE `accession` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `identifier` varchar(255) NOT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `display_string` text,
  `publish` int DEFAULT NULL,
  `content_description` text,
  `condition_description` text,
  `disposition` text,
  `inventory` text,
  `provenance` text,
  `general_note` text,
  `resource_type_id` int DEFAULT NULL,
  `acquisition_type_id` int DEFAULT NULL,
  `accession_date` date DEFAULT NULL,
  `restrictions_apply` int DEFAULT NULL,
  `retention_rule` text,
  `access_restrictions` int DEFAULT NULL,
  `access_restrictions_note` text,
  `use_restrictions` int DEFAULT NULL,
  `use_restrictions_note` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accession_unique_identifier` (`repo_id`,`identifier`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `acquisition_type_id` (`acquisition_type_id`),
  KEY `accession_system_mtime_index` (`system_mtime`),
  KEY `accession_user_mtime_index` (`user_mtime`),
  KEY `accession_suppressed_index` (`suppressed`),
  CONSTRAINT `accession_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `accession_ibfk_2` FOREIGN KEY (`acquisition_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `accession_ibfk_3` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table accession_component_links_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accession_component_links_rlshp`;

CREATE TABLE `accession_component_links_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `suppressed` int DEFAULT '0',
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accession_component_links_rlshp_system_mtime_index` (`system_mtime`),
  KEY `accession_component_links_rlshp_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  CONSTRAINT `accession_component_links_rlshp_ibfk_1` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `accession_component_links_rlshp_ibfk_2` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table active_edit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `active_edit`;

CREATE TABLE `active_edit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active_edit_timestamp_index` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_alternate_set
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_alternate_set`;

CREATE TABLE `agent_alternate_set` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_version_xlink_actuate_attribute_id` int DEFAULT NULL,
  `file_version_xlink_show_attribute_id` int DEFAULT NULL,
  `set_component` varchar(255) DEFAULT NULL,
  `descriptive_note` text,
  `file_uri` varchar(255) DEFAULT NULL,
  `xlink_title_attribute` varchar(255) DEFAULT NULL,
  `xlink_role_attribute` varchar(255) DEFAULT NULL,
  `xlink_arcrole_attribute` varchar(255) DEFAULT NULL,
  `last_verified_date` datetime DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_alternate_set_system_mtime_index` (`system_mtime`),
  KEY `agent_alternate_set_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_alternate_set_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_alternate_set_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_alternate_set_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_alternate_set_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_contact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_contact`;

CREATE TABLE `agent_contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `name` text NOT NULL,
  `salutation_id` int DEFAULT NULL,
  `address_1` text,
  `address_2` text,
  `address_3` text,
  `city` text,
  `region` text,
  `country` text,
  `post_code` text,
  `email` text,
  `email_signature` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `is_representative` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agent_person_one_representative_contact` (`is_representative`,`agent_person_id`),
  UNIQUE KEY `agent_corporate_entity_one_representative_contact` (`is_representative`,`agent_corporate_entity_id`),
  UNIQUE KEY `agent_family_one_representative_contact` (`is_representative`,`agent_family_id`),
  UNIQUE KEY `agent_software_one_representative_contact` (`is_representative`,`agent_software_id`),
  KEY `salutation_id` (`salutation_id`),
  KEY `agent_contact_system_mtime_index` (`system_mtime`),
  KEY `agent_contact_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_contact_ibfk_1` FOREIGN KEY (`salutation_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `agent_contact_ibfk_2` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_contact_ibfk_3` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_contact_ibfk_4` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_contact_ibfk_5` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `agent_contact` WRITE;
/*!40000 ALTER TABLE `agent_contact` DISABLE KEYS */;

INSERT INTO `agent_contact` (`id`, `lock_version`, `json_schema_version`, `agent_person_id`, `agent_family_id`, `agent_corporate_entity_id`, `agent_software_id`, `name`, `salutation_id`, `address_1`, `address_2`, `address_3`, `city`, `region`, `country`, `post_code`, `email`, `email_signature`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `is_representative`)
VALUES
	(1,0,1,NULL,NULL,1,NULL,'Merge 1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18',1);

/*!40000 ALTER TABLE `agent_contact` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table agent_conventions_declaration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_conventions_declaration`;

CREATE TABLE `agent_conventions_declaration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_rule_id` int DEFAULT NULL,
  `file_version_xlink_actuate_attribute_id` int DEFAULT NULL,
  `file_version_xlink_show_attribute_id` int DEFAULT NULL,
  `citation` varchar(255) DEFAULT NULL,
  `descriptive_note` text NOT NULL,
  `file_uri` varchar(255) DEFAULT NULL,
  `xlink_title_attribute` varchar(255) DEFAULT NULL,
  `xlink_role_attribute` varchar(255) DEFAULT NULL,
  `xlink_arcrole_attribute` varchar(255) DEFAULT NULL,
  `last_verified_date` datetime DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_conventions_declaration_system_mtime_index` (`system_mtime`),
  KEY `agent_conventions_declaration_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_conventions_declaration_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_conventions_declaration_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_conventions_declaration_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_conventions_declaration_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_corporate_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_corporate_entity`;

CREATE TABLE `agent_corporate_entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `publish` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `agent_sha1` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sha1_agent_corporate_entity` (`agent_sha1`),
  KEY `agent_corporate_entity_system_mtime_index` (`system_mtime`),
  KEY `agent_corporate_entity_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `agent_corporate_entity` WRITE;
/*!40000 ALTER TABLE `agent_corporate_entity` DISABLE KEYS */;

INSERT INTO `agent_corporate_entity` (`id`, `lock_version`, `json_schema_version`, `publish`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `agent_sha1`, `slug`, `is_slug_auto`)
VALUES
	(1,0,1,0,'admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18','28bafff2396d5180fabd8707170daa02744d774f',NULL,0);

/*!40000 ALTER TABLE `agent_corporate_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table agent_family
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_family`;

CREATE TABLE `agent_family` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `publish` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `agent_sha1` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sha1_agent_family` (`agent_sha1`),
  KEY `agent_family_system_mtime_index` (`system_mtime`),
  KEY `agent_family_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_function
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_function`;

CREATE TABLE `agent_function` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `suppressed` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_function_system_mtime_index` (`system_mtime`),
  KEY `agent_function_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_function_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_function_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_function_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_function_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_gender
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_gender`;

CREATE TABLE `agent_gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gender_id` int NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_gender_system_mtime_index` (`system_mtime`),
  KEY `agent_gender_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  CONSTRAINT `agent_gender_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_identifier
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_identifier`;

CREATE TABLE `agent_identifier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier_type_id` int DEFAULT NULL,
  `entity_identifier` varchar(255) NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_identifier_system_mtime_index` (`system_mtime`),
  KEY `agent_identifier_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_identifier_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_identifier_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_identifier_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_identifier_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_maintenance_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_maintenance_history`;

CREATE TABLE `agent_maintenance_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maintenance_event_type_id` int NOT NULL,
  `maintenance_agent_type_id` int NOT NULL,
  `event_date` datetime NOT NULL,
  `agent` varchar(255) NOT NULL,
  `descriptive_note` text NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_maintenance_history_system_mtime_index` (`system_mtime`),
  KEY `agent_maintenance_history_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_maintenance_history_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_5` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_6` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_7` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_maintenance_history_ibfk_8` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_occupation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_occupation`;

CREATE TABLE `agent_occupation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `suppressed` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_occupation_system_mtime_index` (`system_mtime`),
  KEY `agent_occupation_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_occupation_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_occupation_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_occupation_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_occupation_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_other_agency_codes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_other_agency_codes`;

CREATE TABLE `agent_other_agency_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agency_code_type_id` int DEFAULT NULL,
  `maintenance_agency` varchar(255) NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_other_agency_codes_system_mtime_index` (`system_mtime`),
  KEY `agent_other_agency_codes_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_other_agency_codes_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_other_agency_codes_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_other_agency_codes_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_other_agency_codes_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_person
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_person`;

CREATE TABLE `agent_person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `publish` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `agent_sha1` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sha1_agent_person` (`agent_sha1`),
  KEY `agent_person_system_mtime_index` (`system_mtime`),
  KEY `agent_person_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `agent_person` WRITE;
/*!40000 ALTER TABLE `agent_person` DISABLE KEYS */;

INSERT INTO `agent_person` (`id`, `lock_version`, `json_schema_version`, `publish`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `agent_sha1`, `slug`, `is_slug_auto`)
VALUES
	(1,0,1,0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07','2eacf39a2b8fdd13d8a84323f9798941',NULL,1);

/*!40000 ALTER TABLE `agent_person` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table agent_place
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_place`;

CREATE TABLE `agent_place` (
  `id` int NOT NULL AUTO_INCREMENT,
  `place_role_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `suppressed` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_place_system_mtime_index` (`system_mtime`),
  KEY `agent_place_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_place_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_place_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_place_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_place_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_record_control
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_record_control`;

CREATE TABLE `agent_record_control` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maintenance_status_id` int NOT NULL,
  `publication_status_id` int DEFAULT NULL,
  `government_agency_type_id` int DEFAULT NULL,
  `reference_evaluation_id` int DEFAULT NULL,
  `name_type_id` int DEFAULT NULL,
  `level_of_detail_id` int DEFAULT NULL,
  `modified_record_id` int DEFAULT NULL,
  `cataloging_source_id` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `romanization_id` int DEFAULT NULL,
  `maintenance_agency` varchar(255) DEFAULT NULL,
  `agency_name` varchar(255) DEFAULT NULL,
  `maintenance_agency_note` text,
  `language_note` text,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_record_control_system_mtime_index` (`system_mtime`),
  KEY `agent_record_control_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_record_control_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_record_control_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_record_control_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_record_control_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_record_identifier
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_record_identifier`;

CREATE TABLE `agent_record_identifier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier_type_id` int DEFAULT NULL,
  `source_id` int NOT NULL,
  `primary_identifier` int NOT NULL,
  `record_identifier` varchar(255) NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_record_identifier_system_mtime_index` (`system_mtime`),
  KEY `agent_record_identifier_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_resource`;

CREATE TABLE `agent_resource` (
  `id` int NOT NULL AUTO_INCREMENT,
  `linked_agent_role_id` int NOT NULL,
  `linked_resource` varchar(8704) NOT NULL,
  `linked_resource_description` text,
  `file_uri` varchar(255) DEFAULT NULL,
  `file_version_xlink_actuate_attribute_id` int DEFAULT NULL,
  `file_version_xlink_show_attribute_id` int DEFAULT NULL,
  `xlink_title_attribute` varchar(255) DEFAULT NULL,
  `xlink_role_attribute` varchar(255) DEFAULT NULL,
  `xlink_arcrole_attribute` varchar(255) DEFAULT NULL,
  `last_verified_date` datetime DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `suppressed` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_resource_system_mtime_index` (`system_mtime`),
  KEY `agent_resource_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_resource_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_resource_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_resource_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_resource_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_software
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_software`;

CREATE TABLE `agent_software` (
  `id` int NOT NULL AUTO_INCREMENT,
  `system_role` varchar(255) NOT NULL DEFAULT 'none',
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `publish` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `agent_sha1` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sha1_agent_software` (`agent_sha1`),
  KEY `agent_software_system_role_index` (`system_role`),
  KEY `agent_software_system_mtime_index` (`system_mtime`),
  KEY `agent_software_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `agent_software` WRITE;
/*!40000 ALTER TABLE `agent_software` DISABLE KEYS */;

INSERT INTO `agent_software` (`id`, `system_role`, `lock_version`, `json_schema_version`, `publish`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `agent_sha1`, `slug`, `is_slug_auto`)
VALUES
	(1,'archivesspace_agent',0,1,0,NULL,NULL,'2026-02-16 15:41:06','2026-02-16 15:41:06','2026-02-16 15:41:06','18c2cb4858c38598effe161a42a1c8f58d3d0f9e',NULL,1);

/*!40000 ALTER TABLE `agent_software` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table agent_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_sources`;

CREATE TABLE `agent_sources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_entry` varchar(255) DEFAULT NULL,
  `descriptive_note` text,
  `file_uri` varchar(255) DEFAULT NULL,
  `file_version_xlink_actuate_attribute_id` int DEFAULT NULL,
  `file_version_xlink_show_attribute_id` int DEFAULT NULL,
  `xlink_title_attribute` varchar(255) DEFAULT NULL,
  `xlink_role_attribute` varchar(255) DEFAULT NULL,
  `xlink_arcrole_attribute` varchar(255) DEFAULT NULL,
  `last_verified_date` datetime DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_sources_system_mtime_index` (`system_mtime`),
  KEY `agent_sources_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_sources_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_sources_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_sources_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_sources_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table agent_topic
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agent_topic`;

CREATE TABLE `agent_topic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `suppressed` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `agent_topic_system_mtime_index` (`system_mtime`),
  KEY `agent_topic_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `agent_topic_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `agent_topic_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `agent_topic_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `agent_topic_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table archival_object
# ------------------------------------------------------------

DROP TABLE IF EXISTS `archival_object`;

CREATE TABLE `archival_object` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `root_record_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  `position` int NOT NULL,
  `publish` int NOT NULL DEFAULT '0',
  `ref_id` varchar(255) NOT NULL,
  `component_id` varchar(255) DEFAULT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `display_string` text,
  `level_id` int NOT NULL,
  `other_level` varchar(255) DEFAULT NULL,
  `system_generated` int DEFAULT '0',
  `restrictions_apply` int DEFAULT NULL,
  `repository_processing_note` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ao_unique_refid` (`root_record_id`,`ref_id`),
  UNIQUE KEY `uniq_ao_pos` (`parent_name`,`position`),
  KEY `level_id` (`level_id`),
  KEY `archival_object_system_mtime_index` (`system_mtime`),
  KEY `archival_object_user_mtime_index` (`user_mtime`),
  KEY `repo_id` (`repo_id`),
  KEY `ao_parent_root_idx` (`parent_id`,`root_record_id`),
  KEY `archival_object_ref_id_index` (`ref_id`),
  KEY `archival_object_component_id_index` (`component_id`),
  CONSTRAINT `archival_object_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `archival_object_ibfk_3` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`),
  CONSTRAINT `archival_object_ibfk_4` FOREIGN KEY (`root_record_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `archival_object_ibfk_5` FOREIGN KEY (`parent_id`) REFERENCES `archival_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `archival_object` WRITE;
/*!40000 ALTER TABLE `archival_object` DISABLE KEYS */;

INSERT INTO `archival_object` (`id`, `lock_version`, `json_schema_version`, `repo_id`, `root_record_id`, `parent_id`, `parent_name`, `position`, `publish`, `ref_id`, `component_id`, `title`, `display_string`, `level_id`, `other_level`, `system_generated`, `restrictions_apply`, `repository_processing_note`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `suppressed`, `slug`, `is_slug_auto`)
VALUES
	(1,1,1,2,1,NULL,'root@/repositories/2/resources/1',1000,0,'f34ae6fea866724dbe59803609801d5a',NULL,'ao','ao',895,NULL,0,0,NULL,'admin','admin','2026-02-16 18:49:53','2026-02-16 18:52:50','2026-02-16 18:52:50',0,NULL,0),
	(2,1,1,2,1,NULL,'root@/repositories/2/resources/1',2000,0,'536f17f0d10f3975efd4e6177d583847',NULL,'ao2','ao2',895,NULL,0,0,NULL,'admin','admin','2026-02-16 18:51:27','2026-02-16 18:52:14','2026-02-16 18:52:14',0,NULL,0);

/*!40000 ALTER TABLE `archival_object` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ark_name
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ark_name`;

CREATE TABLE `ark_name` (
  `id` int NOT NULL AUTO_INCREMENT,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `system_mtime` datetime DEFAULT NULL,
  `user_mtime` datetime DEFAULT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  `ark_value` varchar(255) NOT NULL,
  `is_current` int NOT NULL DEFAULT '0',
  `is_external_url` int DEFAULT '0',
  `retired_at_epoch_ms` bigint NOT NULL DEFAULT '0',
  `version_key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ark_name_ao_uniq` (`archival_object_id`,`is_current`,`retired_at_epoch_ms`),
  UNIQUE KEY `ark_name_resource_uniq` (`resource_id`,`is_current`,`retired_at_epoch_ms`),
  KEY `ark_name_archival_object_id_index` (`archival_object_id`),
  KEY `ark_name_resource_id_index` (`resource_id`),
  KEY `ark_name_ark_value_res_idx` (`ark_value`,`resource_id`),
  KEY `ark_name_ark_value_ao_idx` (`ark_value`,`archival_object_id`),
  CONSTRAINT `ark_name_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `ark_name_ibfk_2` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table ark_uniq_check
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ark_uniq_check`;

CREATE TABLE `ark_uniq_check` (
  `id` int NOT NULL AUTO_INCREMENT,
  `record_uri` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_ark_value` (`value`),
  KEY `record_uri_uniq_check_idx` (`record_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assessment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment`;

CREATE TABLE `assessment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `accession_report` int NOT NULL DEFAULT '0',
  `appraisal` int NOT NULL DEFAULT '0',
  `container_list` int NOT NULL DEFAULT '0',
  `catalog_record` int NOT NULL DEFAULT '0',
  `control_file` int NOT NULL DEFAULT '0',
  `finding_aid_ead` int NOT NULL DEFAULT '0',
  `finding_aid_paper` int NOT NULL DEFAULT '0',
  `finding_aid_word` int NOT NULL DEFAULT '0',
  `finding_aid_spreadsheet` int NOT NULL DEFAULT '0',
  `surveyed_duration` varchar(255) DEFAULT NULL,
  `surveyed_extent` text,
  `review_required` int NOT NULL DEFAULT '0',
  `purpose` text,
  `scope` text,
  `sensitive_material` int NOT NULL DEFAULT '0',
  `general_assessment_note` text,
  `special_format_note` text,
  `exhibition_value_note` text,
  `deed_of_gift` int DEFAULT NULL,
  `finding_aid_online` int DEFAULT NULL,
  `related_eac_records` int DEFAULT NULL,
  `existing_description_notes` text,
  `survey_begin` date NOT NULL DEFAULT '1970-01-01',
  `survey_end` date DEFAULT NULL,
  `review_note` text,
  `inactive` int DEFAULT NULL,
  `monetary_value` decimal(16,2) DEFAULT NULL,
  `monetary_value_note` text,
  `conservation_note` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_system_mtime_index` (`system_mtime`),
  KEY `assessment_user_mtime_index` (`user_mtime`),
  KEY `repo_id` (`repo_id`),
  CONSTRAINT `assessment_ibfk_1` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assessment_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment_attribute`;

CREATE TABLE `assessment_attribute` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `assessment_attribute_definition_id` int NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_id` (`assessment_id`),
  KEY `assessment_attribute_definition_id` (`assessment_attribute_definition_id`),
  CONSTRAINT `assessment_attribute_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `assessment_attribute_ibfk_2` FOREIGN KEY (`assessment_attribute_definition_id`) REFERENCES `assessment_attribute_definition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assessment_attribute_definition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment_attribute_definition`;

CREATE TABLE `assessment_attribute_definition` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` int NOT NULL,
  `label` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `position` int NOT NULL,
  `readonly` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assessment_attr_unique_label` (`repo_id`,`type`,`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `assessment_attribute_definition` WRITE;
/*!40000 ALTER TABLE `assessment_attribute_definition` DISABLE KEYS */;

INSERT INTO `assessment_attribute_definition` (`id`, `repo_id`, `label`, `type`, `position`, `readonly`)
VALUES
	(1,1,'Reformatting Readiness','rating',0,0),
	(2,1,'Housing Quality','rating',1,0),
	(3,1,'Physical Condition','rating',2,0),
	(4,1,'Physical Access (arrangement)','rating',3,0),
	(5,1,'Intellectual Access (description)','rating',4,0),
	(6,1,'Interest','rating',5,0),
	(7,1,'Documentation Quality','rating',6,0),
	(8,1,'Research Value','rating',7,1),
	(9,1,'Architectural Materials','format',7,0),
	(10,1,'Art Originals','format',8,0),
	(11,1,'Artifacts','format',9,0),
	(12,1,'Audio Materials','format',10,0),
	(13,1,'Biological Specimens','format',11,0),
	(14,1,'Botanical Specimens','format',12,0),
	(15,1,'Computer Storage Units','format',13,0),
	(16,1,'Film (negative, slide, or motion picture)','format',14,0),
	(17,1,'Glass','format',15,0),
	(18,1,'Photographs','format',16,0),
	(19,1,'Scrapbooks','format',17,0),
	(20,1,'Technical Drawings & Schematics','format',18,0),
	(21,1,'Textiles','format',19,0),
	(22,1,'Vellum & Parchment','format',20,0),
	(23,1,'Video Materials','format',21,0),
	(24,1,'Other','format',22,0),
	(25,1,'Potential Mold or Mold Damage','conservation_issue',23,0),
	(26,1,'Recent Pest Damage','conservation_issue',24,0),
	(27,1,'Deteriorating Film Base','conservation_issue',25,0),
	(28,1,'Brittle Paper','conservation_issue',26,0),
	(29,1,'Metal Fasteners','conservation_issue',27,0),
	(30,1,'Newspaper','conservation_issue',28,0),
	(31,1,'Tape','conservation_issue',29,0),
	(32,1,'Heat-Sensitive Paper','conservation_issue',30,0),
	(33,1,'Water Damage','conservation_issue',31,0);

/*!40000 ALTER TABLE `assessment_attribute_definition` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assessment_attribute_note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment_attribute_note`;

CREATE TABLE `assessment_attribute_note` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `assessment_attribute_definition_id` int NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_id` (`assessment_id`),
  KEY `assessment_attribute_definition_id` (`assessment_attribute_definition_id`),
  CONSTRAINT `assessment_attribute_note_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `assessment_attribute_note_ibfk_2` FOREIGN KEY (`assessment_attribute_definition_id`) REFERENCES `assessment_attribute_definition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assessment_reviewer_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment_reviewer_rlshp`;

CREATE TABLE `assessment_reviewer_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_reviewer_rlshp_system_mtime_index` (`system_mtime`),
  KEY `assessment_reviewer_rlshp_user_mtime_index` (`user_mtime`),
  KEY `assessment_id` (`assessment_id`),
  KEY `agent_person_id` (`agent_person_id`),
  CONSTRAINT `assessment_reviewer_rlshp_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `assessment_reviewer_rlshp_ibfk_2` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assessment_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assessment_rlshp`;

CREATE TABLE `assessment_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_rlshp_system_mtime_index` (`system_mtime`),
  KEY `assessment_rlshp_user_mtime_index` (`user_mtime`),
  KEY `assessment_id` (`assessment_id`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `digital_object_id` (`digital_object_id`),
  CONSTRAINT `assessment_rlshp_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `assessment_rlshp_ibfk_2` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `assessment_rlshp_ibfk_3` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `assessment_rlshp_ibfk_4` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `assessment_rlshp_ibfk_5` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table auth_db
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_db`;

CREATE TABLE `auth_db` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `pwhash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `auth_db_system_mtime_index` (`system_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `auth_db` WRITE;
/*!40000 ALTER TABLE `auth_db` DISABLE KEYS */;

INSERT INTO `auth_db` (`id`, `username`, `create_time`, `system_mtime`, `pwhash`)
VALUES
	(1,'admin','2026-02-16 15:41:07','2026-02-16 15:41:07','$2a$10$Yu/sMABXo.tI1pJlXK4jmetNLr1d.KuFDWL.ZdYRrwDnEmj7/4CP.'),
	(2,'search_indexer','2026-02-16 15:41:08','2026-02-16 18:43:45','$2a$10$7omgAQ7KeZDthd3eyWCwTO6xOUQVLiQ4kB2yVR1hcAVs0G3o07Yga'),
	(4,'public_anonymous','2026-02-16 15:41:08','2026-02-16 18:43:45','$2a$10$IFMGjhu00aTTxn6sCQsrTu1.794Ns0gvFlWTt.wN2PpxTI4sw1S5.'),
	(6,'staff_system','2026-02-16 15:41:08','2026-02-16 18:43:45','$2a$10$5r91qPde2CWqEsLTCAWw4Oe.FdJG5CT999R1gZAaEidm4bQtV8cDW');

/*!40000 ALTER TABLE `auth_db` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table classification
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classification`;

CREATE TABLE `classification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` int NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `title` varchar(8704) NOT NULL,
  `description` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `publish` int DEFAULT '1',
  `suppressed` int DEFAULT '0',
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `classification_system_mtime_index` (`system_mtime`),
  KEY `classification_user_mtime_index` (`user_mtime`),
  KEY `repo_id` (`repo_id`),
  CONSTRAINT `classification_ibfk_1` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table classification_creator_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classification_creator_rlshp`;

CREATE TABLE `classification_creator_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `classification_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `classification_creator_rlshp_system_mtime_index` (`system_mtime`),
  KEY `classification_creator_rlshp_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  KEY `classification_id` (`classification_id`),
  CONSTRAINT `classification_creator_rlshp_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `classification_creator_rlshp_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `classification_creator_rlshp_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `classification_creator_rlshp_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `classification_creator_rlshp_ibfk_5` FOREIGN KEY (`classification_id`) REFERENCES `classification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table classification_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classification_rlshp`;

CREATE TABLE `classification_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_id` int DEFAULT NULL,
  `accession_id` int DEFAULT NULL,
  `classification_id` int DEFAULT NULL,
  `classification_term_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `digital_object_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classification_rlshp_system_mtime_index` (`system_mtime`),
  KEY `classification_rlshp_user_mtime_index` (`user_mtime`),
  KEY `resource_id` (`resource_id`),
  KEY `accession_id` (`accession_id`),
  KEY `classification_id` (`classification_id`),
  KEY `classification_term_id` (`classification_term_id`),
  CONSTRAINT `classification_rlshp_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `classification_rlshp_ibfk_2` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `classification_rlshp_ibfk_3` FOREIGN KEY (`classification_id`) REFERENCES `classification` (`id`),
  CONSTRAINT `classification_rlshp_ibfk_4` FOREIGN KEY (`classification_term_id`) REFERENCES `classification_term` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table classification_term
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classification_term`;

CREATE TABLE `classification_term` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` int NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `title` varchar(8704) NOT NULL,
  `title_sha1` varchar(255) NOT NULL,
  `description` text,
  `root_record_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  `position` int NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `publish` int DEFAULT '1',
  `suppressed` int DEFAULT '0',
  `display_string` text NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `classification_term_parent_name_title_sha1_index` (`parent_name`,`title_sha1`),
  UNIQUE KEY `classification_term_parent_name_identifier_index` (`parent_name`,`identifier`),
  UNIQUE KEY `uniq_ct_pos` (`parent_name`,`position`),
  KEY `classification_term_system_mtime_index` (`system_mtime`),
  KEY `classification_term_user_mtime_index` (`user_mtime`),
  KEY `repo_id` (`repo_id`),
  CONSTRAINT `classification_term_ibfk_1` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table classification_term_creator_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classification_term_creator_rlshp`;

CREATE TABLE `classification_term_creator_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `classification_term_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `classification_term_creator_rlshp_system_mtime_index` (`system_mtime`),
  KEY `classification_term_creator_rlshp_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  KEY `classification_term_id` (`classification_term_id`),
  CONSTRAINT `classification_term_creator_rlshp_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `classification_term_creator_rlshp_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `classification_term_creator_rlshp_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `classification_term_creator_rlshp_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `classification_term_creator_rlshp_ibfk_5` FOREIGN KEY (`classification_term_id`) REFERENCES `classification_term` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table collection_management
# ------------------------------------------------------------

DROP TABLE IF EXISTS `collection_management`;

CREATE TABLE `collection_management` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `processing_hours_per_foot_estimate` varchar(255) DEFAULT NULL,
  `processing_total_extent` varchar(255) DEFAULT NULL,
  `processing_total_extent_type_id` int DEFAULT NULL,
  `processing_hours_total` varchar(255) DEFAULT NULL,
  `processing_plan` text,
  `processing_priority_id` int DEFAULT NULL,
  `processing_status_id` int DEFAULT NULL,
  `processing_funding_source` text,
  `processors` text,
  `rights_determined` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `processing_total_extent_type_id` (`processing_total_extent_type_id`),
  KEY `processing_priority_id` (`processing_priority_id`),
  KEY `processing_status_id` (`processing_status_id`),
  KEY `collection_management_system_mtime_index` (`system_mtime`),
  KEY `collection_management_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  KEY `digital_object_id` (`digital_object_id`),
  CONSTRAINT `collection_management_ibfk_1` FOREIGN KEY (`processing_total_extent_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `collection_management_ibfk_2` FOREIGN KEY (`processing_priority_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `collection_management_ibfk_3` FOREIGN KEY (`processing_status_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `collection_management_ibfk_4` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `collection_management_ibfk_5` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `collection_management_ibfk_6` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table container_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `container_profile`;

CREATE TABLE `container_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `extent_dimension` varchar(255) DEFAULT NULL,
  `dimension_units_id` int DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  `width` varchar(255) DEFAULT NULL,
  `depth` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `stacking_limit` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `container_profile_name_uniq` (`name`),
  KEY `dimension_units_id` (`dimension_units_id`),
  KEY `container_profile_system_mtime_index` (`system_mtime`),
  KEY `container_profile_user_mtime_index` (`user_mtime`),
  CONSTRAINT `container_profile_ibfk_1` FOREIGN KEY (`dimension_units_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `container_profile` WRITE;
/*!40000 ALTER TABLE `container_profile` DISABLE KEYS */;

INSERT INTO `container_profile` (`id`, `lock_version`, `name`, `url`, `extent_dimension`, `dimension_units_id`, `height`, `width`, `depth`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `stacking_limit`, `notes`)
VALUES
	(1,1,'Hollinger',NULL,'height',1349,'0','0','0','admin','admin','2026-02-16 15:43:55','2026-02-16 18:50:53','2026-02-16 15:43:55',NULL,NULL),
	(2,1,'Bankers',NULL,'height',1349,'1','1','1','admin','admin','2026-02-16 18:49:13','2026-02-16 18:52:11','2026-02-16 18:49:13',NULL,NULL);

/*!40000 ALTER TABLE `container_profile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table custom_report_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_report_template`;

CREATE TABLE `custom_report_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `data` text NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `limit` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `custom_report_template_system_mtime_index` (`system_mtime`),
  KEY `custom_report_template_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table date
# ------------------------------------------------------------

DROP TABLE IF EXISTS `date`;

CREATE TABLE `date` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `deaccession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `date_type_id` int DEFAULT NULL,
  `label_id` int NOT NULL,
  `certainty_id` int DEFAULT NULL,
  `expression` varchar(255) DEFAULT NULL,
  `begin` varchar(255) DEFAULT NULL,
  `end` varchar(255) DEFAULT NULL,
  `era_id` int DEFAULT NULL,
  `calendar_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_type_id` (`date_type_id`),
  KEY `label_id` (`label_id`),
  KEY `certainty_id` (`certainty_id`),
  KEY `era_id` (`era_id`),
  KEY `calendar_id` (`calendar_id`),
  KEY `date_system_mtime_index` (`system_mtime`),
  KEY `date_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `resource_id` (`resource_id`),
  KEY `event_id` (`event_id`),
  KEY `deaccession_id` (`deaccession_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  CONSTRAINT `date_ibfk_1` FOREIGN KEY (`date_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `date_ibfk_10` FOREIGN KEY (`deaccession_id`) REFERENCES `deaccession` (`id`),
  CONSTRAINT `date_ibfk_12` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `date_ibfk_13` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `date_ibfk_2` FOREIGN KEY (`label_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `date_ibfk_3` FOREIGN KEY (`certainty_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `date_ibfk_4` FOREIGN KEY (`era_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `date_ibfk_5` FOREIGN KEY (`calendar_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `date_ibfk_6` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `date_ibfk_7` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `date_ibfk_8` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `date_ibfk_9` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `date` WRITE;
/*!40000 ALTER TABLE `date` DISABLE KEYS */;

INSERT INTO `date` (`id`, `lock_version`, `json_schema_version`, `accession_id`, `deaccession_id`, `archival_object_id`, `resource_id`, `event_id`, `digital_object_id`, `digital_object_component_id`, `date_type_id`, `label_id`, `certainty_id`, `expression`, `begin`, `end`, `era_id`, `calendar_id`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,0,1,NULL,NULL,NULL,1,NULL,NULL,NULL,903,906,NULL,'undated',NULL,NULL,NULL,NULL,'admin','admin','2026-02-16 15:43:23','2026-02-16 15:43:23','2026-02-16 15:43:23');

/*!40000 ALTER TABLE `date` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table deaccession
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deaccession`;

CREATE TABLE `deaccession` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `scope_id` int NOT NULL,
  `description` text NOT NULL,
  `reason` text,
  `disposition` text,
  `notification` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scope_id` (`scope_id`),
  KEY `deaccession_system_mtime_index` (`system_mtime`),
  KEY `deaccession_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `deaccession_ibfk_1` FOREIGN KEY (`scope_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `deaccession_ibfk_2` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `deaccession_ibfk_3` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table default_values
# ------------------------------------------------------------

DROP TABLE IF EXISTS `default_values`;

CREATE TABLE `default_values` (
  `lock_version` int NOT NULL DEFAULT '0',
  `id` varchar(255) NOT NULL,
  `blob` blob NOT NULL,
  `repo_id` int NOT NULL,
  `record_type` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `default_values_system_mtime_index` (`system_mtime`),
  KEY `default_values_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table deleted_records
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deleted_records`;

CREATE TABLE `deleted_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deleted_records_uri_index` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table digital_object
# ------------------------------------------------------------

DROP TABLE IF EXISTS `digital_object`;

CREATE TABLE `digital_object` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `digital_object_id` varchar(255) NOT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `level_id` int DEFAULT NULL,
  `digital_object_type_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `restrictions` int DEFAULT NULL,
  `system_generated` int DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `digital_object_repo_id_digital_object_id_index` (`repo_id`,`digital_object_id`),
  KEY `level_id` (`level_id`),
  KEY `digital_object_type_id` (`digital_object_type_id`),
  KEY `digital_object_system_mtime_index` (`system_mtime`),
  KEY `digital_object_user_mtime_index` (`user_mtime`),
  CONSTRAINT `digital_object_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `digital_object_ibfk_2` FOREIGN KEY (`digital_object_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `digital_object_ibfk_4` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table digital_object_component
# ------------------------------------------------------------

DROP TABLE IF EXISTS `digital_object_component`;

CREATE TABLE `digital_object_component` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `root_record_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `position` int NOT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `component_id` varchar(255) DEFAULT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `display_string` text,
  `label` varchar(255) DEFAULT NULL,
  `system_generated` int DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `doc_unique_identifier` (`repo_id`,`component_id`),
  UNIQUE KEY `uniq_do_pos` (`parent_name`,`position`),
  KEY `digital_object_component_system_mtime_index` (`system_mtime`),
  KEY `digital_object_component_user_mtime_index` (`user_mtime`),
  KEY `root_record_id` (`root_record_id`),
  KEY `parent_id` (`parent_id`),
  KEY `digital_object_component_component_id_index` (`component_id`),
  CONSTRAINT `digital_object_component_ibfk_2` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`),
  CONSTRAINT `digital_object_component_ibfk_3` FOREIGN KEY (`root_record_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `digital_object_component_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `digital_object_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table enumeration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enumeration`;

CREATE TABLE `enumeration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `default_value` int DEFAULT NULL,
  `editable` int DEFAULT '1',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `enumeration_system_mtime_index` (`system_mtime`),
  KEY `enumeration_user_mtime_index` (`user_mtime`),
  KEY `enumeration_default_value_fk` (`default_value`),
  CONSTRAINT `enumeration_default_value_fk` FOREIGN KEY (`default_value`) REFERENCES `enumeration_value` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `enumeration` WRITE;
/*!40000 ALTER TABLE `enumeration` DISABLE KEYS */;

INSERT INTO `enumeration` (`id`, `lock_version`, `json_schema_version`, `name`, `default_value`, `editable`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,0,1,'linked_agent_archival_record_relators',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(2,0,1,'linked_event_archival_record_roles',NULL,0,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(3,0,1,'linked_agent_event_roles',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(4,0,1,'name_source',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(5,0,1,'name_rule',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(6,0,1,'accession_acquisition_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(7,0,1,'accession_resource_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(8,0,1,'collection_management_processing_priority',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(9,0,1,'collection_management_processing_status',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(10,0,1,'date_era',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(11,0,1,'date_calendar',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(12,0,1,'digital_object_digital_object_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(13,0,1,'digital_object_level',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(14,0,1,'extent_extent_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(15,0,1,'event_event_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(16,0,1,'container_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(17,0,1,'agent_contact_salutation',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(18,0,1,'event_outcome',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(19,0,1,'resource_resource_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(20,0,1,'resource_finding_aid_description_rules',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(21,0,1,'resource_finding_aid_status',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(22,0,1,'instance_instance_type',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(23,0,1,'subject_source',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(24,0,1,'file_version_use_statement',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(25,0,1,'file_version_checksum_methods',NULL,1,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(26,0,1,'language_iso639_2',NULL,0,NULL,NULL,'2026-02-16 15:40:22','2026-02-16 15:40:22','2026-02-16 15:40:22'),
	(27,0,1,'linked_agent_role',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(28,0,1,'agent_relationship_associative_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(29,0,1,'agent_relationship_earlierlater_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(30,0,1,'agent_relationship_parentchild_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(31,0,1,'agent_relationship_subordinatesuperior_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(32,0,1,'archival_record_level',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(33,0,1,'container_location_status',899,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(34,0,1,'date_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(35,0,1,'date_label',NULL,1,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(36,0,1,'date_certainty',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(37,0,1,'deaccession_scope',921,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(38,0,1,'extent_portion',923,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(39,0,1,'file_version_xlink_actuate_attribute',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(40,0,1,'file_version_xlink_show_attribute',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(41,0,1,'file_version_file_format_name',NULL,1,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(42,0,1,'location_temporary',NULL,1,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(43,0,1,'name_person_name_order',946,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(44,0,1,'note_digital_object_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(45,0,1,'note_multipart_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(46,0,1,'note_orderedlist_enumeration',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(47,0,1,'note_singlepart_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(48,0,1,'note_bibliography_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(49,0,1,'note_index_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(50,0,1,'note_index_item_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(51,0,1,'country_iso_3166',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(52,0,1,'rights_statement_rights_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(53,0,1,'rights_statement_ip_status',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(54,0,1,'subject_term_type',NULL,0,NULL,NULL,'2026-02-16 15:40:23','2026-02-16 15:40:23','2026-02-16 15:40:23'),
	(55,0,1,'user_defined_enum_1',NULL,1,NULL,NULL,'2026-02-16 15:40:25','2026-02-16 15:40:25','2026-02-16 15:40:25'),
	(56,0,1,'user_defined_enum_2',NULL,1,NULL,NULL,'2026-02-16 15:40:25','2026-02-16 15:40:25','2026-02-16 15:40:25'),
	(57,0,1,'user_defined_enum_3',NULL,1,NULL,NULL,'2026-02-16 15:40:25','2026-02-16 15:40:25','2026-02-16 15:40:25'),
	(58,0,1,'user_defined_enum_4',NULL,1,NULL,NULL,'2026-02-16 15:40:25','2026-02-16 15:40:25','2026-02-16 15:40:25'),
	(59,0,1,'accession_parts_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:27','2026-02-16 15:40:27','2026-02-16 15:40:27'),
	(60,0,1,'accession_parts_relator_type',NULL,1,NULL,NULL,'2026-02-16 15:40:27','2026-02-16 15:40:27','2026-02-16 15:40:27'),
	(61,0,1,'accession_sibling_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:27','2026-02-16 15:40:27','2026-02-16 15:40:27'),
	(62,0,1,'accession_sibling_relator_type',NULL,1,NULL,NULL,'2026-02-16 15:40:27','2026-02-16 15:40:27','2026-02-16 15:40:27'),
	(64,0,1,'telephone_number_type',NULL,1,NULL,NULL,'2026-02-16 15:40:30','2026-02-16 15:40:30','2026-02-16 15:40:30'),
	(65,0,1,'restriction_type',NULL,1,NULL,NULL,'2026-02-16 15:40:31','2026-02-16 15:40:31','2026-02-16 15:40:31'),
	(66,0,1,'dimension_units',NULL,0,NULL,NULL,'2026-02-16 15:40:31','2026-02-16 15:40:31','2026-02-16 15:40:31'),
	(67,0,1,'location_function_type',NULL,1,NULL,NULL,'2026-02-16 15:40:31','2026-02-16 15:40:31','2026-02-16 15:40:31'),
	(68,0,1,'rights_statement_act_type',NULL,1,NULL,NULL,'2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(69,0,1,'rights_statement_act_restriction',NULL,1,NULL,NULL,'2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(70,0,1,'note_rights_statement_act_type',NULL,0,NULL,NULL,'2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(71,0,1,'note_rights_statement_type',NULL,0,NULL,NULL,'2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(72,0,1,'rights_statement_external_document_identifier_type',NULL,1,NULL,NULL,'2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(73,0,1,'rights_statement_other_rights_basis',NULL,1,NULL,NULL,'2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(74,0,1,'script_iso15924',NULL,1,NULL,NULL,'2026-02-16 15:40:34','2026-02-16 15:40:34','2026-02-16 15:40:34'),
	(75,0,1,'note_langmaterial_type',NULL,0,NULL,NULL,'2026-02-16 15:40:34','2026-02-16 15:40:34','2026-02-16 15:40:34'),
	(76,0,1,'maintenance_status',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(77,0,1,'publication_status',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(78,0,1,'romanization',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(79,0,1,'transliteration',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(80,0,1,'government_agency_type',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(81,0,1,'reference_evaluation',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(82,0,1,'name_type',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(83,0,1,'level_of_detail',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(84,0,1,'modified_record',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(85,0,1,'cataloging_source',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(86,0,1,'identifier_type',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(87,0,1,'agency_code_type',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(88,0,1,'maintenance_event_type',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(89,0,1,'maintenance_agent_type',1763,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(90,0,1,'date_type_structured',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(91,0,1,'date_role',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(92,0,1,'date_standardized_type',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(93,0,1,'begin_date_standardized_type',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(94,0,1,'end_date_standardized_type',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(95,0,1,'place_role',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(96,0,1,'agent_relationship_identity_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(97,0,1,'agent_relationship_hierarchical_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(98,0,1,'agent_relationship_temporal_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(99,0,1,'agent_relationship_family_relator',NULL,0,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(100,0,1,'gender',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(101,0,1,'agent_relationship_specific_relator',NULL,1,NULL,NULL,'2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(102,0,1,'metadata_license',NULL,1,NULL,NULL,'2026-02-16 15:40:36','2026-02-16 15:40:36','2026-02-16 15:40:36');

/*!40000 ALTER TABLE `enumeration` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table enumeration_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enumeration_value`;

CREATE TABLE `enumeration_value` (
  `id` int NOT NULL AUTO_INCREMENT,
  `enumeration_id` int NOT NULL,
  `value` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `readonly` int DEFAULT '0',
  `position` int NOT NULL DEFAULT '0',
  `suppressed` int DEFAULT '0',
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL DEFAULT '1',
  `created_by` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `last_modified_by` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `system_mtime` datetime DEFAULT NULL,
  `user_mtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enumeration_value_uniq` (`enumeration_id`,`value`),
  UNIQUE KEY `enumeration_position_uniq` (`enumeration_id`,`position`),
  KEY `enumeration_value_enumeration_id_index` (`enumeration_id`),
  KEY `enumeration_value_value_index` (`value`),
  CONSTRAINT `enumeration_value_ibfk_1` FOREIGN KEY (`enumeration_id`) REFERENCES `enumeration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

LOCK TABLES `enumeration_value` WRITE;
/*!40000 ALTER TABLE `enumeration_value` DISABLE KEYS */;

INSERT INTO `enumeration_value` (`id`, `enumeration_id`, `value`, `readonly`, `position`, `suppressed`, `lock_version`, `json_schema_version`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,1,X'616374',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(2,1,X'616470',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(3,1,X'616E6C',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(4,1,X'616E6D',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(5,1,X'616E6E',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(6,1,X'617070',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(7,1,X'617263',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(8,1,X'617272',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(9,1,X'616370',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(10,1,X'617274',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(11,1,X'617264',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(12,1,X'617367',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(13,1,X'61736E',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(14,1,X'617474',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(15,1,X'617563',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(16,1,X'617574',0,21,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(17,1,X'617174',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(18,1,X'616674',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(19,1,X'617564',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(20,1,X'617569',0,19,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(21,1,X'617573',0,20,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(22,1,X'616E74',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(23,1,X'626E64',0,27,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(24,1,X'626464',0,22,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(25,1,X'626C77',0,26,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(26,1,X'626B64',0,24,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(27,1,X'626B70',0,25,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(28,1,X'626A64',0,23,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(29,1,X'627064',0,28,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(30,1,X'62736C',0,29,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(31,1,X'636C6C',0,34,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(32,1,X'637467',0,63,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(33,1,X'636E73',0,42,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(34,1,X'636872',0,31,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(35,1,X'636E67',0,41,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(36,1,X'636C69',0,33,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(37,1,X'636C62',0,32,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(38,1,X'636F6C',0,44,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(39,1,X'636C74',0,36,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(40,1,X'636C72',0,35,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(41,1,X'636D6D',0,37,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(42,1,X'637774',0,68,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(43,1,X'636F6D',0,45,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(44,1,X'63706C',0,53,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(45,1,X'637074',0,54,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(46,1,X'637065',0,51,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(47,1,X'636D70',0,38,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(48,1,X'636D74',0,39,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(49,1,X'636370',0,30,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(50,1,X'636E64',0,40,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(51,1,X'636F6E',0,46,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(52,1,X'63736C',0,58,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(53,1,X'637370',0,59,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(54,1,X'636F73',0,47,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(55,1,X'636F74',0,48,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(56,1,X'636F65',0,43,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(57,1,X'637473',0,65,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(58,1,X'637474',0,66,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(59,1,X'637465',0,62,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(60,1,X'637472',0,64,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(61,1,X'637462',0,61,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(62,1,X'637063',0,50,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(63,1,X'637068',0,52,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(64,1,X'637272',0,57,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(65,1,X'637270',0,56,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(66,1,X'637374',0,60,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(67,1,X'636F76',0,49,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(68,1,X'637265',0,55,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(69,1,X'637572',0,67,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(70,1,X'646E63',0,76,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(71,1,X'647463',0,84,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(72,1,X'64746D',0,86,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(73,1,X'647465',0,85,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(74,1,X'64746F',0,87,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(75,1,X'646664',0,70,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(76,1,X'646674',0,72,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(77,1,X'646665',0,71,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(78,1,X'646767',0,73,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(79,1,X'646C6E',0,75,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(80,1,X'647063',0,78,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(81,1,X'647074',0,79,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(82,1,X'647372',0,82,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(83,1,X'647274',0,81,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(84,1,X'646973',0,74,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(85,1,X'646270',0,69,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(86,1,X'647374',0,83,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(87,1,X'64726D',0,80,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(88,1,X'647562',0,88,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(89,1,X'656474',0,89,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(90,1,X'656C67',0,91,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(91,1,X'656C74',0,92,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(92,1,X'656E67',0,93,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(93,1,X'656772',0,90,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(94,1,X'657472',0,94,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(95,1,X'657670',0,95,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(96,1,X'657870',0,96,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(97,1,X'666163',0,97,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(98,1,X'666C64',0,98,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(99,1,X'666C6D',0,99,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(100,1,X'667079',0,102,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(101,1,X'667267',0,103,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(102,1,X'666D6F',0,100,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(103,1,X'646E72',0,77,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(104,1,X'666E64',0,101,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(105,1,X'676973',0,104,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(106,1,X'677274',0,105,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(107,1,X'686E72',0,106,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(108,1,X'687374',0,107,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(109,1,X'696C75',0,109,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(110,1,X'696C6C',0,108,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(111,1,X'696E73',0,110,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(112,1,X'697472',0,112,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(113,1,X'697665',0,113,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(114,1,X'697672',0,114,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(115,1,X'696E76',0,111,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(116,1,X'6C6272',0,115,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(117,1,X'6C6472',0,117,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(118,1,X'6C7361',0,127,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(119,1,X'6C6564',0,118,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(120,1,X'6C656E',0,121,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(121,1,X'6C696C',0,125,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(122,1,X'6C6974',0,126,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(123,1,X'6C6965',0,124,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(124,1,X'6C656C',0,120,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(125,1,X'6C6574',0,122,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(126,1,X'6C6565',0,119,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(127,1,X'6C6274',0,116,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(128,1,X'6C7365',0,128,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(129,1,X'6C736F',0,129,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(130,1,X'6C6764',0,123,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(131,1,X'6C7467',0,130,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(132,1,X'6C7972',0,131,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(133,1,X'6D6670',0,134,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(134,1,X'6D6672',0,135,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(135,1,X'6D7262',0,138,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(136,1,X'6D726B',0,139,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(137,1,X'6D6463',0,133,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(138,1,X'6D7465',0,141,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(139,1,X'6D6F64',0,136,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(140,1,X'6D6F6E',0,137,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(141,1,X'6D6370',0,132,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(142,1,X'6D7364',0,140,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(143,1,X'6D7573',0,142,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(144,1,X'6E7274',0,143,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(145,1,X'6F706E',0,144,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(146,1,X'6F726D',0,146,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(147,1,X'6F7267',0,145,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(148,1,X'6F7468',0,147,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(149,1,X'6F776E',0,148,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(150,1,X'70706D',0,159,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(151,1,X'707461',0,170,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(152,1,X'707468',0,173,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(153,1,X'706174',0,149,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(154,1,X'707266',0,163,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(155,1,X'706D61',0,156,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(156,1,X'706874',0,154,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(157,1,X'707466',0,172,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(158,1,X'707474',0,174,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(159,1,X'707465',0,171,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(160,1,X'706C74',0,155,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(161,1,X'707274',0,168,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(162,1,X'706F70',0,158,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(163,1,X'70726D',0,165,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(164,1,X'707263',0,161,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(165,1,X'70726F',0,166,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(166,1,X'706D6E',0,157,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(167,1,X'707264',0,162,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(168,1,X'707270',0,167,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(169,1,X'707267',0,164,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(170,1,X'706472',0,152,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(171,1,X'706672',0,153,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(172,1,X'707276',0,169,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(173,1,X'707570',0,175,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(174,1,X'70626C',0,151,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(175,1,X'706264',0,150,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(176,1,X'707074',0,160,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(177,1,X'726370',0,179,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(178,1,X'726365',0,178,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(179,1,X'726364',0,177,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(180,1,X'726564',0,180,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(181,1,X'72656E',0,181,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(182,1,X'727074',0,185,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(183,1,X'727073',0,184,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(184,1,X'727468',0,191,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(185,1,X'72746D',0,192,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(186,1,X'726573',0,182,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(187,1,X'727370',0,189,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(188,1,X'727374',0,190,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(189,1,X'727365',0,187,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(190,1,X'727079',0,186,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(191,1,X'727367',0,188,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(192,1,X'726576',0,183,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(193,1,X'726272',0,176,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(194,1,X'736365',0,194,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(195,1,X'736164',0,193,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(196,1,X'736372',0,196,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(197,1,X'73636C',0,195,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(198,1,X'737079',0,204,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(199,1,X'736563',0,198,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(200,1,X'737464',0,206,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(201,1,X'737467',0,207,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(202,1,X'73676E',0,199,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(203,1,X'736E67',0,201,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(204,1,X'736473',0,197,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(205,1,X'73706B',0,202,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(206,1,X'73706E',0,203,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(207,1,X'73746D',0,209,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(208,1,X'73746E',0,210,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(209,1,X'737472',0,211,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(210,1,X'73746C',0,208,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(211,1,X'736874',0,200,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(212,1,X'737276',0,205,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(213,1,X'746368',0,213,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(214,1,X'746364',0,212,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(215,1,X'746873',0,214,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(216,1,X'747263',0,215,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(217,1,X'74726C',0,216,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(218,1,X'747964',0,217,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(219,1,X'747967',0,218,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(220,1,X'757670',0,219,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(221,1,X'766467',0,220,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(222,1,X'766F63',0,221,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(223,1,X'776974',0,225,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(224,1,X'776465',0,224,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(225,1,X'776463',0,223,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(226,1,X'77616D',0,222,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(227,2,X'736F75726365',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(228,2,X'6F7574636F6D65',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(229,2,X'7472616E73666572',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(230,3,X'617574686F72697A6572',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(231,3,X'657865637574696E675F70726F6772616D',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(232,3,X'696D706C656D656E746572',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(233,3,X'726563697069656E74',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(234,3,X'7472616E736D6974746572',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(235,3,X'76616C696461746F72',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(236,4,X'6C6F63616C',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(237,4,X'6E6166',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(238,4,X'6E6164',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(239,4,X'756C616E',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(240,5,X'6C6F63616C',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(241,5,X'61616372',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(242,5,X'64616373',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(243,5,X'726461',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(244,6,X'6465706F736974',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(245,6,X'67696674',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(246,6,X'7075726368617365',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(247,6,X'7472616E73666572',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(248,7,X'636F6C6C656374696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(249,7,X'7075626C69636174696F6E73',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(250,7,X'706170657273',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(251,7,X'7265636F726473',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(252,8,X'68696768',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(253,8,X'6D656469756D',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(254,8,X'6C6F77',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(255,9,X'6E6577',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(256,9,X'696E5F70726F6772657373',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(257,9,X'636F6D706C65746564',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(258,10,X'6365',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(259,11,X'677265676F7269616E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(260,12,X'636172746F67726170686963',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(261,12,X'6D697865645F6D6174657269616C73',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(262,12,X'6D6F76696E675F696D616765',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(263,12,X'6E6F74617465645F6D75736963',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(264,12,X'736F6674776172655F6D756C74696D65646961',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(265,12,X'736F756E645F7265636F7264696E67',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(266,12,X'736F756E645F7265636F7264696E675F6D75736963616C',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(267,12,X'736F756E645F7265636F7264696E675F6E6F6E6D75736963616C',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(268,12,X'7374696C6C5F696D616765',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(269,12,X'74657874',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(270,13,X'636F6C6C656374696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(271,13,X'776F726B',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(272,13,X'696D616765',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(273,14,X'636173736574746573',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(274,14,X'63756269635F66656574',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(275,14,X'676967616279746573',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(276,14,X'6C6561766573',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(277,14,X'6C696E6561725F66656574',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(278,14,X'6D6567616279746573',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(279,14,X'70686F746F677261706869635F7072696E7473',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(280,14,X'70686F746F677261706869635F736C69646573',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(281,14,X'7265656C73',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(282,14,X'736865657473',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(283,14,X'746572616279746573',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(284,14,X'766F6C756D6573',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(285,15,X'616363657373696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(286,15,X'616363756D756C6174696F6E',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(287,15,X'61636B6E6F776C656467656D656E745F73656E74',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(288,15,X'61636B6E6F776C656467656D656E745F7265636569766564',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(289,15,X'61677265656D656E745F7369676E6564',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(290,15,X'61677265656D656E745F7265636569766564',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(291,15,X'61677265656D656E745F73656E74',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(292,15,X'61707072616973616C',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(293,15,X'6173736573736D656E74',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(294,15,X'63617074757265',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(295,15,X'636174616C6F676564',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(296,15,X'636F6C6C656374696F6E',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(297,15,X'636F6D7072657373696F6E',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(298,15,X'636F6E747269627574696F6E',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(299,15,X'636F6D706F6E656E745F7472616E73666572',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(300,15,X'636F707972696768745F7472616E73666572',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(301,15,X'637573746F64795F7472616E73666572',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(302,15,X'6465616363657373696F6E',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(303,15,X'6465636F6D7072657373696F6E',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(304,15,X'64656372797074696F6E',0,19,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(305,15,X'64656C6574696F6E',0,20,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(306,15,X'6469676974616C5F7369676E61747572655F76616C69646174696F6E',0,21,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(307,15,X'6669786974795F636865636B',0,22,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(308,15,X'696E67657374696F6E',0,23,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(309,15,X'6D6573736167655F6469676573745F63616C63756C6174696F6E',0,24,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(310,15,X'6D6967726174696F6E',0,25,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(311,15,X'6E6F726D616C697A6174696F6E',0,26,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(312,15,X'70726F636573736564',0,27,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(313,15,X'7075626C69636174696F6E',0,28,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(314,15,X'7265706C69636174696F6E',0,29,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(315,15,X'76616C69646174696F6E',0,30,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(316,15,X'76697275735F636865636B',0,31,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(317,16,X'626F78',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(318,16,X'636172746F6E',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(319,16,X'63617365',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(320,16,X'666F6C646572',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(321,16,X'6672616D65',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(322,16,X'6F626A656374',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(323,16,X'7265656C',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(324,17,X'6D72',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(325,17,X'6D7273',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(326,17,X'6D73',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(327,17,X'6D6164616D65',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(328,17,X'736972',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(329,18,X'70617373',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(330,18,X'7061727469616C2070617373',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(331,18,X'6661696C',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(332,19,X'636F6C6C656374696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(333,19,X'7075626C69636174696F6E73',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(334,19,X'706170657273',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(335,19,X'7265636F726473',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(336,20,X'61616372',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(337,20,X'63636F',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(338,20,X'64616373',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(339,20,X'726164',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(340,20,X'6973616467',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(341,21,X'636F6D706C65746564',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(342,21,X'696E5F70726F6772657373',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(343,21,X'756E6465725F7265766973696F6E',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(344,21,X'756E70726F636573736564',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(345,22,X'616363657373696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(346,22,X'617564696F',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(347,22,X'626F6F6B73',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(348,22,X'636F6D70757465725F6469736B73',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(349,22,X'6469676974616C5F6F626A656374',1,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(350,22,X'677261706869635F6D6174657269616C73',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(351,22,X'6D617073',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(352,22,X'6D6963726F666F726D',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(353,22,X'6D697865645F6D6174657269616C73',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(354,22,X'6D6F76696E675F696D61676573',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(355,22,X'7265616C6961',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(356,22,X'74657874',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(357,23,X'616174',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(358,23,X'726267656E72',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(359,23,X'74676E',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(360,23,X'6C637368',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(361,23,X'6C6F63616C',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(362,23,X'6D657368',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(363,23,X'676D677063',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(364,24,X'6170706C69636174696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(365,24,X'6170706C69636174696F6E2D706466',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(366,24,X'617564696F2D636C6970',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(367,24,X'617564696F2D6D6173746572',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(368,24,X'617564696F2D6D61737465722D656469746564',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(369,24,X'617564696F2D73657276696365',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(370,24,X'696D6167652D6D6173746572',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(371,24,X'696D6167652D6D61737465722D656469746564',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(372,24,X'696D6167652D73657276696365',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(373,24,X'696D6167652D736572766963652D656469746564',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(374,24,X'696D6167652D7468756D626E61696C',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(375,24,X'746578742D636F6465626F6F6B',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(376,24,X'746573742D64617461',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(377,24,X'746578742D646174615F646566696E6974696F6E',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(378,24,X'746578742D67656F7265666572656E6365',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(379,24,X'746578742D6F63722D656469746564',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(380,24,X'746578742D6F63722D756E656469746564',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(381,24,X'746578742D7465692D7472616E7363726970746564',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(382,24,X'746578742D7465692D7472616E736C61746564',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(383,24,X'766964656F2D636C6970',0,19,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(384,24,X'766964656F2D6D6173746572',0,20,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(385,24,X'766964656F2D6D61737465722D656469746564',0,21,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(386,24,X'766964656F2D73657276696365',0,22,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(387,24,X'766964656F2D73747265616D696E67',0,23,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(388,25,X'6D6435',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(389,25,X'7368612D31',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(390,25,X'7368612D323536',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(391,25,X'7368612D333834',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(392,25,X'7368612D353132',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(393,26,X'616172',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(394,26,X'61626B',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(395,26,X'616365',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(396,26,X'616368',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(397,26,X'616461',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(398,26,X'616479',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(399,26,X'616661',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(400,26,X'616668',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(401,26,X'616672',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(402,26,X'61696E',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(403,26,X'616B61',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(404,26,X'616B6B',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(405,26,X'616C62',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(406,26,X'616C65',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(407,26,X'616C67',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(408,26,X'616C74',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(409,26,X'616D68',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(410,26,X'616E67',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(411,26,X'616E70',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(412,26,X'617061',0,19,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(413,26,X'617261',0,20,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(414,26,X'617263',0,21,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(415,26,X'617267',0,22,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(416,26,X'61726D',0,23,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(417,26,X'61726E',0,24,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(418,26,X'617270',0,25,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(419,26,X'617274',0,26,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(420,26,X'617277',0,27,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(421,26,X'61736D',0,28,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(422,26,X'617374',0,29,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(423,26,X'617468',0,30,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(424,26,X'617573',0,31,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(425,26,X'617661',0,32,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(426,26,X'617665',0,33,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(427,26,X'617761',0,34,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(428,26,X'61796D',0,35,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(429,26,X'617A65',0,36,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(430,26,X'626164',0,37,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(431,26,X'626169',0,38,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(432,26,X'62616B',0,39,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(433,26,X'62616C',0,40,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(434,26,X'62616D',0,41,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(435,26,X'62616E',0,42,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(436,26,X'626171',0,43,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(437,26,X'626173',0,44,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(438,26,X'626174',0,45,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(439,26,X'62656A',0,46,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(440,26,X'62656C',0,47,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(441,26,X'62656D',0,48,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(442,26,X'62656E',0,49,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(443,26,X'626572',0,50,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(444,26,X'62686F',0,51,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(445,26,X'626968',0,52,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(446,26,X'62696B',0,53,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(447,26,X'62696E',0,54,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(448,26,X'626973',0,55,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(449,26,X'626C61',0,56,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(450,26,X'626E74',0,57,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(451,26,X'626F73',0,58,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(452,26,X'627261',0,59,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(453,26,X'627265',0,60,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(454,26,X'62746B',0,61,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(455,26,X'627561',0,62,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(456,26,X'627567',0,63,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(457,26,X'62756C',0,64,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(458,26,X'627572',0,65,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(459,26,X'62796E',0,66,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(460,26,X'636164',0,67,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(461,26,X'636169',0,68,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(462,26,X'636172',0,69,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(463,26,X'636174',0,70,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(464,26,X'636175',0,71,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(465,26,X'636562',0,72,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(466,26,X'63656C',0,73,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(467,26,X'636861',0,74,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(468,26,X'636862',0,75,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(469,26,X'636865',0,76,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(470,26,X'636867',0,77,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(471,26,X'636869',0,78,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(472,26,X'63686B',0,79,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(473,26,X'63686D',0,80,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(474,26,X'63686E',0,81,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(475,26,X'63686F',0,82,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(476,26,X'636870',0,83,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(477,26,X'636872',0,84,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(478,26,X'636875',0,85,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(479,26,X'636876',0,86,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(480,26,X'636879',0,87,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(481,26,X'636D63',0,88,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(482,26,X'636F70',0,89,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(483,26,X'636F72',0,90,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(484,26,X'636F73',0,91,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(485,26,X'637065',0,92,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(486,26,X'637066',0,93,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(487,26,X'637070',0,94,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(488,26,X'637265',0,95,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(489,26,X'637268',0,96,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(490,26,X'637270',0,97,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(491,26,X'637362',0,98,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(492,26,X'637573',0,99,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(493,26,X'637A65',0,100,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(494,26,X'64616B',0,101,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(495,26,X'64616E',0,102,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(496,26,X'646172',0,103,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(497,26,X'646179',0,104,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(498,26,X'64656C',0,105,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(499,26,X'64656E',0,106,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(500,26,X'646772',0,107,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(501,26,X'64696E',0,108,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(502,26,X'646976',0,109,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(503,26,X'646F69',0,110,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(504,26,X'647261',0,111,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(505,26,X'647362',0,112,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(506,26,X'647561',0,113,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(507,26,X'64756D',0,114,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(508,26,X'647574',0,115,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(509,26,X'647975',0,116,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(510,26,X'647A6F',0,117,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(511,26,X'656669',0,118,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(512,26,X'656779',0,119,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(513,26,X'656B61',0,120,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(514,26,X'656C78',0,121,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(515,26,X'656E67',0,122,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(516,26,X'656E6D',0,123,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(517,26,X'65706F',0,124,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(518,26,X'657374',0,125,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(519,26,X'657765',0,126,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(520,26,X'65776F',0,127,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(521,26,X'66616E',0,128,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(522,26,X'66616F',0,129,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(523,26,X'666174',0,130,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(524,26,X'66696A',0,131,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(525,26,X'66696C',0,132,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(526,26,X'66696E',0,133,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(527,26,X'666975',0,134,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(528,26,X'666F6E',0,135,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(529,26,X'667265',0,136,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(530,26,X'66726D',0,137,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(531,26,X'66726F',0,138,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(532,26,X'667272',0,139,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(533,26,X'667273',0,140,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(534,26,X'667279',0,141,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(535,26,X'66756C',0,142,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(536,26,X'667572',0,143,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(537,26,X'676161',0,144,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(538,26,X'676179',0,145,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(539,26,X'676261',0,146,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(540,26,X'67656D',0,147,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(541,26,X'67656F',0,148,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(542,26,X'676572',0,149,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(543,26,X'67657A',0,150,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(544,26,X'67696C',0,151,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(545,26,X'676C61',0,152,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(546,26,X'676C65',0,153,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(547,26,X'676C67',0,154,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(548,26,X'676C76',0,155,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(549,26,X'676D68',0,156,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(550,26,X'676F68',0,157,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(551,26,X'676F6E',0,158,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(552,26,X'676F72',0,159,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(553,26,X'676F74',0,160,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(554,26,X'677262',0,161,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(555,26,X'677263',0,162,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(556,26,X'677265',0,163,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(557,26,X'67726E',0,164,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(558,26,X'677377',0,165,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(559,26,X'67756A',0,166,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(560,26,X'677769',0,167,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(561,26,X'686169',0,168,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(562,26,X'686174',0,169,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(563,26,X'686175',0,170,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(564,26,X'686177',0,171,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(565,26,X'686562',0,172,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(566,26,X'686572',0,173,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(567,26,X'68696C',0,174,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(568,26,X'68696D',0,175,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(569,26,X'68696E',0,176,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(570,26,X'686974',0,177,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(571,26,X'686D6E',0,178,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(572,26,X'686D6F',0,179,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(573,26,X'687276',0,180,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(574,26,X'687362',0,181,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(575,26,X'68756E',0,182,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(576,26,X'687570',0,183,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(577,26,X'696261',0,184,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(578,26,X'69626F',0,185,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(579,26,X'696365',0,186,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(580,26,X'69646F',0,187,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(581,26,X'696969',0,188,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(582,26,X'696A6F',0,189,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(583,26,X'696B75',0,190,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(584,26,X'696C65',0,191,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(585,26,X'696C6F',0,192,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(586,26,X'696E61',0,193,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(587,26,X'696E63',0,194,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(588,26,X'696E64',0,195,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(589,26,X'696E65',0,196,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(590,26,X'696E68',0,197,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(591,26,X'69706B',0,198,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(592,26,X'697261',0,199,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(593,26,X'69726F',0,200,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(594,26,X'697461',0,201,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(595,26,X'6A6176',0,202,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(596,26,X'6A626F',0,203,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(597,26,X'6A706E',0,204,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(598,26,X'6A7072',0,205,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(599,26,X'6A7262',0,206,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(600,26,X'6B6161',0,207,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(601,26,X'6B6162',0,208,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(602,26,X'6B6163',0,209,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(603,26,X'6B616C',0,210,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(604,26,X'6B616D',0,211,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(605,26,X'6B616E',0,212,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(606,26,X'6B6172',0,213,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(607,26,X'6B6173',0,214,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(608,26,X'6B6175',0,215,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(609,26,X'6B6177',0,216,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(610,26,X'6B617A',0,217,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(611,26,X'6B6264',0,218,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(612,26,X'6B6861',0,219,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(613,26,X'6B6869',0,220,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(614,26,X'6B686D',0,221,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(615,26,X'6B686F',0,222,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(616,26,X'6B696B',0,223,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(617,26,X'6B696E',0,224,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(618,26,X'6B6972',0,225,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(619,26,X'6B6D62',0,226,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(620,26,X'6B6F6B',0,227,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(621,26,X'6B6F6D',0,228,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(622,26,X'6B6F6E',0,229,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(623,26,X'6B6F72',0,230,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(624,26,X'6B6F73',0,231,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(625,26,X'6B7065',0,232,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(626,26,X'6B7263',0,233,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(627,26,X'6B726C',0,234,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(628,26,X'6B726F',0,235,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(629,26,X'6B7275',0,236,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(630,26,X'6B7561',0,237,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(631,26,X'6B756D',0,238,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(632,26,X'6B7572',0,239,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(633,26,X'6B7574',0,240,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(634,26,X'6C6164',0,241,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(635,26,X'6C6168',0,242,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(636,26,X'6C616D',0,243,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(637,26,X'6C616F',0,244,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(638,26,X'6C6174',0,245,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(639,26,X'6C6176',0,246,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(640,26,X'6C657A',0,247,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(641,26,X'6C696D',0,248,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(642,26,X'6C696E',0,249,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(643,26,X'6C6974',0,250,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(644,26,X'6C6F6C',0,251,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(645,26,X'6C6F7A',0,252,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(646,26,X'6C747A',0,253,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(647,26,X'6C7561',0,254,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(648,26,X'6C7562',0,255,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(649,26,X'6C7567',0,256,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(650,26,X'6C7569',0,257,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(651,26,X'6C756E',0,258,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(652,26,X'6C756F',0,259,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(653,26,X'6C7573',0,260,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(654,26,X'6D6163',0,261,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(655,26,X'6D6164',0,262,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(656,26,X'6D6167',0,263,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(657,26,X'6D6168',0,264,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(658,26,X'6D6169',0,265,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(659,26,X'6D616B',0,266,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(660,26,X'6D616C',0,267,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(661,26,X'6D616E',0,268,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(662,26,X'6D616F',0,269,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(663,26,X'6D6170',0,270,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(664,26,X'6D6172',0,271,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(665,26,X'6D6173',0,272,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(666,26,X'6D6179',0,273,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(667,26,X'6D6466',0,274,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(668,26,X'6D6472',0,275,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(669,26,X'6D656E',0,276,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(670,26,X'6D6761',0,277,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(671,26,X'6D6963',0,278,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(672,26,X'6D696E',0,279,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(673,26,X'6D6973',0,280,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(674,26,X'6D6B68',0,281,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(675,26,X'6D6C67',0,282,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(676,26,X'6D6C74',0,283,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(677,26,X'6D6E63',0,284,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(678,26,X'6D6E69',0,285,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(679,26,X'6D6E6F',0,286,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(680,26,X'6D6F68',0,287,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(681,26,X'6D6F6E',0,288,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(682,26,X'6D6F73',0,289,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(683,26,X'6D756C',0,290,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(684,26,X'6D756E',0,291,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(685,26,X'6D7573',0,292,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(686,26,X'6D776C',0,293,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(687,26,X'6D7772',0,294,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(688,26,X'6D796E',0,295,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(689,26,X'6D7976',0,296,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(690,26,X'6E6168',0,297,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(691,26,X'6E6169',0,298,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(692,26,X'6E6170',0,299,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(693,26,X'6E6175',0,300,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(694,26,X'6E6176',0,301,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(695,26,X'6E626C',0,302,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(696,26,X'6E6465',0,303,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(697,26,X'6E646F',0,304,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(698,26,X'6E6473',0,305,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(699,26,X'6E6570',0,306,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(700,26,X'6E6577',0,307,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(701,26,X'6E6961',0,308,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(702,26,X'6E6963',0,309,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(703,26,X'6E6975',0,310,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(704,26,X'6E6E6F',0,311,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(705,26,X'6E6F62',0,312,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(706,26,X'6E6F67',0,313,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(707,26,X'6E6F6E',0,314,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(708,26,X'6E6F72',0,315,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(709,26,X'6E716F',0,316,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(710,26,X'6E736F',0,317,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(711,26,X'6E7562',0,318,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(712,26,X'6E7763',0,319,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(713,26,X'6E7961',0,320,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(714,26,X'6E796D',0,321,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(715,26,X'6E796E',0,322,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(716,26,X'6E796F',0,323,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(717,26,X'6E7A69',0,324,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(718,26,X'6F6369',0,325,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(719,26,X'6F6A69',0,326,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(720,26,X'6F7269',0,327,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(721,26,X'6F726D',0,328,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(722,26,X'6F7361',0,329,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(723,26,X'6F7373',0,330,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(724,26,X'6F7461',0,331,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(725,26,X'6F746F',0,332,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(726,26,X'706161',0,333,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(727,26,X'706167',0,334,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(728,26,X'70616C',0,335,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(729,26,X'70616D',0,336,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(730,26,X'70616E',0,337,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(731,26,X'706170',0,338,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(732,26,X'706175',0,339,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(733,26,X'70656F',0,340,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(734,26,X'706572',0,341,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(735,26,X'706869',0,342,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(736,26,X'70686E',0,343,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(737,26,X'706C69',0,344,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(738,26,X'706F6C',0,345,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(739,26,X'706F6E',0,346,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(740,26,X'706F72',0,347,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(741,26,X'707261',0,348,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(742,26,X'70726F',0,349,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(743,26,X'707573',0,350,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(745,26,X'717565',0,352,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(746,26,X'72616A',0,353,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(747,26,X'726170',0,354,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(748,26,X'726172',0,355,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(749,26,X'726F61',0,356,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(750,26,X'726F68',0,357,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(751,26,X'726F6D',0,358,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(752,26,X'72756D',0,359,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(753,26,X'72756E',0,360,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(754,26,X'727570',0,361,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(755,26,X'727573',0,362,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(756,26,X'736164',0,363,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(757,26,X'736167',0,364,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(758,26,X'736168',0,365,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(759,26,X'736169',0,366,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(760,26,X'73616C',0,367,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(761,26,X'73616D',0,368,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(762,26,X'73616E',0,369,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(763,26,X'736173',0,370,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(764,26,X'736174',0,371,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(765,26,X'73636E',0,372,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(766,26,X'73636F',0,373,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(767,26,X'73656C',0,374,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(768,26,X'73656D',0,375,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(769,26,X'736761',0,376,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(770,26,X'73676E',0,377,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(771,26,X'73686E',0,378,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(772,26,X'736964',0,379,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(773,26,X'73696E',0,380,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(774,26,X'73696F',0,381,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(775,26,X'736974',0,382,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(776,26,X'736C61',0,383,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(777,26,X'736C6F',0,384,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(778,26,X'736C76',0,385,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(779,26,X'736D61',0,386,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(780,26,X'736D65',0,387,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(781,26,X'736D69',0,388,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(782,26,X'736D6A',0,389,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(783,26,X'736D6E',0,390,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(784,26,X'736D6F',0,391,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(785,26,X'736D73',0,392,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(786,26,X'736E61',0,393,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(787,26,X'736E64',0,394,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(788,26,X'736E6B',0,395,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(789,26,X'736F67',0,396,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(790,26,X'736F6D',0,397,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(791,26,X'736F6E',0,398,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(792,26,X'736F74',0,399,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(793,26,X'737061',0,400,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(794,26,X'737264',0,401,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(795,26,X'73726E',0,402,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(796,26,X'737270',0,403,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(797,26,X'737272',0,404,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(798,26,X'737361',0,405,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(799,26,X'737377',0,406,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(800,26,X'73756B',0,407,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(801,26,X'73756E',0,408,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(802,26,X'737573',0,409,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(803,26,X'737578',0,410,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(804,26,X'737761',0,411,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(805,26,X'737765',0,412,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(806,26,X'737963',0,413,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(807,26,X'737972',0,414,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(808,26,X'746168',0,415,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(809,26,X'746169',0,416,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(810,26,X'74616D',0,417,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(811,26,X'746174',0,418,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(812,26,X'74656C',0,419,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(813,26,X'74656D',0,420,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(814,26,X'746572',0,421,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(815,26,X'746574',0,422,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(816,26,X'74676B',0,423,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(817,26,X'74676C',0,424,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(818,26,X'746861',0,425,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(819,26,X'746962',0,426,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(820,26,X'746967',0,427,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(821,26,X'746972',0,428,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(822,26,X'746976',0,429,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(823,26,X'746B6C',0,430,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(824,26,X'746C68',0,431,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(825,26,X'746C69',0,432,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(826,26,X'746D68',0,433,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(827,26,X'746F67',0,434,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(828,26,X'746F6E',0,435,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(829,26,X'747069',0,436,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(830,26,X'747369',0,437,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(831,26,X'74736E',0,438,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(832,26,X'74736F',0,439,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(833,26,X'74756B',0,440,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(834,26,X'74756D',0,441,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(835,26,X'747570',0,442,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(836,26,X'747572',0,443,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(837,26,X'747574',0,444,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(838,26,X'74766C',0,445,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(839,26,X'747769',0,446,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(840,26,X'747976',0,447,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(841,26,X'75646D',0,448,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(842,26,X'756761',0,449,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(843,26,X'756967',0,450,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(844,26,X'756B72',0,451,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(845,26,X'756D62',0,452,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(846,26,X'756E64',0,453,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(847,26,X'757264',0,454,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(848,26,X'757A62',0,455,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(849,26,X'766169',0,456,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(850,26,X'76656E',0,457,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(851,26,X'766965',0,458,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(852,26,X'766F6C',0,459,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(853,26,X'766F74',0,460,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(854,26,X'77616B',0,461,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(855,26,X'77616C',0,462,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(856,26,X'776172',0,463,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(857,26,X'776173',0,464,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(858,26,X'77656C',0,465,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(859,26,X'77656E',0,466,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(860,26,X'776C6E',0,467,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(861,26,X'776F6C',0,468,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(862,26,X'78616C',0,469,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(863,26,X'78686F',0,470,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(864,26,X'79616F',0,471,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(865,26,X'796170',0,472,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(866,26,X'796964',0,473,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(867,26,X'796F72',0,474,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(868,26,X'79706B',0,475,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(869,26,X'7A6170',0,476,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(870,26,X'7A626C',0,477,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(871,26,X'7A656E',0,478,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(872,26,X'7A6861',0,479,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(873,26,X'7A6E64',0,480,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(874,26,X'7A756C',0,481,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(875,26,X'7A756E',0,482,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(876,26,X'7A7878',0,483,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(877,26,X'7A7A61',0,484,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(878,27,X'63726561746F72',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(879,27,X'736F75726365',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(880,27,X'7375626A656374',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(881,28,X'69735F6173736F636961746976655F77697468',1,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(882,29,X'69735F6561726C6965725F666F726D5F6F66',1,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(883,29,X'69735F6C617465725F666F726D5F6F66',1,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(884,30,X'69735F706172656E745F6F66',1,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(885,30,X'69735F6368696C645F6F66',1,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(886,31,X'69735F7375626F7264696E6174655F746F',1,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(887,31,X'69735F7375706572696F725F6F66',1,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(888,32,X'636C617373',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(889,32,X'636F6C6C656374696F6E',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(890,32,X'66696C65',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(891,32,X'666F6E6473',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(892,32,X'6974656D',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(893,32,X'6F746865726C6576656C',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(894,32,X'7265636F7264677270',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(895,32,X'736572696573',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(896,32,X'737562666F6E6473',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(897,32,X'737562677270',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(898,32,X'737562736572696573',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(899,33,X'63757272656E74',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(900,33,X'70726576696F7573',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(901,34,X'73696E676C65',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(902,34,X'62756C6B',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(903,34,X'696E636C7573697665',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(904,35,X'62726F616463617374',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(905,35,X'636F70797269676874',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(906,35,X'6372656174696F6E',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(907,35,X'6465616363657373696F6E',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(908,35,X'6469676974697A6564',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(909,35,X'6576656E74',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(910,35,X'697373756564',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(911,35,X'6D6F646966696564',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(912,35,X'7075626C69636174696F6E',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(913,35,X'6167656E745F72656C6174696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(914,35,X'6F74686572',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(915,35,X'7573616765',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(916,35,X'6578697374656E6365',1,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(917,35,X'7265636F72645F6B656570696E67',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(918,36,X'617070726F78696D617465',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(919,36,X'696E666572726564',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(920,36,X'7175657374696F6E61626C65',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(921,37,X'77686F6C65',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(922,37,X'70617274',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(923,38,X'77686F6C65',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(924,38,X'70617274',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(925,39,X'6E6F6E65',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(926,39,X'6F74686572',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(927,39,X'6F6E4C6F6164',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(928,39,X'6F6E52657175657374',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(929,40,X'6E6577',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(930,40,X'7265706C616365',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(931,40,X'656D626564',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(932,40,X'6F74686572',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(933,40,X'6E6F6E65',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(934,41,X'61696666',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(935,41,X'617669',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(936,41,X'676966',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(937,41,X'6A706567',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(938,41,X'6D7033',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(939,41,X'706466',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(940,41,X'74696666',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(941,41,X'747874',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(942,42,X'636F6E736572766174696F6E',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(943,42,X'65786869626974',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(944,42,X'6C6F616E',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(945,42,X'72656164696E675F726F6F6D',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(946,43,X'696E766572746564',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(947,43,X'646972656374',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(948,44,X'73756D6D617279',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(949,44,X'62696F6768697374',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(950,44,X'6163636573737265737472696374',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(951,44,X'7573657265737472696374',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(952,44,X'637573746F6468697374',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(953,44,X'64696D656E73696F6E73',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(954,44,X'65646974696F6E',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(955,44,X'657874656E74',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(956,44,X'616C74666F726D617661696C',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(957,44,X'6F726967696E616C736C6F63',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(958,44,X'6E6F7465',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(959,44,X'616371696E666F',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(960,44,X'696E736372697074696F6E',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(962,44,X'6C6567616C737461747573',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(963,44,X'7068797364657363',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(964,44,X'70726566657263697465',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(965,44,X'70726F63657373696E666F',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(966,44,X'72656C617465646D6174657269616C',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(967,45,X'6163637275616C73',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(968,45,X'61707072616973616C',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(969,45,X'617272616E67656D656E74',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(970,45,X'62696F6768697374',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(971,45,X'6163636573737265737472696374',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(972,45,X'7573657265737472696374',0,20,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(973,45,X'637573746F6468697374',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(974,45,X'64696D656E73696F6E73',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(975,45,X'616C74666F726D617661696C',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(976,45,X'6F726967696E616C736C6F63',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(977,45,X'66696C65706C616E',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(978,45,X'6F6464',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(979,45,X'616371696E666F',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(980,45,X'6C6567616C737461747573',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(981,45,X'6F7468657266696E64616964',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(982,45,X'7068797374656368',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(983,45,X'70726566657263697465',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(984,45,X'70726F63657373696E666F',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(985,45,X'72656C617465646D6174657269616C',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(986,45,X'73636F7065636F6E74656E74',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(987,45,X'7365706172617465646D6174657269616C',0,19,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(988,46,X'617261626963',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(989,46,X'6C6F776572616C706861',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(990,46,X'7570706572616C706861',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(991,46,X'6C6F776572726F6D616E',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(992,46,X'7570706572726F6D616E',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(993,47,X'6162737472616374',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(994,47,X'7068797364657363',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(996,47,X'706879736C6F63',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(997,47,X'6D6174657269616C73706563',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(998,47,X'706879736661636574',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(999,48,X'6269626C696F677261706879',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1000,49,X'696E646578',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1001,50,X'6E616D65',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1002,50,X'706572736F6E',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1003,50,X'66616D696C79',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1004,50,X'636F72706F726174655F656E74697479',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1005,50,X'7375626A656374',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1006,50,X'66756E6374696F6E',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1007,50,X'6F636375706174696F6E',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1008,50,X'7469746C65',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1009,50,X'67656F677261706869635F6E616D65',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1010,50,X'67656E72655F666F726D',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1011,51,X'4146',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1012,51,X'4158',0,14,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1013,51,X'414C',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1014,51,X'445A',0,61,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1015,51,X'4153',0,10,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1016,51,X'4144',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1017,51,X'414F',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1018,51,X'4149',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1019,51,X'4151',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1020,51,X'4147',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1021,51,X'4152',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1022,51,X'414D',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1023,51,X'4157',0,13,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1024,51,X'4155',0,12,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1025,51,X'4154',0,11,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1026,51,X'415A',0,15,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1027,51,X'4253',0,31,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1028,51,X'4248',0,22,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1029,51,X'4244',0,18,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1030,51,X'4242',0,17,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1031,51,X'4259',0,35,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1032,51,X'4245',0,19,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1033,51,X'425A',0,36,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1034,51,X'424A',0,24,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1035,51,X'424D',0,26,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1036,51,X'4254',0,32,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1037,51,X'424F',0,28,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1038,51,X'4251',0,29,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1039,51,X'4241',0,16,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1040,51,X'4257',0,34,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1041,51,X'4256',0,33,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1042,51,X'4252',0,30,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1043,51,X'494F',0,105,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1044,51,X'424E',0,27,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1045,51,X'4247',0,21,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1046,51,X'4246',0,20,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1047,51,X'4249',0,23,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1048,51,X'4B48',0,116,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1049,51,X'434D',0,46,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1050,51,X'4341',0,37,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1051,51,X'4356',0,51,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1052,51,X'4B59',0,123,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1053,51,X'4346',0,40,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1054,51,X'5444',0,214,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1055,51,X'434C',0,45,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1056,51,X'434E',0,47,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1057,51,X'4358',0,53,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1058,51,X'4343',0,38,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1059,51,X'434F',0,48,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1060,51,X'4B4D',0,118,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1061,51,X'4347',0,41,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1062,51,X'4344',0,39,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1063,51,X'434B',0,44,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1064,51,X'4352',0,49,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1065,51,X'4349',0,43,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1066,51,X'4852',0,97,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1067,51,X'4355',0,50,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1068,51,X'4357',0,52,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1069,51,X'4359',0,54,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1070,51,X'435A',0,55,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1071,51,X'444B',0,58,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1072,51,X'444A',0,57,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1073,51,X'444D',0,59,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1074,51,X'444F',0,60,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1075,51,X'4543',0,62,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1076,51,X'4547',0,64,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1077,51,X'5356',0,209,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1078,51,X'4751',0,87,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1079,51,X'4552',0,66,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1080,51,X'4545',0,63,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1081,51,X'4554',0,68,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1082,51,X'464B',0,71,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1083,51,X'464F',0,73,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1084,51,X'464A',0,70,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1085,51,X'4649',0,69,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1086,51,X'4652',0,74,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1087,51,X'4746',0,79,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1088,51,X'5046',0,174,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1089,51,X'5446',0,215,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1090,51,X'4741',0,75,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1091,51,X'474D',0,84,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1092,51,X'4745',0,78,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1093,51,X'4445',0,56,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1094,51,X'4748',0,81,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1095,51,X'4749',0,82,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1096,51,X'4752',0,88,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1097,51,X'474C',0,83,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1098,51,X'4744',0,77,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1099,51,X'4750',0,86,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1100,51,X'4755',0,91,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1101,51,X'4754',0,90,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1102,51,X'4747',0,80,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1103,51,X'474E',0,85,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1104,51,X'4757',0,92,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1105,51,X'4759',0,93,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1106,51,X'4854',0,98,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1107,51,X'484D',0,95,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1108,51,X'5641',0,235,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1109,51,X'484E',0,96,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1110,51,X'484B',0,94,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1111,51,X'4855',0,99,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1112,51,X'4953',0,108,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1113,51,X'494E',0,104,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1114,51,X'4944',0,100,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1115,51,X'4952',0,107,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1116,51,X'4951',0,106,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1117,51,X'4945',0,101,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1118,51,X'494D',0,103,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1119,51,X'494C',0,102,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1120,51,X'4954',0,109,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1121,51,X'4A4D',0,111,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1122,51,X'4A50',0,113,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1123,51,X'4A45',0,110,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1124,51,X'4A4F',0,112,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1125,51,X'4B5A',0,124,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1126,51,X'4B45',0,114,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1127,51,X'4B49',0,117,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1128,51,X'4B50',0,120,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1129,51,X'4B52',0,121,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1130,51,X'4B57',0,122,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1131,51,X'4B47',0,115,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1132,51,X'4C41',0,125,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1133,51,X'4C56',0,134,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1134,51,X'4C42',0,126,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1135,51,X'4C53',0,131,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1136,51,X'4C52',0,130,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1137,51,X'4C59',0,135,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1138,51,X'4C49',0,128,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1139,51,X'4C54',0,132,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1140,51,X'4C55',0,133,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1141,51,X'4D4F',0,147,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1142,51,X'4D4B',0,143,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1143,51,X'4D47',0,141,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1144,51,X'4D57',0,155,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1145,51,X'4D59',0,157,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1146,51,X'4D56',0,154,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1147,51,X'4D4C',0,144,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1148,51,X'4D54',0,152,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1149,51,X'4D48',0,142,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1150,51,X'4D51',0,149,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1151,51,X'4D52',0,150,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1152,51,X'4D55',0,153,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1153,51,X'5954',0,245,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1154,51,X'4D58',0,156,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1155,51,X'464D',0,72,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1156,51,X'4D44',0,138,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1157,51,X'4D43',0,137,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1158,51,X'4D4E',0,146,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1159,51,X'4D45',0,139,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1160,51,X'4D53',0,151,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1161,51,X'4D41',0,136,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1162,51,X'4D5A',0,158,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1163,51,X'4D4D',0,145,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1164,51,X'4E41',0,159,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1165,51,X'4E52',0,168,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1166,51,X'4E50',0,167,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1167,51,X'4E4C',0,165,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1168,51,X'4E43',0,160,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1169,51,X'4E5A',0,170,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1170,51,X'4E49',0,164,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1171,51,X'4E45',0,161,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1172,51,X'4E47',0,163,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1173,51,X'4E55',0,169,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1174,51,X'4E46',0,162,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1175,51,X'4D50',0,148,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1176,51,X'4E4F',0,166,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1177,51,X'4F4D',0,171,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1178,51,X'504B',0,177,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1179,51,X'5057',0,184,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1180,51,X'5053',0,182,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1181,51,X'5041',0,172,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1182,51,X'5047',0,175,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1183,51,X'5059',0,185,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1184,51,X'5045',0,173,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1185,51,X'5048',0,176,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1186,51,X'504E',0,180,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1187,51,X'504C',0,178,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1188,51,X'5054',0,183,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1189,51,X'5052',0,181,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1190,51,X'5141',0,186,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1191,51,X'5245',0,187,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1192,51,X'524F',0,188,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1193,51,X'5255',0,190,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1194,51,X'5257',0,191,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1195,51,X'424C',0,25,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1196,51,X'5348',0,198,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1197,51,X'4B4E',0,119,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1198,51,X'4C43',0,127,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1199,51,X'4D46',0,140,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1200,51,X'504D',0,179,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1201,51,X'5643',0,236,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1202,51,X'5753',0,243,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1203,51,X'534D',0,203,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1204,51,X'5354',0,208,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1205,51,X'5341',0,192,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1206,51,X'534E',0,204,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1207,51,X'5253',0,189,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1208,51,X'5343',0,194,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1209,51,X'534C',0,202,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1210,51,X'5347',0,197,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1211,51,X'5358',0,210,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1212,51,X'534B',0,201,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1213,51,X'5349',0,199,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1214,51,X'5342',0,193,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1215,51,X'534F',0,205,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1216,51,X'5A41',0,246,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1217,51,X'4753',0,89,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1218,51,X'5353',0,207,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1219,51,X'4553',0,67,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1220,51,X'4C4B',0,129,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1221,51,X'5344',0,195,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1222,51,X'5352',0,206,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1223,51,X'534A',0,200,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1224,51,X'535A',0,212,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1225,51,X'5345',0,196,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1226,51,X'4348',0,42,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1227,51,X'5359',0,211,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1228,51,X'5457',0,227,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1229,51,X'544A',0,218,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1230,51,X'545A',0,228,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1231,51,X'5448',0,217,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1232,51,X'544C',0,220,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1233,51,X'5447',0,216,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1234,51,X'544B',0,219,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1235,51,X'544F',0,223,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1236,51,X'5454',0,225,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1237,51,X'544E',0,222,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1238,51,X'5452',0,224,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1239,51,X'544D',0,221,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1240,51,X'5443',0,213,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1241,51,X'5456',0,226,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1242,51,X'5547',0,230,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1243,51,X'5541',0,229,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1244,51,X'4145',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1245,51,X'4742',0,76,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1246,51,X'5553',0,232,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1247,51,X'554D',0,231,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1248,51,X'5559',0,233,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1249,51,X'555A',0,234,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1250,51,X'5655',0,241,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1251,51,X'5645',0,237,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1252,51,X'564E',0,240,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1253,51,X'5647',0,238,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1254,51,X'5649',0,239,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1255,51,X'5746',0,242,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1256,51,X'4548',0,65,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1257,51,X'5945',0,244,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1258,51,X'5A4D',0,247,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1259,51,X'5A57',0,248,0,0,1,NULL,NULL,'2026-02-16 15:40:28','2026-02-16 15:40:28','2026-02-16 15:40:28'),
	(1260,52,X'636F70797269676874',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1261,52,X'6C6963656E7365',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1262,52,X'73746174757465',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1263,52,X'6F74686572',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1264,53,X'636F707972696768746564',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1265,53,X'7075626C69635F646F6D61696E',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1266,53,X'756E6B6E6F776E',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1267,54,X'63756C747572616C5F636F6E74657874',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1268,54,X'66756E6374696F6E',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1269,54,X'67656F67726170686963',0,3,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1270,54,X'67656E72655F666F726D',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1271,54,X'6F636375706174696F6E',0,4,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1272,54,X'7374796C655F706572696F64',0,5,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1273,54,X'746563686E69717565',0,6,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1274,54,X'74656D706F72616C',0,7,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1275,54,X'746F706963616C',0,8,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1276,54,X'756E69666F726D5F7469746C65',0,9,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1277,55,X'6E6F76616C7565',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1278,56,X'6E6F76616C7565',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1279,57,X'6E6F76616C7565',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1280,58,X'6E6F76616C7565',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1281,34,X'72616E6765',0,2,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1282,59,X'6861735F70617274',0,1,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1283,59,X'666F726D735F706172745F6F66',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1284,60,X'70617274',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1285,61,X'7369626C696E675F6F66',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1286,62,X'626F756E645F77697468',0,0,0,0,1,NULL,NULL,'2026-02-16 15:40:29','2026-02-16 15:40:29','2026-02-16 15:40:29'),
	(1290,1,X'616272',0,226,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1291,1,X'616469',0,227,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1292,1,X'617065',0,228,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1293,1,X'61706C',0,229,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1294,1,X'61746F',0,230,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1295,1,X'627264',0,231,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1296,1,X'62726C',0,232,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1297,1,X'636173',0,233,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1298,1,X'636F72',0,234,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1299,1,X'636F75',0,235,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1300,1,X'637274',0,236,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1301,1,X'646773',0,237,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1302,1,X'656463',0,238,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1303,1,X'65646D',0,239,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1304,1,X'656E6A',0,240,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1305,1,X'666473',0,241,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1306,1,X'666D64',0,242,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1307,1,X'666D6B',0,243,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1308,1,X'666D70',0,244,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1309,1,X'2D677274',0,245,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1310,1,X'686973',0,246,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1311,1,X'697362',0,247,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1312,1,X'6A7564',0,248,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1313,1,X'6A7567',0,249,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1314,1,X'6D6564',0,250,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1315,1,X'6D746B',0,251,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1316,1,X'6F7370',0,252,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1317,1,X'70616E',0,253,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1318,1,X'707261',0,254,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1319,1,X'707265',0,255,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1320,1,X'70726E',0,256,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1321,1,X'707273',0,257,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1322,1,X'726464',0,258,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1323,1,X'727063',0,259,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1324,1,X'727372',0,260,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1325,1,X'736764',0,261,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1326,1,X'736C6C',0,262,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1327,1,X'746C64',0,263,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1328,1,X'746C70',0,264,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1329,1,X'766163',0,265,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1330,1,X'776163',0,266,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1331,1,X'77616C',0,267,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1332,1,X'776174',0,268,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1333,1,X'77696E',0,269,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1334,1,X'777072',0,270,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1335,1,X'777374',0,271,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1336,64,X'627573696E657373',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1337,64,X'686F6D65',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1338,64,X'63656C6C',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1339,64,X'666178',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1340,15,X'70726F63657373696E675F73746172746564',0,33,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1341,15,X'70726F63657373696E675F636F6D706C65746564',0,34,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1342,15,X'70726F63657373696E675F696E5F70726F6772657373',0,35,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1343,15,X'70726F63657373696E675F6E6577',0,36,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1344,65,X'5265737472696374656453706563436F6C6C',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1345,65,X'526573747269637465644375724170707253706563436F6C6C',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1346,65,X'5265737472696374656446726167696C6553706563436F6C6C',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1347,65,X'496E50726F6365737353706563436F6C6C',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1348,65,X'436F6C6453746F726167654272626C',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1349,66,X'696E63686573',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1350,66,X'66656574',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1351,66,X'7961726473',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1352,66,X'6D696C6C696D6574657273',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1353,66,X'63656E74696D6574657273',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1354,66,X'6D6574657273',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1357,67,X'61765F6D6174657269616C73',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1358,67,X'6172726976616C73',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1359,67,X'736861726564',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1360,68,X'64656C657465',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1361,68,X'64697373656D696E617465',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1362,68,X'6D696772617465',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1363,68,X'6D6F64696679',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1364,68,X'7265706C6963617465',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1365,68,X'757365',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1366,69,X'616C6C6F77',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1367,69,X'646973616C6C6F77',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1368,69,X'636F6E646974696F6E616C',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1369,70,X'7065726D697373696F6E73',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1370,70,X'7265737472696374696F6E73',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1371,70,X'657874656E73696F6E',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1372,70,X'65787069726174696F6E',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1373,70,X'6164646974696F6E616C5F696E666F726D6174696F6E',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1374,71,X'6D6174657269616C73',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1375,71,X'747970655F6E6F7465',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1376,71,X'6164646974696F6E616C5F696E666F726D6174696F6E',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1377,72,X'6167726F766F63',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1378,72,X'616C6C6D6F766965',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1379,72,X'616C6C6D75736963',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1380,72,X'616C6C6F63696E65',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1381,72,X'616D6E626F',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1382,72,X'616E7369',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1383,72,X'6172747379',0,6,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1384,72,X'6264757363',0,7,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1385,72,X'626669',0,8,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1386,72,X'626E666367',0,9,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1387,72,X'63616E746963',0,10,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1388,72,X'63676E6462',0,11,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1389,72,X'64616E61636F6465',0,12,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1390,72,X'6461746F736573',0,13,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1391,72,X'646973636F6773',0,14,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1392,72,X'646B66696C6D',0,15,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1393,72,X'646F69',0,16,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1394,72,X'65616E',0,17,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1395,72,X'65696472',0,18,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1396,72,X'66617374',0,19,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1397,72,X'66696C6D706F7274',0,20,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1398,72,X'66696E64616772',0,21,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1399,72,X'6672656562617365',0,22,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1400,72,X'676563',0,23,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1401,72,X'67656F676E6462',0,24,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1402,72,X'67656F6E616D6573',0,25,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1403,72,X'676574747974676E',0,26,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1404,72,X'6765747479756C616E',0,27,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1405,72,X'676E64',0,28,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1406,72,X'676E6973',0,29,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1407,72,X'6774696E2D3134',0,30,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1408,72,X'68646C',0,31,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1409,72,X'69626462',0,32,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1410,72,X'6964726566',0,33,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1411,72,X'696D6462',0,34,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1412,72,X'6973616E',0,35,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1413,72,X'6973626E',0,36,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1414,72,X'6973626E2D61',0,37,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1415,72,X'6973626E7265',0,38,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1416,72,X'6973696C',0,39,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1417,72,X'69736D6E',0,40,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1418,72,X'69736E69',0,41,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1419,72,X'69736F',0,42,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1420,72,X'69737263',0,43,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1421,72,X'6973736E',0,44,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1422,72,X'6973736E2D6C',0,45,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1423,72,X'69737375652D6E756D626572',0,46,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1424,72,X'69737463',0,47,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1425,72,X'69737763',0,48,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1426,72,X'69746172',0,49,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1427,72,X'6B696E6F706F',0,50,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1428,72,X'6C63636E',0,51,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1429,72,X'6C636D64',0,52,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1430,72,X'6C636D7074',0,53,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1431,72,X'6C6962617573',0,54,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1432,72,X'6C6F63616C',0,55,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1433,72,X'6D61747269782D6E756D626572',0,56,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1434,72,X'6D6F6D61',0,57,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1435,72,X'6D756E7A696E67',0,58,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1436,72,X'6D757369632D706C617465',0,59,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1437,72,X'6D757369632D7075626C6973686572',0,60,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1438,72,X'6D7573696362',0,61,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1439,72,X'6E617467617A666964',0,62,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1440,72,X'6E6761',0,63,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1441,72,X'6E69706F',0,64,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1442,72,X'6E6E6462',0,65,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1443,72,X'6E7067',0,66,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1444,72,X'6F646E62',0,67,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1445,72,X'6F70656E736D',0,68,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1446,72,X'6F72636964',0,69,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1447,72,X'6F78666F7264646E62',0,70,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1448,72,X'706F72746875',0,71,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1449,72,X'72626D736274',0,72,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1450,72,X'72626D736774',0,73,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1451,72,X'72626D737065',0,74,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1452,72,X'72626D73707065',0,75,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1453,72,X'72626D737074',0,76,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1454,72,X'72626D737264',0,77,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1455,72,X'72626D737465',0,78,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1456,72,X'726964',0,79,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1457,72,X'726B6461',0,80,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1458,72,X'7361616D',0,81,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1459,72,X'7363686F6C617275',0,82,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1460,72,X'73636F7065',0,83,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1461,72,X'73636F707573',0,84,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1462,72,X'73696369',0,85,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1463,72,X'73706F74696679',0,86,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1464,72,X'73707266627362',0,87,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1465,72,X'7370726662736B',0,88,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1466,72,X'73707266636262',0,89,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1467,72,X'73707266636662',0,90,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1468,72,X'73707266686F63',0,91,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1469,72,X'737072666F6C79',0,92,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1470,72,X'73707266706662',0,93,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1471,72,X'73746F636B2D6E756D626572',0,94,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1472,72,X'7374726E',0,95,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1473,72,X'737666696C6D',0,96,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1474,72,X'7461746561726964',0,97,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1475,72,X'746865617472',0,98,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1476,72,X'74726F7665',0,99,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1477,72,X'757063',0,100,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1478,72,X'757269',0,101,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1479,72,X'75726E',0,102,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1480,72,X'76696166',0,103,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1481,72,X'766964656F7265636F7264696E672D6964656E746966696572',0,104,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1482,72,X'77696B6964617461',0,105,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1483,72,X'776E646C61',0,106,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1484,73,X'646F6E6F72',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1485,73,X'706F6C696379',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1486,15,X'72657175657374',1,37,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1487,18,X'63616E63656C6C6564',1,3,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1488,18,X'66756C66696C6C6564',1,4,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1489,18,X'70656E64696E67',1,5,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1490,3,X'726571756573746572',1,6,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1491,2,X'636F6E74657874',1,3,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1492,2,X'726571756573746564',1,4,0,0,1,NULL,NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(1493,26,X'636E72',0,485,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1494,26,X'7A6768',0,486,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1495,74,X'41646C6D',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1496,74,X'4166616B',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1497,74,X'41676862',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1498,74,X'41686F6D',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1499,74,X'41726162',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1500,74,X'4172616E',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1501,74,X'41726D69',0,6,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1502,74,X'41726D6E',0,7,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1503,74,X'41767374',0,8,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1504,74,X'42616C69',0,9,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1505,74,X'42616D75',0,10,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1506,74,X'42617373',0,11,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1507,74,X'4261746B',0,12,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1508,74,X'42656E67',0,13,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1509,74,X'42686B73',0,14,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1510,74,X'426C6973',0,15,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1511,74,X'426F706F',0,16,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1512,74,X'42726168',0,17,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1513,74,X'42726169',0,18,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1514,74,X'42756769',0,19,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1515,74,X'42756864',0,20,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1516,74,X'43616B6D',0,21,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1517,74,X'43616E73',0,22,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1518,74,X'43617269',0,23,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1519,74,X'4368616D',0,24,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1520,74,X'43686572',0,25,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1521,74,X'43697274',0,26,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1522,74,X'436F7074',0,27,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1523,74,X'43706D6E',0,28,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1524,74,X'43707274',0,29,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1525,74,X'4379726C',0,30,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1526,74,X'43797273',0,31,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1527,74,X'44657661',0,32,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1528,74,X'446F6772',0,33,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1529,74,X'44737274',0,34,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1530,74,X'4475706C',0,35,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1531,74,X'45677964',0,36,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1532,74,X'45677968',0,37,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1533,74,X'45677970',0,38,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1534,74,X'456C6261',0,39,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1535,74,X'456C796D',0,40,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1536,74,X'45746869',0,41,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1537,74,X'47656F6B',0,42,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1538,74,X'47656F72',0,43,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1539,74,X'476C6167',0,44,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1540,74,X'476F6E67',0,45,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1541,74,X'476F6E6D',0,46,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1542,74,X'476F7468',0,47,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1543,74,X'4772616E',0,48,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1544,74,X'4772656B',0,49,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1545,74,X'47756A72',0,50,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1546,74,X'47757275',0,51,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1547,74,X'48616E62',0,52,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1548,74,X'48616E67',0,53,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1549,74,X'48616E69',0,54,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1550,74,X'48616E6F',0,55,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1551,74,X'48616E73',0,56,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1552,74,X'48616E74',0,57,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1553,74,X'48617472',0,58,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1554,74,X'48656272',0,59,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1555,74,X'48697261',0,60,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1556,74,X'486C7577',0,61,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1557,74,X'486D6E67',0,62,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1558,74,X'486D6E70',0,63,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1559,74,X'48726B74',0,64,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1560,74,X'48756E67',0,65,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1561,74,X'496E6473',0,66,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1562,74,X'4974616C',0,67,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1563,74,X'4A616D6F',0,68,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1564,74,X'4A617661',0,69,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1565,74,X'4A70616E',0,70,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1566,74,X'4A757263',0,71,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1567,74,X'4B616C69',0,72,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1568,74,X'4B616E61',0,73,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1569,74,X'4B686172',0,74,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1570,74,X'4B686D72',0,75,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1571,74,X'4B686F6A',0,76,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1572,74,X'4B69746C',0,77,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1573,74,X'4B697473',0,78,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1574,74,X'4B6E6461',0,79,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1575,74,X'4B6F7265',0,80,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1576,74,X'4B70656C',0,81,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1577,74,X'4B746869',0,82,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1578,74,X'4C616E61',0,83,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1579,74,X'4C616F6F',0,84,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1580,74,X'4C617466',0,85,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1581,74,X'4C617467',0,86,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1582,74,X'4C61746E',0,87,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1583,74,X'4C656B65',0,88,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1584,74,X'4C657063',0,89,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1585,74,X'4C696D62',0,90,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1586,74,X'4C696E61',0,91,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1587,74,X'4C696E62',0,92,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1588,74,X'4C697375',0,93,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1589,74,X'4C6F6D61',0,94,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1590,74,X'4C796369',0,95,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1591,74,X'4C796469',0,96,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1592,74,X'4D61686A',0,97,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1593,74,X'4D616B61',0,98,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1594,74,X'4D616E64',0,99,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1595,74,X'4D616E69',0,100,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1596,74,X'4D617263',0,101,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1597,74,X'4D617961',0,102,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1598,74,X'4D656466',0,103,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1599,74,X'4D656E64',0,104,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1600,74,X'4D657263',0,105,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1601,74,X'4D65726F',0,106,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1602,74,X'4D6C796D',0,107,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1603,74,X'4D6F6469',0,108,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1604,74,X'4D6F6E67',0,109,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1605,74,X'4D6F6F6E',0,110,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1606,74,X'4D726F6F',0,111,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1607,74,X'4D746569',0,112,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1608,74,X'4D756C74',0,113,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1609,74,X'4D796D72',0,114,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1610,74,X'4E616E64',0,115,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1611,74,X'4E617262',0,116,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1612,74,X'4E626174',0,117,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1613,74,X'4E657761',0,118,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1614,74,X'4E6B6462',0,119,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1615,74,X'4E6B6762',0,120,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1616,74,X'4E6B6F6F',0,121,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1617,74,X'4E736875',0,122,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1618,74,X'4F67616D',0,123,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1619,74,X'4F6C636B',0,124,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1620,74,X'4F726B68',0,125,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1621,74,X'4F727961',0,126,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1622,74,X'4F736765',0,127,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1623,74,X'4F736D61',0,128,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1624,74,X'50616C6D',0,129,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1625,74,X'50617563',0,130,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1626,74,X'5065726D',0,131,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1627,74,X'50686167',0,132,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1628,74,X'50686C69',0,133,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1629,74,X'50686C70',0,134,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1630,74,X'50686C76',0,135,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1631,74,X'50686E78',0,136,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1632,74,X'506C7264',0,137,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1633,74,X'50697164',0,138,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1634,74,X'50727469',0,139,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1635,74,X'51616161',0,140,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1636,74,X'51616278',0,141,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1637,74,X'526A6E67',0,142,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1638,74,X'526F6867',0,143,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1639,74,X'526F726F',0,144,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1640,74,X'52756E72',0,145,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1641,74,X'53616D72',0,146,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1642,74,X'53617261',0,147,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1643,74,X'53617262',0,148,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1644,74,X'53617572',0,149,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1645,74,X'53676E77',0,150,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1646,74,X'53686177',0,151,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1647,74,X'53687264',0,152,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1648,74,X'53687569',0,153,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1649,74,X'53696464',0,154,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1650,74,X'53696E64',0,155,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1651,74,X'53696E68',0,156,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1652,74,X'536F6764',0,157,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1653,74,X'536F676F',0,158,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1654,74,X'536F7261',0,159,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1655,74,X'536F796F',0,160,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1656,74,X'53756E64',0,161,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1657,74,X'53796C6F',0,162,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1658,74,X'53797263',0,163,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1659,74,X'53797265',0,164,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1660,74,X'5379726A',0,165,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1661,74,X'5379726E',0,166,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1662,74,X'54616762',0,167,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1663,74,X'54616B72',0,168,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1664,74,X'54616C65',0,169,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1665,74,X'54616C75',0,170,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1666,74,X'54616D6C',0,171,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1667,74,X'54616E67',0,172,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1668,74,X'54617674',0,173,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1669,74,X'54656C75',0,174,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1670,74,X'54656E67',0,175,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1671,74,X'54666E67',0,176,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1672,74,X'54676C67',0,177,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1673,74,X'54686161',0,178,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1674,74,X'54686169',0,179,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1675,74,X'54696274',0,180,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1676,74,X'54697268',0,181,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1677,74,X'55676172',0,182,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1678,74,X'56616969',0,183,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1679,74,X'56697370',0,184,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1680,74,X'57617261',0,185,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1681,74,X'5763686F',0,186,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1682,74,X'576F6C65',0,187,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1683,74,X'5870656F',0,188,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1684,74,X'58737578',0,189,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1685,74,X'59696969',0,190,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1686,74,X'5A616E62',0,191,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1687,74,X'5A696E68',0,192,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1688,74,X'5A6D7468',0,193,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1689,74,X'5A737965',0,194,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1690,74,X'5A73796D',0,195,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1691,74,X'5A787878',0,196,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1692,74,X'5A797979',0,197,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1693,74,X'5A7A7A7A',0,198,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1694,75,X'6C616E676D6174657269616C',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1695,4,X'696E67657374',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1696,23,X'696E67657374',0,7,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1697,76,X'6E6577',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1698,76,X'7570677261646564',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1699,76,X'726576697365645F636F72726563746564',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1700,76,X'64657269766564',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1701,76,X'64656C65746564',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1702,76,X'63616E63656C6C65645F6F62736F6C657465',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1703,76,X'64656C657465645F73706C6974',0,6,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1704,76,X'64656C657465645F7265706C61636564',0,7,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1705,77,X'696E5F70726F63657373',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1706,77,X'617070726F766564',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1707,78,X'696E745F737464',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1708,78,X'6E61745F737464',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1709,78,X'6E6C5F6173736F635F737464',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1710,78,X'6E6C5F6269625F6167656E63795F737464',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1711,78,X'6C6F63616C5F7374616E64617264',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1712,78,X'756E6B6E6F776E5F7374616E64617264',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1713,78,X'636F6E765F726F6D5F6361745F6167656E6379',0,6,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1714,78,X'6E6F745F6170706C696361626C65',0,7,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1715,79,X'616C612D6C63',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1716,80,X'6E676F',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1717,80,X'736163',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1718,80,X'6D756C74696C6F63616C',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1719,80,X'666564',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1720,80,X'696E745F676F76',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1721,80,X'6C6F63616C',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1722,80,X'6D756C74697374617465',0,6,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1723,80,X'756E64657465726D696E6564',0,7,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1724,80,X'70726F76696E6369616C',0,8,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1725,80,X'756E6B6E6F776E',0,9,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1726,80,X'6F74686572',0,10,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1727,80,X'6E617463',0,11,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1728,81,X'74725F636F6E73697374656E74',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1729,81,X'74725F696E636F6E73697374656E74',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1730,81,X'6E6F745F6170706C696361626C65',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1731,81,X'6E617463',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1732,82,X'646966666572656E746961746564',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1733,82,X'756E646966666572656E746961746564',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1734,82,X'6E6F745F6170706C696361626C65',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1735,82,X'6E617463',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1736,83,X'66756C6C795F65737461626C6973686564',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1737,83,X'6D656D6F72616E64756D',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1738,83,X'70726F766973696F6E616C',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1739,83,X'7072656C696D696E617279',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1740,83,X'6E6F745F6170706C696361626C65',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1741,83,X'6E617463',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1742,84,X'6E6F745F6D6F646966696564',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1743,84,X'73686F7274656E6564',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1744,84,X'6D697373696E675F63686172616374657273',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1745,84,X'6E617463',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1746,85,X'6E61745F6269625F6167656E6379',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1747,85,X'636370',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1748,85,X'6F74686572',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1749,85,X'756E6B6E6F776E',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1750,85,X'6E617463',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1751,86,X'6C6F63',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1752,86,X'6C6163',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1753,86,X'6C6F63616C',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1754,86,X'6F746865725F756E6D6170706564',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1755,87,X'6F636C63',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1756,87,X'6C6F63616C',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1757,88,X'63726561746564',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1758,88,X'63616E63656C6C6564',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1759,88,X'64656C65746564',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1760,88,X'64657269766564',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1761,88,X'72657669736564',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1762,88,X'75706461746564',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1763,89,X'68756D616E',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1764,89,X'6D616368696E65',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1765,90,X'73696E676C65',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1766,90,X'72616E6765',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1767,91,X'626567696E',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1768,91,X'656E64',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1769,92,X'7374616E64617264',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1770,92,X'6E6F745F6265666F7265',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1771,92,X'6E6F745F6166746572',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1772,93,X'7374616E64617264',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1773,93,X'6E6F745F6265666F7265',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1774,93,X'6E6F745F6166746572',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1775,94,X'7374616E64617264',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1776,94,X'6E6F745F6265666F7265',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1777,94,X'6E6F745F6166746572',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1778,95,X'6173736F635F636F756E747279',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1779,95,X'7265736964656E6365',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1780,95,X'6F746865725F6173736F63',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1781,95,X'706C6163655F6F665F6269727468',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1782,95,X'706C6163655F6F665F6465617468',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1783,96,X'69735F6964656E7469666965645F77697468',1,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1784,97,X'69735F68696572617263686963616C5F77697468',1,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1785,98,X'69735F74656D706F72616C5F77697468',1,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1786,99,X'69735F72656C617465645F77697468',1,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1787,100,X'6E6F745F737065636966696564',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1788,4,X'736E6163',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1789,102,X'7075626C69635F646F6D61696E',0,0,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1790,102,X'6E6F6E5F636F6D6D65726369616C',0,1,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1791,102,X'6E6F6E5F636F6D6D65726369616C5F6E6F5F6465726976617469766573',0,2,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1792,102,X'6E6F5F6465726976617469766573',0,3,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1793,102,X'73686172655F615F6C696B65',0,4,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1794,102,X'6E6F6E5F636F6D6D65726369616C5F73686172655F615F6C696B65',0,5,0,0,1,NULL,NULL,NULL,NULL,NULL),
	(1795,76,X'64656C657465645F6D6572676564',0,8,0,0,1,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `enumeration_value` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `repo_id` int NOT NULL,
  `event_type_id` int NOT NULL,
  `outcome_id` int DEFAULT NULL,
  `outcome_note` varchar(17408) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `refid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `refid` (`refid`),
  KEY `event_type_id` (`event_type_id`),
  KEY `outcome_id` (`outcome_id`),
  KEY `event_system_mtime_index` (`system_mtime`),
  KEY `event_user_mtime_index` (`user_mtime`),
  KEY `event_suppressed_index` (`suppressed`),
  KEY `repo_id` (`repo_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`event_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`outcome_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `event_ibfk_3` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;

INSERT INTO `event` (`id`, `lock_version`, `json_schema_version`, `suppressed`, `repo_id`, `event_type_id`, `outcome_id`, `outcome_note`, `timestamp`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `refid`)
VALUES
	(1,0,1,0,1,295,NULL,NULL,'2026-02-16 15:41:06',NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07',NULL),
	(2,0,1,0,1,295,NULL,NULL,'2026-02-16 15:41:07',NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07',NULL),
	(3,0,1,0,1,295,NULL,NULL,'2026-02-16 15:42:18','admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18',NULL);

/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event_link_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event_link_rlshp`;

CREATE TABLE `event_link_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `role_id` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `top_container_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `event_link_rlshp_system_mtime_index` (`system_mtime`),
  KEY `event_link_rlshp_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  KEY `event_id` (`event_id`),
  KEY `top_container_id` (`top_container_id`),
  CONSTRAINT `event_link_rlshp_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_10` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_11` FOREIGN KEY (`top_container_id`) REFERENCES `top_container` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_2` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_3` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_4` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_5` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_6` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_7` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_8` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `event_link_rlshp_ibfk_9` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `event_link_rlshp` WRITE;
/*!40000 ALTER TABLE `event_link_rlshp` DISABLE KEYS */;

INSERT INTO `event_link_rlshp` (`id`, `accession_id`, `resource_id`, `archival_object_id`, `digital_object_id`, `digital_object_component_id`, `agent_person_id`, `agent_family_id`, `agent_corporate_entity_id`, `agent_software_id`, `event_id`, `aspace_relationship_position`, `created_by`, `last_modified_by`, `system_mtime`, `user_mtime`, `role_id`, `suppressed`, `top_container_id`)
VALUES
	(1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,3,0,NULL,NULL,'2026-02-16 15:42:18','2026-02-16 15:42:18',228,0,NULL);

/*!40000 ALTER TABLE `event_link_rlshp` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table extent
# ------------------------------------------------------------

DROP TABLE IF EXISTS `extent`;

CREATE TABLE `extent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `deaccession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `portion_id` int NOT NULL,
  `number` varchar(255) NOT NULL,
  `extent_type_id` int NOT NULL,
  `container_summary` text,
  `physical_details` text,
  `dimensions` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `extent_type_id` (`extent_type_id`),
  KEY `extent_system_mtime_index` (`system_mtime`),
  KEY `extent_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `resource_id` (`resource_id`),
  KEY `deaccession_id` (`deaccession_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  CONSTRAINT `extent_ibfk_1` FOREIGN KEY (`extent_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `extent_ibfk_2` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `extent_ibfk_3` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `extent_ibfk_4` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `extent_ibfk_5` FOREIGN KEY (`deaccession_id`) REFERENCES `deaccession` (`id`),
  CONSTRAINT `extent_ibfk_6` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `extent_ibfk_7` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `extent` WRITE;
/*!40000 ALTER TABLE `extent` DISABLE KEYS */;

INSERT INTO `extent` (`id`, `lock_version`, `json_schema_version`, `accession_id`, `deaccession_id`, `archival_object_id`, `resource_id`, `digital_object_id`, `digital_object_component_id`, `portion_id`, `number`, `extent_type_id`, `container_summary`, `physical_details`, `dimensions`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,0,1,NULL,NULL,NULL,1,NULL,NULL,923,'2',274,NULL,NULL,NULL,'admin','admin','2026-02-16 15:43:23','2026-02-16 15:43:23','2026-02-16 15:43:23');

/*!40000 ALTER TABLE `extent` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table external_document
# ------------------------------------------------------------

DROP TABLE IF EXISTS `external_document`;

CREATE TABLE `external_document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `title` varchar(8704) NOT NULL,
  `location` varchar(8704) NOT NULL,
  `publish` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `location_sha1` varchar(255) DEFAULT NULL,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `rights_statement_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `identifier_type_id` int DEFAULT NULL,
  `assessment_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_exdoc_acc` (`accession_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_arc_obj` (`archival_object_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_res` (`resource_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_sub` (`subject_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_age_per` (`agent_person_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_age_fam` (`agent_family_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_age_cor_ent` (`agent_corporate_entity_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_age_sof` (`agent_software_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_rig_sta` (`rights_statement_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_dig_obj` (`digital_object_id`,`location_sha1`),
  UNIQUE KEY `uniq_exdoc_dig_obj_com` (`digital_object_component_id`,`location_sha1`),
  KEY `external_document_system_mtime_index` (`system_mtime`),
  KEY `external_document_user_mtime_index` (`user_mtime`),
  KEY `event_external_document_fk` (`event_id`),
  KEY `external_document_identifier_type_id_fk` (`identifier_type_id`),
  KEY `assessment_external_document_fk` (`assessment_id`),
  CONSTRAINT `assessment_external_document_fk` FOREIGN KEY (`assessment_id`) REFERENCES `event` (`id`),
  CONSTRAINT `event_external_document_fk` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `external_document_ibfk_1` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `external_document_ibfk_10` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `external_document_ibfk_11` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `external_document_ibfk_2` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `external_document_ibfk_3` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `external_document_ibfk_4` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `external_document_ibfk_5` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `external_document_ibfk_6` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `external_document_ibfk_7` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `external_document_ibfk_8` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `external_document_ibfk_9` FOREIGN KEY (`rights_statement_id`) REFERENCES `rights_statement` (`id`),
  CONSTRAINT `external_document_identifier_type_id_fk` FOREIGN KEY (`identifier_type_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table external_id
# ------------------------------------------------------------

DROP TABLE IF EXISTS `external_id`;

CREATE TABLE `external_id` (
  `id` int NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) NOT NULL,
  `source` varchar(255) NOT NULL,
  `subject_id` int DEFAULT NULL,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `collection_management_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `external_id_system_mtime_index` (`system_mtime`),
  KEY `external_id_user_mtime_index` (`user_mtime`),
  KEY `subject_id` (`subject_id`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `collection_management_id` (`collection_management_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  KEY `event_id` (`event_id`),
  KEY `location_id` (`location_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `external_id_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `external_id_ibfk_2` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `external_id_ibfk_3` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `external_id_ibfk_4` FOREIGN KEY (`collection_management_id`) REFERENCES `collection_management` (`id`),
  CONSTRAINT `external_id_ibfk_5` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `external_id_ibfk_6` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `external_id_ibfk_7` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `external_id_ibfk_8` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `external_id_ibfk_9` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table file_version
# ------------------------------------------------------------

DROP TABLE IF EXISTS `file_version`;

CREATE TABLE `file_version` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `use_statement_id` int DEFAULT NULL,
  `checksum_method_id` int DEFAULT NULL,
  `file_uri` varchar(17408) NOT NULL,
  `publish` int DEFAULT NULL,
  `xlink_actuate_attribute_id` int DEFAULT NULL,
  `xlink_show_attribute_id` int DEFAULT NULL,
  `file_format_name_id` int DEFAULT NULL,
  `file_format_version` varchar(255) DEFAULT NULL,
  `file_size_bytes` bigint DEFAULT NULL,
  `checksum` varchar(255) DEFAULT NULL,
  `checksum_method` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `is_representative` int DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `digital_object_one_representative_file_version` (`is_representative`,`digital_object_id`),
  KEY `use_statement_id` (`use_statement_id`),
  KEY `checksum_method_id` (`checksum_method_id`),
  KEY `xlink_actuate_attribute_id` (`xlink_actuate_attribute_id`),
  KEY `xlink_show_attribute_id` (`xlink_show_attribute_id`),
  KEY `file_format_name_id` (`file_format_name_id`),
  KEY `file_version_system_mtime_index` (`system_mtime`),
  KEY `file_version_user_mtime_index` (`user_mtime`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  CONSTRAINT `file_version_ibfk_1` FOREIGN KEY (`use_statement_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `file_version_ibfk_2` FOREIGN KEY (`checksum_method_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `file_version_ibfk_3` FOREIGN KEY (`xlink_actuate_attribute_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `file_version_ibfk_4` FOREIGN KEY (`xlink_show_attribute_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `file_version_ibfk_5` FOREIGN KEY (`file_format_name_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `file_version_ibfk_6` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `file_version_ibfk_7` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `group_code` varchar(255) NOT NULL,
  `group_code_norm` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_uniq` (`repo_id`,`group_code_norm`),
  KEY `group_system_mtime_index` (`system_mtime`),
  KEY `group_user_mtime_index` (`user_mtime`),
  CONSTRAINT `group_repo_id_fk` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;

INSERT INTO `group` (`id`, `lock_version`, `json_schema_version`, `repo_id`, `group_code`, `group_code_norm`, `description`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,0,1,1,'administrators','administrators','Administrators',NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(2,0,1,1,'searchindex','searchindex','Search index',NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(3,0,1,1,'publicanonymous','publicanonymous','Public Anonymous',NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(4,0,1,1,'staffsystem','staffsystem','Staff System Group',NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(5,2,1,2,'repository-managers','repository-managers','Managers of the merge_1 repository','admin','admin','2026-02-16 15:42:18','2026-02-16 18:43:45','2026-02-16 15:42:18'),
	(6,1,1,2,'repository-archivists','repository-archivists','Archivists of the merge_1 repository','admin','admin','2026-02-16 15:42:18','2026-02-16 18:43:45','2026-02-16 15:42:18'),
	(7,0,1,2,'repository-project-managers','repository-project-managers','Project managers of the merge_1 repository','admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18'),
	(8,0,1,2,'repository-advanced-data-entry','repository-advanced-data-entry','Advanced Data Entry users of the merge_1 repository','admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18'),
	(9,0,1,2,'repository-basic-data-entry','repository-basic-data-entry','Basic Data Entry users of the merge_1 repository','admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18'),
	(10,0,1,2,'repository-viewers','repository-viewers','Viewers of the merge_1 repository','admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18');

/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table group_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group_permission`;

CREATE TABLE `group_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_permission_permission_id_group_id_index` (`permission_id`,`group_id`),
  KEY `group_permission_permission_id_index` (`permission_id`),
  KEY `group_permission_group_id_index` (`group_id`),
  CONSTRAINT `group_permission_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_permission_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `group_permission` WRITE;
/*!40000 ALTER TABLE `group_permission` DISABLE KEYS */;

INSERT INTO `group_permission` (`id`, `permission_id`, `group_id`)
VALUES
	(25,1,1),
	(92,1,6),
	(138,1,9),
	(26,2,1),
	(69,2,5),
	(93,2,6),
	(31,3,1),
	(73,3,5),
	(94,3,6),
	(117,3,7),
	(133,3,8),
	(29,4,1),
	(62,4,5),
	(84,4,6),
	(108,4,7),
	(74,5,5),
	(95,5,6),
	(1,6,1),
	(2,7,1),
	(3,8,1),
	(4,9,1),
	(45,9,2),
	(48,9,3),
	(5,10,1),
	(6,11,1),
	(7,12,1),
	(8,13,1),
	(46,13,2),
	(9,14,1),
	(50,14,5),
	(10,15,1),
	(51,15,5),
	(76,15,6),
	(98,15,7),
	(119,15,8),
	(135,15,9),
	(11,16,1),
	(52,16,5),
	(77,16,6),
	(99,16,7),
	(120,16,8),
	(136,16,9),
	(12,17,1),
	(53,17,5),
	(78,17,6),
	(100,17,7),
	(121,17,8),
	(137,17,9),
	(13,18,1),
	(54,18,5),
	(79,18,6),
	(101,18,7),
	(122,18,8),
	(14,19,1),
	(55,19,5),
	(102,19,7),
	(15,20,1),
	(59,20,5),
	(105,20,7),
	(16,21,1),
	(17,22,1),
	(58,22,5),
	(104,22,7),
	(18,23,1),
	(44,23,2),
	(19,24,1),
	(43,24,2),
	(47,24,3),
	(57,24,5),
	(81,24,6),
	(97,24,7),
	(118,24,8),
	(134,24,9),
	(139,24,10),
	(20,25,1),
	(21,26,1),
	(22,27,1),
	(49,27,4),
	(23,28,1),
	(68,28,5),
	(89,28,6),
	(113,28,7),
	(130,28,8),
	(24,29,1),
	(27,30,1),
	(60,30,5),
	(82,30,6),
	(106,30,7),
	(124,30,8),
	(28,31,1),
	(61,31,5),
	(83,31,6),
	(107,31,7),
	(125,31,8),
	(30,32,1),
	(63,32,5),
	(85,32,6),
	(109,32,7),
	(126,32,8),
	(32,33,1),
	(114,33,7),
	(33,34,1),
	(34,35,1),
	(64,35,5),
	(35,36,1),
	(56,36,5),
	(80,36,6),
	(103,36,7),
	(123,36,8),
	(36,37,1),
	(65,37,5),
	(86,37,6),
	(110,37,7),
	(127,37,8),
	(37,38,1),
	(66,38,5),
	(87,38,6),
	(111,38,7),
	(128,38,8),
	(38,39,1),
	(67,39,5),
	(88,39,6),
	(112,39,7),
	(129,39,8),
	(39,40,1),
	(70,40,5),
	(90,40,6),
	(115,40,7),
	(131,40,8),
	(40,41,1),
	(71,41,5),
	(91,41,6),
	(116,41,7),
	(132,41,8),
	(41,42,1),
	(72,42,5),
	(42,43,1),
	(75,43,5),
	(96,43,6);

/*!40000 ALTER TABLE `group_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table group_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group_user`;

CREATE TABLE `group_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_user_group_id_index` (`group_id`),
  KEY `group_user_user_id_index` (`user_id`),
  CONSTRAINT `group_user_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `group_user` WRITE;
/*!40000 ALTER TABLE `group_user` DISABLE KEYS */;

INSERT INTO `group_user` (`id`, `user_id`, `group_id`)
VALUES
	(1,1,1),
	(2,2,2),
	(3,3,3),
	(4,4,4);

/*!40000 ALTER TABLE `group_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table instance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `instance`;

CREATE TABLE `instance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `resource_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `accession_id` int DEFAULT NULL,
  `instance_type_id` int NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `is_representative` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resource_one_representative_instance` (`is_representative`,`resource_id`),
  UNIQUE KEY `component_one_representative_instance` (`is_representative`,`archival_object_id`),
  KEY `instance_type_id` (`instance_type_id`),
  KEY `instance_system_mtime_index` (`system_mtime`),
  KEY `instance_user_mtime_index` (`user_mtime`),
  KEY `resource_id` (`resource_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `accession_id` (`accession_id`),
  CONSTRAINT `instance_ibfk_1` FOREIGN KEY (`instance_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `instance_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `instance_ibfk_3` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `instance_ibfk_4` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `instance` WRITE;
/*!40000 ALTER TABLE `instance` DISABLE KEYS */;

INSERT INTO `instance` (`id`, `lock_version`, `json_schema_version`, `resource_id`, `archival_object_id`, `accession_id`, `instance_type_id`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `is_representative`)
VALUES
	(1,0,1,NULL,2,NULL,353,'admin','admin','2026-02-16 18:52:14','2026-02-16 18:52:14','2026-02-16 18:52:14',NULL),
	(2,0,1,NULL,1,NULL,353,'admin','admin','2026-02-16 18:52:50','2026-02-16 18:52:50','2026-02-16 18:52:50',NULL);

/*!40000 ALTER TABLE `instance` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table instance_do_link_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `instance_do_link_rlshp`;

CREATE TABLE `instance_do_link_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `digital_object_id` int DEFAULT NULL,
  `instance_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `instance_do_link_rlshp_system_mtime_index` (`system_mtime`),
  KEY `instance_do_link_rlshp_user_mtime_index` (`user_mtime`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `instance_id` (`instance_id`),
  CONSTRAINT `instance_do_link_rlshp_ibfk_1` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `instance_do_link_rlshp_ibfk_2` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table job
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job`;

CREATE TABLE `job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` int NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `job_blob` mediumblob NOT NULL,
  `time_submitted` datetime NOT NULL,
  `time_started` datetime DEFAULT NULL,
  `time_finished` datetime DEFAULT NULL,
  `owner_id` int NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `job_params` varchar(255) DEFAULT NULL,
  `job_type` varchar(255) NOT NULL DEFAULT 'unknown_job_type',
  PRIMARY KEY (`id`),
  KEY `job_system_mtime_index` (`system_mtime`),
  KEY `job_user_mtime_index` (`user_mtime`),
  KEY `job_status_idx` (`status`),
  KEY `job_repo_id_fk` (`repo_id`),
  KEY `job_owner_id_fk` (`owner_id`),
  CONSTRAINT `job_owner_id_fk` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `job_repo_id_fk` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table job_created_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_created_record`;

CREATE TABLE `job_created_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `record_uri` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_created_record_system_mtime_index` (`system_mtime`),
  KEY `job_created_record_user_mtime_index` (`user_mtime`),
  KEY `job_created_record_job_id_fk` (`job_id`),
  CONSTRAINT `job_created_record_job_id_fk` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table job_input_file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_input_file`;

CREATE TABLE `job_input_file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `file_path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_input_file_job_id_fk` (`job_id`),
  CONSTRAINT `job_input_file_job_id_fk` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table job_modified_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_modified_record`;

CREATE TABLE `job_modified_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `record_uri` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_modified_record_system_mtime_index` (`system_mtime`),
  KEY `job_modified_record_user_mtime_index` (`user_mtime`),
  KEY `job_modified_record_job_id_fk` (`job_id`),
  CONSTRAINT `job_modified_record_job_id_fk` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table lang_material
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lang_material`;

CREATE TABLE `lang_material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `accession_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_material_system_mtime_index` (`system_mtime`),
  KEY `lang_material_user_mtime_index` (`user_mtime`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `resource_id` (`resource_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  KEY `accession_id` (`accession_id`),
  CONSTRAINT `lang_material_ibfk_1` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `lang_material_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `lang_material_ibfk_3` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `lang_material_ibfk_4` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `lang_material_ibfk_5` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `lang_material` WRITE;
/*!40000 ALTER TABLE `lang_material` DISABLE KEYS */;

INSERT INTO `lang_material` (`id`, `lock_version`, `json_schema_version`, `archival_object_id`, `resource_id`, `digital_object_id`, `digital_object_component_id`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `accession_id`)
VALUES
	(1,0,1,NULL,1,NULL,NULL,'admin','admin','2026-02-16 15:43:23','2026-02-16 15:43:23','2026-02-16 15:43:23',NULL);

/*!40000 ALTER TABLE `lang_material` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table language_and_script
# ------------------------------------------------------------

DROP TABLE IF EXISTS `language_and_script`;

CREATE TABLE `language_and_script` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `lang_material_id` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `language_id` (`language_id`),
  KEY `script_id` (`script_id`),
  KEY `language_and_script_system_mtime_index` (`system_mtime`),
  KEY `language_and_script_user_mtime_index` (`user_mtime`),
  KEY `lang_material_id` (`lang_material_id`),
  CONSTRAINT `language_and_script_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `language_and_script_ibfk_2` FOREIGN KEY (`script_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `language_and_script_ibfk_3` FOREIGN KEY (`lang_material_id`) REFERENCES `lang_material` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `language_and_script` WRITE;
/*!40000 ALTER TABLE `language_and_script` DISABLE KEYS */;

INSERT INTO `language_and_script` (`id`, `lock_version`, `json_schema_version`, `lang_material_id`, `language_id`, `script_id`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,0,1,1,597,NULL,'admin','admin','2026-02-16 15:43:23','2026-02-16 15:43:23','2026-02-16 15:43:23');

/*!40000 ALTER TABLE `language_and_script` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table linked_agent_term
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linked_agent_term`;

CREATE TABLE `linked_agent_term` (
  `id` int NOT NULL AUTO_INCREMENT,
  `linked_agents_rlshp_id` int NOT NULL,
  `term_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `term_id` (`term_id`),
  KEY `linked_agent_term_idx` (`linked_agents_rlshp_id`,`term_id`),
  CONSTRAINT `linked_agent_term_ibfk_1` FOREIGN KEY (`linked_agents_rlshp_id`) REFERENCES `linked_agents_rlshp` (`id`),
  CONSTRAINT `linked_agent_term_ibfk_2` FOREIGN KEY (`term_id`) REFERENCES `term` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table linked_agents_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `linked_agents_rlshp`;

CREATE TABLE `linked_agents_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `role_id` int DEFAULT NULL,
  `relator_id` int DEFAULT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `rights_statement_id` int DEFAULT NULL,
  `is_primary` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `relator_id` (`relator_id`),
  KEY `linked_agents_rlshp_system_mtime_index` (`system_mtime`),
  KEY `linked_agents_rlshp_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_software_id` (`agent_software_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  KEY `event_id` (`event_id`),
  KEY `resource_id` (`resource_id`),
  KEY `rights_statement_id` (`rights_statement_id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_10` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_11` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_12` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_13` FOREIGN KEY (`rights_statement_id`) REFERENCES `rights_statement` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_2` FOREIGN KEY (`relator_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_3` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_5` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_6` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_7` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_8` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `linked_agents_rlshp_ibfk_9` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `linked_agents_rlshp` WRITE;
/*!40000 ALTER TABLE `linked_agents_rlshp` DISABLE KEYS */;

INSERT INTO `linked_agents_rlshp` (`id`, `agent_person_id`, `agent_software_id`, `agent_family_id`, `agent_corporate_entity_id`, `accession_id`, `archival_object_id`, `digital_object_id`, `digital_object_component_id`, `event_id`, `resource_id`, `aspace_relationship_position`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `role_id`, `relator_id`, `title`, `suppressed`, `rights_statement_id`, `is_primary`)
VALUES
	(1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,0,'admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18',232,NULL,NULL,0,NULL,NULL);

/*!40000 ALTER TABLE `linked_agents_rlshp` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table location
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `building` varchar(255) NOT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `floor` varchar(255) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `classification` varchar(255) DEFAULT NULL,
  `coordinate_1_label` varchar(255) DEFAULT NULL,
  `coordinate_1_indicator` varchar(255) DEFAULT NULL,
  `coordinate_2_label` varchar(255) DEFAULT NULL,
  `coordinate_2_indicator` varchar(255) DEFAULT NULL,
  `coordinate_3_label` varchar(255) DEFAULT NULL,
  `coordinate_3_indicator` varchar(255) DEFAULT NULL,
  `temporary_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `temporary_id` (`temporary_id`),
  KEY `location_system_mtime_index` (`system_mtime`),
  KEY `location_user_mtime_index` (`user_mtime`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`temporary_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table location_function
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location_function`;

CREATE TABLE `location_function` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `location_id` int DEFAULT NULL,
  `location_function_type_id` int NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `location_function_type_id` (`location_function_type_id`),
  KEY `location_function_system_mtime_index` (`system_mtime`),
  KEY `location_function_user_mtime_index` (`user_mtime`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `location_function_ibfk_1` FOREIGN KEY (`location_function_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `location_function_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table location_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location_profile`;

CREATE TABLE `location_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dimension_units_id` int DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  `width` varchar(255) DEFAULT NULL,
  `depth` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location_profile_name_uniq` (`name`),
  KEY `dimension_units_id` (`dimension_units_id`),
  KEY `location_profile_system_mtime_index` (`system_mtime`),
  KEY `location_profile_user_mtime_index` (`user_mtime`),
  CONSTRAINT `location_profile_ibfk_1` FOREIGN KEY (`dimension_units_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table location_profile_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location_profile_rlshp`;

CREATE TABLE `location_profile_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `location_profile_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `location_profile_rlshp_system_mtime_index` (`system_mtime`),
  KEY `location_profile_rlshp_user_mtime_index` (`user_mtime`),
  KEY `location_id` (`location_id`),
  KEY `location_profile_id` (`location_profile_id`),
  CONSTRAINT `location_profile_rlshp_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `location_profile_rlshp_ibfk_2` FOREIGN KEY (`location_profile_id`) REFERENCES `location_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table metadata_rights_declaration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `metadata_rights_declaration`;

CREATE TABLE `metadata_rights_declaration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `license_id` int DEFAULT NULL,
  `file_version_xlink_actuate_attribute_id` int DEFAULT NULL,
  `file_version_xlink_show_attribute_id` int DEFAULT NULL,
  `citation` varchar(255) DEFAULT NULL,
  `descriptive_note` text NOT NULL,
  `file_uri` varchar(255) DEFAULT NULL,
  `xlink_title_attribute` varchar(255) DEFAULT NULL,
  `xlink_role_attribute` varchar(255) DEFAULT NULL,
  `xlink_arcrole_attribute` varchar(255) DEFAULT NULL,
  `last_verified_date` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `metadata_rights_declaration_system_mtime_index` (`system_mtime`),
  KEY `metadata_rights_declaration_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_1` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_3` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_4` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_5` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_6` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_7` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `metadata_rights_declaration_ibfk_8` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table name_authority_id
# ------------------------------------------------------------

DROP TABLE IF EXISTS `name_authority_id`;

CREATE TABLE `name_authority_id` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `name_person_id` int DEFAULT NULL,
  `name_family_id` int DEFAULT NULL,
  `name_software_id` int DEFAULT NULL,
  `name_corporate_entity_id` int DEFAULT NULL,
  `authority_id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authority_id` (`authority_id`),
  KEY `name_authority_id_system_mtime_index` (`system_mtime`),
  KEY `name_authority_id_user_mtime_index` (`user_mtime`),
  KEY `name_person_id` (`name_person_id`),
  KEY `name_family_id` (`name_family_id`),
  KEY `name_software_id` (`name_software_id`),
  KEY `name_corporate_entity_id` (`name_corporate_entity_id`),
  CONSTRAINT `name_authority_id_ibfk_1` FOREIGN KEY (`name_person_id`) REFERENCES `name_person` (`id`),
  CONSTRAINT `name_authority_id_ibfk_2` FOREIGN KEY (`name_family_id`) REFERENCES `name_family` (`id`),
  CONSTRAINT `name_authority_id_ibfk_3` FOREIGN KEY (`name_software_id`) REFERENCES `name_software` (`id`),
  CONSTRAINT `name_authority_id_ibfk_4` FOREIGN KEY (`name_corporate_entity_id`) REFERENCES `name_corporate_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table name_corporate_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `name_corporate_entity`;

CREATE TABLE `name_corporate_entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `agent_corporate_entity_id` int NOT NULL,
  `primary_name` text NOT NULL,
  `subordinate_name_1` text,
  `subordinate_name_2` text,
  `number` varchar(255) DEFAULT NULL,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `authorized` int DEFAULT NULL,
  `is_display_name` int DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `jurisdiction` int DEFAULT '0',
  `conference_meeting` int DEFAULT '0',
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `corporate_entity_one_authorized` (`authorized`,`agent_corporate_entity_id`),
  UNIQUE KEY `corporate_entity_one_display_name` (`is_display_name`,`agent_corporate_entity_id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `name_corporate_entity_system_mtime_index` (`system_mtime`),
  KEY `name_corporate_entity_user_mtime_index` (`user_mtime`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  CONSTRAINT `name_corporate_entity_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_corporate_entity_ibfk_2` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_corporate_entity_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `name_corporate_entity` WRITE;
/*!40000 ALTER TABLE `name_corporate_entity` DISABLE KEYS */;

INSERT INTO `name_corporate_entity` (`id`, `lock_version`, `json_schema_version`, `agent_corporate_entity_id`, `primary_name`, `subordinate_name_1`, `subordinate_name_2`, `number`, `dates`, `qualifier`, `source_id`, `rules_id`, `sort_name`, `sort_name_auto_generate`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `authorized`, `is_display_name`, `location`, `jurisdiction`, `conference_meeting`, `language_id`, `script_id`, `transliteration_id`)
VALUES
	(1,0,1,1,'Merge 1',NULL,NULL,NULL,NULL,NULL,236,NULL,'Merge 1',1,'admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18',1,1,NULL,0,0,NULL,NULL,NULL);

/*!40000 ALTER TABLE `name_corporate_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table name_family
# ------------------------------------------------------------

DROP TABLE IF EXISTS `name_family`;

CREATE TABLE `name_family` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `agent_family_id` int NOT NULL,
  `family_name` text NOT NULL,
  `prefix` text,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `authorized` int DEFAULT NULL,
  `is_display_name` int DEFAULT NULL,
  `family_type` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `family_one_authorized` (`authorized`,`agent_family_id`),
  UNIQUE KEY `family_one_display_name` (`is_display_name`,`agent_family_id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `name_family_system_mtime_index` (`system_mtime`),
  KEY `name_family_user_mtime_index` (`user_mtime`),
  KEY `agent_family_id` (`agent_family_id`),
  CONSTRAINT `name_family_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_family_ibfk_2` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_family_ibfk_3` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table name_person
# ------------------------------------------------------------

DROP TABLE IF EXISTS `name_person`;

CREATE TABLE `name_person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `agent_person_id` int NOT NULL,
  `primary_name` varchar(255) NOT NULL,
  `name_order_id` int NOT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `prefix` text,
  `rest_of_name` text,
  `suffix` text,
  `fuller_form` text,
  `number` varchar(255) DEFAULT NULL,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `authorized` int DEFAULT NULL,
  `is_display_name` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `person_one_authorized` (`authorized`,`agent_person_id`),
  UNIQUE KEY `person_one_display_name` (`is_display_name`,`agent_person_id`),
  KEY `name_order_id` (`name_order_id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `name_person_system_mtime_index` (`system_mtime`),
  KEY `name_person_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  CONSTRAINT `name_person_ibfk_1` FOREIGN KEY (`name_order_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_person_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_person_ibfk_3` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_person_ibfk_4` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `name_person` WRITE;
/*!40000 ALTER TABLE `name_person` DISABLE KEYS */;

INSERT INTO `name_person` (`id`, `lock_version`, `json_schema_version`, `agent_person_id`, `primary_name`, `name_order_id`, `title`, `prefix`, `rest_of_name`, `suffix`, `fuller_form`, `number`, `dates`, `qualifier`, `source_id`, `rules_id`, `sort_name`, `sort_name_auto_generate`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `authorized`, `is_display_name`, `language_id`, `script_id`, `transliteration_id`)
VALUES
	(1,0,1,1,'Administrator',947,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,236,240,'Administrator',1,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07',1,1,NULL,NULL,NULL);

/*!40000 ALTER TABLE `name_person` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table name_software
# ------------------------------------------------------------

DROP TABLE IF EXISTS `name_software`;

CREATE TABLE `name_software` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `agent_software_id` int NOT NULL,
  `software_name` text NOT NULL,
  `version` text,
  `manufacturer` text,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `authorized` int DEFAULT NULL,
  `is_display_name` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `software_one_authorized` (`authorized`,`agent_software_id`),
  UNIQUE KEY `software_one_display_name` (`is_display_name`,`agent_software_id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `name_software_system_mtime_index` (`system_mtime`),
  KEY `name_software_user_mtime_index` (`user_mtime`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `name_software_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_software_ibfk_2` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `name_software_ibfk_3` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `name_software` WRITE;
/*!40000 ALTER TABLE `name_software` DISABLE KEYS */;

INSERT INTO `name_software` (`id`, `lock_version`, `json_schema_version`, `agent_software_id`, `software_name`, `version`, `manufacturer`, `dates`, `qualifier`, `source_id`, `rules_id`, `sort_name`, `sort_name_auto_generate`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `authorized`, `is_display_name`, `language_id`, `script_id`, `transliteration_id`)
VALUES
	(1,0,1,1,'ArchivesSpace','v4.1.1',NULL,NULL,NULL,236,240,'ArchivesSpace v4.1.1',1,NULL,NULL,'2026-02-16 15:41:06','2026-02-16 15:41:06','2026-02-16 15:41:06',1,1,NULL,NULL,NULL);

/*!40000 ALTER TABLE `name_software` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `note`;

CREATE TABLE `note` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '1',
  `resource_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `notes_json_schema_version` int NOT NULL,
  `notes` mediumblob NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `rights_statement_act_id` int DEFAULT NULL,
  `rights_statement_id` int DEFAULT NULL,
  `lang_material_id` int DEFAULT NULL,
  `agent_topic_id` int DEFAULT NULL,
  `agent_place_id` int DEFAULT NULL,
  `agent_occupation_id` int DEFAULT NULL,
  `agent_function_id` int DEFAULT NULL,
  `agent_gender_id` int DEFAULT NULL,
  `used_language_id` int DEFAULT NULL,
  `agent_contact_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `note_system_mtime_index` (`system_mtime`),
  KEY `note_user_mtime_index` (`user_mtime`),
  KEY `resource_id` (`resource_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_software_id` (`agent_software_id`),
  KEY `rights_statement_act_id` (`rights_statement_act_id`),
  KEY `rights_statement_id` (`rights_statement_id`),
  KEY `lang_material_id` (`lang_material_id`),
  CONSTRAINT `note_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `note_ibfk_10` FOREIGN KEY (`rights_statement_id`) REFERENCES `rights_statement` (`id`),
  CONSTRAINT `note_ibfk_11` FOREIGN KEY (`lang_material_id`) REFERENCES `lang_material` (`id`),
  CONSTRAINT `note_ibfk_2` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `note_ibfk_3` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `note_ibfk_4` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `note_ibfk_5` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `note_ibfk_6` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `note_ibfk_7` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `note_ibfk_8` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `note_ibfk_9` FOREIGN KEY (`rights_statement_act_id`) REFERENCES `rights_statement_act` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table note_persistent_id
# ------------------------------------------------------------

DROP TABLE IF EXISTS `note_persistent_id`;

CREATE TABLE `note_persistent_id` (
  `id` int NOT NULL AUTO_INCREMENT,
  `note_id` int NOT NULL,
  `persistent_id` varchar(255) NOT NULL,
  `parent_type` varchar(255) NOT NULL,
  `parent_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `note_id` (`note_id`),
  CONSTRAINT `note_persistent_id_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table notification
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `code` varchar(255) NOT NULL,
  `params` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_time_index` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;

INSERT INTO `notification` (`id`, `time`, `code`, `params`)
VALUES
	(1,'2026-02-16 15:41:09','REFRESH_ACLS',X'7B7D'),
	(2,'2026-02-16 15:41:09','REFRESH_PREFERENCES',X'7B7D'),
	(3,'2026-02-16 15:41:09','BACKEND_STARTED',X'7B7D'),
	(4,'2026-02-16 15:42:19','REFRESH_ACLS',X'7B7D'),
	(5,'2026-02-16 15:42:19','REPOSITORY_CHANGED',X'7B7D'),
	(6,'2026-02-16 18:43:46','REFRESH_PREFERENCES',X'7B7D'),
	(7,'2026-02-16 18:43:46','BACKEND_STARTED',X'7B7D');

/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oai_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oai_config`;

CREATE TABLE `oai_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `oai_repository_name` varchar(255) DEFAULT NULL,
  `oai_record_prefix` varchar(255) DEFAULT NULL,
  `oai_admin_email` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `system_mtime` datetime DEFAULT NULL,
  `user_mtime` datetime DEFAULT NULL,
  `lock_version` int DEFAULT '0',
  `repo_set_codes` text,
  `repo_set_description` varchar(255) DEFAULT NULL,
  `sponsor_set_names` text,
  `sponsor_set_description` varchar(255) DEFAULT NULL,
  `repo_set_name` varchar(255) DEFAULT NULL,
  `sponsor_set_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `oai_config` WRITE;
/*!40000 ALTER TABLE `oai_config` DISABLE KEYS */;

INSERT INTO `oai_config` (`id`, `oai_repository_name`, `oai_record_prefix`, `oai_admin_email`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `lock_version`, `repo_set_codes`, `repo_set_description`, `sponsor_set_names`, `sponsor_set_description`, `repo_set_name`, `sponsor_set_name`)
VALUES
	(1,'ArchivesSpace OAI Provider','oai:archivesspace','admin@example.com','admin',NULL,'2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33',0,'[]','','[]','','repository_set','sponsor_set');

/*!40000 ALTER TABLE `oai_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table owner_repo_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `owner_repo_rlshp`;

CREATE TABLE `owner_repo_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `repository_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_repo_rlshp_system_mtime_index` (`system_mtime`),
  KEY `owner_repo_rlshp_user_mtime_index` (`user_mtime`),
  KEY `location_id` (`location_id`),
  KEY `repository_id` (`repository_id`),
  CONSTRAINT `owner_repo_rlshp_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `owner_repo_rlshp_ibfk_2` FOREIGN KEY (`repository_id`) REFERENCES `repository` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table parallel_name_corporate_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parallel_name_corporate_entity`;

CREATE TABLE `parallel_name_corporate_entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `name_corporate_entity_id` int NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `jurisdiction` int DEFAULT '0',
  `conference_meeting` int DEFAULT '0',
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  `primary_name` text NOT NULL,
  `subordinate_name_1` text,
  `subordinate_name_2` text,
  `number` varchar(255) DEFAULT NULL,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT '1',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `parallel_name_corporate_entity_system_mtime_index` (`system_mtime`),
  KEY `parallel_name_corporate_entity_user_mtime_index` (`user_mtime`),
  KEY `name_corporate_entity_id` (`name_corporate_entity_id`),
  CONSTRAINT `parallel_name_corporate_entity_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_corporate_entity_ibfk_2` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_corporate_entity_ibfk_3` FOREIGN KEY (`name_corporate_entity_id`) REFERENCES `name_corporate_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table parallel_name_family
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parallel_name_family`;

CREATE TABLE `parallel_name_family` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `name_family_id` int NOT NULL,
  `family_type` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  `family_name` text NOT NULL,
  `prefix` text,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT '1',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `parallel_name_family_system_mtime_index` (`system_mtime`),
  KEY `parallel_name_family_user_mtime_index` (`user_mtime`),
  KEY `name_family_id` (`name_family_id`),
  CONSTRAINT `parallel_name_family_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_family_ibfk_2` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_family_ibfk_3` FOREIGN KEY (`name_family_id`) REFERENCES `name_family` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table parallel_name_person
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parallel_name_person`;

CREATE TABLE `parallel_name_person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `name_person_id` int NOT NULL,
  `primary_name` varchar(255) NOT NULL,
  `name_order_id` int NOT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `prefix` text,
  `rest_of_name` text,
  `suffix` text,
  `fuller_form` text,
  `number` varchar(255) DEFAULT NULL,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT '1',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name_order_id` (`name_order_id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `parallel_name_person_system_mtime_index` (`system_mtime`),
  KEY `parallel_name_person_user_mtime_index` (`user_mtime`),
  KEY `name_person_id` (`name_person_id`),
  CONSTRAINT `parallel_name_person_ibfk_1` FOREIGN KEY (`name_order_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_person_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_person_ibfk_3` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_person_ibfk_4` FOREIGN KEY (`name_person_id`) REFERENCES `name_person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table parallel_name_software
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parallel_name_software`;

CREATE TABLE `parallel_name_software` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `name_software_id` int NOT NULL,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `transliteration_id` int DEFAULT NULL,
  `software_name` text NOT NULL,
  `version` text,
  `manufacturer` text,
  `dates` varchar(255) DEFAULT NULL,
  `qualifier` text,
  `source_id` int DEFAULT NULL,
  `rules_id` int DEFAULT NULL,
  `sort_name` text NOT NULL,
  `sort_name_auto_generate` int DEFAULT '1',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`),
  KEY `rules_id` (`rules_id`),
  KEY `parallel_name_software_system_mtime_index` (`system_mtime`),
  KEY `parallel_name_software_user_mtime_index` (`user_mtime`),
  KEY `name_software_id` (`name_software_id`),
  CONSTRAINT `parallel_name_software_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_software_ibfk_2` FOREIGN KEY (`rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `parallel_name_software_ibfk_3` FOREIGN KEY (`name_software_id`) REFERENCES `name_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_code` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `level` varchar(255) DEFAULT 'repository',
  `system` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_code` (`permission_code`),
  KEY `permission_system_mtime_index` (`system_mtime`),
  KEY `permission_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;

INSERT INTO `permission` (`id`, `permission_code`, `description`, `level`, `system`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,'create_job','The ability to create background jobs','repository',0,'admin','admin','2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(2,'cancel_job','The ability to cancel background jobs','repository',0,'admin','admin','2026-02-16 15:40:32','2026-02-16 15:40:32','2026-02-16 15:40:32'),
	(3,'manage_enumeration_record','The ability to create, modify and delete a controlled vocabulary list record','repository',0,'admin','admin','2026-02-16 15:40:33','2026-02-16 15:40:33','2026-02-16 15:40:33'),
	(4,'view_agent_contact_record','The ability to view contact details for agent records','repository',0,'admin','admin','2026-02-16 15:40:34','2026-02-16 15:40:34','2026-02-16 15:40:34'),
	(5,'show_full_agents','The ability to add and edit extended agent attributes','repository',0,'admin','admin','2026-02-16 15:40:35','2026-02-16 15:40:35','2026-02-16 15:40:35'),
	(6,'administer_system','The ability to act as a system administrator','global',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(7,'manage_users','The ability to manage user accounts while logged in','global',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(8,'become_user','The ability to masquerade as another user','global',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(9,'view_all_records','The ability to view any record in the system','global',1,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(10,'create_repository','The ability to create new repositories','global',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(11,'delete_repository','The ability to delete a repository','global',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(12,'transfer_repository','The ability to transfer the contents of a repository','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(13,'index_system','The ability to read any record for indexing','global',1,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(14,'manage_repository','The ability to manage a given repository','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(15,'update_accession_record','The ability to create and modify accessions records','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(16,'update_resource_record','The ability to create and modify resources records','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(17,'update_digital_object_record','The ability to create and modify digital objects records','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(18,'update_event_record','The ability to create and modify event records','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(19,'delete_event_record','The ability to delete event records','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(20,'suppress_archival_record','The ability to suppress the major archival record types: accessions/resources/digital objects/components/collection management/events','repository',0,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 15:41:07','2026-02-16 15:41:07'),
	(21,'transfer_archival_record','The ability to transfer records between different repositories','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(22,'delete_archival_record','The ability to delete the major archival record types: accessions/resources/digital objects/components/collection management/events','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(23,'view_suppressed','The ability to view suppressed records in a given repository','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(24,'view_repository','The ability to view a given repository','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(25,'update_classification_record','The ability to create and modify classification records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(26,'delete_classification_record','The ability to delete classification records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(27,'mediate_edits','Track concurrent updates to records','global',1,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(28,'import_records','The ability to initiate an importer job','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(29,'cancel_importer_job','The ability to cancel a queued or running importer job','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(30,'manage_subject_record','The ability to create, modify and delete a subject record','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(31,'manage_agent_record','The ability to create, modify and delete an agent record','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(32,'manage_vocabulary_record','The ability to create, modify and delete a vocabulary record','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(33,'merge_agents_and_subjects','The ability to merge agent/subject records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(34,'merge_archival_record','The ability to merge archival records records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(35,'manage_rde_templates','The ability to create and delete RDE templates','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(36,'update_container_record','The ability to create and update container records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(37,'manage_container_record','The ability to delete and bulk update container records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(38,'manage_container_profile_record','The ability to create, modify and delete a container profile record','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(39,'manage_location_profile_record','The ability to create, modify and delete a location profile record','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(40,'update_assessment_record','The ability to create and modify assessment records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(41,'delete_assessment_record','The ability to delete assessment records','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(42,'manage_assessment_attributes','The ability to manage assessment attribute definitions','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08'),
	(43,'manage_custom_report_templates','The ability to manage custom report templates','repository',0,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08');

/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table preference
# ------------------------------------------------------------

DROP TABLE IF EXISTS `preference`;

CREATE TABLE `preference` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `user_uniq` varchar(255) NOT NULL,
  `defaults` mediumblob NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `preference_uniq` (`repo_id`,`user_uniq`),
  KEY `preference_system_mtime_index` (`system_mtime`),
  KEY `preference_user_mtime_index` (`user_mtime`),
  KEY `preference_user_id_fk` (`user_id`),
  CONSTRAINT `preference_repo_id_fk` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`) ON DELETE CASCADE,
  CONSTRAINT `preference_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `preference` WRITE;
/*!40000 ALTER TABLE `preference` DISABLE KEYS */;

INSERT INTO `preference` (`id`, `lock_version`, `json_schema_version`, `repo_id`, `user_id`, `user_uniq`, `defaults`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,1,1,1,NULL,'GLOBAL_USER',X'7B2273686F775F73757070726573736564223A66616C73652C227075626C697368223A66616C73652C227264655F736F72745F616C706861223A747275652C22696E636C7564655F756E7075626C6973686564223A66616C73652C226469676974616C5F6F626A6563745F737061776E223A66616C73652C22616363657373696F6E5F62726F7773655F636F6C756D6E5F31223A227469746C65222C22616363657373696F6E5F62726F7773655F636F6C756D6E5F32223A226964656E746966696572222C22616363657373696F6E5F62726F7773655F636F6C756D6E5F33223A22616363657373696F6E5F64617465222C22616363657373696F6E5F62726F7773655F636F6C756D6E5F34223A226461746573222C22616363657373696F6E5F62726F7773655F636F6C756D6E5F35223A22657874656E7473222C22616363657373696F6E5F736F72745F636F6C756D6E223A227469746C65222C22616363657373696F6E5F736F72745F646972656374696F6E223A22617363222C227265736F757263655F62726F7773655F636F6C756D6E5F31223A227469746C65222C227265736F757263655F62726F7773655F636F6C756D6E5F32223A226964656E746966696572222C227265736F757263655F62726F7773655F636F6C756D6E5F33223A226C6576656C222C227265736F757263655F62726F7773655F636F6C756D6E5F34223A226461746573222C227265736F757263655F62726F7773655F636F6C756D6E5F35223A22657874656E7473222C227265736F757263655F736F72745F636F6C756D6E223A227469746C65222C227265736F757263655F736F72745F646972656374696F6E223A22617363222C226469676974616C5F6F626A6563745F62726F7773655F636F6C756D6E5F31223A227469746C65222C226469676974616C5F6F626A6563745F62726F7773655F636F6C756D6E5F32223A226469676974616C5F6F626A6563745F6964222C226469676974616C5F6F626A6563745F736F72745F636F6C756D6E223A227469746C65222C226469676974616C5F6F626A6563745F736F72745F646972656374696F6E223A22617363222C226D756C74695F62726F7773655F636F6C756D6E5F31223A227072696D6172795F74797065222C226D756C74695F62726F7773655F636F6C756D6E5F32223A227469746C65222C226D756C74695F62726F7773655F636F6C756D6E5F33223A22636F6E74657874222C226D756C74695F62726F7773655F636F6C756D6E5F34223A226964656E746966696572222C226D756C74695F62726F7773655F636F6C756D6E5F35223A226461746573222C226D756C74695F736F72745F636F6C756D6E223A2273636F7265222C226D756C74695F736F72745F646972656374696F6E223A2264657363222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F31223A227469746C65222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F32223A226275696C64696E67222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F33223A22666C6F6F72222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F34223A22726F6F6D222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F35223A2261726561222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F36223A226C6F636174696F6E5F70726F66696C655F646973706C61795F737472696E675F755F73736F7274222C226C6F636174696F6E5F62726F7773655F636F6C756D6E5F37223A226C6F636174696F6E5F686F6C64696E6773222C226C6F636174696F6E5F736F72745F636F6C756D6E223A227469746C65222C226C6F636174696F6E5F736F72745F646972656374696F6E223A22617363222C226167656E745F62726F7773655F636F6C756D6E5F31223A227072696D6172795F74797065222C226167656E745F62726F7773655F636F6C756D6E5F32223A227469746C65222C226167656E745F62726F7773655F636F6C756D6E5F33223A22617574686F726974795F6964222C226167656E745F62726F7773655F636F6C756D6E5F34223A22736F75726365222C226167656E745F62726F7773655F636F6C756D6E5F35223A2272756C6573222C226167656E745F736F72745F636F6C756D6E223A227469746C65222C226167656E745F736F72745F646972656374696F6E223A22617363222C22617263686976616C5F6F626A6563745F62726F7773655F636F6C756D6E5F31223A227469746C65222C22617263686976616C5F6F626A6563745F62726F7773655F636F6C756D6E5F32223A22636F6E74657874222C22617263686976616C5F6F626A6563745F62726F7773655F636F6C756D6E5F33223A226964656E746966696572222C22617263686976616C5F6F626A6563745F62726F7773655F636F6C756D6E5F34223A226461746573222C22617263686976616C5F6F626A6563745F62726F7773655F636F6C756D6E5F35223A22657874656E7473222C22617263686976616C5F6F626A6563745F736F72745F636F6C756D6E223A227469746C65222C22617263686976616C5F6F626A6563745F736F72745F646972656374696F6E223A22617363222C226173736573736D656E745F62726F7773655F636F6C756D6E5F31223A226173736573736D656E745F6964222C226173736573736D656E745F62726F7773655F636F6C756D6E5F32223A226173736573736D656E745F7265636F726473222C226173736573736D656E745F62726F7773655F636F6C756D6E5F33223A226173736573736D656E745F7375727665796F7273222C226173736573736D656E745F62726F7773655F636F6C756D6E5F34223A226173736573736D656E745F636F6D706C65746564222C226173736573736D656E745F736F72745F636F6C756D6E223A226173736573736D656E745F6964222C226173736573736D656E745F736F72745F646972656374696F6E223A22617363222C22636C617373696669636174696F6E5F62726F7773655F636F6C756D6E5F31223A227469746C65222C22636C617373696669636174696F6E5F736F72745F636F6C756D6E223A227469746C65222C22636C617373696669636174696F6E5F736F72745F646972656374696F6E223A22617363222C22636F6C6C656374696F6E5F6D616E6167656D656E745F62726F7773655F636F6C756D6E5F31223A22706172656E745F7469746C65222C22636F6C6C656374696F6E5F6D616E6167656D656E745F62726F7773655F636F6C756D6E5F32223A22706172656E745F74797065222C22636F6C6C656374696F6E5F6D616E6167656D656E745F62726F7773655F636F6C756D6E5F33223A2270726F63657373696E675F7072696F72697479222C22636F6C6C656374696F6E5F6D616E6167656D656E745F62726F7773655F636F6C756D6E5F34223A2270726F63657373696E675F737461747573222C22636F6C6C656374696F6E5F6D616E6167656D656E745F62726F7773655F636F6C756D6E5F35223A2270726F63657373696E675F686F7572735F746F74616C222C22636F6C6C656374696F6E5F6D616E6167656D656E745F736F72745F636F6C756D6E223A22706172656E745F7469746C65222C22636F6C6C656374696F6E5F6D616E6167656D656E745F736F72745F646972656374696F6E223A22617363222C22636F6E7461696E65725F70726F66696C655F62726F7773655F636F6C756D6E5F31223A227469746C65222C22636F6E7461696E65725F70726F66696C655F736F72745F636F6C756D6E223A227469746C65222C22636F6E7461696E65725F70726F66696C655F736F72745F646972656374696F6E223A22617363222C226469676974616C5F6F626A6563745F636F6D706F6E656E745F62726F7773655F636F6C756D6E5F31223A227469746C65222C226469676974616C5F6F626A6563745F636F6D706F6E656E745F62726F7773655F636F6C756D6E5F32223A22636F6E74657874222C226469676974616C5F6F626A6563745F636F6D706F6E656E745F736F72745F636F6C756D6E223A227469746C65222C226469676974616C5F6F626A6563745F636F6D706F6E656E745F736F72745F646972656374696F6E223A22617363222C226576656E745F62726F7773655F636F6C756D6E5F31223A226576656E745F74797065222C226576656E745F62726F7773655F636F6C756D6E5F32223A226F7574636F6D65222C226576656E745F62726F7773655F636F6C756D6E5F33223A226167656E7473222C226576656E745F62726F7773655F636F6C756D6E5F34223A226C696E6B65645F7265636F726473222C226576656E745F736F72745F636F6C756D6E223A226576656E745F74797065222C226576656E745F736F72745F646972656374696F6E223A22617363222C226C6F636174696F6E5F70726F66696C655F62726F7773655F636F6C756D6E5F31223A227469746C65222C226C6F636174696F6E5F70726F66696C655F736F72745F636F6C756D6E223A227469746C65222C226C6F636174696F6E5F70726F66696C655F736F72745F646972656374696F6E223A22617363222C227265706F7369746F726965735F62726F7773655F636F6C756D6E5F31223A227469746C65222C227265706F7369746F726965735F62726F7773655F636F6C756D6E5F32223A227075626C697368222C227265706F7369746F726965735F62726F7773655F636F6C756D6E5F33223A2261756469745F696E666F222C227265706F7369746F726965735F736F72745F636F6C756D6E223A227469746C65222C227265706F7369746F726965735F736F72745F646972656374696F6E223A22617363222C227375626A6563745F62726F7773655F636F6C756D6E5F31223A227469746C65222C227375626A6563745F736F72745F636F6C756D6E223A227469746C65222C227375626A6563745F736F72745F646972656374696F6E223A22617363222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F31223A227469746C65222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F32223A22636F6E74657874222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F33223A2274797065222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F34223A22696E64696361746F72222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F35223A22626172636F6465222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F36223A22636F6E7461696E65725F70726F66696C655F646973706C61795F737472696E675F755F73737472222C22746F705F636F6E7461696E65725F62726F7773655F636F6C756D6E5F37223A226C6F636174696F6E5F646973706C61795F737472696E675F755F73737472222C22746F705F636F6E7461696E65725F736F72745F636F6C756D6E223A227469746C65222C22746F705F636F6E7461696E65725F736F72745F646972656374696F6E223A22617363222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F31223A227265736F757263655F616363657373696F6E222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F32223A22736572696573222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F33223A22636F6E7461696E65725F70726F66696C65222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F34223A2274797065222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F35223A22696E64696361746F72222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F36223A22626172636F6465222C22746F705F636F6E7461696E65725F6D676D745F62726F7773655F636F6C756D6E5F37223A22696E7465726E616C5F6E6F7465222C22746F705F636F6E7461696E65725F6D676D745F736F72745F636F6C756D6E223A227265736F757263655F616363657373696F6E222C22746F705F636F6E7461696E65725F6D676D745F736F72745F646972656374696F6E223A22617363222C226A6F625F62726F7773655F636F6C756D6E5F31223A22737461747573222C226A6F625F62726F7773655F636F6C756D6E5F32223A226A6F625F7265706F72745F74797065222C226A6F625F62726F7773655F636F6C756D6E5F33223A226A6F625F64617461222C226A6F625F62726F7773655F636F6C756D6E5F34223A2261756469745F696E666F222C226A6F625F736F72745F636F6C756D6E223A2274696D655F7375626D6974746564222C226A6F625F736F72745F646972656374696F6E223A2264657363222C226C6F63616C65223A22656E222C226E6F74655F6F72646572223A5B5D2C2264656661756C745F76616C756573223A66616C73657D',NULL,NULL,'2026-02-16 15:41:09','2026-02-16 18:43:45','2026-02-16 18:43:45');

/*!40000 ALTER TABLE `preference` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rde_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rde_template`;

CREATE TABLE `rde_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `record_type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `order` blob,
  `visible` blob,
  `defaults` blob,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rde_template_system_mtime_index` (`system_mtime`),
  KEY `rde_template_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table related_accession_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `related_accession_rlshp`;

CREATE TABLE `related_accession_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accession_id_0` int DEFAULT NULL,
  `accession_id_1` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `relator_id` int NOT NULL,
  `relator_type_id` int NOT NULL,
  `relationship_target_record_type` varchar(255) NOT NULL,
  `relationship_target_id` int NOT NULL,
  `jsonmodel_type` varchar(255) NOT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relator_id` (`relator_id`),
  KEY `relator_type_id` (`relator_type_id`),
  KEY `related_accession_rlshp_system_mtime_index` (`system_mtime`),
  KEY `related_accession_rlshp_user_mtime_index` (`user_mtime`),
  KEY `accession_id_0` (`accession_id_0`),
  KEY `accession_id_1` (`accession_id_1`),
  CONSTRAINT `related_accession_rlshp_ibfk_1` FOREIGN KEY (`relator_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `related_accession_rlshp_ibfk_2` FOREIGN KEY (`relator_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `related_accession_rlshp_ibfk_3` FOREIGN KEY (`accession_id_0`) REFERENCES `accession` (`id`),
  CONSTRAINT `related_accession_rlshp_ibfk_4` FOREIGN KEY (`accession_id_1`) REFERENCES `accession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table related_agents_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `related_agents_rlshp`;

CREATE TABLE `related_agents_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_person_id_0` int DEFAULT NULL,
  `agent_person_id_1` int DEFAULT NULL,
  `agent_corporate_entity_id_0` int DEFAULT NULL,
  `agent_corporate_entity_id_1` int DEFAULT NULL,
  `agent_software_id_0` int DEFAULT NULL,
  `agent_software_id_1` int DEFAULT NULL,
  `agent_family_id_0` int DEFAULT NULL,
  `agent_family_id_1` int DEFAULT NULL,
  `jsonmodel_type` varchar(255) NOT NULL,
  `description` text,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `relationship_target_record_type` varchar(255) NOT NULL,
  `relationship_target_id` int NOT NULL,
  `relator_id` int NOT NULL,
  `specific_relator_id` int DEFAULT NULL,
  `relationship_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `related_agents_rlshp_system_mtime_index` (`system_mtime`),
  KEY `related_agents_rlshp_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id_0` (`agent_person_id_0`),
  KEY `agent_person_id_1` (`agent_person_id_1`),
  KEY `agent_corporate_entity_id_0` (`agent_corporate_entity_id_0`),
  KEY `agent_corporate_entity_id_1` (`agent_corporate_entity_id_1`),
  KEY `agent_software_id_0` (`agent_software_id_0`),
  KEY `agent_software_id_1` (`agent_software_id_1`),
  KEY `agent_family_id_0` (`agent_family_id_0`),
  KEY `agent_family_id_1` (`agent_family_id_1`),
  KEY `relator_id` (`relator_id`),
  KEY `specific_relator_id` (`specific_relator_id`),
  CONSTRAINT `related_agents_rlshp_ibfk_1` FOREIGN KEY (`agent_person_id_0`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_10` FOREIGN KEY (`specific_relator_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_2` FOREIGN KEY (`agent_person_id_1`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id_0`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_4` FOREIGN KEY (`agent_corporate_entity_id_1`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_5` FOREIGN KEY (`agent_software_id_0`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_6` FOREIGN KEY (`agent_software_id_1`) REFERENCES `agent_software` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_7` FOREIGN KEY (`agent_family_id_0`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_8` FOREIGN KEY (`agent_family_id_1`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `related_agents_rlshp_ibfk_9` FOREIGN KEY (`relator_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table repository
# ------------------------------------------------------------

DROP TABLE IF EXISTS `repository`;

CREATE TABLE `repository` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `org_code` varchar(255) DEFAULT NULL,
  `parent_institution_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `contact_persons` text,
  `country_id` int DEFAULT NULL,
  `agent_representation_id` int DEFAULT NULL,
  `hidden` int DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `publish` int DEFAULT NULL,
  `description` text,
  `oai_is_disabled` int DEFAULT '0',
  `oai_sets_available` text,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '1',
  `ark_shoulder` varchar(255) DEFAULT NULL,
  `position` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `repo_code` (`repo_code`),
  UNIQUE KEY `position` (`position`),
  KEY `country_id` (`country_id`),
  KEY `repository_system_mtime_index` (`system_mtime`),
  KEY `repository_user_mtime_index` (`user_mtime`),
  KEY `agent_representation_id` (`agent_representation_id`),
  CONSTRAINT `repository_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `repository_ibfk_2` FOREIGN KEY (`agent_representation_id`) REFERENCES `agent_corporate_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `repository` WRITE;
/*!40000 ALTER TABLE `repository` DISABLE KEYS */;

INSERT INTO `repository` (`id`, `lock_version`, `json_schema_version`, `repo_code`, `name`, `org_code`, `parent_institution_name`, `url`, `image_url`, `contact_persons`, `country_id`, `agent_representation_id`, `hidden`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `publish`, `description`, `oai_is_disabled`, `oai_sets_available`, `slug`, `is_slug_auto`, `ark_shoulder`, `position`)
VALUES
	(1,0,1,'_archivesspace','Global repository',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2026-02-16 15:41:06','2026-02-16 15:41:06','2026-02-16 15:41:06',NULL,NULL,0,NULL,'archivesspace',1,NULL,0),
	(2,0,1,'merge_1','Merge 1',NULL,NULL,NULL,NULL,NULL,NULL,1,0,'admin','admin','2026-02-16 15:42:18','2026-02-16 15:42:18','2026-02-16 15:42:18',0,NULL,0,'[\"888\",\"889\",\"890\",\"891\",\"892\",\"893\",\"894\",\"895\",\"896\",\"897\",\"898\"]','merge_1',0,NULL,1);

/*!40000 ALTER TABLE `repository` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table required_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `required_fields`;

CREATE TABLE `required_fields` (
  `lock_version` int NOT NULL DEFAULT '0',
  `id` varchar(255) NOT NULL,
  `blob` blob NOT NULL,
  `repo_id` int NOT NULL,
  `record_type` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `required_fields_system_mtime_index` (`system_mtime`),
  KEY `required_fields_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resource`;

CREATE TABLE `resource` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `repo_id` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `title` varchar(8704) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `level_id` int NOT NULL,
  `other_level` varchar(255) DEFAULT NULL,
  `resource_type_id` int DEFAULT NULL,
  `publish` int DEFAULT NULL,
  `restrictions` int DEFAULT NULL,
  `repository_processing_note` text,
  `ead_id` varchar(255) DEFAULT NULL,
  `ead_location` varchar(255) DEFAULT NULL,
  `finding_aid_title` text,
  `finding_aid_filing_title` text,
  `finding_aid_date` varchar(255) DEFAULT NULL,
  `finding_aid_author` text,
  `finding_aid_description_rules_id` int DEFAULT NULL,
  `finding_aid_language_note` varchar(255) DEFAULT NULL,
  `finding_aid_sponsor` text,
  `finding_aid_edition_statement` text,
  `finding_aid_series_statement` text,
  `finding_aid_status_id` int DEFAULT NULL,
  `finding_aid_note` text,
  `system_generated` int DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `finding_aid_subtitle` text,
  `finding_aid_sponsor_sha1` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  `finding_aid_language_id` int DEFAULT NULL,
  `finding_aid_script_id` int DEFAULT NULL,
  `is_finding_aid_status_published` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `resource_unique_identifier` (`repo_id`,`identifier`),
  UNIQUE KEY `resource_unique_ead_id` (`repo_id`,`ead_id`),
  KEY `level_id` (`level_id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `finding_aid_description_rules_id` (`finding_aid_description_rules_id`),
  KEY `finding_aid_status_id` (`finding_aid_status_id`),
  KEY `resource_system_mtime_index` (`system_mtime`),
  KEY `resource_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_finding_aid_sponsor_sha1_index` (`finding_aid_sponsor_sha1`),
  CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `resource_ibfk_3` FOREIGN KEY (`resource_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `resource_ibfk_4` FOREIGN KEY (`finding_aid_description_rules_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `resource_ibfk_5` FOREIGN KEY (`finding_aid_status_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `resource_ibfk_6` FOREIGN KEY (`repo_id`) REFERENCES `repository` (`id`),
  CONSTRAINT `resource_ibfk_7` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;

INSERT INTO `resource` (`id`, `lock_version`, `json_schema_version`, `repo_id`, `accession_id`, `title`, `identifier`, `level_id`, `other_level`, `resource_type_id`, `publish`, `restrictions`, `repository_processing_note`, `ead_id`, `ead_location`, `finding_aid_title`, `finding_aid_filing_title`, `finding_aid_date`, `finding_aid_author`, `finding_aid_description_rules_id`, `finding_aid_language_note`, `finding_aid_sponsor`, `finding_aid_edition_statement`, `finding_aid_series_statement`, `finding_aid_status_id`, `finding_aid_note`, `system_generated`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `suppressed`, `finding_aid_subtitle`, `finding_aid_sponsor_sha1`, `slug`, `is_slug_auto`, `finding_aid_language_id`, `finding_aid_script_id`, `is_finding_aid_status_published`)
VALUES
	(1,0,1,2,NULL,'resource','[\"23456\",null,null,null]',889,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'admin','admin','2026-02-16 15:43:23','2026-02-16 18:52:50','2026-02-16 15:43:23',0,NULL,NULL,NULL,0,496,1639,1);

/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revision_statement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revision_statement`;

CREATE TABLE `revision_statement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_id` int DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `description` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `publish` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `revision_statement_system_mtime_index` (`system_mtime`),
  KEY `revision_statement_user_mtime_index` (`user_mtime`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `revision_statement_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table rights_restriction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rights_restriction`;

CREATE TABLE `rights_restriction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `restriction_note_type` varchar(255) DEFAULT NULL,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_id` (`resource_id`),
  KEY `archival_object_id` (`archival_object_id`),
  CONSTRAINT `rights_restriction_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `rights_restriction_ibfk_2` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table rights_restriction_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rights_restriction_type`;

CREATE TABLE `rights_restriction_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rights_restriction_id` int NOT NULL,
  `restriction_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `restriction_type_id` (`restriction_type_id`),
  KEY `rights_restriction_id` (`rights_restriction_id`),
  CONSTRAINT `rights_restriction_type_ibfk_1` FOREIGN KEY (`restriction_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `rights_restriction_type_ibfk_2` FOREIGN KEY (`rights_restriction_id`) REFERENCES `rights_restriction` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table rights_statement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rights_statement`;

CREATE TABLE `rights_statement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `repo_id` int DEFAULT NULL,
  `identifier` varchar(255) NOT NULL,
  `rights_type_id` int NOT NULL,
  `statute_citation` varchar(255) DEFAULT NULL,
  `jurisdiction_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `status_id` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `determination_date` date DEFAULT NULL,
  `license_terms` varchar(255) DEFAULT NULL,
  `other_rights_basis_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rights_type_id` (`rights_type_id`),
  KEY `jurisdiction_id` (`jurisdiction_id`),
  KEY `rights_statement_system_mtime_index` (`system_mtime`),
  KEY `rights_statement_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `resource_id` (`resource_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  KEY `rights_statement_status_id_fk` (`status_id`),
  KEY `rights_statement_other_rights_basis_id_fk` (`other_rights_basis_id`),
  CONSTRAINT `rights_statement_ibfk_1` FOREIGN KEY (`rights_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `rights_statement_ibfk_3` FOREIGN KEY (`jurisdiction_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `rights_statement_ibfk_4` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `rights_statement_ibfk_5` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `rights_statement_ibfk_6` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `rights_statement_ibfk_7` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `rights_statement_ibfk_8` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `rights_statement_other_rights_basis_id_fk` FOREIGN KEY (`other_rights_basis_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `rights_statement_status_id_fk` FOREIGN KEY (`status_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table rights_statement_act
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rights_statement_act`;

CREATE TABLE `rights_statement_act` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rights_statement_id` int NOT NULL,
  `act_type_id` int NOT NULL,
  `restriction_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `act_type_id` (`act_type_id`),
  KEY `restriction_id` (`restriction_id`),
  KEY `rights_statement_act_system_mtime_index` (`system_mtime`),
  KEY `rights_statement_act_user_mtime_index` (`user_mtime`),
  KEY `rights_statement_id` (`rights_statement_id`),
  CONSTRAINT `rights_statement_act_ibfk_1` FOREIGN KEY (`act_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `rights_statement_act_ibfk_2` FOREIGN KEY (`restriction_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `rights_statement_act_ibfk_3` FOREIGN KEY (`rights_statement_id`) REFERENCES `rights_statement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table rights_statement_pre_088
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rights_statement_pre_088`;

CREATE TABLE `rights_statement_pre_088` (
  `id` int NOT NULL DEFAULT '0',
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `repo_id` int DEFAULT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb3 NOT NULL,
  `rights_type_id` int NOT NULL,
  `active` int DEFAULT NULL,
  `materials` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `ip_status_id` int DEFAULT NULL,
  `ip_expiration_date` date DEFAULT NULL,
  `license_identifier_terms` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `statute_citation` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `jurisdiction_id` int DEFAULT NULL,
  `type_note` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `permissions` text CHARACTER SET utf8mb3,
  `restrictions` text CHARACTER SET utf8mb3,
  `restriction_start_date` date DEFAULT NULL,
  `restriction_end_date` date DEFAULT NULL,
  `granted_note` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `last_modified_by` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table schema_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_info`;

CREATE TABLE `schema_info` (
  `version` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `schema_info` WRITE;
/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;

INSERT INTO `schema_info` (`version`)
VALUES
	(175);

/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequence
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequence`;

CREATE TABLE `sequence` (
  `sequence_name` varchar(255) NOT NULL,
  `value` int NOT NULL,
  PRIMARY KEY (`sequence_name`),
  KEY `sequence_namevalue_idx` (`sequence_name`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `system_mtime` datetime NOT NULL,
  `expirable` int DEFAULT '1',
  `session_data` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`),
  KEY `session_system_mtime_index` (`system_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;

INSERT INTO `session` (`id`, `session_id`, `system_mtime`, `expirable`, `session_data`)
VALUES
	(1,'bb837077b35d17f96656f0a98a8370d8c95226c7','2026-02-16 15:46:00',0,X'4241683743446F4A64584E6C636B6B6945334E6C59584A6A61463970626D526C65475679426A6F4752565136443278765A326C75583352706257564A0A64546F4A56476C745A51305068682B41737677317051673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39750A5A556B694346565551775937426C5136446D563463476C7959574A735A55593D0A'),
	(2,'35357e63275b8cf38d7fb87cfbd405cc9a78c708','2026-02-16 15:46:00',0,X'4241683743446F4A64584E6C636B6B6945334E6C59584A6A61463970626D526C65475679426A6F4752565136443278765A326C75583352706257564A0A64546F4A56476C745A51305068682B414B6C69477051673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39750A5A556B694346565551775937426C5136446D563463476C7959574A735A55593D0A'),
	(3,'b70730bf012fdc1bcea419cdfd1b33c8f4c5529a','2026-02-16 15:46:05',0,X'4241683743446F4A64584E6C636B6B6945584E3059575A6D58334E356333526C62515936426B56554F67397362326470626C39306157316C535855360A435652706257554E4434596667476F41724B59494F67317A64574A7461574E796279494741446F4C62325A6D633256306151413643587076626D564A0A4967685656454D474F775A554F67356C65484270636D4669624756470A'),
	(4,'b58bd15a91e4fcbe539178d1e6fabc2ba9053677','2026-02-16 15:45:55',0,X'4241683743446F4A64584E6C636B6B6945334E6C59584A6A61463970626D526C65475679426A6F4752565136443278765A326C75583352706257564A0A64546F4A56476C745A51305068682B41455155587077673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39750A5A556B694346565551775937426C5136446D563463476C7959574A735A55593D0A'),
	(5,'a862c3acd560a45334e37ef9d96fddd8c256d8f3','2026-02-16 15:44:30',1,X'4241683743446F4A64584E6C636B6B69436D466B62576C75426A6F4752565136443278765A326C75583352706257564A64546F4A56476C745A5130500A68682B41777030757077673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39755A556B6943465655517759370A426C5136446D563463476C7959574A735A56513D0A'),
	(6,'5fe4470e9d918fdedfb5b0e82615269917569b08','2026-02-16 18:55:48',0,X'4241683743446F4A64584E6C636B6B6945334E6C59584A6A61463970626D526C65475679426A6F4752565136443278765A326C75583352706257564A0A64546F4A56476C745A51305368682B41423078317277673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39750A5A556B694346565551775937426C5136446D563463476C7959574A735A55593D0A'),
	(7,'c3591f50b417d286ce2ee85639e0122a1ad713f7','2026-02-16 18:55:53',0,X'4241683743446F4A64584E6C636B6B6945334E6C59584A6A61463970626D526C65475679426A6F4752565136443278765A326C75583352706257564A0A64546F4A56476C745A51305368682B41743134457341673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39750A5A556B694346565551775937426C5136446D563463476C7959574A735A55593D0A'),
	(8,'837cfda503cf4bf8d39a3214d554620bd57fb606','2026-02-16 18:55:53',0,X'4241683743446F4A64584E6C636B6B6945584E3059575A6D58334E356333526C62515936426B56554F67397362326470626C39306157316C535855360A435652706257554E456F5966674B50724B3745494F67317A64574A7461574E796279494741446F4C62325A6D633256306151413643587076626D564A0A4967685656454D474F775A554F67356C65484270636D4669624756470A'),
	(9,'91d6e432aef1e0035b00f52f55b86654a1227672','2026-02-16 18:55:23',1,X'4241683743446F4A64584E6C636B6B69436D466B62576C75426A6F4752565136443278765A326C75583352706257564A64546F4A56476C745A5130530A68682B415A306F317351673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39755A556B6943465655517759370A426C5136446D563463476C7959574A735A56513D0A'),
	(10,'6a331dcd244fcfd6c374b2276325cde61b603aa3','2026-02-16 18:55:33',0,X'4241683743446F4A64584E6C636B6B6945334E6C59584A6A61463970626D526C65475679426A6F4752565136443278765A326C75583352706257564A0A64546F4A56476C745A51305368682B414A3536567351673644584E31596D317059334A76496759414F6774765A6D5A7A5A58527041446F4A656D39750A5A556B694346565551775937426C5136446D563463476C7959574A735A55593D0A');

/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table spawned_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `spawned_rlshp`;

CREATE TABLE `spawned_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `spawned_rlshp_system_mtime_index` (`system_mtime`),
  KEY `spawned_rlshp_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `spawned_rlshp_ibfk_1` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `spawned_rlshp_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table structured_date_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structured_date_label`;

CREATE TABLE `structured_date_label` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_label_id` int NOT NULL,
  `date_certainty_id` int DEFAULT NULL,
  `date_era_id` int DEFAULT NULL,
  `date_calendar_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `name_person_id` int DEFAULT NULL,
  `name_family_id` int DEFAULT NULL,
  `name_corporate_entity_id` int DEFAULT NULL,
  `name_software_id` int DEFAULT NULL,
  `parallel_name_person_id` int DEFAULT NULL,
  `parallel_name_family_id` int DEFAULT NULL,
  `parallel_name_corporate_entity_id` int DEFAULT NULL,
  `parallel_name_software_id` int DEFAULT NULL,
  `related_agents_rlshp_id` int DEFAULT NULL,
  `agent_place_id` int DEFAULT NULL,
  `agent_occupation_id` int DEFAULT NULL,
  `agent_function_id` int DEFAULT NULL,
  `agent_topic_id` int DEFAULT NULL,
  `agent_gender_id` int DEFAULT NULL,
  `agent_resource_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  `date_type_structured` varchar(255) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  KEY `structured_date_label_system_mtime_index` (`system_mtime`),
  KEY `structured_date_label_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `structured_date_label_ibfk_1` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `structured_date_label_ibfk_2` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `structured_date_label_ibfk_3` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `structured_date_label_ibfk_4` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table structured_date_range
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structured_date_range`;

CREATE TABLE `structured_date_range` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structured_date_label_id` int NOT NULL,
  `begin_date_expression` varchar(255) DEFAULT NULL,
  `begin_date_standardized` varchar(255) DEFAULT NULL,
  `begin_date_standardized_type_id` int NOT NULL DEFAULT '1769',
  `end_date_expression` varchar(255) DEFAULT NULL,
  `end_date_standardized` varchar(255) DEFAULT NULL,
  `end_date_standardized_type_id` int NOT NULL DEFAULT '1769',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structured_date_range_system_mtime_index` (`system_mtime`),
  KEY `structured_date_range_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table structured_date_single
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structured_date_single`;

CREATE TABLE `structured_date_single` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structured_date_label_id` int NOT NULL,
  `date_role_id` int NOT NULL,
  `date_expression` varchar(255) DEFAULT NULL,
  `date_standardized` varchar(255) DEFAULT NULL,
  `date_standardized_type_id` int NOT NULL DEFAULT '1769',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structured_date_single_system_mtime_index` (`system_mtime`),
  KEY `structured_date_single_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table sub_container
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sub_container`;

CREATE TABLE `sub_container` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `instance_id` int DEFAULT NULL,
  `type_2_id` int DEFAULT NULL,
  `indicator_2` varchar(255) DEFAULT NULL,
  `type_3_id` int DEFAULT NULL,
  `indicator_3` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `barcode_2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_2_id` (`type_2_id`),
  KEY `type_3_id` (`type_3_id`),
  KEY `sub_container_system_mtime_index` (`system_mtime`),
  KEY `sub_container_user_mtime_index` (`user_mtime`),
  KEY `instance_id` (`instance_id`),
  CONSTRAINT `sub_container_ibfk_1` FOREIGN KEY (`type_2_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `sub_container_ibfk_2` FOREIGN KEY (`type_3_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `sub_container_ibfk_3` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `sub_container` WRITE;
/*!40000 ALTER TABLE `sub_container` DISABLE KEYS */;

INSERT INTO `sub_container` (`id`, `lock_version`, `json_schema_version`, `instance_id`, `type_2_id`, `indicator_2`, `type_3_id`, `indicator_3`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `barcode_2`)
VALUES
	(1,0,1,1,NULL,NULL,NULL,NULL,'admin','admin','2026-02-16 18:52:14','2026-02-16 18:52:14','2026-02-16 18:52:14',NULL),
	(2,0,1,2,NULL,NULL,NULL,NULL,'admin','admin','2026-02-16 18:52:50','2026-02-16 18:52:50','2026-02-16 18:52:50',NULL);

/*!40000 ALTER TABLE `sub_container` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table subject
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `vocab_id` int NOT NULL,
  `title` varchar(8704) DEFAULT NULL,
  `terms_sha1` varchar(255) NOT NULL,
  `authority_id` varchar(255) DEFAULT NULL,
  `scope_note` text,
  `source_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_slug_auto` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subj_auth_source_uniq` (`vocab_id`,`authority_id`,`source_id`),
  UNIQUE KEY `subj_terms_uniq` (`vocab_id`,`terms_sha1`,`source_id`),
  KEY `source_id` (`source_id`),
  KEY `subject_terms_sha1_index` (`terms_sha1`),
  KEY `subject_system_mtime_index` (`system_mtime`),
  KEY `subject_user_mtime_index` (`user_mtime`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `subject_ibfk_2` FOREIGN KEY (`vocab_id`) REFERENCES `vocabulary` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table subject_agent_subrecord_place_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subject_agent_subrecord_place_rlshp`;

CREATE TABLE `subject_agent_subrecord_place_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `agent_function_id` int DEFAULT NULL,
  `agent_occupation_id` int DEFAULT NULL,
  `agent_resource_id` int DEFAULT NULL,
  `agent_topic_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_agent_subrecord_place_rlshp_system_mtime_index` (`system_mtime`),
  KEY `subject_agent_subrecord_place_rlshp_user_mtime_index` (`user_mtime`),
  KEY `subject_id` (`subject_id`),
  KEY `agent_function_id` (`agent_function_id`),
  KEY `agent_occupation_id` (`agent_occupation_id`),
  KEY `agent_topic_id` (`agent_topic_id`),
  CONSTRAINT `subject_agent_subrecord_place_rlshp_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `subject_agent_subrecord_place_rlshp_ibfk_2` FOREIGN KEY (`agent_function_id`) REFERENCES `agent_function` (`id`),
  CONSTRAINT `subject_agent_subrecord_place_rlshp_ibfk_3` FOREIGN KEY (`agent_occupation_id`) REFERENCES `agent_occupation` (`id`),
  CONSTRAINT `subject_agent_subrecord_place_rlshp_ibfk_4` FOREIGN KEY (`agent_topic_id`) REFERENCES `agent_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table subject_agent_subrecord_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subject_agent_subrecord_rlshp`;

CREATE TABLE `subject_agent_subrecord_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `agent_function_id` int DEFAULT NULL,
  `agent_occupation_id` int DEFAULT NULL,
  `agent_place_id` int DEFAULT NULL,
  `agent_topic_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_agent_subrecord_rlshp_system_mtime_index` (`system_mtime`),
  KEY `subject_agent_subrecord_rlshp_user_mtime_index` (`user_mtime`),
  KEY `subject_id` (`subject_id`),
  KEY `agent_function_id` (`agent_function_id`),
  KEY `agent_occupation_id` (`agent_occupation_id`),
  KEY `agent_place_id` (`agent_place_id`),
  KEY `agent_topic_id` (`agent_topic_id`),
  CONSTRAINT `subject_agent_subrecord_rlshp_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `subject_agent_subrecord_rlshp_ibfk_2` FOREIGN KEY (`agent_function_id`) REFERENCES `agent_function` (`id`),
  CONSTRAINT `subject_agent_subrecord_rlshp_ibfk_3` FOREIGN KEY (`agent_occupation_id`) REFERENCES `agent_occupation` (`id`),
  CONSTRAINT `subject_agent_subrecord_rlshp_ibfk_4` FOREIGN KEY (`agent_place_id`) REFERENCES `agent_place` (`id`),
  CONSTRAINT `subject_agent_subrecord_rlshp_ibfk_5` FOREIGN KEY (`agent_topic_id`) REFERENCES `agent_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table subject_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subject_rlshp`;

CREATE TABLE `subject_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accession_id` int DEFAULT NULL,
  `archival_object_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `digital_object_component_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `subject_rlshp_system_mtime_index` (`system_mtime`),
  KEY `subject_rlshp_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `archival_object_id` (`archival_object_id`),
  KEY `resource_id` (`resource_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `digital_object_component_id` (`digital_object_component_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `subject_rlshp_ibfk_1` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `subject_rlshp_ibfk_2` FOREIGN KEY (`archival_object_id`) REFERENCES `archival_object` (`id`),
  CONSTRAINT `subject_rlshp_ibfk_3` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `subject_rlshp_ibfk_4` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `subject_rlshp_ibfk_5` FOREIGN KEY (`digital_object_component_id`) REFERENCES `digital_object_component` (`id`),
  CONSTRAINT `subject_rlshp_ibfk_6` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table subject_term
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subject_term`;

CREATE TABLE `subject_term` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `term_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `term_id` (`term_id`),
  KEY `subject_term_idx` (`subject_id`,`term_id`),
  CONSTRAINT `subject_term_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `subject_term_ibfk_2` FOREIGN KEY (`term_id`) REFERENCES `term` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table subnote_metadata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subnote_metadata`;

CREATE TABLE `subnote_metadata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `note_id` int NOT NULL,
  `guid` varchar(255) NOT NULL,
  `publish` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `note_id` (`note_id`),
  CONSTRAINT `subnote_metadata_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table surveyed_by_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `surveyed_by_rlshp`;

CREATE TABLE `surveyed_by_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assessment_id` int NOT NULL,
  `agent_person_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `surveyed_by_rlshp_system_mtime_index` (`system_mtime`),
  KEY `surveyed_by_rlshp_user_mtime_index` (`user_mtime`),
  KEY `assessment_id` (`assessment_id`),
  KEY `agent_person_id` (`agent_person_id`),
  CONSTRAINT `surveyed_by_rlshp_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`id`),
  CONSTRAINT `surveyed_by_rlshp_ibfk_2` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table system_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `system_event`;

CREATE TABLE `system_event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `time` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_event_time_index` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table telephone
# ------------------------------------------------------------

DROP TABLE IF EXISTS `telephone`;

CREATE TABLE `telephone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agent_contact_id` int DEFAULT NULL,
  `number` text NOT NULL,
  `ext` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `number_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `telephone_system_mtime_index` (`system_mtime`),
  KEY `telephone_user_mtime_index` (`user_mtime`),
  KEY `agent_contact_id` (`agent_contact_id`),
  KEY `number_type_id` (`number_type_id`),
  CONSTRAINT `telephone_ibfk_1` FOREIGN KEY (`agent_contact_id`) REFERENCES `agent_contact` (`id`),
  CONSTRAINT `telephone_ibfk_2` FOREIGN KEY (`number_type_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table term
# ------------------------------------------------------------

DROP TABLE IF EXISTS `term`;

CREATE TABLE `term` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `vocab_id` int NOT NULL,
  `term` varchar(255) NOT NULL,
  `term_type_id` int NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `term_vocab_id_term_term_type_id_index` (`vocab_id`,`term`,`term_type_id`),
  KEY `term_type_id` (`term_type_id`),
  KEY `term_system_mtime_index` (`system_mtime`),
  KEY `term_user_mtime_index` (`user_mtime`),
  CONSTRAINT `term_ibfk_1` FOREIGN KEY (`term_type_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `term_ibfk_2` FOREIGN KEY (`vocab_id`) REFERENCES `vocabulary` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table top_container
# ------------------------------------------------------------

DROP TABLE IF EXISTS `top_container`;

CREATE TABLE `top_container` (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` int NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `ils_holding_id` varchar(255) DEFAULT NULL,
  `ils_item_id` varchar(255) DEFAULT NULL,
  `exported_to_ils` datetime DEFAULT NULL,
  `indicator` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `type_id` int DEFAULT NULL,
  `created_for_collection` varchar(255) DEFAULT NULL,
  `internal_note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `top_container_uniq_barcode` (`repo_id`,`barcode`),
  KEY `top_container_indicator_index` (`indicator`),
  KEY `top_container_system_mtime_index` (`system_mtime`),
  KEY `top_container_user_mtime_index` (`user_mtime`),
  KEY `top_container_type_fk` (`type_id`),
  CONSTRAINT `top_container_type_fk` FOREIGN KEY (`type_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `top_container` WRITE;
/*!40000 ALTER TABLE `top_container` DISABLE KEYS */;

INSERT INTO `top_container` (`id`, `repo_id`, `lock_version`, `json_schema_version`, `barcode`, `ils_holding_id`, `ils_item_id`, `exported_to_ils`, `indicator`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `type_id`, `created_for_collection`, `internal_note`)
VALUES
	(1,2,1,1,NULL,NULL,NULL,NULL,'1234','admin','admin','2026-02-16 18:50:53','2026-02-16 18:52:50','2026-02-16 18:50:53',NULL,'/repositories/2/resources/1',NULL),
	(2,2,1,1,NULL,NULL,NULL,NULL,'2345','admin','admin','2026-02-16 18:52:11','2026-02-16 18:52:50','2026-02-16 18:52:11',NULL,'/repositories/2/resources/1',NULL);

/*!40000 ALTER TABLE `top_container` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table top_container_housed_at_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `top_container_housed_at_rlshp`;

CREATE TABLE `top_container_housed_at_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `top_container_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `jsonmodel_type` varchar(255) NOT NULL DEFAULT 'container_location',
  `status` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `top_container_housed_at_rlshp_system_mtime_index` (`system_mtime`),
  KEY `top_container_housed_at_rlshp_user_mtime_index` (`user_mtime`),
  KEY `top_container_id` (`top_container_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `top_container_housed_at_rlshp_ibfk_1` FOREIGN KEY (`top_container_id`) REFERENCES `top_container` (`id`),
  CONSTRAINT `top_container_housed_at_rlshp_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table top_container_link_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `top_container_link_rlshp`;

CREATE TABLE `top_container_link_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `top_container_id` int DEFAULT NULL,
  `sub_container_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `top_container_link_rlshp_system_mtime_index` (`system_mtime`),
  KEY `top_container_link_rlshp_user_mtime_index` (`user_mtime`),
  KEY `top_container_id` (`top_container_id`),
  KEY `sub_container_id` (`sub_container_id`),
  CONSTRAINT `top_container_link_rlshp_ibfk_1` FOREIGN KEY (`top_container_id`) REFERENCES `top_container` (`id`),
  CONSTRAINT `top_container_link_rlshp_ibfk_2` FOREIGN KEY (`sub_container_id`) REFERENCES `sub_container` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `top_container_link_rlshp` WRITE;
/*!40000 ALTER TABLE `top_container_link_rlshp` DISABLE KEYS */;

INSERT INTO `top_container_link_rlshp` (`id`, `top_container_id`, `sub_container_id`, `aspace_relationship_position`, `suppressed`, `created_by`, `last_modified_by`, `system_mtime`, `user_mtime`)
VALUES
	(1,2,1,0,0,NULL,NULL,'2026-02-16 18:52:14','2026-02-16 18:52:14'),
	(2,1,2,0,0,NULL,NULL,'2026-02-16 18:52:50','2026-02-16 18:52:50');

/*!40000 ALTER TABLE `top_container_link_rlshp` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table top_container_profile_rlshp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `top_container_profile_rlshp`;

CREATE TABLE `top_container_profile_rlshp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `top_container_id` int DEFAULT NULL,
  `container_profile_id` int DEFAULT NULL,
  `aspace_relationship_position` int DEFAULT NULL,
  `suppressed` int NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `top_container_profile_rlshp_system_mtime_index` (`system_mtime`),
  KEY `top_container_profile_rlshp_user_mtime_index` (`user_mtime`),
  KEY `top_container_id` (`top_container_id`),
  KEY `container_profile_id` (`container_profile_id`),
  CONSTRAINT `top_container_profile_rlshp_ibfk_1` FOREIGN KEY (`top_container_id`) REFERENCES `top_container` (`id`),
  CONSTRAINT `top_container_profile_rlshp_ibfk_2` FOREIGN KEY (`container_profile_id`) REFERENCES `container_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `top_container_profile_rlshp` WRITE;
/*!40000 ALTER TABLE `top_container_profile_rlshp` DISABLE KEYS */;

INSERT INTO `top_container_profile_rlshp` (`id`, `top_container_id`, `container_profile_id`, `aspace_relationship_position`, `suppressed`, `created_by`, `last_modified_by`, `system_mtime`, `user_mtime`)
VALUES
	(1,1,1,0,0,NULL,NULL,'2026-02-16 18:50:53','2026-02-16 18:50:53'),
	(2,2,2,0,0,NULL,NULL,'2026-02-16 18:52:11','2026-02-16 18:52:11');

/*!40000 ALTER TABLE `top_container_profile_rlshp` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table used_language
# ------------------------------------------------------------

DROP TABLE IF EXISTS `used_language`;

CREATE TABLE `used_language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language_id` int DEFAULT NULL,
  `script_id` int DEFAULT NULL,
  `agent_person_id` int DEFAULT NULL,
  `agent_family_id` int DEFAULT NULL,
  `agent_corporate_entity_id` int DEFAULT NULL,
  `agent_software_id` int DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `lock_version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `language_id` (`language_id`),
  KEY `script_id` (`script_id`),
  KEY `used_language_system_mtime_index` (`system_mtime`),
  KEY `used_language_user_mtime_index` (`user_mtime`),
  KEY `agent_person_id` (`agent_person_id`),
  KEY `agent_family_id` (`agent_family_id`),
  KEY `agent_corporate_entity_id` (`agent_corporate_entity_id`),
  KEY `agent_software_id` (`agent_software_id`),
  CONSTRAINT `used_language_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `used_language_ibfk_2` FOREIGN KEY (`script_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `used_language_ibfk_3` FOREIGN KEY (`agent_person_id`) REFERENCES `agent_person` (`id`),
  CONSTRAINT `used_language_ibfk_4` FOREIGN KEY (`agent_family_id`) REFERENCES `agent_family` (`id`),
  CONSTRAINT `used_language_ibfk_5` FOREIGN KEY (`agent_corporate_entity_id`) REFERENCES `agent_corporate_entity` (`id`),
  CONSTRAINT `used_language_ibfk_6` FOREIGN KEY (`agent_software_id`) REFERENCES `agent_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `agent_record_id` int DEFAULT NULL,
  `agent_record_type` varchar(255) DEFAULT NULL,
  `is_system_user` int NOT NULL DEFAULT '0',
  `is_hidden_user` int NOT NULL DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `additional_contact` text,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `is_active_user` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_system_mtime_index` (`system_mtime`),
  KEY `user_user_mtime_index` (`user_mtime`),
  KEY `agent_record_id` (`agent_record_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`agent_record_id`) REFERENCES `agent_person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `lock_version`, `json_schema_version`, `username`, `name`, `source`, `agent_record_id`, `agent_record_type`, `is_system_user`, `is_hidden_user`, `email`, `first_name`, `last_name`, `telephone`, `title`, `department`, `additional_contact`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`, `is_active_user`)
VALUES
	(1,2,1,'admin','Administrator','DBAuth',1,'agent_person',1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-02-16 15:41:07','2026-02-16 18:44:19','2026-02-16 18:44:19',1),
	(2,6,1,'search_indexer','Search Indexer','DBAuth',NULL,NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 18:44:25','2026-02-16 18:44:25',1),
	(3,0,1,'public_anonymous','Public Interface Anonymous','local',NULL,NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 15:41:08','2026-02-16 15:41:08',1),
	(4,2,1,'staff_system','Staff System User','DBAuth',NULL,NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-02-16 15:41:08','2026-02-16 18:44:18','2026-02-16 18:44:18',1);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_defined
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_defined`;

CREATE TABLE `user_defined` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `json_schema_version` int NOT NULL,
  `accession_id` int DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `digital_object_id` int DEFAULT NULL,
  `boolean_1` int DEFAULT NULL,
  `boolean_2` int DEFAULT NULL,
  `boolean_3` int DEFAULT NULL,
  `integer_1` varchar(255) DEFAULT NULL,
  `integer_2` varchar(255) DEFAULT NULL,
  `integer_3` varchar(255) DEFAULT NULL,
  `real_1` varchar(255) DEFAULT NULL,
  `real_2` varchar(255) DEFAULT NULL,
  `real_3` varchar(255) DEFAULT NULL,
  `string_1` varchar(255) DEFAULT NULL,
  `string_2` varchar(255) DEFAULT NULL,
  `string_3` varchar(255) DEFAULT NULL,
  `string_4` varchar(255) DEFAULT NULL,
  `text_1` text,
  `text_2` text,
  `text_3` text,
  `text_4` text,
  `text_5` text,
  `date_1` date DEFAULT NULL,
  `date_2` date DEFAULT NULL,
  `date_3` date DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  `enum_1_id` int DEFAULT NULL,
  `enum_2_id` int DEFAULT NULL,
  `enum_3_id` int DEFAULT NULL,
  `enum_4_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_defined_system_mtime_index` (`system_mtime`),
  KEY `user_defined_user_mtime_index` (`user_mtime`),
  KEY `accession_id` (`accession_id`),
  KEY `resource_id` (`resource_id`),
  KEY `digital_object_id` (`digital_object_id`),
  KEY `enum_1_id` (`enum_1_id`),
  KEY `enum_2_id` (`enum_2_id`),
  KEY `enum_3_id` (`enum_3_id`),
  KEY `enum_4_id` (`enum_4_id`),
  CONSTRAINT `user_defined_ibfk_1` FOREIGN KEY (`accession_id`) REFERENCES `accession` (`id`),
  CONSTRAINT `user_defined_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `user_defined_ibfk_3` FOREIGN KEY (`digital_object_id`) REFERENCES `digital_object` (`id`),
  CONSTRAINT `user_defined_ibfk_4` FOREIGN KEY (`enum_1_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `user_defined_ibfk_5` FOREIGN KEY (`enum_2_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `user_defined_ibfk_6` FOREIGN KEY (`enum_3_id`) REFERENCES `enumeration_value` (`id`),
  CONSTRAINT `user_defined_ibfk_7` FOREIGN KEY (`enum_4_id`) REFERENCES `enumeration_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table vocabulary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `vocabulary`;

CREATE TABLE `vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lock_version` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `ref_id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_modified_by` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `system_mtime` datetime NOT NULL,
  `user_mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `ref_id` (`ref_id`),
  KEY `vocabulary_system_mtime_index` (`system_mtime`),
  KEY `vocabulary_user_mtime_index` (`user_mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `vocabulary` WRITE;
/*!40000 ALTER TABLE `vocabulary` DISABLE KEYS */;

INSERT INTO `vocabulary` (`id`, `lock_version`, `name`, `ref_id`, `created_by`, `last_modified_by`, `create_time`, `system_mtime`, `user_mtime`)
VALUES
	(1,0,'global','global',NULL,NULL,'2026-02-16 15:40:19','2026-02-16 15:40:33','2026-02-16 15:40:19');

/*!40000 ALTER TABLE `vocabulary` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
