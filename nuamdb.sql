-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2025 at 05:47 PM
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
(48, 'Can view solicitud', 12, 'view_solicitud'),
(49, 'Can add chat_privado', 13, 'add_chat_privado'),
(50, 'Can change chat_privado', 13, 'change_chat_privado'),
(51, 'Can delete chat_privado', 13, 'delete_chat_privado'),
(52, 'Can view chat_privado', 13, 'view_chat_privado'),
(53, 'Can add mensaje_privado', 14, 'add_mensaje_privado'),
(54, 'Can change mensaje_privado', 14, 'change_mensaje_privado'),
(55, 'Can delete mensaje_privado', 14, 'delete_mensaje_privado'),
(56, 'Can view mensaje_privado', 14, 'view_mensaje_privado');

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
(13, 'Intranet', 'chat_privado'),
(10, 'Intranet', 'factor_calificacion'),
(7, 'Intranet', 'instrumento_financiero'),
(14, 'Intranet', 'mensaje_privado'),
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
(19, 'sessions', '0001_initial', '2025-12-01 08:17:32.464430'),
(20, 'Intranet', '0002_chat_privado_mensaje_privado', '2025-12-01 16:44:03.295175');

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
('y8wlxdngjpge47wjqvuy0i6lylrphfly', '.eJxVjDsOgzAQRO_iOrIW_NE6ZfqcwVp7l5gkMhKGCuXuAYki0XTz3symIq1LiWuTOY6srqoDdfktE-WX1IPwk-pj0nmqyzwmfSj6pE3fJ5b37XT_Dgq1sq8NZgeuSxYp0eAcBGRGFoYAlMVYJjSGPeyxHiVbAScG-j6Q8QOpzxcHFTf2:1vQ700:dYdDED1GY0Sw41XV55eCQMZYw3uxVFuB6iJyJRr_cYw', '2025-12-15 16:43:40.759756');

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

--
-- Dumping data for table `intranet_califica`
--

