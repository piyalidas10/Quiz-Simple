-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 05, 2017 at 06:41 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `question_id` int(50) NOT NULL,
  `question` varchar(100) NOT NULL,
  `is_active` enum('0','1') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question_id`, `question`, `is_active`) VALUES
(1, 'Which is the largest country in the world by population?', '1'),
(2, 'When did the second world war end?', '1'),
(3, 'Which was the first country to issue paper currency?', '1'),
(4, 'Which city hosted the 1996 Summer Olympics?', '1'),
(5, 'Who invented telephone?', '1');

-- --------------------------------------------------------

--
-- Table structure for table `question_choices`
--

CREATE TABLE IF NOT EXISTS `question_choices` (
  `choice_id` int(50) NOT NULL,
  `question_id` int(50) NOT NULL,
  `is_right_choice` enum('0','1') NOT NULL,
  `choice` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question_choices`
--

INSERT INTO `question_choices` (`choice_id`, `question_id`, `is_right_choice`, `choice`) VALUES
(1, 1, '0', 'India'),
(2, 1, '0', 'USA'),
(3, 1, '1', 'China'),
(4, 1, '0', 'Russia'),
(1, 2, '1', '1945'),
(2, 2, '0', '1939'),
(3, 2, '0', '1944'),
(4, 2, '0', '1942'),
(1, 3, '0', 'USA'),
(2, 3, '0', 'France'),
(3, 3, '0', 'Italy'),
(4, 3, '1', 'China'),
(1, 4, '1', 'Atlanta'),
(2, 4, '0', 'Sydney'),
(3, 4, '0', 'Athens'),
(4, 4, '0', 'Beijing'),
(1, 5, '0', 'Albert Einstein'),
(2, 5, '1', 'Alexander Graham Bell'),
(3, 5, '0', 'Isaac Newton'),
(4, 5, '0', 'Marie Curie');

