-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 03, 2015 at 04:55 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `summary`, `user_id`, `createdon`) VALUES
(1, 'Common', 'Common task', 2, '2015-04-29 00:17:37'),
(2, 'Important', 'Tasks that are important.', 2, '2015-04-29 00:18:15'),
(5, 'Common', 'Some common tasks', 5, '2015-05-20 19:47:27'),
(6, 'Improvement', 'Time to improve some skills', 2, '2015-05-31 04:00:25'),
(7, 'Common', 'Some common tasks', 6, '2015-06-03 22:58:51');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `date`, `content`, `user_id`) VALUES
(17, '2015-06-04 00:00:00', '<p data-mce-style="text-align: left;" style="text-align: left;">&nbsp;&nbsp;&nbsp;&nbsp; <strong>T</strong>oday I created this panel and added it in notifier. I found it really cool. There are several motives for creating this panel. <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; â‡’ Firstly because I wanted to write diary on my pc.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; â‡’ To improve my english. As I read somewhere that writing daily can do so.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; â‡’ And I thought of creating similar kind of thing much earlier.<br></p><p>&nbsp;&nbsp;&nbsp; So I created. Now let''s see how much change I can bring by using this thing.<br data-mce-bogus="1"></p>', 2),
(18, '2015-06-04 00:00:00', ' <p> </p><p> </p><h2>Diary writing pattern<br></h2><p><span style="color: rgb(0, 51, 0);">&nbsp;&nbsp;&nbsp;&nbsp; You need to improve yourself on various areas. One of which is your fitness. So 1 page you will have to write over your improvement. Like how much you have done to improve today etc. In improvement you should consider following things : <br>&nbsp;&nbsp;&nbsp; â‡’ Fitness : exercise, eating habit etc.<br>&nbsp;&nbsp;&nbsp; â‡’ Knowledge : material you are studying, like C++ currently<br>&nbsp;&nbsp;&nbsp; And the name of this section will be <strong><code>"Improvement"</code></strong><br></span></p><p><span style="color: rgb(0, 51, 0);">&nbsp;&nbsp;&nbsp; Another section will be about what you think about something and what you are planning to do next etc.. And lets name it as <strong><code>"Thought"</code>.</strong><code></code></span><span style="color: rgb(153, 51, 102);"><span style="color: rgb(0, 51, 0);"><strong></strong></span></span></p><p><span style="color: rgb(153, 51, 102);"><span style="color: rgb(0, 51, 0);">&nbsp;&nbsp;&nbsp; Forget not to add some motivational thought line at the end of every page like :</span> </span></p><p style="text-align: center;"><span style="color: rgb(0, 51, 0);"><span data-mce-style="color: #ffff99;" style="color: rgb(255, 255, 153);">!! You call it piracy, We call it freedom !!</span><em><strong><span style="overflow: hidden; line-height: 0px;" id="mce_7_start" data-mce-type="bookmark"></span><br data-mce-bogus="1"></strong></em></span></p><p><span style="color: rgb(0, 51, 0);"><strong>Color pattern :<br>&nbsp;&nbsp;&nbsp; </strong>Imaginary guide<br>&nbsp;&nbsp;&nbsp; <span data-mce-style="color: #ffff99;" style="color: rgb(255, 255, 153);">Thought</span><br>&nbsp;&nbsp;&nbsp; <em><span style="color: rgb(51, 51, 153);">Your words</span></em><br></span></p><p><span style="color: rgb(0, 51, 0);">&nbsp;&nbsp;&nbsp; So from next day start writing diary every day<br></span></p><p> </p> ', 2),
(19, '2015-06-05 00:00:00', '        <p>  </p><h2 style="text-align: center;">Thought</h2><p><span style="color: rgb(0, 0, 255);"><em>&nbsp;&nbsp;&nbsp; I want to start my carreer now. I cannot rely even more on my dad''s money. I have to do something. And I am thinking that I should get a job here in Rishikesh and keep concentrating on my improvement and all stuff. I wanted to go Bangalore to get a job, but on the same time I am pretty much aware that I will need a good money for this. And may be my father will not be able to give me that. So that thing give me another reason to get a job as soon as possible in Rishikesh. <br></em></span></p><p><span style="color: rgb(0, 0, 255);"><em>&nbsp;&nbsp;&nbsp; My friend Avnish''s exams are also going to end. But his situation is not like mine. He wanted to study further for mtech, and will not be seeking job like me. But it will be good if he could help me somehow in getting a job.</em></span><br data-mce-bogus="1"></p><p>  </p>        ', 2),
(20, '2015-06-05 00:00:00', '     <h2 style="text-align: center;" data-mce-style="text-align: center;">Improvement</h2><h2 style="text-align: center;" data-mce-style="text-align: center;"></h2><p><span style="color: rgb(0, 0, 255);"><em>&nbsp;&nbsp;&nbsp; I did a little exercise today. And having small pain due to this. I have to work regularly to be better on fitness perspective. Did exercise after coming back from shop. It is sad that a little exercise make me feel pain. But I will keep doing this regularly and will get what I wanted.</em></span><br></p><p><span data-mce-style="color: #0000ff;" style="color: rgb(0, 0, 255);"><em>&nbsp;&nbsp;&nbsp; I am still reading C++ and completed 50 to 62 pages. <br data-mce-bogus="1"></em></span></p><p><span data-mce-style="color: #003300;" style="color: rgb(0, 51, 0);">&nbsp;&nbsp;&nbsp; Okay that''s good actually. What is more important is to keep it up. Don''t lose your path. There is one more thing on which you should focus i.e. preparation for e-litmus and MCAT exams. If you want to be recognized in your field, it is very important. So you should <strong>work on preparation of e-litmus and MCAT exams</strong>. Hope you will keep doing things right way.<br data-mce-bogus="1"></span></p>     ', 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=62 ;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`id`, `checked`, `task_name`, `comment`, `recorder_id`, `user_id`, `task_type`) VALUES
(6, b'0', 'Newspaper reading', '', 14, 2, 'daily'),
(7, b'0', 'Meditation', '', 14, 2, 'daily'),
(8, b'0', 'Newspaper reading', '', 15, 2, 'daily'),
(9, b'0', 'Meditation', '', 15, 2, 'daily'),
(16, b'0', 'Newspaper reading', '', 21, 2, 'daily'),
(17, b'0', 'Meditation', '', 21, 2, 'daily'),
(18, b'0', 'Newspaper reading', '', 22, 2, 'daily'),
(19, b'0', 'Meditation', '', 22, 2, 'daily'),
(20, b'0', 'Newspaper reading', '', 23, 2, 'daily'),
(21, b'0', 'Meditation', '', 23, 2, 'daily'),
(22, b'0', 'Newspaper reading', '', 24, 2, 'daily'),
(23, b'0', 'Meditation', '', 24, 2, 'daily'),
(24, b'0', 'Newspapers', '', 24, 2, 'weekly'),
(25, b'0', 'Newspaper reading', '', 25, 2, 'daily'),
(26, b'0', 'Meditation', '', 25, 2, 'daily'),
(27, b'0', 'Newspaper reading', '', 26, 2, 'daily'),
(28, b'0', 'Meditation', '', 26, 2, 'daily'),
(29, b'0', 'Newspaper reading', '', 27, 2, 'daily'),
(30, b'0', 'Meditation', '', 27, 2, 'daily'),
(31, b'0', 'Newspaper reading', '', 28, 2, 'daily'),
(32, b'0', 'Meditation', '', 28, 2, 'daily'),
(33, b'0', 'Newspaper reading', '', 29, 2, 'daily'),
(34, b'0', 'Meditation', '', 29, 2, 'daily'),
(35, b'0', 'Newspaper reading', '', 30, 2, 'daily'),
(36, b'0', 'Meditation', '', 30, 2, 'daily'),
(37, b'0', 'Newspaper reading', '', 31, 2, 'daily'),
(38, b'0', 'Meditation', '', 31, 2, 'daily'),
(39, b'0', 'Newspapers', '', 31, 2, 'weekly'),
(40, b'0', 'Newspaper reading', '', 32, 2, 'daily'),
(41, b'0', 'Meditation', '', 32, 2, 'daily'),
(49, b'0', 'Newspapers', '', 39, 2, 'weekly'),
(50, b'0', 'Homework', '', 45, 5, 'daily'),
(51, b'0', 'Newspapers', '', 48, 2, 'weekly'),
(52, b'0', 'Watch english news', '', 49, 2, 'daily'),
(53, b'0', 'Newspapers', '', 56, 2, 'weekly'),
(54, b'0', 'Watch english news', '', 59, 2, 'daily'),
(55, b'0', 'Watch english news', '', 60, 2, 'daily'),
(56, b'0', 'Watch english news', '', 62, 2, 'daily'),
(57, b'0', 'Watch english news', '', 63, 2, 'daily'),
(58, b'0', 'Watch english news', '', 64, 2, 'daily'),
(59, b'0', 'Watch english news', '', 65, 2, 'daily'),
(60, b'1', 'Newspaper reading', 'I did it successfully....   HURRAAAYYYY!!!', 68, 2, 'daily'),
(61, b'0', 'Newspaper reading', '', 69, 2, 'daily');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=72 ;

