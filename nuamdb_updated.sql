-- ========================================================
-- Script de Base de Datos Actualizado para nuamdb
-- Generado automáticamente por Antigravity AI
-- Fecha: 2026-07-12
-- Compatible con MariaDB / MySQL
-- Incluye grupo Cliente (ID 5) y sus permisos correspondientes.
-- ========================================================

CREATE DATABASE IF NOT EXISTS `nuamdb` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `nuamdb`;

SET FOREIGN_KEY_CHECKS = 0;

-- ========================================================
-- MIGRATION: contenttypes / 0001_initial
-- ========================================================
--
-- Create model ContentType
--
CREATE TABLE `django_content_type` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NOT NULL, `app_label` varchar(100) NOT NULL, `model` varchar(100) NOT NULL);
--
-- Alter unique_together for contenttype (1 constraint(s))
--
ALTER TABLE `django_content_type` ADD CONSTRAINT `django_content_type_app_label_model_76bd3d3b_uniq` UNIQUE (`app_label`, `model`);

-- ========================================================
-- MIGRATION: contenttypes / 0002_remove_content_type_name
-- ========================================================
--
-- Change Meta options on contenttype
--
-- (no-op)
--
-- Alter field name on contenttype
--
ALTER TABLE `django_content_type` MODIFY `name` varchar(100) NULL;
--
-- Raw Python operation
--
-- THIS OPERATION CANNOT BE WRITTEN AS SQL
--
-- Remove field name from contenttype
--
ALTER TABLE `django_content_type` DROP COLUMN `name`;