INSERT INTO `intranet_califica` (`id`, `valor`, `calificacion_id`, `factor_id`) VALUES
(1, 0.174669, 6846521, 8),
(2, 0.145878, 6846521, 9),
(3, 0, 6846521, 10),
(4, 0, 6846521, 11),
(5, 0, 6846521, 12),
(6, 0, 6846521, 13),
(7, 0, 6846521, 14),
(8, 0.281169, 6846521, 15),
(9, 0.252406, 6846521, 16),
(10, 0, 6846521, 17),
(11, 0, 6846521, 18),
(12, 0.145878, 6846521, 19),
(13, 0, 6846521, 20),
(14, 0.018045, 6846521, 21),
(15, 0.145906, 6846521, 22),
(16, 0, 6846521, 23),
(17, 0.039349, 6846521, 24),
(18, 0, 6846521, 25),
(19, 0, 6846521, 26),
(20, 0, 6846521, 27),
(21, 0, 6846521, 28),
(22, 0.145878, 6846521, 29),
(23, 0, 6846521, 30),
(24, 0, 6846521, 31),
(25, 0.00739, 6846521, 32),
(26, 0, 6846521, 33),
(27, 0.014588, 6846521, 34),
(28, 0, 6846521, 35),
(29, 0, 6846521, 36),
(30, 0.001453, 6846521, 37),
(31, 0.4, 10000, 8),
(32, 0.45, 10000, 9),
(33, 0.5, 10000, 10),
(34, 0.55, 10000, 11),
(35, 0.6, 10000, 12),
(36, 0.65, 10000, 13),
(37, 0.7, 10000, 14),
(38, 0.75, 10000, 15),
(39, 0.8, 10000, 16),
(40, 0.85, 10000, 17),
(41, 0.9, 10000, 18),
(42, 0.95, 10000, 19),
(43, 0, 10000, 20),
(44, 0.05, 10000, 21),
(45, 0.1, 10000, 22),
(46, 0.15, 10000, 23),
(47, 0.2, 10000, 24),
(48, 0.25, 10000, 25),
(49, 0.3, 10000, 26),
(50, 0.35, 10000, 27),
(51, 0.4, 10000, 28),
(52, 0.45, 10000, 29),
(53, 0.5, 10000, 30),
(54, 0.55, 10000, 31),
(55, 0.6, 10000, 32),
(56, 0.65, 10000, 33),
(57, 0.7, 10000, 34),
(58, 0.75, 10000, 35),
(59, 0.8, 10000, 36),
(60, 0, 10000, 37),
(61, 0.8, 10001, 8),
(62, 0.9, 10001, 9),
(63, 1, 10001, 10),
(64, 0.05, 10001, 11),
(65, 0.1, 10001, 12),
(66, 0.15, 10001, 13),
(67, 0.2, 10001, 14),
(68, 0.25, 10001, 15),
(69, 0.3, 10001, 16),
(70, 0.35, 10001, 17),
(71, 0.4, 10001, 18),
(72, 0.45, 10001, 19),
(73, 0.5, 10001, 20),
(74, 0.55, 10001, 21),
(75, 0.6, 10001, 22),
(76, 0.65, 10001, 23),
(77, 0.7, 10001, 24),
(78, 0.75, 10001, 25),
(79, 0.8, 10001, 26),
(80, 0.85, 10001, 27),
(81, 0.9, 10001, 28),
(82, 0.95, 10001, 29),
(83, 0, 10001, 30),
(84, 0.05, 10001, 31),
(85, 0.1, 10001, 32),
(86, 0.15, 10001, 33),
(87, 0.2, 10001, 34),
(88, 0.25, 10001, 35),
(89, 0.3, 10001, 36),
(90, 0, 10001, 37),
(91, 0.2, 10002, 8),
(92, 0.25, 10002, 9),
(93, 0.3, 10002, 10),
(94, 0.35, 10002, 11),
(95, 0.4, 10002, 12),
(96, 0.45, 10002, 13),
(97, 0.5, 10002, 14),
(98, 0.55, 10002, 15),
(99, 0.6, 10002, 16),
(100, 0.65, 10002, 17),
(101, 0.7, 10002, 18),
(102, 0.75, 10002, 19),
(103, 0.8, 10002, 20),
(104, 0.85, 10002, 21),
(105, 0.9, 10002, 22),
(106, 0.95, 10002, 23),
(107, 0, 10002, 24),
(108, 0.05, 10002, 25),
(109, 0.1, 10002, 26),
(110, 0.15, 10002, 27),
(111, 0.2, 10002, 28),
(112, 0.25, 10002, 29),
(113, 0.3, 10002, 30),
(114, 0.35, 10002, 31),
(115, 0.4, 10002, 32),
(116, 0.45, 10002, 33),
(117, 0.5, 10002, 34),
(118, 0.55, 10002, 35),
(119, 0.6, 10002, 36),
(120, 0, 10002, 37),
(121, 0.6, 10003, 8),
(122, 0.65, 10003, 9),
(123, 0.7, 10003, 10),
(124, 0.75, 10003, 11),
(125, 0.8, 10003, 12),
(126, 0.85, 10003, 13),
(127, 0.9, 10003, 14),
(128, 0.95, 10003, 15),
(129, 0, 10003, 16),
(130, 0.05, 10003, 17),
(131, 0.1, 10003, 18),
(132, 0.15, 10003, 19),
(133, 0.2, 10003, 20),
(134, 0.25, 10003, 21),
(135, 0.3, 10003, 22),
(136, 0.35, 10003, 23),
(137, 0.4, 10003, 24),
(138, 0.45, 10003, 25),
(139, 0.5, 10003, 26),
(140, 0.55, 10003, 27),
(141, 0.6, 10003, 28),
(142, 0.65, 10003, 29),
(143, 0.7, 10003, 30),
(144, 0.75, 10003, 31),
(145, 0.8, 10003, 32),
(146, 0.85, 10003, 33),
(147, 0.9, 10003, 34),
(148, 0.95, 10003, 35),
(149, 0, 10003, 36),
(150, 0, 10003, 37),
(151, 0, 10004, 8),
(152, 0.05, 10004, 9),
(153, 0.1, 10004, 10),
(154, 0.15, 10004, 11),
(155, 0.2, 10004, 12),
(156, 0.25, 10004, 13),
(157, 0.3, 10004, 14),
(158, 0.35, 10004, 15),
(159, 0.4, 10004, 16),
(160, 0.45, 10004, 17),
(161, 0.5, 10004, 18),
(162, 0.55, 10004, 19),
(163, 0.6, 10004, 20),
(164, 0.65, 10004, 21),
(165, 0.7, 10004, 22),
(166, 0.75, 10004, 23),
(167, 0.8, 10004, 24),
(168, 0.85, 10004, 25),
(169, 0.9, 10004, 26),
(170, 0.95, 10004, 27),
(171, 0, 10004, 28),
(172, 0.05, 10004, 29),
(173, 0.1, 10004, 30),
(174, 0.15, 10004, 31),
(175, 0.2, 10004, 32),
(176, 0.25, 10004, 33),
(177, 0.3, 10004, 34),
(178, 0.35, 10004, 35),
(179, 0.4, 10004, 36),
(180, 0, 10004, 37);

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

