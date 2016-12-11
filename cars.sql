-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2016 at 01:37 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `infovisdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `ID` int(11) NOT NULL,
  `DATE` date NOT NULL,
  `HOUR` int(11) NOT NULL,
  `MINUTE` int(11) NOT NULL,
  `WEEKDAY` int(11) NOT NULL,
  `AUTOID` int(11) NOT NULL,
  `AUTONAME` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`ID`, `DATE`, `HOUR`, `MINUTE`, `WEEKDAY`, `AUTOID`, `AUTONAME`) VALUES
(1, '2016-12-05', 5, 34, 1, 124023, 'Babsi'),
(2, '2016-12-06', 13, 44, 2, 122343, 'Horst'),
(3, '2016-12-07', 12, 9, 3, 123873, 'Harry'),
(4, '2016-12-08', 12, 9, 4, 123233, 'Bob'),
(5, '2016-12-09', 0, 55, 5, 193789, 'Gordon'),
(6, '2016-12-10', 2, 1, 6, 323789, 'Eva'),
(7, '2016-12-11', 22, 54, 0, 138793, 'Tobi'),
(8, '2016-12-05', 22, 34, 0, 214353, 'Tom'),
(9, '2016-12-05', 22, 34, 0, 214353, 'Tom'),
(10, '2016-12-04', 2, 34, 6, 223453, 'Julia');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
