-- ========================================================
-- Script de Base de Datos Actualizado para nuamdb
-- Generado automaticamente por Antigravity AI
-- Compatible con MariaDB / MySQL
-- ========================================================

CREATE DATABASE IF NOT EXISTS `nuamdb` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `nuamdb`;

SET FOREIGN_KEY_CHECKS = 0;

-- Table structure for table `Intranet_auditoria`
DROP TABLE IF EXISTS `Intranet_auditoria`;
CREATE TABLE `Intranet_auditoria` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tabla` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `valores_antes` json DEFAULT NULL,
  `valores_despues` json DEFAULT NULL,
  `usuario_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Intranet_auditoria_usuario_id_b1bb78de_fk_Intranet_user_id` (`usuario_id`),
  CONSTRAINT `Intranet_auditoria_usuario_id_b1bb78de_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `Intranet_auditoria`
INSERT INTO `Intranet_auditoria` (`id`, `tabla`, `registro_id`, `accion`, `descripcion`, `fecha`, `valores_antes`, `valores_despues`, `usuario_id`) VALUES 
(1, 'User', '17', 'CREAR', 'Ingreso de Usuario', '2026-07-12 15:03:02.127312', NULL, '{"id": 17, "email": "jadeth.morales@nuam.com", "groups": [], "is_staff": false, "password": "pbkdf2_sha256$600000$IE9RXEb90cuaQCbxrwJcI6$7h+Uzvw+XARBP0zFKG8k9d8x52MIjFuQ3M9lHI6leJk=", "is_active": true, "last_name": "Morales", "first_name": "Jadeth", "last_login": null, "date_joined": "2026-07-12T15:03:01.531972+00:00", "is_superuser": false, "user_permissions": []}', 10);

