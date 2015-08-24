-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 24, 2015 at 05:47 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `summary`, `user_id`, `createdon`) VALUES
(13, 'Common', 'Some common tasks', 9, '2015-08-24 02:05:54');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `log` varchar(200) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pages_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `date`, `content`, `user_id`) VALUES
(1, '2015-08-24 00:00:00', '   <p> </p><h2>So! Finally I created this site.<br></h2><p style="padding-left: 30px;">Now lets make some rules. So that I can keep this place (i.e. diary more organized). <br>Rules for using appropriate coloring while writing diary.<br>&nbsp;&nbsp;&nbsp; 1. <span data-mce-style="color: #000080;" style="color: rgb(0, 0, 128);">When writing basic stuff (Like description, happenings etc)</span><br>&nbsp;&nbsp;&nbsp; 2. <span data-mce-style="color: #ffff00;" style="color: rgb(255, 255, 0);">Some thought / quote / inspiring words etc.<br></span>&nbsp;&nbsp;&nbsp; 3. <span data-mce-style="color: #800000;" style="color: rgb(128, 0, 0);">!!REMINDERS!!</span><span data-mce-style="color: #800000;" style="color: rgb(128, 0, 0);"></span><br>&nbsp;&nbsp;&nbsp; 4. <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p>   ', 9),
(2, '2015-08-24 00:00:00', '<h2><span style="color: rgb(0, 0, 128);">Let''s see how long will I be able to write this diary efficiently...</span><br data-mce-bogus="1"></h2>', 9);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=89 ;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`id`, `checked`, `task_name`, `comment`, `recorder_id`, `user_id`, `task_type`) VALUES
(88, b'1', 'Checkout', '', 109, 9, 'daily');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=110 ;

--
-- Dumping data for table `recorder`
--

INSERT INTO `recorder` (`id`, `added`, `date`, `user_id`) VALUES
(109, b'1', '2015-08-24 00:00:00', 9);

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
  `summary` varchar(500) DEFAULT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskdaily_categoryid_fkey` (`category_id`),
  KEY `taskdaily_userid_fkey` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `task_daily`
--

INSERT INTO `task_daily` (`id`, `name`, `summary`, `createdon`, `category_id`, `user_id`) VALUES
(5, 'Checkout', 'Checkout some common websites : <br />\r\n1. <a href=''http://localhost/notifier/notes.php''>http://localhost/notifier/notes.php</a> <br />\r\n2. \r\n<a href=''http://stackoverflow.com/''>http://stackoverflow.com</a>', '2015-08-24 02:08:36', 13, 9);

-- --------------------------------------------------------

--
-- Table structure for table `task_weekly`
--

CREATE TABLE IF NOT EXISTS `task_weekly` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `day` enum('sun','mon','tue','wed','thu','fri','sat') NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskweekly_categoryid_fkey` (`category_id`),
  KEY `taskweekly_userid_fkey` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  `userpass` char(13) NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `loggedin_hash` char(13) DEFAULT NULL,
  `loggedin_last` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `userpass`, `createdon`, `loggedin_hash`, `loggedin_last`) VALUES
(9, 'afzalex', 'cNTeHIl4VG6M6', '2015-08-24 02:05:54', 'fgTsNkWF2loY.', '2015-08-24 02:06:06');

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `users_delete_before_trigger`;
DELIMITER //
CREATE TRIGGER `users_delete_before_trigger` BEFORE DELETE ON `users`
 FOR EACH ROW begin
delete from recorder where user_id = old.id;
delete from category where user_id = old.id;
delete from notes where user_id = old.id;
delete from record where user_id = old.id;
delete from task_yearly where user_id = old.id;
delete from task_weekly where user_id = old.id;
delete from task_daily where user_id = old.id;
end
//
DELIMITER ;
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
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `pages_userid_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
