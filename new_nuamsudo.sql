-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2025 at 10:10 AM
-- Server version: 11.8.3-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nuamdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Administrador'),
(2, 'Auditor'),
(4, 'Bolsa'),
(3, 'Corredor');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_group_permissions`
--

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
(37, 2, 22),
(38, 2, 24),
(39, 2, 25),
(40, 2, 26),
(41, 2, 27),
(42, 2, 28),
(29, 2, 32),
(30, 2, 36),
(31, 2, 40),
(32, 2, 44),
(33, 2, 45),
(34, 2, 46),
(35, 2, 47),
(36, 2, 48),
(48, 3, 21),
(49, 3, 22),
(50, 3, 23),
(51, 3, 24),
(52, 3, 25),
(43, 3, 32),
(44, 3, 36),
(45, 3, 40),
(46, 3, 45),
(47, 3, 48),
(57, 4, 21),
(58, 4, 22),
(59, 4, 25),
(60, 4, 26),
(61, 4, 29),
(62, 4, 30),
(53, 4, 33),
(54, 4, 34),
(55, 4, 37),
(56, 4, 38);

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

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
(48, 'Can view solicitud', 12, 'view_solicitud');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-12-01 08:22:15.482901', '1', 'Administrador', 1, '[{\"added\": {}}]', 3, 1),
(2, '2025-12-01 08:23:29.612287', '2', 'Auditor', 1, '[{\"added\": {}}]', 3, 1),
(3, '2025-12-01 08:24:47.665242', '3', 'Corredor', 1, '[{\"added\": {}}]', 3, 1),
(4, '2025-12-01 08:25:29.586714', '4', 'Bolsa', 1, '[{\"added\": {}}]', 3, 1),
(5, '2025-12-01 08:28:28.928687', '1', 'superuser@nuam.com', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Groups\"]}}]', 11, 1),
(6, '2025-12-01 08:49:52.583148', '2', 'admin@nuam.com', 3, '', 11, 1),
(7, '2025-12-01 08:49:52.583183', '3', 'auditor@nuam.com', 3, '', 11, 1),
(8, '2025-12-01 08:49:52.583201', '5', 'BCS@nuam.com', 3, '', 11, 1),
(9, '2025-12-01 08:49:52.583215', '8', 'bolsa@nuam.com', 3, '', 11, 1),
(10, '2025-12-01 08:49:52.583229', '7', 'BVC@nuam.com', 3, '', 11, 1),
(11, '2025-12-01 08:49:52.583241', '6', 'BVL@nuam.com', 3, '', 11, 1),
(12, '2025-12-01 08:49:52.583253', '4', 'corredor@nuam.com', 3, '', 11, 1),
(13, '2025-12-01 08:51:48.915163', '9', 'admin@nuam.com', 3, '', 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(8, 'Intranet', 'califica'),
(6, 'Intranet', 'calificacion_tributaria'),
(9, 'Intranet', 'categoria_factor'),
(10, 'Intranet', 'factor_calificacion'),
(7, 'Intranet', 'instrumento_financiero'),
(12, 'Intranet', 'solicitud'),
(11, 'Intranet', 'user'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-12-01 08:17:07.908744'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-12-01 08:17:09.196048'),
(3, 'auth', '0001_initial', '2025-12-01 08:17:13.011677'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-12-01 08:17:14.054017'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-12-01 08:17:14.122611'),
(6, 'auth', '0004_alter_user_username_opts', '2025-12-01 08:17:14.174213'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-12-01 08:17:14.230523'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-12-01 08:17:14.274971'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-12-01 08:17:14.311300'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-12-01 08:17:14.361909'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-12-01 08:17:14.422347'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-12-01 08:17:14.939747'),
(13, 'auth', '0011_update_proxy_permissions', '2025-12-01 08:17:14.977881'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-12-01 08:17:15.019935'),
(15, 'Intranet', '0001_initial', '2025-12-01 08:17:29.507506'),
(16, 'admin', '0001_initial', '2025-12-01 08:17:31.585900'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-12-01 08:17:31.623304'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-01 08:17:31.665326'),
(19, 'sessions', '0001_initial', '2025-12-01 08:17:32.464430');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('bwt46fx2sp2qftfuxyw252kocp3huqaf', '.eJxVjDsOwjAQBe_iGlneXX9iSnrOYK29NgmgRMqnQtwdIqWA9s3Me6nE29qnbalzGkSdFajT75a5POq4A7nzeJt0mcZ1HrLeFX3QRV8nqc_L4f4d9Lz037p0BaypFAOKYGjWuQCG0UHMENBiy8wILUrsPHGgjALekrcmOPKk3h_A-jZ4:1vPzvA:uh8IdwIrfcI-rL2xHmdGVLPMCpP2n-KmojOPcReoOPc', '2025-12-15 09:10:12.790910');

-- --------------------------------------------------------

--
-- Table structure for table `intranet_califica`
--

CREATE TABLE `intranet_califica` (
  `id` bigint(20) NOT NULL,
  `valor` double NOT NULL,
  `calificacion_id` bigint(20) NOT NULL,
  `factor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intranet_calificacion_tributaria`
--

CREATE TABLE `intranet_calificacion_tributaria` (
  `secuencia_evento` bigint(20) NOT NULL,
  `mercado` varchar(50) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `fecha_pago` date NOT NULL,
  `dividendo` int(11) DEFAULT NULL,
  `valor_historico` bigint(20) DEFAULT NULL,
  `anio` int(11) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `origen_calificacion` varchar(20) NOT NULL,
  `isfut` tinyint(1) NOT NULL,
  `factor_actualizacion` decimal(10,6) NOT NULL,
  `evento_capital` int(11) DEFAULT NULL,
  `instrumento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intranet_categoria_factor`
--

CREATE TABLE `intranet_categoria_factor` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `padre_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `intranet_categoria_factor`
--

