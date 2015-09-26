-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 26, 2015 at 05:23 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `summary`, `user_id`, `createdon`) VALUES
(13, 'Common', 'Some common tasks', 9, '2015-08-24 02:05:54'),
(14, 'Test', 'test', 9, '2015-09-09 13:52:23');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `date`, `content`, `user_id`) VALUES
(1, '2015-08-24 00:00:00', '             <p> </p><h2>So! Finally I created this site.<br></h2><p style="padding-left: 30px;">Now lets make some rules. So that I can keep this place (i.e. diary) more organized. <br>Rules for using appropriate coloring while writing diary.<br>&nbsp;&nbsp;&nbsp; 1. <span style="color: rgb(0, 0, 128);">When writing basic stuff (Like description, happenings etc) [indigo]</span><br>&nbsp;&nbsp;&nbsp; 2. <span style="color: rgb(255, 255, 0);">Some thought / quote / inspiring words etc. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; [yellow]<span style="color: rgb(255, 255, 153);"><span style="color: rgb(255, 255, 0);"></span></span><br></span>&nbsp;&nbsp;&nbsp; 3. <span style="color: rgb(128, 0, 0);">!!REMINDERS!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [burnt orange]</span><span style="color: rgb(128, 0, 0);"></span><br>&nbsp;&nbsp;&nbsp; 4. <span style="color: rgb(0, 128, 0);">Daily common description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: rgb(0, 128, 0);">[green]</span></span><br>&nbsp;&nbsp;&nbsp; 5. <span style="color: rgb(128, 0, 128);">Plans&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [red violet]<span data-mce-style="color: #ff00ff;" style="color: rgb(255, 0, 255);"></span></span><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p>             ', 9),
(2, '2015-08-24 00:00:00', '    <p> </p><h2><span style="color: rgb(0, 0, 128);">Let''s see how long will I be able to write this diary efficiently...</span><br data-mce-bogus="1"></h2><p><span style="color: rgb(0, 0, 128);">I started writing diary many times. But most of the time I failed to keep doing that.<br>Now I want to write it. As I know benefits of writing diary... I wish, I will keep it up.<br></span></p><p> </p>    ', 9),
(3, '2015-08-25 00:00:00', '              <p>    </p><p><span style="color: rgb(0, 0, 128);">Day was normal today. I don''t think it will be different now and then because now I am doing job and will rarely get some time to do other stuff.<br></span></p><p><span style="color: rgb(0, 0, 128);">Again the same thing came into my mind. MY SALARY! , I am not happy with the salary I am getting. I will have to keep improving my skills. Otherwise all my dreams will go into trash. <br data-mce-bogus="1"></span></p><p>    </p>              ', 9),
(5, '2015-08-26 00:00:00', '<p style=""><span data-mce-style="color: #993366;" style="color: rgb(153, 51, 102);"><br data-mce-bogus="1"></span></p><p style="padding-left: 30px;"><span style="color: rgb(153, 51, 102);">Visit these websites :<br>1. <a title="hackerearth.com" href="https://www.hackerearth.com/tracks/pledge-2015-easy/panda-and-xor/" data-mce-href="https://www.hackerearth.com/tracks/pledge-2015-easy/panda-and-xor/">hackerearth.com<br>2. </a><a style="color: rgb(153, 51, 102);" title="stackoverflow.com" href="http://stackoverflow.com/" data-mce-href="http://stackoverflow.com/">stackoverflow.com</a></span><br></p>', 9),
(6, '2015-08-27 00:00:00', '    <p><span data-mce-style="color: #000080;" style="color: rgb(0, 0, 128);">I am happy that tomorrow I will go back to my home. meet mom. and bros. I don''t know when will I get the chance to meet everybody again. Last time when I was leaving mom, mom embraced me. I was really feeling like I will weep. I was leaving mom. and going to far away from my home. </span><br></p><p><span style="color: rgb(0, 0, 128);">Now is the time, go back and meet everybody. I will need some money to enjoy there. </span></p><p><span style="color: rgb(0, 0, 128);"><span style="color: rgb(0, 0, 0);">But wait, think again. Do you really think you need money to spend some good time with your family. The obvious answer is NO. Go there and try to enjoy each and every moment. </span><br data-mce-bogus="1"></span></p><p><span style="color: rgb(0, 0, 128);">Okay then, what are the things I will be taking with me. <br>1. First of all will be clothes. I will wash them there in washing machine, <span style="color: rgb(0, 0, 0);">(Try to do that thing yourself. may be mom will feel happy)</span><br data-mce-bogus="1">2. Laptop is very important I know. <span style="color: rgb(0, 0, 0);">But don''t forget to get movies <span data-mce-style="color: #000080;" style="color: rgb(0, 0, 128);"><br>3. Visit bank to trasfer your branch to jaipur''s branch</span></span></span><br></p><p><br data-mce-bogus="1"></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: #993366;" data-mce-style="color: #993366;">Visit these websites :<br>1. <a title="hackerearth.com" href="https://www.hackerearth.com/tracks/pledge-2015-easy/panda-and-xor/" data-mce-href="https://www.hackerearth.com/tracks/pledge-2015-easy/panda-and-xor/">hackerearth.com&nbsp; <br>2. </a><a style="color: rgb(153, 51, 102);" title="stackoverflow.com" href="http://stackoverflow.com/" data-mce-href="http://stackoverflow.com/">stackoverflow.com <em><span style="color: rgb(0, 0, 128);">(done)</span></em></a></span><br data-mce-bogus="1"></p>    ', 9),
(9, '2015-09-04 00:00:00', '<p> </p><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">Interest is raising in the project I am working on. But I want to learn some more things along with this. Linux is one of those things. But The problem is, I want internet for most of the tasks, which I don''t have. Don''t know how to get it. Because the internect connection I was relying on is not there now. hardly I get 1 hour of internet. I will have to find some way through.<br>Today Jugal was saying that I was saying I will wake early and go for a walk in morning. But see, I failed in that thing too. I don''t want to fail completely. Keep on trying and I will make it some time. But the key is KEEP ON TRYING.</span><br data-mce-bogus="1"></p><p> </p>', 9),
(10, '2015-09-06 00:00:00', '     <p> </p><h2><span style="color: rgb(0, 51, 102);">Got Wifi password back</span></h2><p><span style="color: rgb(0, 51, 102);">I was tense because there was no internet available now a days to me. Because today was sunday I was at PG all day. I asked Karan if he want some fantastic game. Then I showed him "Far Cry 3". He liked it too much. and asked me to give him that game. It does took time but in between I got the password from his computer they were using to connect to wifi.<br data-mce-bogus="1"></span></p><p><span style="color: rgb(0, 51, 102);">But the problem is, after some time some other guys of PG came to my room and checked out his computer. And they also got the password. I didn''t wanted this. But what could be done now. <br data-mce-bogus="1"></span></p><p><span style="color: rgb(0, 51, 102);">But now I have a plan.<br><span style="color: rgb(153, 51, 102);">I will create my own keylogger. and install it in their computer. And then ask PG''s master to change wifi''s password.</span><br><span style="color: rgb(153, 51, 102);">It will need hardwork and dedication toward this task. But it will have it''s own benefits.</span> <br data-mce-bogus="1"></span></p><p> </p>     ', 9),
(11, '2015-09-08 00:00:00', '         <p>&nbsp;<br></p><h2><span style="color: rgb(51, 51, 153);">&nbsp;"What is meditation?" by Sandeep Maheshwari</span></h2><p><span style="color: rgb(0, 0, 128);"><span style="color: rgb(51, 51, 153);">Today I saw a show of sandeep maheshwari. In which he explained what is mediation. The thing that I want to keep in mind among all his word was "Meditaion is anything that you do with all your ability. Being awared of everything you are doing". I think if I will keep it in mind I will be able to do what I want to do.</span> </span></p><p>&nbsp;<br></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: #ffff00;" data-mce-style="color: #ffff00;"><span style="color: #000000;" data-mce-style="color: #000000;">06 Sep 2015 |</span> <span style="color: #993366;" data-mce-style="color: #993366;">"I will create my own keylogger. and install it in their computer."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing</span></p><p>&nbsp;<br></p>         ', 9),
(19, '2015-09-08 00:00:00', ' <p> </p><p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><p><br></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><hr><p><span style="color: rgb(255, 255, 0);" data-mce-style="color: #ffff00;"><span style="color: #000000;" data-mce-style="color: #000000;">06 Sep 2015 |</span> <span style="color: #993366;" data-mce-style="color: #993366;">"I will create my own keylogger. and install it in their computer."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing</span></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;">&nbsp;&nbsp;&nbsp; 1. <span style="color: #000080;" data-mce-style="color: #000080;">When writing basic stuff (Like description, happenings etc) [indigo]</span><br>&nbsp;&nbsp;&nbsp; 2. <span style="color: #ffff00;" data-mce-style="color: #ffff00;">Some thought / quote / inspiring words etc. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; [yellow]<br></span>&nbsp;&nbsp;&nbsp; 3. <span style="color: #800000;" data-mce-style="color: #800000;">!!REMINDERS!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [burnt orange]</span><br>&nbsp;&nbsp;&nbsp; 4. <span style="color: #008000;" data-mce-style="color: #008000;">Daily common description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #008000;" data-mce-style="color: #008000;">[green]</span></span><br>&nbsp;&nbsp;&nbsp; 5. <span style="color: #800080;" data-mce-style="color: #800080;">Plans&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [red violet]</span><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p> ', 9),
(24, '2015-09-09 00:00:00', '   <p> </p><p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><h3><span style="color: rgb(51, 51, 153);">My first Salary</span><br></h3><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">I got my first salary of my life. After my office I gone to shop and bought some sweets. Spent Rs 210 and get 1/2 kg of "Ras malai" and 1/2 kg of "Gulab Jamun". And given some to my roommates. Jugal hugged me for that special day of my life and given me blessings. He is actually a good person. </span><br data-mce-bogus="1"></p><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">But very before going to shop I called Shazad and said him to look for a pair of "kurta pajama" for papa and a mobile phone for my mom. With my first salary I want to buy those thing for my mom.</span><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: rgb(255, 255, 0);" data-mce-style="color: #ffff00;"><span style="color: #000000;" data-mce-style="color: #000000;">06 Sep 2015 |</span> <span style="color: #993366;" data-mce-style="color: #993366;">"I will create my own keylogger. and install it in their computer."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing.</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p>   ', 9),
(25, '2015-09-11 00:00:00', '   <p style=""><span style="color: rgb(0, 51, 102);">I don''t think I have much money to spends. Here is my plan to spend my money wisely. </span><br><br></p><table data-mce-style="height: 168px; border-color: black;" style="height: 168px; border-color: black;" border="1" width="519"><tbody><tr><td><span style="color: rgb(0, 51, 102);"><strong>Description</strong></span><br data-mce-bogus="1"></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);"><strong>cost</strong></span><br data-mce-bogus="1"></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);"><strong>balance</strong></span><br data-mce-bogus="1"></td></tr><tr><td><span style="color: rgb(0, 51, 102);">Rent of room</span><br></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">5000</span><br></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">&nbsp;5000</span><br data-mce-bogus="1"></td></tr><tr><td><span style="color: rgb(0, 51, 102);">Gifts for mom / dad</span><br></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">3000</span><br></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">&nbsp;8000</span><br data-mce-bogus="1"></td></tr><tr><td><span style="color: rgb(0, 51, 102);">EMI for monu''s lappy</span><br></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">2000</span><br></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">10000</span><br data-mce-bogus="1"></td></tr><tr><td><span style="color: rgb(0, 51, 102);">Needs (milk etc)</span><br data-mce-bogus="1"></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">1000</span><br data-mce-bogus="1"></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">11000</span><br data-mce-bogus="1"></td></tr><tr><td><span style="color: rgb(0, 51, 102);">Travel </span><br data-mce-bogus="1"></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">1000</span><br data-mce-bogus="1"></td><td style="text-align: right;"><span style="color: rgb(0, 51, 102);">12000</span><br data-mce-bogus="1"></td></tr></tbody></table><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: #ffff00;" data-mce-style="color: #ffff00;"><span style="color: #000000;" data-mce-style="color: #000000;">06 Sep 2015 |</span> <span style="color: #993366;" data-mce-style="color: #993366;">"I will create my own keylogger. and install it in their computer."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing</span><br style="color: #ffff00;" data-mce-style="color: #ffff00;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p><p> </p>   ', 9),
(26, '2015-09-13 00:00:00', '     <p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><h2><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">Fight in Hostel!!</span><br data-mce-bogus="1"></h2><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">I was watching a movie "Drashyam". It is a nice movie. Then I heard sounds of quarrel. I reduced the volume and got to know that all the people of my nearby were fighting madly. First I opened my door.&nbsp; Then I saw all people were gone mad. The people from upstair''s came to nearby room and all were inside. And They were fighting against each other for some reason. Later I got to know that people from nearby room had said something wrong about haryana and the people who were staying upstair and were new started fighting for this. And 5-6 of those new people start beating those 2-3. Then others also joined. Some to help as brother, some to stop fight but start fighting themself later etc. <br data-mce-bogus="1"></span></p><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">I closed the door and called the police. Uncles (PG''s master) and Anty came, Nearly in 5 minutes fight was stopped. But they were still shouting at each other. Then I opened the door and tried to solve out the matter, which was impossible. In nearly 10 minutes police was on door. Whenever anybody asked who called the police I let them know. But uncle and all sent the police back because now nobody wanted to pull the matter. Uncles and Aunt tried to talk to everybody. <br data-mce-bogus="1"></span></p><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);"><br data-mce-bogus="1"></span></p><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);"><br data-mce-bogus="1"></span></p><hr><p><span style="color: rgb(255, 255, 0);" data-mce-style="color: #ffff00;"><span style="color: #000000;" data-mce-style="color: #000000;">06 Sep 2015 |</span> <span style="color: #993366;" data-mce-style="color: #993366;">"I will create my own keylogger. and install it in their computer."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing</span></p><p>  </p>     ', 9),
(27, '2015-09-13 00:00:00', ' <p> </p><p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><h2><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">Laptop is going. What to do!</span><br></h2><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">Last day my brother monu told me that he will need laptop. I was planning to go home on 25th, so he said he will get laptop when I will be there. 25th is Eid. So he will also be there. I don''t know how I will live without lappy, programming etc. </span></p><p><span data-mce-style="color: #333399;" style="color: rgb(51, 51, 153);">Then I started looking for some PC on internet to buy on EMI. But the problem was all the lappy''s that are available on EMI''s doesn''t support any bank''s debit card in which my account is. I cannot leave without lappy easily. I will have to find some way out or live without laptop and programming. <br data-mce-bogus="1"></span></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: rgb(255, 255, 0);" data-mce-style="color: #ffff00;"><span style="color: #993366;" data-mce-style="color: #993366;"><span style="color: #000000;" data-mce-style="color: #000000;">06 Sep 2015 |</span> "I will create my own keylogger. and install it in their computer."<br><span style="color: #000000;" data-mce-style="color: #000000;">13 Sep 2015  |</span> "I cannot leave without lappy easily."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p> ', 9),
(28, '2015-09-13 00:00:00', ' <p> </p><p> </p><p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><p><br></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><hr><p><span style="color: rgb(255, 255, 0);" data-mce-style="color: #ffff00;"><span style="color: #993366;" data-mce-style="color: #993366;"><span style="color: #000000;" data-mce-style="color: #000000;"><span data-mce-style="color: #993300;" style="color: rgb(153, 51, 0);">Put an email to CEO that you are taking a leave on 24 and 25.&nbsp;&nbsp; Book railway ticket for 24th</span><br>06 Sep 2015 |</span> "I will create my own keylogger. and install it in their computer."<br><span style="color: #000000;" data-mce-style="color: #000000;">13 Sep 2015 |</span> "I cannot leave without lappy easily."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></span></p><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;">&nbsp;&nbsp;&nbsp; 1. <span style="color: #000080;" data-mce-style="color: #000080;">When writing basic stuff (Like description, happenings etc) [indigo]</span><br>&nbsp;&nbsp;&nbsp; 2. <span style="color: #ffff00;" data-mce-style="color: #ffff00;">Some thought / quote / inspiring words etc. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; [yellow]<br></span>&nbsp;&nbsp;&nbsp; 3. <span style="color: #800000;" data-mce-style="color: #800000;">!!REMINDERS!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [burnt orange]</span><br>&nbsp;&nbsp;&nbsp; 4. <span style="color: #008000;" data-mce-style="color: #008000;">Daily common description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #008000;" data-mce-style="color: #008000;">[green]</span></span><br>&nbsp;&nbsp;&nbsp; 5. <span style="color: #800080;" data-mce-style="color: #800080;">Plans&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [red violet]</span><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p><p> </p> ', 9),
(29, '2015-09-15 00:00:00', '       <p> </p><h2><span style="color: rgb(51, 51, 153);">Plan to leave enbraun<br data-mce-bogus="1"></span></h2><p><span style="color: rgb(51, 51, 153);">ENBRAUN! I cannot forget when Rudraksh sir told me that I will be getting 15K salary. And now what I am getting is 12K. I am really really unsatisfied with my salary. Those things were making me sad. But after thinking for some time I realized that there is nothing wrong. I would hardly be getting a job where I could have been exposed to such technologies. <br>I will leave this company. I will keep stayed here untill I will get anything more than 30K from other company. As I know this company will never give me 30K. Neither now, nor after 1 year. Now this company is like a base for me. I will leave this comany but I will have to plan for it really really very carefully now. I know that there are no jobs now in market. The reason is this time period. I will start looking for another job and will try to get a job of nearly 30K after 1 year. Will break bond. and then I could give that 35K to them. <br>I will have to keep improving my skills. Now plan is to use some time of office to learn "Spring". Nobody will be able to know that I have worked on spring or not. It is only my knowledge which can let them know that thing. <br data-mce-bogus="1"></span></p><p><span style="color: rgb(51, 51, 153);"> By the way, Plan changed. I am not booking railway ticket. Because it is in waiting. So I will have to go via bus now. :) </span><br><span style="color: rgb(51, 51, 153);">Now I will go home on night of 23rd and reach Rishikesh on 24th. Then stay there for some time and will come back on the morning of 28th September.</span><br></p><p><br data-mce-bogus="1"></p><p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: rgb(255, 255, 0);"><span style="color: rgb(153, 51, 102);"><span style="color: rgb(0, 0, 0);"><span style="color: rgb(153, 51, 0);">Put an email to CEO that you are taking a leave on 24 and 25.&nbsp;&nbsp; Book railway ticket for 24th</span><br>06 Sep 2015 |</span> "I will create my own keylogger. and install it in their computer."<br><span style="color: rgb(0, 0, 0);">13 Sep 2015 |</span> "I cannot leave without lappy easily."</span><br><span style="color: rgb(0, 0, 0);">15 Sep 2015 |</span> <span data-mce-style="color: #993366;" style="color: rgb(153, 51, 102);">"use some time of office to learn ''Spring''"&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; "try to get a job of nearly 30K after 1 year. Will break bond."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing </span><br style="color: rgb(255, 255, 0);"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br></p><p> </p><p> </p>       ', 9),
(33, '2015-09-15 00:00:00', '           <p><span style="color: #003366;" data-mce-style="color: #003366;"><span style="color: #000000;" data-mce-style="color: #000000;"></span></span></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><p><br data-mce-bogus="1"></p><hr><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;"><span style="color: #ffff00;" data-mce-style="color: #ffff00;"><span style="color: #993366;" data-mce-style="color: #993366;"><span style="color: #000000;" data-mce-style="color: #000000;"><span style="color: #993300;" data-mce-style="color: #993300;">Put an email to CEO that you are taking a leave on 24 and 25.&nbsp;&nbsp; Book railway ticket for 24th</span><br>06 Sep 2015 |</span> "I will create my own keylogger. and install it in their computer."<br><span style="color: #000000;" data-mce-style="color: #000000;">13 Sep 2015 |</span> "I cannot leave without lappy easily."</span><br><span style="color: #000000;" data-mce-style="color: #000000;">15 Sep 2015 |</span> <span style="color: rgb(153, 51, 102);" data-mce-style="color: #993366;">"use some time of office to learn ''Spring''"&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; "try to get a job of nearly 30K after 1 year. Will break bond."</span><br>Meditaion is anything that you do with all your ability. Being awared of everything you are doing </span></p><p style="padding-left: 30px;" data-mce-style="padding-left: 30px;">&nbsp;&nbsp;&nbsp; 1. <span style="color: #000080;" data-mce-style="color: #000080;">When writing basic stuff (Like description, happenings etc) [indigo]</span><br>&nbsp;&nbsp;&nbsp; 2. <span style="color: #ffff00;" data-mce-style="color: #ffff00;">Some thought / quote / inspiring words etc. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; [yellow]<br></span>&nbsp;&nbsp;&nbsp; 3. <span style="color: #800000;" data-mce-style="color: #800000;">!!REMINDERS!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [burnt orange]</span><br>&nbsp;&nbsp;&nbsp; 4. <span style="color: #008000;" data-mce-style="color: #008000;">Daily common description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #008000;" data-mce-style="color: #008000;">[green]</span></span><br>&nbsp;&nbsp;&nbsp; 5. <span style="color: #800080;" data-mce-style="color: #800080;">Plans&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [red violet]</span><br></p><pre style="text-align: right;" data-mce-style="text-align: right;"><em>theme / from 15th September / Page 2</em></pre><p> </p><p> </p><p>  </p>           ', 9);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=127 ;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`id`, `checked`, `task_name`, `comment`, `recorder_id`, `user_id`, `task_type`) VALUES
(92, b'1', 'Checkout', '', 113, 9, 'daily'),
(96, b'0', 'Checkout', 'Internet is not working...', 116, 9, 'daily'),
(97, b'1', 'Checkout', '', 117, 9, 'daily'),
(98, b'1', 'Checkout', '', 118, 9, 'daily'),
(99, b'0', 'Checkout', '', 119, 9, 'daily'),
(100, b'0', 'Checkout', '', 120, 9, 'daily'),
(101, b'0', 'Checkout', '', 121, 9, 'daily'),
(102, b'0', 'Checkout', '', 122, 9, 'daily'),
(103, b'0', 'Checkout', '', 123, 9, 'daily'),
(104, b'0', 'Checkout', '', 124, 9, 'daily'),
(105, b'0', 'Checkout', '', 125, 9, 'daily'),
(106, b'0', 'Checkout', '', 126, 9, 'daily'),
(107, b'0', 'Checkout', '', 127, 9, 'daily'),
(109, b'0', 'Checkout', '', 129, 9, 'daily'),
(110, b'0', 'Checkout', '', 130, 9, 'daily'),
(111, b'0', 'Checkout', '', 131, 9, 'daily'),
(112, b'1', 'Checkout', '', 132, 9, 'daily'),
(115, b'0', 'Checkout', '', 134, 9, 'daily'),
(116, b'1', 'Checkout', '', 135, 9, 'daily'),
(117, b'1', 'Checkout', '', 136, 9, 'daily'),
(118, b'0', 'Checkout', '', 137, 9, 'daily'),
(119, b'0', 'Checkout', '', 138, 9, 'daily'),
(120, b'0', 'Checkout', '', 139, 9, 'daily'),
(121, b'0', 'Checkout', '', 140, 9, 'daily'),
(122, b'0', 'Checkout', '', 141, 9, 'daily'),
(123, b'0', 'Checkout', '', 142, 9, 'daily'),
(124, b'0', 'Checkout', '', 143, 9, 'daily'),
(125, b'0', 'Checkout', '', 144, 9, 'daily'),
(126, b'0', 'Checkout', '', 145, 9, 'daily');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=146 ;