--
-- Dumping data for table `intranet_calificacion_tributaria`
--

INSERT INTO `intranet_calificacion_tributaria` (`secuencia_evento`, `mercado`, `descripcion`, `fecha_pago`, `dividendo`, `valor_historico`, `anio`, `estado`, `origen_calificacion`, `isfut`, `factor_actualizacion`, `evento_capital`, `instrumento_id`) VALUES
(10000, 'MERCADO INTERNACIONAL', 'Descripcion prueba 1', '2024-01-15', 100, 1000, 2024, 'PENDIENTE', 'SISTEMA', 1, 0.000000, NULL, 1),
(10001, 'MERCADO MONETARIO', 'Descripcion prueba 2', '2024-02-15', 110, 1200, 2024, 'PENDIENTE', 'SISTEMA', 0, 0.000000, NULL, 2),
(10002, 'FONDOS DE INVERSIÓN-MUTUOS', 'Descripcion prueba 3', '2024-03-15', 120, 1400, 2024, 'PENDIENTE', 'SISTEMA', 0, 0.000000, NULL, 3),
(10003, 'FONDOS DE INVERSIÓN-MUTUOS', 'Descripcion prueba 4', '2024-04-15', 130, 1600, 2024, 'PENDIENTE', 'SISTEMA', 0, 0.000000, NULL, 4),
(10004, 'ACCIONES', 'Descripcion prueba 5', '2024-05-15', 140, 1800, 2024, 'PENDIENTE', 'SISTEMA', 1, 0.000000, NULL, 6),
(6846521, 'FONDOS DE INVERSIÓN-MUTUOS', 'fdgsdfg', '2025-12-18', 1, 6546, 2023, 'PENDIENTE', 'SISTEMA', 1, 0.000000, NULL, 5);

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
(10, 'pbkdf2_sha256$1000000$kZjmsKAkZmv2Y6rNiuzIIf$jDtd76wjXYKWn8fCf/6MIYGavCmo2xZVznOuKXEmxho=', '2025-12-01 16:43:40.724062', 0, 'Admin', 'Doe', 0, 1, '2025-12-01 08:54:55.605816', 'admin@nuam.com'),
(11, 'pbkdf2_sha256$1000000$wGHVjTK3pJKIse8untiViI$P0ByaJ/3WPyLsObwgAbIbbiHDdxITQWz4pOYZVsnpj4=', '2025-12-01 10:02:36.628189', 0, 'Auditor', 'Doe', 0, 1, '2025-12-01 08:55:12.114170', 'auditor@nuam.com'),
(12, 'pbkdf2_sha256$1000000$1dK7hqKUsmy3gVvu6H5gTF$4PvVj5c6D5+p8ubLEt5V9CnawiRaixCmfruwpG29H7M=', '2025-12-01 09:59:50.934637', 0, 'Corredor', 'Doe', 0, 1, '2025-12-01 08:55:35.700550', 'corredor@nuam.com'),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `intranet_califica`
--
ALTER TABLE `intranet_califica`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `intranet_user_groups`
--
ALTER TABLE `intranet_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