INSERT INTO `intranet_categoria_factor` (`id`, `nombre`, `padre_id`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `intranet_factor_calificacion`
--

CREATE TABLE `intranet_factor_calificacion` (
  `factor_id` int(11) NOT NULL,
  `nombre_factor` varchar(120) NOT NULL,
  `categoria_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `intranet_factor_calificacion`
--

INSERT INTO `intranet_factor_calificacion` (`factor_id`, `nombre_factor`, `categoria_id`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `intranet_instrumento_financiero`
--

CREATE TABLE `intranet_instrumento_financiero` (
  `instrumento_id` int(11) NOT NULL,
  `codigo` varchar(6) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `bolsa` varchar(30) NOT NULL,
  `mercado` varchar(50) NOT NULL,
  `estado` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `intranet_instrumento_financiero`
--

INSERT INTO `intranet_instrumento_financiero` (`instrumento_id`, `codigo`, `descripcion`, `categoria`, `bolsa`, `mercado`, `estado`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `intranet_solicitud`
--

CREATE TABLE `intranet_solicitud` (
  `solicitud_id` int(11) NOT NULL,
  `motivo` longtext NOT NULL,
  `fecha` date DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intranet_user`
--

CREATE TABLE `intranet_user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `intranet_user`
--

INSERT INTO `intranet_user` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`) VALUES
(1, 'pbkdf2_sha256$1000000$i8LhXJDBLc5YQGa5E4YLsV$yai5huDhI7JPC6jw/Ep4YljGHDTFJimIHUb0JqutZow=', '2025-12-01 09:10:12.763213', 1, 'Super', 'User', 1, 1, '2025-12-01 08:21:10.000000', 'superuser@nuam.com'),
(10, 'pbkdf2_sha256$1000000$kZjmsKAkZmv2Y6rNiuzIIf$jDtd76wjXYKWn8fCf/6MIYGavCmo2xZVznOuKXEmxho=', '2025-12-01 09:10:03.876233', 0, 'Admin', 'Doe', 0, 1, '2025-12-01 08:54:55.605816', 'admin@nuam.com'),
(11, 'pbkdf2_sha256$1000000$wGHVjTK3pJKIse8untiViI$P0ByaJ/3WPyLsObwgAbIbbiHDdxITQWz4pOYZVsnpj4=', NULL, 0, 'Auditor', 'Doe', 0, 1, '2025-12-01 08:55:12.114170', 'auditor@nuam.com'),
(12, 'pbkdf2_sha256$1000000$1dK7hqKUsmy3gVvu6H5gTF$4PvVj5c6D5+p8ubLEt5V9CnawiRaixCmfruwpG29H7M=', NULL, 0, 'Corredor', 'Doe', 0, 1, '2025-12-01 08:55:35.700550', 'corredor@nuam.com'),
(13, 'pbkdf2_sha256$1000000$rubUklbzI5varzZW2G0wel$ojaa4cNA42MLo67ew6Yjoxo5XvbUZ0/FAyR5yJh+HBE=', NULL, 0, 'Bolsa', 'Comercio Santiago', 0, 1, '2025-12-01 08:59:30.477192', 'bcs@nuam.com'),
(14, 'pbkdf2_sha256$1000000$2ou3fxtUjxQeKyR7uh3fId$7eU2JJ+19W5C21nUSn+DE7TWltB1tt3b5EVczVL/Je0=', NULL, 0, 'Bolsa', 'Valores Lima', 0, 1, '2025-12-01 08:59:47.313347', 'bvl@nuam.com'),
(15, 'pbkdf2_sha256$1000000$PMhigRh0PeSOyHBkKbuMYt$qKfh8muQ4naFoEfjZn/8OkzetseLzMag9UGTz372urs=', NULL, 0, 'Bolsa', 'Valores Colombia', 0, 1, '2025-12-01 09:00:05.090741', 'bvc@nuam.com'),
(16, 'pbkdf2_sha256$1000000$qQeA7iPPqe2ia04vvDF4rS$3GBgZIdDyuB7PVrlGrM0Lxhi2Nr84cZP3A0rcDZol48=', NULL, 0, 'Bolsa', 'Valores', 0, 1, '2025-12-01 09:00:19.154876', 'bolsa@nuam.com');

-- --------------------------------------------------------

--
-- Table structure for table `intranet_user_groups`
--

CREATE TABLE `intranet_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `intranet_user_groups`
--

INSERT INTO `intranet_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(10, 10, 1),
(11, 11, 2),
(12, 12, 3),
(13, 13, 4),
(14, 14, 4),
(15, 15, 4),
(16, 16, 4);

-- --------------------------------------------------------

--
-- Table structure for table `intranet_user_user_permissions`
--

CREATE TABLE `intranet_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_Intranet_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `intranet_califica`
--
ALTER TABLE `intranet_califica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Intranet_califica_factor_id_d90edd10_fk_Intranet_` (`factor_id`),
  ADD KEY `Intranet_califica_calificacion_id_4ede9fe8_fk_Intranet_` (`calificacion_id`);

--
-- Indexes for table `intranet_calificacion_tributaria`
--
ALTER TABLE `intranet_calificacion_tributaria`
  ADD PRIMARY KEY (`secuencia_evento`),
  ADD KEY `Intranet_calificacio_instrumento_id_868bd9cb_fk_Intranet_` (`instrumento_id`);

--
-- Indexes for table `intranet_categoria_factor`
--
ALTER TABLE `intranet_categoria_factor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Intranet_categoria_f_padre_id_2d6b5feb_fk_Intranet_` (`padre_id`);

--
-- Indexes for table `intranet_factor_calificacion`
--
ALTER TABLE `intranet_factor_calificacion`
  ADD PRIMARY KEY (`factor_id`),
  ADD KEY `Intranet_factor_cali_categoria_id_f1d76899_fk_Intranet_` (`categoria_id`);

--
-- Indexes for table `intranet_instrumento_financiero`
--
ALTER TABLE `intranet_instrumento_financiero`
  ADD PRIMARY KEY (`instrumento_id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indexes for table `intranet_solicitud`
--
ALTER TABLE `intranet_solicitud`
  ADD PRIMARY KEY (`solicitud_id`),
  ADD KEY `Intranet_solicitud_group_id_eb4f1179_fk_auth_group_id` (`group_id`),
  ADD KEY `Intranet_solicitud_usuario_id_72a2a0c5_fk_Intranet_user_id` (`usuario_id`);

--
-- Indexes for table `intranet_user`
--
ALTER TABLE `intranet_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `intranet_user_groups`
--
ALTER TABLE `intranet_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Intranet_user_groups_user_id_group_id_89ebf548_uniq` (`user_id`,`group_id`),
  ADD KEY `Intranet_user_groups_group_id_23c3b620_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `intranet_user_user_permissions`
--
ALTER TABLE `intranet_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Intranet_user_user_permi_user_id_permission_id_8d2bc6ed_uniq` (`user_id`,`permission_id`),
  ADD KEY `Intranet_user_user_p_permission_id_de1b018a_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `intranet_califica`
--
ALTER TABLE `intranet_califica`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `intranet_categoria_factor`
--
ALTER TABLE `intranet_categoria_factor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `intranet_factor_calificacion`
--
ALTER TABLE `intranet_factor_calificacion`
  MODIFY `factor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `intranet_instrumento_financiero`
--
ALTER TABLE `intranet_instrumento_financiero`
  MODIFY `instrumento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `intranet_solicitud`
--
ALTER TABLE `intranet_solicitud`
  MODIFY `solicitud_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `intranet_user`
--
ALTER TABLE `intranet_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `intranet_user_groups`
--
ALTER TABLE `intranet_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `intranet_user_user_permissions`
--
ALTER TABLE `intranet_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Intranet_user_id` FOREIGN KEY (`user_id`) REFERENCES `intranet_user` (`id`);

--
-- Constraints for table `intranet_califica`
--
ALTER TABLE `intranet_califica`
  ADD CONSTRAINT `Intranet_califica_calificacion_id_4ede9fe8_fk_Intranet_` FOREIGN KEY (`calificacion_id`) REFERENCES `intranet_calificacion_tributaria` (`secuencia_evento`),
  ADD CONSTRAINT `Intranet_califica_factor_id_d90edd10_fk_Intranet_` FOREIGN KEY (`factor_id`) REFERENCES `intranet_factor_calificacion` (`factor_id`);

--
-- Constraints for table `intranet_calificacion_tributaria`
--
ALTER TABLE `intranet_calificacion_tributaria`
  ADD CONSTRAINT `Intranet_calificacio_instrumento_id_868bd9cb_fk_Intranet_` FOREIGN KEY (`instrumento_id`) REFERENCES `intranet_instrumento_financiero` (`instrumento_id`);

--
-- Constraints for table `intranet_categoria_factor`
--
ALTER TABLE `intranet_categoria_factor`
  ADD CONSTRAINT `Intranet_categoria_f_padre_id_2d6b5feb_fk_Intranet_` FOREIGN KEY (`padre_id`) REFERENCES `intranet_categoria_factor` (`id`);

--
-- Constraints for table `intranet_factor_calificacion`
--
ALTER TABLE `intranet_factor_calificacion`
  ADD CONSTRAINT `Intranet_factor_cali_categoria_id_f1d76899_fk_Intranet_` FOREIGN KEY (`categoria_id`) REFERENCES `intranet_categoria_factor` (`id`);

--
-- Constraints for table `intranet_solicitud`
--
ALTER TABLE `intranet_solicitud`
  ADD CONSTRAINT `Intranet_solicitud_group_id_eb4f1179_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `Intranet_solicitud_usuario_id_72a2a0c5_fk_Intranet_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `intranet_user` (`id`);

--
-- Constraints for table `intranet_user_groups`
--
ALTER TABLE `intranet_user_groups`
  ADD CONSTRAINT `Intranet_user_groups_group_id_23c3b620_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `Intranet_user_groups_user_id_3e881222_fk_Intranet_user_id` FOREIGN KEY (`user_id`) REFERENCES `intranet_user` (`id`);

--
-- Constraints for table `intranet_user_user_permissions`
--
ALTER TABLE `intranet_user_user_permissions`
  ADD CONSTRAINT `Intranet_user_user_p_permission_id_de1b018a_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `Intranet_user_user_p_user_id_85bc83e0_fk_Intranet_` FOREIGN KEY (`user_id`) REFERENCES `intranet_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