-- ========================================================
-- MIGRATION: auth / 0001_initial
-- ========================================================
--
-- Create model Permission
--
CREATE TABLE `auth_permission` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(50) NOT NULL, `content_type_id` integer NOT NULL, `codename` varchar(100) NOT NULL);
--
-- Create model Group
--
CREATE TABLE `auth_group` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(80) NOT NULL UNIQUE);
CREATE TABLE `auth_group_permissions` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `group_id` integer NOT NULL, `permission_id` integer NOT NULL);
--
-- Create model User
--
-- (no-op)
ALTER TABLE `auth_permission` ADD CONSTRAINT `auth_permission_content_type_id_codename_01ab375a_uniq` UNIQUE (`content_type_id`, `codename`);
ALTER TABLE `auth_permission` ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` UNIQUE (`group_id`, `permission_id`);
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

-- ========================================================
-- MIGRATION: auth / 0002_alter_permission_name_max_length
-- ========================================================
--
-- Alter field name on permission
--
ALTER TABLE `auth_permission` MODIFY `name` varchar(255) NOT NULL;

-- ========================================================
-- MIGRATION: auth / 0003_alter_user_email_max_length
-- ========================================================
--
-- Alter field email on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: auth / 0004_alter_user_username_opts
-- ========================================================
--
-- Alter field username on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: auth / 0005_alter_user_last_login_null
-- ========================================================
--
-- Alter field last_login on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: auth / 0006_require_contenttypes_0002
-- ========================================================


-- ========================================================
-- MIGRATION: auth / 0007_alter_validators_add_error_messages
-- ========================================================
--
-- Alter field username on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: auth / 0008_alter_user_username_max_length
-- ========================================================
--
-- Alter field username on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: auth / 0009_alter_user_last_name_max_length
-- ========================================================
--
-- Alter field last_name on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: auth / 0010_alter_group_name_max_length
-- ========================================================
--
-- Alter field name on group
--
ALTER TABLE `auth_group` MODIFY `name` varchar(150) NOT NULL;

-- ========================================================
-- MIGRATION: auth / 0011_update_proxy_permissions
-- ========================================================
--
-- Raw Python operation
--
-- THIS OPERATION CANNOT BE WRITTEN AS SQL

-- ========================================================
-- MIGRATION: auth / 0012_alter_user_first_name_max_length
-- ========================================================
--
-- Alter field first_name on user
--
-- (no-op)

-- ========================================================
-- MIGRATION: Intranet / 0001_initial
-- ========================================================
--
-- Create model calificacion_tributaria
--
CREATE TABLE `Intranet_calificacion_tributaria` (`secuencia_evento` bigint NOT NULL PRIMARY KEY, `mercado` varchar(50) NOT NULL, `descripcion` varchar(150) NOT NULL, `fecha_pago` date NOT NULL, `dividendo` integer NULL, `valor_historico` bigint NULL, `anio` integer NOT NULL, `estado` varchar(30) NOT NULL, `origen_calificacion` varchar(20) NOT NULL, `isfut` bool NOT NULL, `factor_actualizacion` numeric(10, 6) NOT NULL, `evento_capital` integer NULL);
--
-- Create model instrumento_financiero
--
CREATE TABLE `Intranet_instrumento_financiero` (`instrumento_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `codigo` varchar(6) NOT NULL UNIQUE, `descripcion` varchar(150) NOT NULL, `categoria` varchar(50) NOT NULL, `bolsa` varchar(30) NOT NULL, `mercado` varchar(50) NOT NULL, `estado` varchar(9) NOT NULL);
--
-- Create model califica
--
CREATE TABLE `Intranet_califica` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `valor` double precision NOT NULL, `calificacion_id` bigint NOT NULL);
--
-- Create model categoria_factor
--
CREATE TABLE `Intranet_categoria_factor` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `nombre` varchar(200) NOT NULL, `padre_id` bigint NULL);
--
-- Create model factor_calificacion
--
CREATE TABLE `Intranet_factor_calificacion` (`factor_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `nombre_factor` varchar(120) NOT NULL, `categoria_id` bigint NULL);
--
-- Add field factores to calificacion_tributaria
--
-- (no-op)
--
-- Add field factor to califica
--
ALTER TABLE `Intranet_califica` ADD COLUMN `factor_id` integer NOT NULL , ADD CONSTRAINT `Intranet_califica_factor_id_d90edd10_fk_Intranet_` FOREIGN KEY (`factor_id`) REFERENCES `Intranet_factor_calificacion`(`factor_id`);
--
-- Add field instrumento to calificacion_tributaria
--
ALTER TABLE `Intranet_calificacion_tributaria` ADD COLUMN `instrumento_id` integer NOT NULL , ADD CONSTRAINT `Intranet_calificacio_instrumento_id_868bd9cb_fk_Intranet_` FOREIGN KEY (`instrumento_id`) REFERENCES `Intranet_instrumento_financiero`(`instrumento_id`);
--
-- Create model User
--
CREATE TABLE `Intranet_user` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `password` varchar(128) NOT NULL, `last_login` datetime(6) NULL, `is_superuser` bool NOT NULL, `first_name` varchar(150) NOT NULL, `last_name` varchar(150) NOT NULL, `is_staff` bool NOT NULL, `is_active` bool NOT NULL, `date_joined` datetime(6) NOT NULL, `email` varchar(254) NOT NULL UNIQUE);
CREATE TABLE `Intranet_user_groups` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `user_id` bigint NOT NULL, `group_id` integer NOT NULL);
CREATE TABLE `Intranet_user_user_permissions` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `user_id` bigint NOT NULL, `permission_id` integer NOT NULL);
--
-- Create model solicitud
--
CREATE TABLE `Intranet_solicitud` (`solicitud_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `motivo` longtext NOT NULL, `fecha` date NULL, `group_id` integer NOT NULL, `usuario_id` bigint NOT NULL);
ALTER TABLE `Intranet_califica` ADD CONSTRAINT `Intranet_califica_calificacion_id_4ede9fe8_fk_Intranet_` FOREIGN KEY (`calificacion_id`) REFERENCES `Intranet_calificacion_tributaria` (`secuencia_evento`);
ALTER TABLE `Intranet_categoria_factor` ADD CONSTRAINT `Intranet_categoria_f_padre_id_2d6b5feb_fk_Intranet_` FOREIGN KEY (`padre_id`) REFERENCES `Intranet_categoria_factor` (`id`);
ALTER TABLE `Intranet_factor_calificacion` ADD CONSTRAINT `Intranet_factor_cali_categoria_id_f1d76899_fk_Intranet_` FOREIGN KEY (`categoria_id`) REFERENCES `Intranet_categoria_factor` (`id`);
ALTER TABLE `Intranet_user_groups` ADD CONSTRAINT `Intranet_user_groups_user_id_group_id_89ebf548_uniq` UNIQUE (`user_id`, `group_id`);
ALTER TABLE `Intranet_user_groups` ADD CONSTRAINT `Intranet_user_groups_user_id_3e881222_fk_Intranet_user_id` FOREIGN KEY (`user_id`) REFERENCES `Intranet_user` (`id`);
ALTER TABLE `Intranet_user_groups` ADD CONSTRAINT `Intranet_user_groups_group_id_23c3b620_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
ALTER TABLE `Intranet_user_user_permissions` ADD CONSTRAINT `Intranet_user_user_permi_user_id_permission_id_8d2bc6ed_uniq` UNIQUE (`user_id`, `permission_id`);
ALTER TABLE `Intranet_user_user_permissions` ADD CONSTRAINT `Intranet_user_user_p_user_id_85bc83e0_fk_Intranet_` FOREIGN KEY (`user_id`) REFERENCES `Intranet_user` (`id`);
ALTER TABLE `Intranet_user_user_permissions` ADD CONSTRAINT `Intranet_user_user_p_permission_id_de1b018a_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
ALTER TABLE `Intranet_solicitud` ADD CONSTRAINT `Intranet_solicitud_group_id_eb4f1179_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
ALTER TABLE `Intranet_solicitud` ADD CONSTRAINT `Intranet_solicitud_usuario_id_72a2a0c5_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `Intranet_user` (`id`);

