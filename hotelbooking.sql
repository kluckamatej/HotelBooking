CREATE TABLE IF NOT EXISTS `Hotel` (
  `hotelNo` int(11) NOT NULL,
  `hotelName` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`hotelNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE IF NOT EXISTS `Guest` (
  `guestNo` int(11) NOT NULL,
  `guestName` varchar(15) DEFAULT NULL,
  `guestAdress` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`guestNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE IF NOT EXISTS `Room` (
  `roomNo` int(11) NOT NULL,
  `hotelNo` int(11) NOT NULL,
  `type` varchar(15) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`roomNo`,`hotelNo`),
  FOREIGN KEY (hotelNO) REFERENCES Hotel(hotelNO)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `Booking` (
  `hotelNo` int(11) NOT NULL,
  `guestNo` int(11) NOT NULL,
  `dateFrom` date NOT NULL,
  `dateTo` date NOT NULL,
  `roomNo` int(11) NOT NULL,
  PRIMARY KEY (`hotelNo`,`guestNo`,`dateFrom`),
  FOREIGN KEY (roomNO) REFERENCES Room(roomNo),
  FOREIGN KEY (hotelNO) REFERENCES Room(hotelNO),
  FOREIGN KEY (guestNO) REFERENCES Guest(guestNO)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO Hotel (hotelNo, hotelName, city) VALUES
	(1, 'Scandic Bygholm Park', 'Horsens'),
	(2, 'Hotel Opus', 'Horsens'),
	(3, 'Grosvenor Hotel', 'Horsens'),
	(4, 'Jørgensens Hotel', 'Horsens'),
	(5, 'Hotel Australia','Vejle'),
	(6, 'Hotel Copenhagen D''Angleterre', 'København');

INSERT INTO Room (hotelNo, roomNo, type, price) VALUES
	(1, 1, 'Single', 900),
	(1, 2, 'Double', 1150),
	(1, 3, 'Suite', 1750),
	(1, 4, 'Luxus Suite', 2250),
	(1, 5, 'Weeding Suite', 3350),
	(2, 1, 'Single', 875),
	(2, 2, 'Double', 1050),
	(2, 3, 'Suite', 1675),
	(2, 4, 'Luxus Suite', 2100),
	(2, 5, 'Weeding Suite', 3700),
	(3, 1, 'Single', 850),
	(3, 2, 'Double', 1025),
	(3, 3, 'Suite', 1500),
	(3, 4, 'Luxus Suite', 1950),
	(3, 5, 'Weeding Suite', 3300),
	(4, 1, 'Single', 850),
	(4, 2, 'Double', 1025),
	(4, 3, 'Suite', 1500),
	(4, 4, 'Luxus Suite', 1950),
	(4, 5, 'Weeding Suite', 3300),
	(5, 1, 'Single', 1033),
	(5, 2, 'Double', 1275),
	(5, 3, 'Suite', 1734),
	(5, 4, 'Luxus Suite', 2750),
	(5, 5, 'Weeding Suite', 3900),
	(6, 1, 'Single', 1560),
	(6, 2, 'Double', 2374),
	(6, 3, 'Suite', 3750),
	(6, 4, 'Luxus Suite', 6250),
	(6, 5, 'Weeding Suite', 11750);

INSERT INTO Guest (guestNo, guestName, guestAdress) VALUES
	(1, 'Henrik Kronborg', 'Horsens'),
	(2, 'Clint Eastwood', 'Horsens'),
	(3, 'Ole Olsen', 'Vojens');

INSERT INTO Booking(hotelNo, GuestNo, dateFrom, dateTo, roomNo) VALUES
	(1, 2, '2009-10-26', '2009-10-28', 4),
	(4, 1, '2009-10-31', '2009-11-04', 3),
	(3, 3, '2009-12-01', '2009-12-28', 4),
	(6, 2, '2009-12-23', '2009-12-25', 5),
	(4, 3, '2010-01-11', NULL, 1);