--
-- Dumping data for table `recorder`
--

INSERT INTO `recorder` (`id`, `added`, `date`, `user_id`) VALUES
(113, b'1', '2015-08-25 00:00:00', 9),
(116, b'1', '2015-08-27 00:00:00', 9),
(117, b'1', '2015-08-26 00:00:00', 9),
(118, b'1', '2015-08-24 00:00:00', 9),
(119, b'1', '2015-08-29 00:00:00', 9),
(120, b'1', '2015-08-30 00:00:00', 9),
(121, b'1', '2015-09-01 00:00:00', 9),
(122, b'1', '2015-09-02 00:00:00', 9),
(123, b'1', '2015-09-04 00:00:00', 9),
(124, b'1', '2015-09-03 00:00:00', 9),
(125, b'1', '2015-08-31 00:00:00', 9),
(126, b'1', '2015-08-28 00:00:00', 9),
(127, b'1', '2015-09-06 00:00:00', 9),
(129, b'1', '2015-09-08 00:00:00', 9),
(130, b'1', '2015-09-09 00:00:00', 9),
(131, b'1', '2015-09-05 00:00:00', 9),
(132, b'1', '2015-09-07 00:00:00', 9),
(134, b'1', '2015-09-10 00:00:00', 9),
(135, b'1', '2015-09-11 00:00:00', 9),
(136, b'1', '2015-09-12 00:00:00', 9),
(137, b'1', '2015-09-13 00:00:00', 9),
(138, b'1', '2015-09-15 00:00:00', 9),
(139, b'1', '2015-09-20 00:00:00', 9),
(140, b'1', '2015-09-19 00:00:00', 9),
(141, b'1', '2015-09-18 00:00:00', 9),
(142, b'1', '2015-09-17 00:00:00', 9),
(143, b'1', '2015-09-16 00:00:00', 9),
(144, b'1', '2015-09-14 00:00:00', 9),
(145, b'1', '2015-09-26 00:00:00', 9);

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
(5, 'Checkout', 'Checkout some common websites : <br />\r\n1. http://localhost/notifier/notes.php <br />\r\n2. http://stackoverflow.com <br />\r\n3. https://hackerearth.com', '2015-08-24 02:08:36', 13, 9);

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
  `default_note` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `userpass`, `createdon`, `loggedin_hash`, `loggedin_last`, `default_note`) VALUES
(9, 'afzalex', 'cNTeHIl4VG6M6', '2015-08-24 02:05:54', 'fgTsNkWF2loY.', '2015-09-15 22:29:28', 33);

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