-- Table structure for table `Intranet_califica`
DROP TABLE IF EXISTS `Intranet_califica`;
CREATE TABLE `Intranet_califica` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `valor` double NOT NULL,
  `calificacion_id` bigint NOT NULL,
  `factor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Intranet_califica_factor_id_d90edd10_fk_Intranet_` (`factor_id`),
  KEY `Intranet_califica_calificacion_id_4ede9fe8_fk_Intranet_` (`calificacion_id`),
  CONSTRAINT `Intranet_califica_calificacion_id_4ede9fe8_fk_Intranet_` FOREIGN KEY (`calificacion_id`) REFERENCES `Intranet_calificacion_tributaria` (`secuencia_evento`),
  CONSTRAINT `Intranet_califica_factor_id_d90edd10_fk_Intranet_` FOREIGN KEY (`factor_id`) REFERENCES `Intranet_factor_calificacion` (`factor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `Intranet_calificacion_tributaria`
DROP TABLE IF EXISTS `Intranet_calificacion_tributaria`;
CREATE TABLE `Intranet_calificacion_tributaria` (
  `secuencia_evento` bigint NOT NULL,
  `mercado` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date NOT NULL,
  `dividendo` int DEFAULT NULL,
  `valor_historico` bigint DEFAULT NULL,
  `anio` int NOT NULL,
  `estado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origen_calificacion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isfut` tinyint(1) NOT NULL,
  `factor_actualizacion` decimal(10,6) NOT NULL,
  `evento_capital` int DEFAULT NULL,
  `instrumento_id` int NOT NULL,
  `cliente_id` bigint DEFAULT NULL,
  PRIMARY KEY (`secuencia_evento`),
  KEY `Intranet_calificacio_instrumento_id_868bd9cb_fk_Intranet_` (`instrumento_id`),
  KEY `Intranet_calificacio_cliente_id_66e3df99_fk_Intranet_` (`cliente_id`),
  CONSTRAINT `Intranet_calificacio_cliente_id_66e3df99_fk_Intranet_` FOREIGN KEY (`cliente_id`) REFERENCES `Intranet_user` (`id`),
  CONSTRAINT `Intranet_calificacio_instrumento_id_868bd9cb_fk_Intranet_` FOREIGN KEY (`instrumento_id`) REFERENCES `Intranet_instrumento_financiero` (`instrumento_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `Intranet_categoria_factor`
DROP TABLE IF EXISTS `Intranet_categoria_factor`;
CREATE TABLE `Intranet_categoria_factor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `padre_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Intranet_categoria_f_padre_id_2d6b5feb_fk_Intranet_` (`padre_id`),
  CONSTRAINT `Intranet_categoria_f_padre_id_2d6b5feb_fk_Intranet_` FOREIGN KEY (`padre_id`) REFERENCES `Intranet_categoria_factor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- Table structure for table `Intranet_chat_privado`
DROP TABLE IF EXISTS `Intranet_chat_privado`;
CREATE TABLE `Intranet_chat_privado` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_creacion` datetime(6) NOT NULL,
  `usuario1_id` bigint NOT NULL,
  `usuario2_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Intranet_chat_privado_usuario1_id_c526e63d_fk_Intranet_user_id` (`usuario1_id`),
  KEY `Intranet_chat_privado_usuario2_id_8c6440a6_fk_Intranet_user_id` (`usuario2_id`),
  CONSTRAINT `Intranet_chat_privado_usuario1_id_c526e63d_fk_Intranet_user_id` FOREIGN KEY (`usuario1_id`) REFERENCES `Intranet_user` (`id`),
  CONSTRAINT `Intranet_chat_privado_usuario2_id_8c6440a6_fk_Intranet_user_id` FOREIGN KEY (`usuario2_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `Intranet_factor_calificacion`
DROP TABLE IF EXISTS `Intranet_factor_calificacion`;
CREATE TABLE `Intranet_factor_calificacion` (
  `factor_id` int NOT NULL AUTO_INCREMENT,
  `nombre_factor` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria_id` bigint DEFAULT NULL,
  PRIMARY KEY (`factor_id`),
  KEY `Intranet_factor_cali_categoria_id_f1d76899_fk_Intranet_` (`categoria_id`),
  CONSTRAINT `Intranet_factor_cali_categoria_id_f1d76899_fk_Intranet_` FOREIGN KEY (`categoria_id`) REFERENCES `Intranet_categoria_factor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- Table structure for table `Intranet_instrumento_financiero`
DROP TABLE IF EXISTS `Intranet_instrumento_financiero`;
CREATE TABLE `Intranet_instrumento_financiero` (
  `instrumento_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bolsa` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mercado` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`instrumento_id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `Intranet_instrumento_financiero`
INSERT INTO `Intranet_instrumento_financiero` (`instrumento_id`, `codigo`, `descripcion`, `categoria`, `bolsa`, `mercado`, `estado`) VALUES 
(1, 'ADP', 'DEPOSITO A PLAZO', 'Efectivo y Depósitos', 'BCS', 'Mercado Internacional', 'Ingresado'),
(2, 'ADPCL', 'DEPOSITO A PLAZO CHILE', 'Efectivo y Depósitos', 'BCS', 'Mercado Monetario', 'Ingresado'),
(3, 'AGG', 'FONDOS ETF´s', 'Fondos', 'BVL', 'Fondos de Inversión-Mutuos', 'Ingresado'),
(4, 'AGGCL', 'FONDOS MUTUOS - FONDOS ETF´s', 'Fondos', 'BCS', 'Fondos de Inversión-Mutuos', 'Ingresado'),
(5, 'AIG', 'American International Group. - Dolares', 'Acciones y Participaciones', 'BVC', 'Mercado Internacional', 'Ingresado'),
(6, 'AIGCL', 'American International Group. - Pesos Chilenos', 'Acciones y Participaciones', 'BCS', 'Acciones', 'Ingresado'),
(7, 'AMGN', 'Amgen Inc. opciones, ETFs, fondos, divisas, materias primas y criptomonedas.', 'Fondos', 'BCS', 'Mercado Internacional', 'Ingresado'),
(8, 'AMGCL', 'Amgen Inc.  
Patrocinador en Chile: BCI Corredor de Bolsa S.A. - Pesos Chilenos', 'Acciones y Participaciones', 'BCS', 'Acciones', 'Ingresado'),
(9, 'AXP', 'American Express Compan', 'Otras Cuentas-Derechos', 'BVL', 'Mercado Internacional', 'Ingresado'),
(10, 'AXPCL', 'American Express Compan - Pesos Chilenos', 'Acciones y Participaciones', 'BCS', 'Acciones', 'Ingresado'),
(11, 'BAC', 'Bank Of America Corp - Dolares', 'Otras Cuentas-Derechos', 'BVL', 'Mercado Internacional', 'Ingresado');

-- Table structure for table `Intranet_mensaje_privado`
DROP TABLE IF EXISTS `Intranet_mensaje_privado`;
CREATE TABLE `Intranet_mensaje_privado` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mensaje` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_envio` datetime(6) NOT NULL,
  `chat_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Intranet_mensaje_pri_chat_id_e28484a0_fk_Intranet_` (`chat_id`),
  KEY `Intranet_mensaje_privado_usuario_id_54c88dbb_fk_Intranet_user_id` (`usuario_id`),
  CONSTRAINT `Intranet_mensaje_pri_chat_id_e28484a0_fk_Intranet_` FOREIGN KEY (`chat_id`) REFERENCES `Intranet_chat_privado` (`id`),
  CONSTRAINT `Intranet_mensaje_privado_usuario_id_54c88dbb_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `Intranet_notification`
DROP TABLE IF EXISTS `Intranet_notification`;
CREATE TABLE `Intranet_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `leida` tinyint(1) NOT NULL,
  `receptor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Intranet_notification_receptor_id_49ca62ce_fk_Intranet_user_id` (`receptor_id`),
  CONSTRAINT `Intranet_notification_receptor_id_49ca62ce_fk_Intranet_user_id` FOREIGN KEY (`receptor_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `Intranet_solicitud`
DROP TABLE IF EXISTS `Intranet_solicitud`;
CREATE TABLE `Intranet_solicitud` (
  `solicitud_id` int NOT NULL AUTO_INCREMENT,
  `motivo` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `group_id` int NOT NULL,
  `usuario_id` bigint NOT NULL,
  `calificacion_id` bigint DEFAULT NULL,
  PRIMARY KEY (`solicitud_id`),
  KEY `Intranet_solicitud_group_id_eb4f1179_fk_auth_group_id` (`group_id`),
  KEY `Intranet_solicitud_usuario_id_72a2a0c5_fk_Intranet_user_id` (`usuario_id`),
  KEY `Intranet_solicitud_calificacion_id_1062bed0_fk_Intranet_` (`calificacion_id`),
  CONSTRAINT `Intranet_solicitud_calificacion_id_1062bed0_fk_Intranet_` FOREIGN KEY (`calificacion_id`) REFERENCES `Intranet_calificacion_tributaria` (`secuencia_evento`),
  CONSTRAINT `Intranet_solicitud_group_id_eb4f1179_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Intranet_solicitud_usuario_id_72a2a0c5_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `Intranet_user`
DROP TABLE IF EXISTS `Intranet_user`;
CREATE TABLE `Intranet_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `Intranet_user`
INSERT INTO `Intranet_user` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`) VALUES 
(1, 'pbkdf2_sha256$1000000$i8LhXJDBLc5YQGa5E4YLsV$yai5huDhI7JPC6jw/Ep4YljGHDTFJimIHUb0JqutZow=', '2025-12-01 09:10:12.763213', 1, 'Super', 'User', 1, 1, '2025-12-01 08:21:10', 'superuser@nuam.com'),
(10, 'pbkdf2_sha256$600000$d6Z3qOFvh5FnOUU3UqMmyF$FxHny4HFoRJq0pIxRo5gshm8CRoPe8cvz+QR7RSHnIE=', '2026-07-12 16:15:58.262509', 0, 'Admin', 'Doe', 0, 1, '2025-12-01 08:54:55.605816', 'admin@nuam.com'),
(11, 'pbkdf2_sha256$1000000$wGHVjTK3pJKIse8untiViI$P0ByaJ/3WPyLsObwgAbIbbiHDdxITQWz4pOYZVsnpj4=', '2025-12-01 10:02:36.628189', 0, 'Auditor', 'Doe', 0, 1, '2025-12-01 08:55:12.114170', 'auditor@nuam.com'),
(12, 'pbkdf2_sha256$1000000$1dK7hqKUsmy3gVvu6H5gTF$4PvVj5c6D5+p8ubLEt5V9CnawiRaixCmfruwpG29H7M=', '2025-12-01 09:59:50.934637', 0, 'Corredor', 'Doe', 0, 1, '2025-12-01 08:55:35.700550', 'corredor@nuam.com'),
(13, 'pbkdf2_sha256$1000000$rubUklbzI5varzZW2G0wel$ojaa4cNA42MLo67ew6Yjoxo5XvbUZ0/FAyR5yJh+HBE=', NULL, 0, 'Bolsa', 'Comercio Santiago', 0, 1, '2025-12-01 08:59:30.477192', 'bcs@nuam.com'),
(14, 'pbkdf2_sha256$1000000$2ou3fxtUjxQeKyR7uh3fId$7eU2JJ+19W5C21nUSn+DE7TWltB1tt3b5EVczVL/Je0=', NULL, 0, 'Bolsa', 'Valores Lima', 0, 1, '2025-12-01 08:59:47.313347', 'bvl@nuam.com'),
(15, 'pbkdf2_sha256$1000000$PMhigRh0PeSOyHBkKbuMYt$qKfh8muQ4naFoEfjZn/8OkzetseLzMag9UGTz372urs=', NULL, 0, 'Bolsa', 'Valores Colombia', 0, 1, '2025-12-01 09:00:05.090741', 'bvc@nuam.com'),
(16, 'pbkdf2_sha256$1000000$qQeA7iPPqe2ia04vvDF4rS$3GBgZIdDyuB7PVrlGrM0Lxhi2Nr84cZP3A0rcDZol48=', NULL, 0, 'Bolsa', 'Valores', 0, 1, '2025-12-01 09:00:19.154876', 'bolsa@nuam.com'),
(17, 'pbkdf2_sha256$600000$IE9RXEb90cuaQCbxrwJcI6$7h+Uzvw+XARBP0zFKG8k9d8x52MIjFuQ3M9lHI6leJk=', '2026-07-12 15:21:02.152280', 0, 'Jadeth', 'Morales', 0, 1, '2026-07-12 15:03:01.531972', 'jadeth.morales@nuam.com');

-- Table structure for table `Intranet_user_groups`
DROP TABLE IF EXISTS `Intranet_user_groups`;
CREATE TABLE `Intranet_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Intranet_user_groups_user_id_group_id_89ebf548_uniq` (`user_id`,`group_id`),
  KEY `Intranet_user_groups_group_id_23c3b620_fk_auth_group_id` (`group_id`),
  CONSTRAINT `Intranet_user_groups_group_id_23c3b620_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Intranet_user_groups_user_id_3e881222_fk_Intranet_user_id` FOREIGN KEY (`user_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `Intranet_user_groups`
INSERT INTO `Intranet_user_groups` (`id`, `user_id`, `group_id`) VALUES 
(1, 1, 1),
(10, 10, 1),
(11, 11, 2),
(12, 12, 3),
(13, 13, 4),
(14, 14, 4),
(15, 15, 4),
(16, 16, 4),
(17, 17, 5);

-- Table structure for table `Intranet_user_user_permissions`
DROP TABLE IF EXISTS `Intranet_user_user_permissions`;
CREATE TABLE `Intranet_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Intranet_user_user_permi_user_id_permission_id_8d2bc6ed_uniq` (`user_id`,`permission_id`),
  KEY `Intranet_user_user_p_permission_id_de1b018a_fk_auth_perm` (`permission_id`),
  CONSTRAINT `Intranet_user_user_p_permission_id_de1b018a_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `Intranet_user_user_p_user_id_85bc83e0_fk_Intranet_` FOREIGN KEY (`user_id`) REFERENCES `Intranet_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `auth_group`
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `auth_group`
INSERT INTO `auth_group` (`id`, `name`) VALUES 
(1, 'Administrador'),
(2, 'Auditor'),
(4, 'Bolsa'),
(5, 'Cliente'),
(3, 'Corredor');

-- Table structure for table `auth_group_permissions`
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(66, 5, 28),
(68, 5, 36),
(67, 5, 40),
(64, 5, 45),
(65, 5, 48);

-- Table structure for table `auth_permission`
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- Table structure for table `django_admin_log`
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_Intranet_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Intranet_user_id` FOREIGN KEY (`user_id`) REFERENCES `Intranet_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table structure for table `django_content_type`
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `django_content_type`
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES 
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(13, 'Intranet', 'auditoria'),
(8, 'Intranet', 'califica'),
(6, 'Intranet', 'calificacion_tributaria'),
(9, 'Intranet', 'categoria_factor'),
(14, 'Intranet', 'chat_privado'),
(10, 'Intranet', 'factor_calificacion'),
(7, 'Intranet', 'instrumento_financiero'),
(15, 'Intranet', 'mensaje_privado'),
(16, 'Intranet', 'notification'),
(12, 'Intranet', 'solicitud'),
(11, 'Intranet', 'user'),
(5, 'sessions', 'session');

-- Table structure for table `django_migrations`
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `django_migrations`
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES 
(1, 'contenttypes', '0001_initial', '2026-07-12 23:18:45.022570'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-07-12 23:18:45.164042'),
(3, 'auth', '0001_initial', '2026-07-12 23:18:45.296774'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-07-12 23:18:45.430805'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-07-12 23:18:45.565451'),
(6, 'auth', '0004_alter_user_username_opts', '2026-07-12 23:18:45.700233'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-07-12 23:18:45.834996'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-07-12 23:18:45.968354'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-07-12 23:18:46.102194'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-07-12 23:18:46.236129'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-07-12 23:18:46.368882'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-07-12 23:18:46.507136'),
(13, 'auth', '0011_update_proxy_permissions', '2026-07-12 23:18:46.637774'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-07-12 23:18:46.772165'),
(15, 'Intranet', '0001_initial', '2026-07-12 23:18:46.907118'),
(16, 'Intranet', '0002_auditoria_chat_privado_mensaje_privado_notification', '2026-07-12 23:18:47.041695'),
(17, 'Intranet', '0003_calificacion_tributaria_cliente_and_more', '2026-07-12 23:18:47.173863'),
(18, 'admin', '0001_initial', '2026-07-12 23:18:47.306535'),
(19, 'admin', '0002_logentry_remove_auto_add', '2026-07-12 23:18:47.439127'),
(20, 'admin', '0003_logentry_add_action_flag_choices', '2026-07-12 23:18:47.571471'),
(21, 'sessions', '0001_initial', '2026-07-12 23:18:47.717398');

-- Table structure for table `django_session`
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `django_session`
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES 
('yt6vg0xhnjk91rqwcx9wbho771ss4ri3', '.eJxVjMsOwiAUBf-FtSHQAAGX7v0Gch9cqRpISrsy_rs26UK3Z2bOS2XY1pq3UZY8szora9Tpd0SgR2k74Tu0W9fU27rMqHdFH3Toa-fyvBzu30GFUb-12ITsmNDFhJ4nb6KY5ASBU0QpaJ0xEnyiIMWFCcQGEvAQCMWSqPcHLjo5hw:1wiwqV:UzyjYpXVgtAr0eVtAW3yzXyXbgXh797mcvVgxZQlItw', '2026-07-26 16:15:59.895755');

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;