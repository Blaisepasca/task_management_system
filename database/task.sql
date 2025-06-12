-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2025 at 05:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `task`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `created_at`, `updated_at`) VALUES
(1, 'New Department created.', 'New Department NGO created.', 'App\\Models\\Department', 5, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Department\",\"data\":\"\"}', '2025-05-03 00:19:43', '2025-05-03 00:19:43'),
(2, 'New Department created.', 'New Department Government created.', 'App\\Models\\Department', 6, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Department\",\"data\":\"\"}', '2025-05-03 00:19:56', '2025-05-03 00:19:56'),
(3, 'New Department created.', 'New Department Private created.', 'App\\Models\\Department', 7, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Department\",\"data\":\"\"}', '2025-05-03 00:20:12', '2025-05-03 00:20:12'),
(4, 'New Client created.', 'New Client Plan created.', 'App\\Models\\Client', 1, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Client\",\"data\":\"\"}', '2025-05-03 00:20:50', '2025-05-03 00:20:50'),
(5, 'Project Assign To User', 'Assigned Softaware to System Admin', 'App\\Models\\Project', 1, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\"\"}', '2025-05-03 00:28:51', '2025-05-03 00:28:51'),
(6, 'Project Created', 'Created project', 'App\\Models\\Project', 1, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\" Softaware\"}', '2025-05-03 00:28:51', '2025-05-03 00:28:51'),
(7, 'Project Assign To User', 'Assigned Kugura ibikoresho to System Admin', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\"\"}', '2025-05-03 00:30:13', '2025-05-03 00:30:13'),
(8, 'Project Created', 'Created project', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\" Kugura ibikoresho\"}', '2025-05-03 00:30:13', '2025-05-03 00:30:13'),
(9, 'Project Assignee Updated', 'Assigned Kugura ibikoresho to SAFI Normand Arnauld', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\"\"}', '2025-05-03 00:40:02', '2025-05-03 00:40:02'),
(10, 'Task Created', 'Created new task Procurement', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-03 00:40:31', '2025-05-03 00:40:31'),
(11, 'Task Created', 'Created new task Market review', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-03 00:52:18', '2025-05-03 00:52:18'),
(12, 'Task Created', 'Created new task Research', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-03 01:04:33', '2025-05-03 01:04:33'),
(13, 'Task Created', 'Created new task Test task', 'App\\Models\\Project', 2, 'App\\Models\\User', 2, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-03 01:18:05', '2025-05-03 01:18:05'),
(14, 'Task Created', 'Created new task task test', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-05 05:38:57', '2025-05-05 05:38:57'),
(15, 'Task Created', 'Created new task New task test', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-05 05:43:02', '2025-05-05 05:43:02'),
(16, 'Project Assign To User', 'Assigned Kubaka to SAFI Normand Arnauld', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\"\"}', '2025-05-08 09:19:07', '2025-05-08 09:19:07'),
(17, 'Project Created', 'Created project', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\" Kubaka\"}', '2025-05-08 09:19:07', '2025-05-08 09:19:07'),
(18, 'Task Created', 'Created new task try', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kubaka\"}', '2025-05-08 09:20:15', '2025-05-08 09:20:15'),
(19, 'Project Assignee Updated', 'Assigned Kubaka to System Admin', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Project\",\"data\":\"\"}', '2025-05-08 09:25:51', '2025-05-08 09:25:51'),
(20, 'Task Created', 'Created new task try again', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Task\",\"data\":\"of Kubaka\"}', '2025-05-08 09:28:02', '2025-05-08 09:28:02'),
(21, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 08:50:38', '2025-05-18 08:50:38'),
(22, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 08:50:38', '2025-05-18 08:50:38'),
(23, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(24, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(25, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:15:54', '2025-05-18 10:15:54'),
(26, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 10:15:54', '2025-05-18 10:15:54'),
(27, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:18:51', '2025-05-18 10:18:51'),
(28, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 10:18:51', '2025-05-18 10:18:51'),
(29, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:19:26', '2025-05-18 10:19:26'),
(30, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 10:19:26', '2025-05-18 10:19:26'),
(31, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:19:26', '2025-05-18 10:19:26'),
(32, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 10:19:26', '2025-05-18 10:19:26'),
(33, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:44:51', '2025-05-18 10:44:51'),
(34, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 10:44:51', '2025-05-18 10:44:51'),
(35, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:49:19', '2025-05-18 10:49:19'),
(36, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 10:49:19', '2025-05-18 10:49:19'),
(37, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 10:54:23', '2025-05-18 10:54:23'),
(38, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 10:54:23', '2025-05-18 10:54:23'),
(39, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:03:56', '2025-05-18 11:03:56'),
(40, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:03:56', '2025-05-18 11:03:56'),
(41, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:07:34', '2025-05-18 11:07:34'),
(42, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:07:34', '2025-05-18 11:07:34'),
(43, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:17:02', '2025-05-18 11:17:02'),
(44, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:17:02', '2025-05-18 11:17:02'),
(45, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:17:03', '2025-05-18 11:17:03'),
(46, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 11:17:03', '2025-05-18 11:17:03'),
(47, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:18:12', '2025-05-18 11:18:12'),
(48, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:18:12', '2025-05-18 11:18:12'),
(49, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:20:38', '2025-05-18 11:20:38'),
(50, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:20:38', '2025-05-18 11:20:38'),
(51, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:21:38', '2025-05-18 11:21:38'),
(52, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:21:38', '2025-05-18 11:21:38'),
(53, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:25:01', '2025-05-18 11:25:01'),
(54, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:25:01', '2025-05-18 11:25:01'),
(55, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:25:01', '2025-05-18 11:25:01'),
(56, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 11:25:01', '2025-05-18 11:25:01'),
(57, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:27:06', '2025-05-18 11:27:06'),
(58, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:27:06', '2025-05-18 11:27:06'),
(59, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:29:35', '2025-05-18 11:29:35'),
(60, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:29:35', '2025-05-18 11:29:35'),
(61, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:31:21', '2025-05-18 11:31:21'),
(62, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:31:21', '2025-05-18 11:31:21'),
(63, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:31:44', '2025-05-18 11:31:44'),
(64, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:31:44', '2025-05-18 11:31:44'),
(65, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:31:45', '2025-05-18 11:31:45'),
(66, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 11:31:45', '2025-05-18 11:31:45'),
(67, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(68, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(69, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(70, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(71, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(72, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(73, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(74, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(75, 'Report Created', 'Created project report', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(76, 'Report Created', 'Created project report', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Report\",\"data\":\"of Kubaka\"}', '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(77, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 2, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kugura ibikoresho\"}', '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(78, 'Invoice Created', 'Created project invoice', 'App\\Models\\Project', 3, 'App\\Models\\User', 1, '{\"modal\":\"App\\\\Models\\\\Invoice\",\"data\":\"of Kubaka\"}', '2025-05-18 11:49:08', '2025-05-18 11:49:08');

-- --------------------------------------------------------

--
-- Table structure for table `activity_types`
--

CREATE TABLE `activity_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_types`
--

INSERT INTO `activity_types` (`id`, `name`, `created_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Development', NULL, NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35', NULL),
(2, 'Management', NULL, NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35', NULL),
(3, 'Code Review', NULL, NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35', NULL),
(4, 'Testing', NULL, NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35', NULL),
(5, 'Documentation', NULL, NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `name`, `email`, `website`, `created_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`, `department_id`, `user_id`) VALUES
(1, 'Plan', '', '', 1, NULL, '2025-05-03 00:20:50', '2025-05-03 00:20:50', NULL, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `comment` text NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `comment`, `task_id`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '<p>hello, how far is the task?<br></p>', 1, 1, '2025-05-03 00:41:10', '2025-05-03 00:41:10', NULL),
(2, '<p>Working on it</p>', 2, 2, '2025-05-03 00:58:24', '2025-05-03 00:58:24', NULL),
(3, '<p>this can\'t be done</p>', 4, 2, '2025-05-04 18:46:17', '2025-05-04 18:46:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(170) NOT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `color`, `created_at`, `updated_at`, `deleted_at`) VALUES
(5, 'NGO', NULL, '#3F51B5', '2025-05-03 00:19:43', '2025-05-03 00:19:43', NULL),
(6, 'Government', NULL, '#D72525', '2025-05-03 00:19:56', '2025-05-03 00:19:56', NULL),
(7, 'Private', NULL, '#3F51B5', '2025-05-03 00:20:12', '2025-05-03 00:20:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `type` bigint(20) UNSIGNED DEFAULT NULL,
  `added_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `amount` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `category` int(11) NOT NULL DEFAULT 1,
  `billable` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `invoice_number` varchar(255) NOT NULL,
  `issue_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `total_hour` varchar(255) NOT NULL,
  `discount` double DEFAULT NULL,
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL,
  `amount` double NOT NULL,
  `sub_total` double NOT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `discount_type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `name`, `invoice_number`, `issue_date`, `due_date`, `total_hour`, `discount`, `tax_id`, `status`, `amount`, `sub_total`, `notes`, `created_by`, `created_at`, `updated_at`, `deleted_at`, `discount_type`) VALUES
(1, 'May report 2025-05-01 00:00:00 - 2025-05-18 00:00:00', 'MHGTVL', '2025-05-18', NULL, '2025-05-18 12:19:26', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 10:19:26', '2025-05-18 11:47:10', '2025-05-18 11:47:10', 0),
(2, 'May report 2025-05-01 00:00:00 - 2025-05-18 00:00:00', 'GFKUWR', '2025-05-18', NULL, '15 hr 57 min', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 11:17:03', '2025-05-18 11:47:43', '2025-05-18 11:47:43', 0),
(3, 'May report 2025-05-01 00:00:00 - 2025-05-18 00:00:00', 'QFPMAH', '2025-05-18', NULL, '15 hr 57 min', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 11:25:01', '2025-05-18 11:48:04', '2025-05-18 11:48:04', 0),
(4, 'May report 2025-05-01 00:00:00 - 2025-05-18 00:00:00', 'WRPVOU', '2025-05-18', NULL, '15 hr 57 min', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 11:31:45', '2025-05-18 11:48:36', '2025-05-18 11:48:36', 0),
(5, 'May report 2025-05-01 00:00:00 - 2025-05-18 00:00:00', 'KNCEE8', '2025-05-18', NULL, '15 hr 57 min', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 11:33:03', '2025-05-18 11:48:44', '2025-05-18 11:48:44', 0),
(6, 'tryyy 2025-04-28 00:00:00 - 2025-05-18 00:00:00', 'JSVRRN', '2025-05-18', NULL, '15 hr 57 min', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 11:37:27', '2025-05-18 11:37:27', NULL, 0),
(7, 'May report 2025-05-01 00:00:00 - 2025-05-18 00:00:00', 'H42VJT', '2025-05-18', NULL, '15 hr 57 min', 0, NULL, 1, 0, 0, NULL, 1, '2025-05-18 11:49:08', '2025-05-18 11:49:08', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_clients`
--

CREATE TABLE `invoice_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_clients`
--

INSERT INTO `invoice_clients` (`id`, `invoice_id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 3, 1, NULL, NULL),
(4, 4, 1, NULL, NULL),
(5, 5, 1, NULL, NULL),
(6, 6, 1, NULL, NULL),
(7, 7, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` varchar(255) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `task_id` int(10) UNSIGNED DEFAULT NULL,
  `item_project_id` int(10) UNSIGNED DEFAULT NULL,
  `hours` varchar(255) NOT NULL,
  `task_amount` double DEFAULT NULL,
  `fix_rate` double DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `owner_id`, `owner_type`, `item_name`, `task_id`, `item_project_id`, `hours`, `task_amount`, `fix_rate`, `description`, `created_at`, `updated_at`) VALUES
(1, 5, 'App\\Models\\Invoice', 'Market review', 2, 2, '51 min', NULL, 0, NULL, '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(2, 5, 'App\\Models\\Invoice', 'Market review', 2, 2, '2 hr 58 min', NULL, 0, NULL, '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(3, 5, 'App\\Models\\Invoice', 'Research', 3, 2, '1 hr', NULL, 0, NULL, '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(4, 5, 'App\\Models\\Invoice', 'Test task', 4, 2, '4 hr 46 min', NULL, 0, NULL, '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(5, 5, 'App\\Models\\Invoice', 'try', 7, 3, '6 hr 22 min', NULL, 0, NULL, '2025-05-18 11:33:03', '2025-05-18 11:33:03'),
(6, 6, 'App\\Models\\Invoice', 'Market review', 2, 2, '51 min', NULL, 0, NULL, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(7, 6, 'App\\Models\\Invoice', 'Market review', 2, 2, '2 hr 58 min', NULL, 0, NULL, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(8, 6, 'App\\Models\\Invoice', 'Research', 3, 2, '1 hr', NULL, 0, NULL, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(9, 6, 'App\\Models\\Invoice', 'Test task', 4, 2, '4 hr 46 min', NULL, 0, NULL, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(10, 6, 'App\\Models\\Invoice', 'try', 7, 3, '6 hr 22 min', NULL, 0, NULL, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(11, 7, 'App\\Models\\Invoice', 'Market review', 2, 2, '51 min', NULL, 0, NULL, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(12, 7, 'App\\Models\\Invoice', 'Market review', 2, 2, '2 hr 58 min', NULL, 0, NULL, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(13, 7, 'App\\Models\\Invoice', 'Research', 3, 2, '1 hr', NULL, 0, NULL, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(14, 7, 'App\\Models\\Invoice', 'Test task', 4, 2, '4 hr 46 min', NULL, 0, NULL, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(15, 7, 'App\\Models\\Invoice', 'try', 7, 3, '6 hr 22 min', NULL, 0, NULL, '2025-05-18 11:49:08', '2025-05-18 11:49:08');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_projects`
--

CREATE TABLE `invoice_projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_projects`
--

INSERT INTO `invoice_projects` (`id`, `invoice_id`, `project_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, NULL),
(2, 1, 3, NULL, NULL),
(3, 2, 2, NULL, NULL),
(4, 2, 3, NULL, NULL),
(5, 3, 2, NULL, NULL),
(6, 3, 3, NULL, NULL),
(7, 4, 2, NULL, NULL),
(8, 4, 3, NULL, NULL),
(9, 5, 2, NULL, NULL),
(10, 5, 3, NULL, NULL),
(11, 6, 2, NULL, NULL),
(12, 6, 3, NULL, NULL),
(13, 7, 2, NULL, NULL),
(14, 7, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` text NOT NULL,
  `custom_properties` text NOT NULL,
  `responsive_images` text NOT NULL,
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `uuid` char(36) DEFAULT NULL,
  `generated_conversions` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `size`, `manipulations`, `custom_properties`, `responsive_images`, `order_column`, `created_at`, `updated_at`, `conversions_disk`, `uuid`, `generated_conversions`) VALUES
(1, 'App\\Models\\User', 1, 'users', 'Screenshot 2024-04-16 085420', 'Screenshot-2024-04-16-085420.png', 'image/png', 'public', 29489, '[]', '[]', '[]', 1, '2025-05-10 20:05:51', '2025-05-10 20:05:51', 'public', '9daf0c2d-8f7d-4049-ba83-7ce043f288f5', '[]'),
(2, 'App\\Models\\User', 2, 'users', 'Screenshot 2024-04-16 085444', 'Screenshot-2024-04-16-085444.png', 'image/png', 'public', 28862, '[]', '[]', '[]', 2, '2025-05-10 20:06:47', '2025-05-10 20:06:47', 'public', '297ae69b-cd1b-4b62-a2b2-7c53050ea301', '[]');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_05_02_101439_create_activity_types_table', 1),
(4, '2019_05_02_101619_create_clients_table', 1),
(5, '2019_05_03_043336_create_tags_table', 1),
(6, '2019_05_03_050601_create_projects_table', 1),
(7, '2019_05_03_060503_create_tasks_table', 1),
(8, '2019_05_03_072634_create_task_tags_table', 1),
(9, '2019_05_03_094616_create_time_entries_table', 1),
(10, '2019_05_22_115729_create_table_task_assignees', 1),
(11, '2019_06_11_062240_create_project_users_table', 1),
(12, '2019_06_18_093135_create_table_task_attachment', 1),
(13, '2019_06_19_045436_create_status_table', 1),
(14, '2019_06_21_124817_create_comments_table', 1),
(15, '2019_07_06_121218_create_reports_table', 1),
(16, '2019_07_08_114940_create_table_report_filters', 1),
(17, '2019_07_19_055226_populate_project_users_table', 1),
(18, '2019_08_19_000000_create_failed_jobs_table', 1),
(19, '2019_09_14_060733_create_permission_tables', 1),
(20, '2019_10_15_095114_add_salary_in_users', 1),
(21, '2020_02_19_134502_create_settings_table', 1),
(22, '2020_04_08_105133_create_departments_table', 1),
(23, '2020_04_08_115453_add_department_id_to_clients_table', 1),
(24, '2020_08_06_045725_create_taxes_table', 1),
(25, '2020_08_06_071644_create_invoices_table', 1),
(26, '2020_08_07_110611_create_invoice_items_table', 1),
(27, '2020_08_08_053928_create_media_table', 1),
(28, '2020_09_21_050626_create_report_invoices_table', 1),
(29, '2020_10_05_055541_add_discount_apply_field_to_invoice_table', 1),
(30, '2020_10_05_070445_create_invoice_projects_table', 1),
(31, '2020_10_05_070527_create_invoice_clients_table', 1),
(32, '2020_10_09_063902_add_budget_type_to_projects_table', 1),
(33, '2020_11_06_114032_add_status_feild_to_projects_table', 1),
(34, '2020_11_20_090538_add_meta_to_reports_table', 1),
(35, '2020_11_21_083148_add_calender_view_permission_to_permissions_table', 1),
(36, '2020_11_25_074504_add_group_to_setting_table', 1),
(37, '2020_12_12_092228_add_user_id_to_clients', 1),
(38, '2020_12_12_092404_add_owner_id_and_owner_type_to_users', 1),
(39, '2020_12_15_153246_add_manage_status_permission_to_permissions_table', 1),
(40, '2021_01_02_043241_remove_soft_deleted_tags_from_tags_table', 1),
(41, '2021_01_16_112850_create_expenses_table', 1),
(42, '2021_02_02_091125_change_budget_column_type_in_projects', 1),
(43, '2021_02_04_085602_remove_task_tag_entry_from_pivot_table', 1),
(44, '2021_02_12_050509_make_fields_nullable_of_projects_table', 1),
(45, '2021_02_23_051251_create_activity_log_table', 1),
(46, '2021_03_24_070000_create_notifications_table', 1),
(47, '2021_04_12_112648_create_events_table', 1),
(48, '2021_04_16_084448_add_estimate_field_to_tasks_table', 1),
(49, '2021_05_10_112220_create_user_notifications_table', 1),
(50, '2021_06_29_115255_remove_activity_log_of_users', 1),
(51, '2021_07_12_000000_add_uuid_to_failed_jobs_table', 1),
(52, '2021_07_1_103036_add_conversions_disk_column_in_media_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(170) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(170) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `first_notification_hour` varchar(255) DEFAULT NULL,
  `second_notification_hour` varchar(255) DEFAULT NULL,
  `third_notification_hour` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'manage_calendar_view', 'web', 'Manage Calendar View', '<p>Able to access Setting tab.</p>', '2021-08-05 07:19:33', '2021-08-05 07:19:33'),
(2, 'manage_status', 'web', 'Manage Status', '<p>Able to access Status tab.</p>', '2021-08-05 07:19:33', '2021-08-05 07:19:33'),
(3, 'manage_clients', 'web', 'Manage Clients', '<p>Visible clients tab and manage it.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(4, 'manage_projects', 'web', 'Manage Projects', '<p>Project tab visible and manage it.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(5, 'manage_all_tasks', 'web', 'Manage Tasks', '<p>All projects list comes into Project filter otherwise comes only related projects.Assignee Filter visible in task module otherwise own assigned and non-assigned.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(6, 'manage_time_entries', 'web', 'Manage Entry', '<p>User can manage own time entry.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(7, 'manage_users', 'web', 'Manage Users', '<p>User tab visible</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(8, 'manage_tags', 'web', 'Manage Tags', '<p>Able to access tags tab.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(9, 'manage_activities', 'web', 'Manage Activities', '<p>Able to access Activity tab.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(10, 'manage_reports', 'web', 'Manage Reports', '<p></p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(11, 'manage_roles', 'web', 'Manage Roles', '<p></p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(14, 'manage_settings', 'web', 'Manage Settings', '<p>Able to access Setting tab.</p>', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(15, 'manage_department', 'web', 'Manage Department', NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(17, 'manage_activity_log', 'web', 'Manage Activity Log', NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(18, 'manage_events', 'web', 'Manage Events', NULL, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(19, 'role_client', 'web', 'Role Client', '<p>Able to access Client Panel.</p>', '2021-08-05 07:19:35', '2021-08-05 07:19:35');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(170) NOT NULL,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `description` text NOT NULL,
  `price` bigint(20) DEFAULT NULL,
  `currency` int(11) DEFAULT NULL,
  `prefix` varchar(170) NOT NULL,
  `color` varchar(255) NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `budget_type` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `client_id`, `description`, `price`, `currency`, `prefix`, `color`, `created_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`, `budget_type`, `status`) VALUES
(1, 'Softaware', 1, '', NULL, NULL, 'SOFTAW', '#3F51B5', 1, 1, '2025-05-03 00:28:51', '2025-05-03 00:29:49', '2025-05-03 00:29:49', NULL, 1),
(2, 'Kugura ibikoresho', 1, '', NULL, NULL, 'KUGURA', '#3F51B5', 1, NULL, '2025-05-03 00:30:13', '2025-05-03 00:30:13', NULL, NULL, 1),
(3, 'Kubaka', 1, '', NULL, NULL, 'KUBAKA', '#5E1313', 1, NULL, '2025-05-08 09:19:06', '2025-05-08 09:19:06', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `project_user`
--

CREATE TABLE `project_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_user`
--

INSERT INTO `project_user` (`id`, `project_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-03 00:28:51', '2025-05-03 00:28:51'),
(2, 2, 1, '2025-05-03 00:30:13', '2025-05-03 00:30:13'),
(3, 2, 2, '2025-05-03 00:40:02', '2025-05-03 00:40:02'),
(4, 3, 2, '2025-05-08 09:19:06', '2025-05-08 09:19:06'),
(5, 3, 1, '2025-05-08 09:25:51', '2025-05-08 09:25:51');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `report_type` int(11) NOT NULL DEFAULT 1,
  `report_data` text DEFAULT NULL,
  `invoice_generate` tinyint(1) NOT NULL DEFAULT 0,
  `meta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `name`, `owner_id`, `start_date`, `end_date`, `report_type`, `report_data`, `invoice_generate`, `meta`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'try', 1, '2025-04-27', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":false,\"all_projects\":true,\"all_users\":true}', '2025-05-18 08:50:38', '2025-05-18 10:11:06', NULL),
(2, 'tryyy', 1, '2025-04-28', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 09:21:33', '2025-05-18 09:21:33', NULL),
(3, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 10:15:54', '2025-05-18 11:46:56', '2025-05-18 11:46:56'),
(4, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 10:18:51', '2025-05-18 11:47:03', '2025-05-18 11:47:03'),
(5, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 10:19:26', '2025-05-18 11:47:10', '2025-05-18 11:47:10'),
(6, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 10:44:51', '2025-05-18 11:47:17', '2025-05-18 11:47:17'),
(7, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 10:49:19', '2025-05-18 11:37:09', '2025-05-18 11:37:09'),
(8, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 10:54:23', '2025-05-18 11:47:23', '2025-05-18 11:47:23'),
(9, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:03:56', '2025-05-18 11:47:30', '2025-05-18 11:47:30'),
(10, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:07:34', '2025-05-18 11:47:36', '2025-05-18 11:47:36'),
(11, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:17:02', '2025-05-18 11:47:43', '2025-05-18 11:47:43'),
(12, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:18:12', '2025-05-18 11:37:00', '2025-05-18 11:37:00'),
(13, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:20:38', '2025-05-18 11:47:50', '2025-05-18 11:47:50'),
(14, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:21:38', '2025-05-18 11:47:57', '2025-05-18 11:47:57'),
(15, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:25:01', '2025-05-18 11:48:04', '2025-05-18 11:48:04'),
(16, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:27:06', '2025-05-18 11:48:12', '2025-05-18 11:48:12'),
(17, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:29:35', '2025-05-18 11:48:22', '2025-05-18 11:48:22'),
(18, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 0, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:31:21', '2025-05-18 11:48:29', '2025-05-18 11:48:29'),
(19, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:31:44', '2025-05-18 11:48:36', '2025-05-18 11:48:36'),
(20, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:33:03', '2025-05-18 11:48:44', '2025-05-18 11:48:44'),
(21, 'tryyy', 1, '2025-04-28', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:37:26', '2025-05-18 11:37:27', NULL),
(22, 'May report', 1, '2025-05-01', '2025-05-18', 1, NULL, 1, '{\"all_departments\":true,\"all_clients\":true,\"all_projects\":true,\"all_users\":true}', '2025-05-18 11:49:08', '2025-05-18 11:49:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `report_filters`
--

CREATE TABLE `report_filters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `report_id` int(10) UNSIGNED NOT NULL,
  `param_type` varchar(255) NOT NULL,
  `param_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `report_filters`
--

INSERT INTO `report_filters` (`id`, `report_id`, `param_type`, `param_id`, `created_at`, `updated_at`) VALUES
(9, 2, 'App\\Models\\Project', 2, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(10, 2, 'App\\Models\\Project', 3, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(11, 2, 'App\\Models\\User', 1, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(12, 2, 'App\\Models\\User', 2, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(13, 2, 'App\\Models\\Client', 1, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(14, 2, 'App\\Models\\Department', 6, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(15, 2, 'App\\Models\\Department', 5, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(16, 2, 'App\\Models\\Department', 7, '2025-05-18 09:21:33', '2025-05-18 09:21:33'),
(17, 1, 'App\\Models\\Project', 2, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(18, 1, 'App\\Models\\Project', 3, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(19, 1, 'App\\Models\\User', 1, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(20, 1, 'App\\Models\\User', 2, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(21, 1, 'App\\Models\\Client', 1, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(22, 1, 'App\\Models\\Department', 6, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(23, 1, 'App\\Models\\Department', 5, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(24, 1, 'App\\Models\\Department', 7, '2025-05-18 10:11:06', '2025-05-18 10:11:06'),
(169, 21, 'App\\Models\\Project', 2, '2025-05-18 11:37:26', '2025-05-18 11:37:26'),
(170, 21, 'App\\Models\\Project', 3, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(171, 21, 'App\\Models\\User', 1, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(172, 21, 'App\\Models\\User', 2, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(173, 21, 'App\\Models\\Client', 1, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(174, 21, 'App\\Models\\Department', 6, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(175, 21, 'App\\Models\\Department', 5, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(176, 21, 'App\\Models\\Department', 7, '2025-05-18 11:37:27', '2025-05-18 11:37:27'),
(177, 22, 'App\\Models\\Project', 2, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(178, 22, 'App\\Models\\Project', 3, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(179, 22, 'App\\Models\\User', 1, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(180, 22, 'App\\Models\\User', 2, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(181, 22, 'App\\Models\\Client', 1, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(182, 22, 'App\\Models\\Department', 6, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(183, 22, 'App\\Models\\Department', 5, '2025-05-18 11:49:08', '2025-05-18 11:49:08'),
(184, 22, 'App\\Models\\Department', 7, '2025-05-18 11:49:08', '2025-05-18 11:49:08');

-- --------------------------------------------------------

--
-- Table structure for table `report_invoices`
--

CREATE TABLE `report_invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `report_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `report_invoices`
--

INSERT INTO `report_invoices` (`id`, `invoice_id`, `report_id`, `created_at`, `updated_at`) VALUES
(1, 1, 5, NULL, NULL),
(2, 2, 11, NULL, NULL),
(3, 3, 15, NULL, NULL),
(4, 4, 19, NULL, NULL),
(5, 5, 20, NULL, NULL),
(6, 6, 21, NULL, NULL),
(7, 7, 22, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Admin', '<p>Admin</p>', 'web', '2021-08-05 07:19:34', '2021-08-05 07:19:34'),
(2, 'User', 'Team Member', '<p>Team Member</p>', 'web', '2021-08-05 07:19:34', '2025-05-03 01:15:50');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(5, 2),
(6, 1),
(6, 2),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(14, 1),
(15, 1),
(17, 1),
(18, 1);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `group` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `group`, `created_at`, `updated_at`) VALUES
(1, 'app_name', 'Task management', 1, '2021-08-05 07:19:35', '2025-05-03 00:38:04'),
(2, 'app_logo', 'assets/img/logo-red-black.png', 1, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(3, 'favicon', 'assets/img/favicon.png', 1, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(4, 'company_name', 'Company name', 1, '2021-08-05 07:19:35', '2025-05-03 00:38:04'),
(5, 'current_currency', 'inr', 1, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(6, 'company_address', 'Kigali - rwanda', 1, '2021-08-05 07:19:35', '2025-05-03 00:38:04'),
(7, 'company_email', 'admin@gmail.com', 1, '2021-08-05 07:19:35', '2025-05-03 00:38:04'),
(8, 'company_phone', '1234567890', 1, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(9, 'working_days_of_month', '24', 1, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(10, 'working_hours_of_day', '8', 1, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(11, 'default_invoice_template', 'defaultTemplate', 2, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(12, 'default_invoice_color', '#040404', 2, '2021-08-05 07:19:35', '2021-08-05 07:19:35');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `status`, `name`, `created_at`, `updated_at`) VALUES
(1, 0, 'Pending', '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(2, 1, 'Completed', '2021-08-05 07:19:35', '2021-08-05 07:19:35');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(170) NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `created_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'urgent', 1, NULL, '2025-05-03 00:52:18', '2025-05-03 00:52:18', NULL),
(2, 'double check', 1, NULL, '2025-05-03 00:52:18', '2025-05-03 00:52:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `priority` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `due_date` date DEFAULT NULL,
  `completed_on` date DEFAULT NULL,
  `task_number` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `estimate_time` varchar(255) DEFAULT NULL,
  `estimate_time_type` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `priority`, `title`, `description`, `project_id`, `status`, `due_date`, `completed_on`, `task_number`, `created_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`, `estimate_time`, `estimate_time_type`) VALUES
(1, NULL, 'Procurement', '', 2, 1, '2025-05-03', NULL, 1, 1, NULL, '2025-05-03 00:40:31', '2025-05-03 00:47:07', NULL, NULL, NULL),
(2, 'highest', 'Market review', '', 2, 1, '2025-05-02', '2025-05-02', 2, 1, NULL, '2025-05-03 00:52:18', '2025-05-03 01:02:30', NULL, '01', 0),
(3, NULL, 'Research', '', 2, 1, '2025-05-03', '2025-05-02', 3, 1, NULL, '2025-05-03 01:04:33', '2025-05-03 01:13:21', NULL, '01', 0),
(4, 'medium', 'Test task', '', 2, 0, NULL, NULL, 4, 2, NULL, '2025-05-03 01:18:05', '2025-05-03 01:18:05', NULL, '01', 0),
(5, 'medium', 'task test', '&lt;p&gt;you have to build to build something&lt;/p&gt;', 2, 0, '2025-05-07', NULL, 5, 1, NULL, '2025-05-05 05:38:57', '2025-05-05 05:38:57', NULL, NULL, NULL),
(6, 'medium', 'New task test', '&lt;p&gt;have to check with this&lt;/p&gt;', 2, 0, '2025-05-07', NULL, 6, 1, NULL, '2025-05-05 05:43:01', '2025-05-05 05:43:01', NULL, NULL, NULL),
(7, 'highest', 'try', '', 3, 0, '2025-05-15', NULL, 1, 1, NULL, '2025-05-08 09:20:15', '2025-05-08 09:20:15', NULL, '4', 1),
(8, 'medium', 'try again', '', 3, 0, '2025-05-14', NULL, 2, 1, NULL, '2025-05-08 09:28:02', '2025-05-08 09:28:02', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `task_assignees`
--

CREATE TABLE `task_assignees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `task_assignees`
--

INSERT INTO `task_assignees` (`id`, `task_id`, `user_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 3, 1),
(5, 4, 2),
(6, 5, 2),
(7, 6, 2),
(8, 7, 2),
(9, 8, 1),
(10, 8, 2);

-- --------------------------------------------------------

--
-- Table structure for table `task_attachments`
--

CREATE TABLE `task_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_tags`
--

CREATE TABLE `task_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `task_tags`
--

INSERT INTO `task_tags` (`id`, `task_id`, `tag_id`) VALUES
(1, 2, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `tax` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `tax`, `created_at`, `updated_at`) VALUES
(1, '5% of your taxable income', 5, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(2, '10% of your taxable salary', 10, '2021-08-05 07:19:35', '2021-08-05 07:19:35'),
(3, '15% of your taxable expense', 15, '2021-08-05 07:19:35', '2021-08-05 07:19:35');

-- --------------------------------------------------------

--
-- Table structure for table `time_entries`
--

CREATE TABLE `time_entries` (
  `id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `activity_type_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `start_time` varchar(255) DEFAULT NULL,
  `end_time` varchar(255) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `entry_type` int(11) NOT NULL DEFAULT 1,
  `note` text NOT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `time_entries`
--

INSERT INTO `time_entries` (`id`, `task_id`, `activity_type_id`, `user_id`, `start_time`, `end_time`, `duration`, `entry_type`, `note`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 3, 2, '2025-05-02 22:03:00', '2025-05-02 22:54:07', 51, 2, 'hi', NULL, '2025-05-03 00:54:29', '2025-05-03 00:54:29', NULL),
(2, 2, 5, 2, '2025-05-02 16:00:00', '2025-05-02 18:58:56', 178, 2, 'Workingg on it', NULL, '2025-05-03 01:01:45', '2025-05-03 01:12:40', NULL),
(3, 3, 1, 1, '2025-05-02 20:00:00', '2025-05-02 21:00:00', 60, 2, 'N/A', NULL, '2025-05-03 01:06:32', '2025-05-03 01:06:32', NULL),
(4, 4, 1, 2, '2025-05-04 06:00:00', '2025-05-04 10:46:32', 286, 2, 'Reading', NULL, '2025-05-04 18:47:54', '2025-05-04 18:47:54', NULL),
(5, 7, 1, 2, '2025-05-06 00:00:00', '2025-05-06 06:22:36', 382, 2, 'nmmnm', NULL, '2025-05-08 09:23:04', '2025-05-08 09:23:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(170) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `set_password` tinyint(1) NOT NULL DEFAULT 0,
  `is_email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `activation_code` varchar(255) DEFAULT NULL,
  `salary` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `language` varchar(255) NOT NULL DEFAULT 'en',
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `email_verified_at`, `password`, `set_password`, `is_email_verified`, `is_active`, `activation_code`, `salary`, `created_by`, `deleted_by`, `remember_token`, `language`, `image_path`, `created_at`, `updated_at`, `deleted_at`, `owner_id`, `owner_type`) VALUES
(1, 'System Admin', 'admin@example.com', NULL, '2021-08-05 07:19:35', '$2y$10$xqqkNCFn.J.t8ALEVQaocuO76B44SrpEyL7ndWaLz6BRWsDIcjQO6', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 'en', NULL, '2021-08-05 07:19:34', '2025-05-04 19:26:12', NULL, NULL, NULL),
(2, 'SAFI Normand Arnauld', 'normandsafi98@gmail.com', '0788919143', '2025-05-03 00:38:49', '$2y$10$BLOI9B.ee8BwIcCeCSs6DOhvhRUP/VAoxwApcbTpOx63Xbm.sOpg6', 1, 0, 1, '68152c4b4b186', NULL, 1, NULL, NULL, 'en', NULL, '2025-05-03 00:34:19', '2025-05-03 00:39:04', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `title`, `type`, `description`, `read_at`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'New Project Assigned', 'App\\Models\\Project', 'You are assigned to Softaware', '2025-05-03 00:30:21', 1, '2025-05-03 00:28:51', '2025-05-03 00:30:21'),
(2, 'New Project Assigned', 'App\\Models\\Project', 'You are assigned to Kugura ibikoresho', '2025-05-03 01:18:23', 1, '2025-05-03 00:30:13', '2025-05-03 01:18:23'),
(3, 'New Project Assigned', 'App\\Models\\Project', 'Kugura ibikoresho assigned to you', '2025-05-03 00:41:48', 2, '2025-05-03 00:40:02', '2025-05-03 00:41:48'),
(4, 'New Task Assigned', 'App\\Models\\Task', 'Procurement assigned to you', '2025-05-03 00:41:47', 2, '2025-05-03 00:40:31', '2025-05-03 00:41:47'),
(5, 'New Task Assigned', 'App\\Models\\Task', 'Procurement assigned to you', NULL, 2, '2025-05-03 00:43:01', '2025-05-03 00:43:01'),
(6, 'New Task Assigned', 'App\\Models\\Task', 'Market review assigned to you', NULL, 2, '2025-05-03 00:52:18', '2025-05-03 00:52:18'),
(7, 'New Task Assigned', 'App\\Models\\Task', 'task test assigned to you', NULL, 2, '2025-05-05 05:38:57', '2025-05-05 05:38:57'),
(8, 'New Task Assigned', 'App\\Models\\Task', 'New task test assigned to you', NULL, 2, '2025-05-05 05:43:01', '2025-05-05 05:43:01'),
(9, 'New Project Assigned', 'App\\Models\\Project', 'You are assigned to Kubaka', NULL, 2, '2025-05-08 09:19:06', '2025-05-08 09:19:06'),
(10, 'New Task Assigned', 'App\\Models\\Task', 'try assigned to you', NULL, 2, '2025-05-08 09:20:15', '2025-05-08 09:20:15'),
(11, 'New Project Assigned', 'App\\Models\\Project', 'Kubaka assigned to you', NULL, 1, '2025-05-08 09:25:51', '2025-05-08 09:25:51'),
(12, 'New Task Assigned', 'App\\Models\\Task', 'try again assigned to you', NULL, 2, '2025-05-08 09:28:02', '2025-05-08 09:28:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `activity_types`
--
ALTER TABLE `activity_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_types_created_by_foreign` (`created_by`),
  ADD KEY `activity_types_deleted_by_foreign` (`deleted_by`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clients_created_by_foreign` (`created_by`),
  ADD KEY `clients_deleted_by_foreign` (`deleted_by`),
  ADD KEY `clients_department_id_foreign` (`department_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_created_by_foreign` (`created_by`),
  ADD KEY `comments_task_id_foreign` (`task_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_name_unique` (`name`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `events_added_by_foreign` (`added_by`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_client_id_foreign` (`client_id`),
  ADD KEY `expenses_project_id_foreign` (`project_id`),
  ADD KEY `expenses_created_by_foreign` (`created_by`),
  ADD KEY `expenses_deleted_by_foreign` (`deleted_by`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoices_tax_id_foreign` (`tax_id`),
  ADD KEY `invoices_created_by_foreign` (`created_by`);

--
-- Indexes for table `invoice_clients`
--
ALTER TABLE `invoice_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_clients_invoice_id_foreign` (`invoice_id`),
  ADD KEY `invoice_clients_client_id_foreign` (`client_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_items_task_id_foreign` (`task_id`),
  ADD KEY `invoice_items_item_project_id_foreign` (`item_project_id`);

--
-- Indexes for table `invoice_projects`
--
ALTER TABLE `invoice_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_projects_invoice_id_foreign` (`invoice_id`),
  ADD KEY `invoice_projects_project_id_foreign` (`project_id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `projects_prefix_unique` (`prefix`),
  ADD UNIQUE KEY `projects_name_unique` (`name`),
  ADD KEY `projects_client_id_foreign` (`client_id`),
  ADD KEY `projects_created_by_foreign` (`created_by`),
  ADD KEY `projects_deleted_by_foreign` (`deleted_by`);

--
-- Indexes for table `project_user`
--
ALTER TABLE `project_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_user_project_id_foreign` (`project_id`),
  ADD KEY `project_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reports_owner_id_foreign` (`owner_id`);

--
-- Indexes for table `report_filters`
--
ALTER TABLE `report_filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_filters_report_id_foreign` (`report_id`);

--
-- Indexes for table `report_invoices`
--
ALTER TABLE `report_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_invoices_invoice_id_foreign` (`invoice_id`),
  ADD KEY `report_invoices_report_id_foreign` (`report_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `status_status_unique` (`status`),
  ADD UNIQUE KEY `status_name_unique` (`name`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_unique` (`name`),
  ADD KEY `tags_created_by_foreign` (`created_by`),
  ADD KEY `tags_deleted_by_foreign` (`deleted_by`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tasks_task_number_project_id_unique` (`task_number`,`project_id`),
  ADD KEY `tasks_deleted_by_foreign` (`deleted_by`),
  ADD KEY `tasks_project_id_foreign` (`project_id`),
  ADD KEY `tasks_created_by_foreign` (`created_by`);

--
-- Indexes for table `task_assignees`
--
ALTER TABLE `task_assignees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_assignees_task_id_foreign` (`task_id`),
  ADD KEY `task_assignees_user_id_foreign` (`user_id`);

--
-- Indexes for table `task_attachments`
--
ALTER TABLE `task_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_attachments_task_id_foreign` (`task_id`);

--
-- Indexes for table `task_tags`
--
ALTER TABLE `task_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_tags_task_id_foreign` (`task_id`),
  ADD KEY `task_tags_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `time_entries`
--
ALTER TABLE `time_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time_entries_deleted_by_foreign` (`deleted_by`),
  ADD KEY `time_entries_task_id_foreign` (`task_id`),
  ADD KEY `time_entries_activity_type_id_foreign` (`activity_type_id`),
  ADD KEY `time_entries_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_created_by_foreign` (`created_by`),
  ADD KEY `users_deleted_by_foreign` (`deleted_by`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_notifications_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `activity_types`
--
ALTER TABLE `activity_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `invoice_clients`
--
ALTER TABLE `invoice_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `invoice_projects`
--
ALTER TABLE `invoice_projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project_user`
--
ALTER TABLE `project_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `report_filters`
--
ALTER TABLE `report_filters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- AUTO_INCREMENT for table `report_invoices`
--
ALTER TABLE `report_invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `task_assignees`
--
ALTER TABLE `task_assignees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `task_attachments`
--
ALTER TABLE `task_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_tags`
--
ALTER TABLE `task_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `time_entries`
--
ALTER TABLE `time_entries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_types`
--
ALTER TABLE `activity_types`
  ADD CONSTRAINT `activity_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `activity_types_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `clients_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `clients_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `expenses_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `expenses_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `expenses_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_clients`
--
ALTER TABLE `invoice_clients`
  ADD CONSTRAINT `invoice_clients_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_clients_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `invoice_items_item_project_id_foreign` FOREIGN KEY (`item_project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_items_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_projects`
--
ALTER TABLE `invoice_projects`
  ADD CONSTRAINT `invoice_projects_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_projects_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `projects_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `projects_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `project_user`
--
ALTER TABLE `project_user`
  ADD CONSTRAINT `project_user_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `project_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `report_filters`
--
ALTER TABLE `report_filters`
  ADD CONSTRAINT `report_filters_report_id_foreign` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_invoices`
--
ALTER TABLE `report_invoices`
  ADD CONSTRAINT `report_invoices_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `report_invoices_report_id_foreign` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `tags_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tags_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tasks_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Constraints for table `task_assignees`
--
ALTER TABLE `task_assignees`
  ADD CONSTRAINT `task_assignees_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`),
  ADD CONSTRAINT `task_assignees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `task_attachments`
--
ALTER TABLE `task_attachments`
  ADD CONSTRAINT `task_attachments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`);

--
-- Constraints for table `task_tags`
--
ALTER TABLE `task_tags`
  ADD CONSTRAINT `task_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`),
  ADD CONSTRAINT `task_tags_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`);

--
-- Constraints for table `time_entries`
--
ALTER TABLE `time_entries`
  ADD CONSTRAINT `time_entries_activity_type_id_foreign` FOREIGN KEY (`activity_type_id`) REFERENCES `activity_types` (`id`),
  ADD CONSTRAINT `time_entries_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `time_entries_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`),
  ADD CONSTRAINT `time_entries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `users_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD CONSTRAINT `user_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