-- ========================================================
-- MIGRATION: Intranet / 0002_auditoria_chat_privado_mensaje_privado_notification
-- ========================================================
--
-- Create model Auditoria
--
CREATE TABLE `Intranet_auditoria` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `tabla` varchar(100) NOT NULL, `registro_id` varchar(100) NOT NULL, `accion` varchar(20) NOT NULL, `descripcion` longtext NOT NULL, `fecha` datetime(6) NOT NULL, `valores_antes` json NULL, `valores_despues` json NULL, `usuario_id` bigint NULL);
--
-- Create model chat_privado
--
CREATE TABLE `Intranet_chat_privado` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `fecha_creacion` datetime(6) NOT NULL, `usuario1_id` bigint NOT NULL, `usuario2_id` bigint NOT NULL);
--
-- Create model mensaje_privado
--
CREATE TABLE `Intranet_mensaje_privado` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `mensaje` longtext NOT NULL, `fecha_envio` datetime(6) NOT NULL, `chat_id` bigint NOT NULL, `usuario_id` bigint NOT NULL);
--
-- Create model notification
--
CREATE TABLE `Intranet_notification` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `tipo` varchar(50) NOT NULL, `mensaje` longtext NOT NULL, `fecha` datetime(6) NOT NULL, `leida` bool NOT NULL, `receptor_id` bigint NOT NULL);
ALTER TABLE `Intranet_auditoria` ADD CONSTRAINT `Intranet_auditoria_usuario_id_b1bb78de_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `Intranet_user` (`id`);
ALTER TABLE `Intranet_chat_privado` ADD CONSTRAINT `Intranet_chat_privado_usuario1_id_c526e63d_fk_Intranet_user_id` FOREIGN KEY (`usuario1_id`) REFERENCES `Intranet_user` (`id`);
ALTER TABLE `Intranet_chat_privado` ADD CONSTRAINT `Intranet_chat_privado_usuario2_id_8c6440a6_fk_Intranet_user_id` FOREIGN KEY (`usuario2_id`) REFERENCES `Intranet_user` (`id`);
ALTER TABLE `Intranet_mensaje_privado` ADD CONSTRAINT `Intranet_mensaje_pri_chat_id_e28484a0_fk_Intranet_` FOREIGN KEY (`chat_id`) REFERENCES `Intranet_chat_privado` (`id`);
ALTER TABLE `Intranet_mensaje_privado` ADD CONSTRAINT `Intranet_mensaje_privado_usuario_id_54c88dbb_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `Intranet_user` (`id`);
ALTER TABLE `Intranet_notification` ADD CONSTRAINT `Intranet_notification_receptor_id_49ca62ce_fk_Intranet_user_id` FOREIGN KEY (`receptor_id`) REFERENCES `Intranet_user` (`id`);

