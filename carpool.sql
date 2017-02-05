-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 06, 2016 at 02:04 PM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Table structure for table `user`
--
CREATE TABLE `user` (
  	`id` int(11) NOT NULL,
  	`first_name` varchar(100) DEFAULT NULL,
  	`last_name` varchar(100) DEFAULT NULL,
  	`email` varchar(200) NOT NULL,
  	`username` varchar(100) NOT NULL,
  	`pw` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Table structure for table `product`
--
CREATE TABLE `product` (
  	`id` int(11) NOT NULL,
  	`name` varchar(100) NOT NULL,
  	`description` text NOT NULL,
  	`destination` varchar(100) NOT NULL,
  	`source` varchar(100) NOT NULL,
	 `leave_time` varchar(100) NOT NULL,
 	  `price` decimal(10,2) NOT NULL,
  	`img_url` varchar(200) DEFAULT NULL,
  	`date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	`creator_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--
INSERT INTO 
`user` (`id`, `first_name`, `last_name`, `email`, `username`, `pw`) 
VALUES
(1, 'Matt', 'Blumen', 'matthb7@vt.edu', 'matthb7', '1234');
--
-- Dumping data for table `product`
--
INSERT INTO 
`product` (`id`, `name`, `description`, `destination`, `source`, 
	`leave_time`, `price`, `img_url`, `date_created`, `creator_id`) 
VALUES 
(1, 'Shelby', 'Hello', 'Richmond', 'Blacksburg', '4pm', 
	'20.00', 'p1.jpg', '2016-10-06 11:49:30', 1),
(2, 'Pat', 'Hi There', 'Fairfax', 'Richmond', '12pm', 
	'15.00', 'p2.jpg', '2016-10-06 11:49:35', 1),
(3, 'Julia', 'Hey Guys', 'Blacksburg', 'Brick', '8am', 
  '15.00', 'p3.jpg', '2016-10-06 11:49:40', 1),
(4, 'Elliot', 'Yo Boys', 'Alexandria', 'Baltimore', '8pm', 
  '20.00', 'p4.jpg', '2016-10-06 11:49:45', 1),
(5, 'Henry', 'Hey', 'San Francisco', 'Columbus', '6pm', 
  '50.00', 'p5.jpg', '2016-10-06 11:49:50', 1);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `added_by` (`creator_id`);

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`);