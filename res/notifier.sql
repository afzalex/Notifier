-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 30, 2015 at 12:47 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `notifier`
--
CREATE DATABASE IF NOT EXISTS `notifier` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `notifier`;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `summary` varchar(200) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `summary`, `user_id`, `createdon`) VALUES
(1, 'Common', 'Common task', 2, '2015-04-29 00:17:37'),
(2, 'Important', 'Tasks that are important.', 2, '2015-04-29 00:18:15');

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

CREATE TABLE IF NOT EXISTS `record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checked` bit(1) DEFAULT b'0',
  `task_name` varchar(100) NOT NULL,
  `comment` varchar(300) DEFAULT '',
  `recorder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `task_type` enum('daily','weekly','monthly','yearly','particular','interval') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `record_recorderid_fkey` (`recorder_id`),
  KEY `record_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`id`, `checked`, `task_name`, `comment`, `recorder_id`, `user_id`, `task_type`) VALUES
(6, b'0', 'Newspaper reading', '', 14, 2, 'daily'),
(7, b'0', 'Meditation', '', 14, 2, 'daily'),
(8, b'0', 'Newspaper reading', '', 15, 2, 'daily'),
(9, b'0', 'Meditation', '', 15, 2, 'daily');

-- --------------------------------------------------------

--
-- Table structure for table `recorder`
--

CREATE TABLE IF NOT EXISTS `recorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `added` bit(1) DEFAULT b'0',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recorder_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `recorder`
--

INSERT INTO `recorder` (`id`, `added`, `date`, `user_id`) VALUES
(12, b'1', '2015-04-28 00:00:00', 2),
(14, b'1', '2015-04-29 00:00:00', 2),
(15, b'1', '2015-04-30 00:00:00', 2);

--
-- Triggers `recorder`
--
DROP TRIGGER IF EXISTS `recorder_before_delete_trigger`;
DELIMITER //
CREATE TRIGGER `recorder_before_delete_trigger` BEFORE DELETE ON `recorder`
 FOR EACH ROW begin
delete from record where user_id=old.user_id and recorder_id=old.id;
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `task_daily`
--

CREATE TABLE IF NOT EXISTS `task_daily` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `summary` varchar(200) DEFAULT '',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskdaily_categoryid_fkey` (`category_id`),
  KEY `taskdaily_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `task_daily`
--

INSERT INTO `task_daily` (`id`, `name`, `summary`, `createdon`, `category_id`, `user_id`) VALUES
(1, 'Meditation', 'Must do meditation for a happy and healthy life', '2015-04-29 00:17:53', 2, 2),
(2, 'Newspaper reading', 'Reading will improve your communication skill', '2015-04-29 23:53:58', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `task_weekly`
--

CREATE TABLE IF NOT EXISTS `task_weekly` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `summary` varchar(200) DEFAULT '',
  `day` enum('sun','mon','tue','wed','thu','fri','sat') NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskweekly_categoryid_fkey` (`category_id`),
  KEY `taskweekly_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `task_weekly`
--

INSERT INTO `task_weekly` (`id`, `name`, `summary`, `day`, `createdon`, `category_id`, `user_id`) VALUES
(1, 'Newspapers', 'Read sunday newspaper. And some important articles.', 'sun', '2015-04-29 00:19:25', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `task_yearly`
--

CREATE TABLE IF NOT EXISTS `task_yearly` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `summary` varchar(200) DEFAULT '',
  `month` int(2) DEFAULT NULL,
  `date` int(2) NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskyearly_categoryid_fkey` (`category_id`),
  KEY `taskyearly_userid_fkey` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `userpass` char(76) NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `userpass`, `createdon`) VALUES
(2, 'afzalex', 'AFpwh9NB6Yf.o', '2015-04-28 23:52:19');

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `users_insert_before_trigger`;
DELIMITER //
CREATE TRIGGER `users_insert_before_trigger` AFTER INSERT ON `users`
 FOR EACH ROW begin
insert into category (name, summary, user_id) values ("Common", "Some common tasks", new.id);
end
//
DELIMITER ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_recorderid_fkey` FOREIGN KEY (`recorder_id`) REFERENCES `recorder` (`id`),
  ADD CONSTRAINT `record_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `recorder`
--
ALTER TABLE `recorder`
  ADD CONSTRAINT `recorder_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `task_daily`
--
ALTER TABLE `task_daily`
  ADD CONSTRAINT `taskdaily_categoryid_fkey` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `taskdaily_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `task_weekly`
--
ALTER TABLE `task_weekly`
  ADD CONSTRAINT `taskweekly_categoryid_fkey` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `taskweekly_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `task_yearly`
--
ALTER TABLE `task_yearly`
  ADD CONSTRAINT `taskyearly_categoryid_fkey` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `taskyearly_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