-- ========================================================
-- MIGRATION: Intranet / 0003_calificacion_tributaria_cliente_and_more
-- ========================================================
--
-- Add field cliente to calificacion_tributaria
--
ALTER TABLE `Intranet_calificacion_tributaria` ADD COLUMN `cliente_id` bigint NULL , ADD CONSTRAINT `Intranet_calificacio_cliente_id_66e3df99_fk_Intranet_` FOREIGN KEY (`cliente_id`) REFERENCES `Intranet_user`(`id`);
--
-- Add field calificacion to solicitud
--
ALTER TABLE `Intranet_solicitud` ADD COLUMN `calificacion_id` bigint NULL , ADD CONSTRAINT `Intranet_solicitud_calificacion_id_1062bed0_fk_Intranet_` FOREIGN KEY (`calificacion_id`) REFERENCES `Intranet_calificacion_tributaria`(`secuencia_evento`);

-- ========================================================
-- MIGRATION: admin / 0001_initial
-- ========================================================
--
-- Create model LogEntry
--
CREATE TABLE `django_admin_log` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `action_time` datetime(6) NOT NULL, `object_id` longtext NULL, `object_repr` varchar(200) NOT NULL, `action_flag` smallint UNSIGNED NOT NULL CHECK (`action_flag` >= 0), `change_message` longtext NOT NULL, `content_type_id` integer NULL, `user_id` bigint NOT NULL);
ALTER TABLE `django_admin_log` ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);
ALTER TABLE `django_admin_log` ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Intranet_user_id` FOREIGN KEY (`user_id`) REFERENCES `Intranet_user` (`id`);

-- ========================================================
-- MIGRATION: admin / 0002_logentry_remove_auto_add
-- ========================================================
--
-- Alter field action_time on logentry
--
-- (no-op)

-- ========================================================
-- MIGRATION: admin / 0003_logentry_add_action_flag_choices
-- ========================================================
--
-- Alter field action_flag on logentry
--
-- (no-op)

-- ========================================================
-- MIGRATION: sessions / 0001_initial
-- ========================================================
--
-- Create model Session
--
CREATE TABLE `django_session` (`session_key` varchar(40) NOT NULL PRIMARY KEY, `session_data` longtext NOT NULL, `expire_date` datetime(6) NOT NULL);
CREATE INDEX `django_session_expire_date_a5c62663` ON `django_session` (`expire_date`);
-- ========================================================
-- DATOS INICIALES (POPULATE)
-- ========================================================

-- Dumping data for table `django_content_type`

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(6, 'Intranet', 'calificacion_tributaria'),
(7, 'Intranet', 'instrumento_financiero'),
(8, 'Intranet', 'califica'),
(9, 'Intranet', 'categoria_factor'),
(10, 'Intranet', 'factor_calificacion'),
(11, 'Intranet', 'user'),
(12, 'Intranet', 'solicitud'),
(13, 'Intranet', 'auditoria'),
(14, 'Intranet', 'chat_privado'),
(15, 'Intranet', 'mensaje_privado'),
(16, 'Intranet', 'notification');

-- Dumping data for table `auth_permission`

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add calificacion_tributaria', 6, 'add_calificacion_tributaria'),
(22, 'Can change calificacion_tributaria', 6, 'change_calificacion_tributaria'),
(23, 'Can delete calificacion_tributaria', 6, 'delete_calificacion_tributaria'),
(24, 'Can view calificacion_tributaria', 6, 'view_calificacion_tributaria'),
(25, 'Can add instrumento_financiero', 7, 'add_instrumento_financiero'),
(26, 'Can change instrumento_financiero', 7, 'change_instrumento_financiero'),
(27, 'Can delete instrumento_financiero', 7, 'delete_instrumento_financiero'),
(28, 'Can view instrumento_financiero', 7, 'view_instrumento_financiero'),
(29, 'Can add califica', 8, 'add_califica'),
(30, 'Can change califica', 8, 'change_califica'),
(31, 'Can delete califica', 8, 'delete_califica'),
(32, 'Can view califica', 8, 'view_califica'),
(33, 'Can add categoria_factor', 9, 'add_categoria_factor'),
(34, 'Can change categoria_factor', 9, 'change_categoria_factor'),
(35, 'Can delete categoria_factor', 9, 'delete_categoria_factor'),
(36, 'Can view categoria_factor', 9, 'view_categoria_factor'),
(37, 'Can add factor_calificacion', 10, 'add_factor_calificacion'),
(38, 'Can change factor_calificacion', 10, 'change_factor_calificacion'),
(39, 'Can delete factor_calificacion', 10, 'delete_factor_calificacion'),
(40, 'Can view factor_calificacion', 10, 'view_factor_calificacion'),
(41, 'Can add user', 11, 'add_user'),
(42, 'Can change user', 11, 'change_user'),
(43, 'Can delete user', 11, 'delete_user'),
(44, 'Can view user', 11, 'view_user'),
(45, 'Can add solicitud', 12, 'add_solicitud'),
(46, 'Can change solicitud', 12, 'change_solicitud'),
(47, 'Can delete solicitud', 12, 'delete_solicitud'),
(48, 'Can view solicitud', 12, 'view_solicitud'),
(49, 'Can add auditoria', 13, 'add_auditoria'),
(50, 'Can change auditoria', 13, 'change_auditoria'),
(51, 'Can delete auditoria', 13, 'delete_auditoria'),
(52, 'Can view auditoria', 13, 'view_auditoria'),
(53, 'Can add chat_privado', 14, 'add_chat_privado'),
(54, 'Can change chat_privado', 14, 'change_chat_privado'),
(55, 'Can delete chat_privado', 14, 'delete_chat_privado'),
(56, 'Can view chat_privado', 14, 'view_chat_privado'),
(57, 'Can add mensaje_privado', 15, 'add_mensaje_privado'),
(58, 'Can change mensaje_privado', 15, 'change_mensaje_privado'),
(59, 'Can delete mensaje_privado', 15, 'delete_mensaje_privado'),
(60, 'Can view mensaje_privado', 15, 'view_mensaje_privado'),
(61, 'Can add notification', 16, 'add_notification'),
(62, 'Can change notification', 16, 'change_notification'),
(63, 'Can delete notification', 16, 'delete_notification'),
(64, 'Can view notification', 16, 'view_notification');

-- Dumping data for table `auth_group`

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Administrador'),
(2, 'Auditor'),
(3, 'Corredor'),
(4, 'Bolsa'),
(5, 'Cliente');

-- Dumping data for table `auth_group_permissions`

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(1, 1, 21),
(2, 1, 22),
(3, 1, 23),
(4, 1, 24),
(5, 1, 25),
(6, 1, 26),
(7, 1, 27),
(8, 1, 28),
(9, 1, 29),
(10, 1, 30),
(11, 1, 31),
(12, 1, 32),
(13, 1, 33),
(14, 1, 34),
(15, 1, 35),
(16, 1, 36),
(17, 1, 37),
(18, 1, 38),
(19, 1, 39),
(20, 1, 40),
(21, 1, 41),
(22, 1, 42),
(23, 1, 43),
(24, 1, 44),
(25, 1, 45),
(26, 1, 46),
(27, 1, 47),
(28, 1, 48),
(29, 2, 22),
(30, 2, 24),
(31, 2, 25),
(32, 2, 26),
(33, 2, 27),
(34, 2, 28),
(35, 2, 32),
(36, 2, 36),
(37, 2, 40),
(38, 2, 44),
(39, 2, 45),
(40, 2, 46),
(41, 2, 47),
(42, 2, 48),
(43, 3, 21),
(44, 3, 22),
(45, 3, 23),
(46, 3, 24),
(47, 3, 25),
(48, 3, 32),
(49, 3, 36),
(50, 3, 40),
(51, 3, 45),
(52, 3, 48),
(53, 4, 21),
(54, 4, 22),
(55, 4, 25),
(56, 4, 26),
(57, 4, 29),
(58, 4, 30),
(59, 4, 33),
(60, 4, 34),
(61, 4, 37),
(62, 4, 38),
(63, 5, 24),
(64, 5, 45),
(65, 5, 48),
(66, 5, 28),
(67, 5, 40),
(68, 5, 36);

-- Dumping data for table `Intranet_categoria_factor`

INSERT INTO `Intranet_categoria_factor` (`id`, `nombre`, `padre_id`) VALUES
(1, 'Afectos a los Impuestos Global Complementario y/o Impuesto Adicional', NULL),
(2, 'Rentas Exentas e Ingresos no Constitutivos de Renta (REX)', NULL),
(3, 'Rentas con Tributación Cumplida', 2),
(4, 'Rentas Exentas', 2),
(5, 'Acumulados a Contar del 01/01/2017', NULL),
(6, 'Asociados a Rentas Afectas', 5),
(7, 'Asociados a Rentas Exentas', 5),
(8, 'No Sujetos a Restitución generados hasta el 31/12/2019', 6),
(9, 'No Sujetos a Restitución a contar del 01/01/2020', 6),
(10, 'Sujetos a Restitución', 6),
(11, 'Sujetos a Restitución', 7),
(12, 'Acumulados Hasta el 31/12/2016', NULL),
(13, 'Asociados a Rentas Afectas', 12),
(14, 'Asociados a Rentas Exentas (Art. 11, Ley 18.401)', 12);

-- Dumping data for table `Intranet_factor_calificacion`

INSERT INTO `Intranet_factor_calificacion` (`factor_id`, `nombre_factor`, `categoria_id`) VALUES
(8, 'Con crédito IDPC generados a contar del 01/01/2017', 1),
(9, 'Con crédito IDPC acumulados hasta el 31/12/2016', 1),
(10, 'Con derecho a crédito por pago de IDPC voluntario', 1),
(11, 'Sin derecho a crédito', 1),
(12, 'Rentas provenientes del registro RAP y Diferencia Inicial de sociedad acogida al ex Art. 14 TER A) LIR', 3),
(13, 'Otras ventas percibidas Sin Prioridad en su orden de imputación', 3),
(14, 'Exceso Distribuciones Desproporcionadas (Nº9 Art.14 A)', 3),
(15, 'Utilidades afectadas con impuesto sustitutivo al FUT (ISFUT) Ley Nº20.780', 3),
(16, 'Rentas generadas hasta el 31/12/1983 y/o utilidades afectadas con impuesto sustitutivo al FUT (ISFUT) Ley Nº21.210', 3),
(17, 'Rentas Exentas de Impuesto Global Complementario (IGC) (Artículo 11, Ley 18.401) Afectas a Impuesto Adicional', 4),
(18, 'Rentas Exentas de Impuesto Global Complementario (IGC) y/o Impuesto Adicional (IA)', 4),
(19, 'Ingresos No Constitutivos de Renta', 2),
(20, 'Sin derecho a devolución', 8),
(21, 'Con derecho a devolución', 8),
(22, 'Sin derecho a devolución', 9),
(23, 'Con derecho a devolución', 9),
(24, 'Sin derecho a devolución', 10),
(25, 'Con derecho a devolución', 10),
(26, 'Sin derecho a devolución', 11),
(27, 'Con derecho a devolución', 11),
(28, 'Crédito por IPE', 5),
(29, 'Sin derecho a devolución', 13),
(30, 'Con derecho a devolución', 13),
(31, 'Sin derecho a devolución', 14),
(32, 'Con derecho a devolución', 14),
(33, 'Crédito por IPE', 12),
(34, 'Crédito por Impuesto Tasa Adicional, Ex. Art. 21 LIR', NULL),
(35, 'Tasa Efectiva del crédito del FUT (TEF)', NULL),
(36, 'Tasa Efectiva del crédito del FUNT (TEX)', NULL),
(37, 'Devolución de capital Art. 17 Nº7 LIR', NULL);

-- Dumping data for table `Intranet_instrumento_financiero`

INSERT INTO `Intranet_instrumento_financiero` (`instrumento_id`, `codigo`, `descripcion`, `categoria`, `bolsa`, `mercado`, `estado`) VALUES
(1, 'ADP', 'DEPOSITO A PLAZO', 'Efectivo y Depósitos', 'BCS', 'Mercado Internacional', 'Ingresado'),
(2, 'ADPCL', 'DEPOSITO A PLAZO CHILE', 'Efectivo y Depósitos', 'BCS', 'Mercado Monetario', 'Ingresado'),
(3, 'AGG', 'FONDOS ETF´s', 'Fondos', 'BVL', 'Fondos de Inversión-Mutuos', 'Ingresado'),
(4, 'AGGCL', 'FONDOS MUTUOS - FONDOS ETF´s', 'Fondos', 'BCS', 'Fondos de Inversión-Mutuos', 'Ingresado'),
(5, 'AIG', 'American International Group. - Dolares', 'Acciones y Participaciones', 'BVC', 'Mercado Internacional', 'Ingresado'),
(6, 'AIGCL', 'American International Group. - Pesos Chilenos', 'Acciones y Participaciones', 'BCS', 'Acciones', 'Ingresado'),
(7, 'AMGN', 'Amgen Inc. opciones, ETFs, fondos, divisas, materias primas y criptomonedas.', 'Fondos', 'BCS', 'Mercado Internacional', 'Ingresado'),
(8, 'AMGCL', 'Amgen Inc.  \r\nPatrocinador en Chile: BCI Corredor de Bolsa S.A. - Pesos Chilenos', 'Acciones y Participaciones', 'BCS', 'Acciones', 'Ingresado'),
(9, 'AXP', 'American Express Compan', 'Otras Cuentas-Derechos', 'BVL', 'Mercado Internacional', 'Ingresado'),
(10, 'AXPCL', 'American Express Compan - Pesos Chilenos', 'Acciones y Participaciones', 'BCS', 'Acciones', 'Ingresado'),
(11, 'BAC', 'Bank Of America Corp - Dolares', 'Otras Cuentas-Derechos', 'BVL', 'Mercado Internacional', 'Ingresado');

-- Dumping data for table `Intranet_user`

INSERT INTO `Intranet_user` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`) VALUES
(1, 'pbkdf2_sha256$1000000$i8LhXJDBLc5YQGa5E4YLsV$yai5huDhI7JPC6jw/Ep4YljGHDTFJimIHUb0JqutZow=', '2025-12-01 09:10:12.763213', 1, 'Super', 'User', 1, 1, '2025-12-01 08:21:10.000000', 'superuser@nuam.com'),
(10, 'pbkdf2_sha256$1000000$kZjmsKAkZmv2Y6rNiuzIIf$jDtd76wjXYKWn8fCf/6MIYGavCmo2xZVznOuKXEmxho=', '2025-12-01 16:43:40.724062', 0, 'Admin', 'Doe', 0, 1, '2025-12-01 08:54:55.605816', 'admin@nuam.com'),
(11, 'pbkdf2_sha256$1000000$wGHVjTK3pJKIse8untiViI$P0ByaJ/3WPyLsObwgAbIbbiHDdxITQWz4pOYZVsnpj4=', '2025-12-01 10:02:36.628189', 0, 'Auditor', 'Doe', 0, 1, '2025-12-01 08:55:12.114170', 'auditor@nuam.com'),
(12, 'pbkdf2_sha256$1000000$1dK7hqKUsmy3gVvu6H5gTF$4PvVj5c6D5+p8ubLEt5V9CnawiRaixCmfruwpG29H7M=', '2025-12-01 09:59:50.934637', 0, 'Corredor', 'Doe', 0, 1, '2025-12-01 08:55:35.700550', 'corredor@nuam.com'),
(13, 'pbkdf2_sha256$1000000$rubUklbzI5varzZW2G0wel$ojaa4cNA42MLo67ew6Yjoxo5XvbUZ0/FAyR5yJh+HBE=', NULL, 0, 'Bolsa', 'Comercio Santiago', 0, 1, '2025-12-01 08:59:30.477192', 'bcs@nuam.com'),
(14, 'pbkdf2_sha256$1000000$2ou3fxtUjxQeKyR7uh3fId$7eU2JJ+19W5C21nUSn+DE7TWltB1tt3b5EVczVL/Je0=', NULL, 0, 'Bolsa', 'Valores Lima', 0, 1, '2025-12-01 08:59:47.313347', 'bvl@nuam.com'),
(15, 'pbkdf2_sha256$1000000$PMhigRh0PeSOyHBkKbuMYt$qKfh8muQ4naFoEfjZn/8OkzetseLzMag9UGTz372urs=', NULL, 0, 'Bolsa', 'Valores Colombia', 0, 1, '2025-12-01 09:00:05.090741', 'bvc@nuam.com'),
(16, 'pbkdf2_sha256$1000000$qQeA7iPPqe2ia04vvDF4rS$3GBgZIdDyuB7PVrlGrM0Lxhi2Nr84cZP3A0rcDZol48=', NULL, 0, 'Bolsa', 'Valores', 0, 1, '2025-12-01 09:00:19.154876', 'bolsa@nuam.com');