--
-- Dumping data for table `recorder`
--

INSERT INTO `recorder` (`id`, `added`, `date`, `user_id`) VALUES
(12, b'1', '2015-04-28 00:00:00', 2),
(14, b'1', '2015-04-29 00:00:00', 2),
(15, b'1', '2015-04-30 00:00:00', 2),
(21, b'1', '2015-05-13 00:00:00', 2),
(22, b'1', '2015-05-12 00:00:00', 2),
(23, b'1', '2015-05-11 00:00:00', 2),
(24, b'1', '2015-05-10 00:00:00', 2),
(25, b'1', '2015-05-09 00:00:00', 2),
(26, b'1', '2015-05-08 00:00:00', 2),
(27, b'1', '2015-05-07 00:00:00', 2),
(28, b'1', '2015-05-06 00:00:00', 2),
(29, b'1', '2015-05-05 00:00:00', 2),
(30, b'1', '2015-05-04 00:00:00', 2),
(31, b'1', '2015-05-03 00:00:00', 2),
(32, b'1', '2015-05-02 00:00:00', 2),
(36, b'1', '2015-05-19 00:00:00', 2),
(37, b'1', '2015-05-18 00:00:00', 2),
(39, b'1', '2015-05-17 00:00:00', 2),
(40, b'1', '2015-05-16 00:00:00', 2),
(41, b'1', '2015-05-15 00:00:00', 2),
(42, b'1', '2015-05-14 00:00:00', 2),
(43, b'1', '2015-05-01 00:00:00', 2),
(45, b'1', '2015-05-20 00:00:00', 5),
(46, b'1', '2015-05-20 00:00:00', 2),
(47, b'1', '2015-05-21 00:00:00', 2),
(48, b'1', '2015-05-31 00:00:00', 2),
(49, b'1', '2015-06-01 00:00:00', 2),
(50, b'1', '2015-05-30 00:00:00', 2),
(51, b'1', '2015-05-29 00:00:00', 2),
(52, b'1', '2015-05-28 00:00:00', 2),
(53, b'1', '2015-05-27 00:00:00', 2),
(54, b'1', '2015-05-26 00:00:00', 2),
(55, b'1', '2015-05-25 00:00:00', 2),
(56, b'1', '2015-05-24 00:00:00', 2),
(57, b'1', '2015-05-23 00:00:00', 2),
(58, b'1', '2015-05-22 00:00:00', 2),
(59, b'1', '2015-06-02 00:00:00', 2),
(60, b'1', '2015-06-03 00:00:00', 2),
(61, b'1', '2015-06-03 00:00:00', 6),
(62, b'1', '2015-06-04 00:00:00', 2),
(63, b'1', '2015-06-05 00:00:00', 2),
(64, b'1', '2015-06-06 00:00:00', 2),
(65, b'1', '2015-06-08 00:00:00', 2),
(66, b'1', '2015-06-13 00:00:00', 2),
(68, b'1', '2015-06-17 00:00:00', 2),
(69, b'1', '2015-06-19 00:00:00', 2),
(70, b'1', '2015-07-04 00:00:00', 2),
(71, b'1', '2015-07-03 00:00:00', 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `task_daily`
--

INSERT INTO `task_daily` (`id`, `name`, `summary`, `createdon`, `category_id`, `user_id`) VALUES
(1, 'Homework', 'To do homework of my school.', '2015-05-20 19:48:21', 5, 5);

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
  `userpass` char(76) NOT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `userpass`, `createdon`) VALUES
(2, 'afzalex', 'cNTeHIl4VG6M6', '2015-04-28 23:52:19'),
(5, 'Imran', 'cNzfwF80fYFPs', '2015-05-20 19:47:27'),
(6, 'Mohammad imran', 'cNQX0JCfiX456', '2015-06-03 22:58:51');

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