-- Dumping data for table `Intranet_user_groups`

INSERT INTO `Intranet_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(10, 10, 1),
(11, 11, 2),
(12, 12, 3),
(13, 13, 4),
(14, 14, 4),
(15, 15, 4),
(16, 16, 4);

-- Dumping data for table `django_migrations`

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-07-12 10:15:11.729834'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-07-12 10:15:11.729834'),
(3, 'auth', '0001_initial', '2026-07-12 10:15:11.729834'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-07-12 10:15:11.729834'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-07-12 10:15:11.729834'),
(6, 'auth', '0004_alter_user_username_opts', '2026-07-12 10:15:11.729834'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-07-12 10:15:11.729834'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-07-12 10:15:11.729834'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-07-12 10:15:11.729834'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-07-12 10:15:11.729834'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-07-12 10:15:11.729834'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-07-12 10:15:11.729834'),
(13, 'auth', '0011_update_proxy_permissions', '2026-07-12 10:15:11.729834'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-07-12 10:15:11.729834'),
(15, 'Intranet', '0001_initial', '2026-07-12 10:15:11.729834'),
(16, 'Intranet', '0002_auditoria_chat_privado_mensaje_privado_notification', '2026-07-12 10:15:11.729834'),
(17, 'Intranet', '0003_calificacion_tributaria_cliente_and_more', '2026-07-12 10:15:11.729834'),
(18, 'admin', '0001_initial', '2026-07-12 10:15:11.729834'),
(19, 'admin', '0002_logentry_remove_auto_add', '2026-07-12 10:15:11.729834'),
(20, 'admin', '0003_logentry_add_action_flag_choices', '2026-07-12 10:15:11.729834'),
(21, 'sessions', '0001_initial', '2026-07-12 10:15:11.729834');

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
