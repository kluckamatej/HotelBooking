DROP TABLE IF EXISTS SalesSystem.SalesOrder;
DROP TABLE IF EXISTS SalesSystem.SalesPerson;
DROP TABLE IF EXISTS SalesSystem.Customer;

DROP DATABASE IF EXISTS SalesSystem;

# ------------ 1. Create Database ------------
CREATE DATABASE SalesSystem;

USE SalesSystem;

# ------------ 2. Create 3 relations ------------
CREATE TABLE SalesPerson
(
	name 			VARCHAR(35),
	percentOfQuota	INT(2),
	salary			INT(8),
	PRIMARY KEY(name)
) ENGINE = INNODB;

CREATE TABLE Customer
(
	name 			VARCHAR(35),
	city			VARCHAR(35),
	industryType	CHAR,
	PRIMARY KEY(name)
) ENGINE = INNODB;

CREATE TABLE SalesOrder
(
	number			INT,
	custName		VARCHAR(35) NOT NULL,
	salesPerson		VARCHAR(35) NOT NULL,
	amount			INT,
	PRIMARY KEY(number),
	FOREIGN KEY(custName) REFERENCES Customer(name) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(salesPerson) REFERENCES SalesPerson(name) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

# ------------ 3. Insert data into tables ------------
INSERT INTO SalesPerson (name, percentOfQuota, salary)
	VALUES
	('Abel', 63, 12000),
	('Baker', 38, 42000),
	('Jones', 26, 36000),
	('Murphy', 42, 50000),
	('Zenith', 59, 118000),
	('Kobad', 27, 36000);
	
INSERT INTO Customer (name, city, industryType)
	VALUES
	('Abernathy Construction', 'Willow', 'B'),
	('Manchester Lumber', 'Manchester', 'F'),
	('Tri-City Builders', 'Memphis', 'B'),
	('Amalgamated Housing', 'Memphis', 'B');
	
INSERT INTO SalesOrder (number, custName, salesPerson, amount)
	VALUES
	(100, 'Abernathy Construction', 'Zenith', 560),
	(200, 'Abernathy Construction', 'Jones', 1800),
	(300, 'Manchester Lumber', 'Abel', 480),
	(400, 'Amalgamated Housing', 'Abel', 2500),
	(500, 'Abernathy Construction', 'Murphy', 6000),
	(600, 'Tri-City Builders', 'Abel', 700),
	(700, 'Manchester Lumber', 'Jones', 150);
	
# ------------ 4. Show the salaries of all sales people ------------
SELECT salary FROM SalesPerson;

# ------------ 5. Show the salaries of all sales people avoid duplicates ------------
SELECT name, salary FROM SalesPerson;

# ------------ 6. Show the sales people under 30% of qouta ------------
SELECT name FROM SalesPerson 
WHERE 
	percentOfQuota<30;

# ------------ 7. Show the names of sales people who have an order with Abernathy Construction ------------
SELECT name FROM SalesPerson JOIN SalesOrder ON (name=salesPerson)  
WHERE 
	custName='Abernathy Construction';

# ------------ 8. Show the names of sales people who earn more than 49999 and less than 100000 ------------
SELECT name FROM SalesPerson 
WHERE 
	(salary > 49999) AND (salary < 100000);

# ------------ 9. Show the names of sales people percent of qaota greather than 49 and less than 60 ------------
SELECT name FROM SalesPerson 
WHERE 
	( percentOfQuota > 49) AND (percentOfQuota < 60);

# ------------ 10. Show the names of sales people percent of qaota greather than 49 and less than 60 with LIKE (Very Strange Execercise - never do this in a real system)------------
SELECT name FROM Salesperson 
WHERE 
	percentOfQuota LIKE '5_';

# ------------ 11. Show the names of customers who are located in a city ending with 's' ------------
SELECT name FROM Customer 
WHERE 
	city LIKE '%s';

# ------------ 12. Show the names and salary of all salespeople who do not have an order with 'Abernathy Construction', in ascending order of salary ------------
SELECT name, salary FROM SalesPerson 
WHERE 
	name NOT IN (SELECT salesPerson FROM SalesOrder 
				 WHERE 
					custName='Abernathy Construction') 
ORDER BY salary ASC;

# ------------ 13. Compute the number of orders
SELECT COUNT(*) FROM SalesOrder;

# ------------ 14. Compute the number of different customers who have an order
SELECT COUNT(DISTINCT custName) FROM SalesOrder;

# ------------ 15. Compute the average percent of quota for salespeople
SELECT AVG(percentOfQuota) FROM SalesPerson;

# ------------ 16. Show the name of the salesperson with highest percent of quota
SELECT name FROM SalesPerson 
WHERE 
	percentOfQuota = (SELECT MAX(percentOfQuota) FROM SalesPerson );

# ------------ 17. Compute the number of orders for each salesperson
SELECT salesPerson, COUNT(salesPerson) FROM SalesOrder 
GROUP BY SalesPerson;

# ------------ 18. Compute the number of orders for each salesperson, considering only orders for an amount exceeding 500
SELECT salesPerson, COUNT(Number) FROM SalesOrder 
WHERE 
	amount > 500 
GROUP BY SalesPerson;

# ------------ 19. Show the names and quota percentages of salespeople who have an order with 'Abernathy Construction', in descending order of quota percentage (use a join)
SELECT name, percentOfQuota FROM SalesPerson JOIN SalesOrder ON (name = salesPerson) 
WHERE 
	custName = 'Abernathy Construction' 
ORDER BY percentOfQuota DESC;

# ------------ 20. Show the quota percentages of salespeople who have an order with a customer in Memphis (use a join)
SELECT percentOfQuota FROM SalesPerson JOIN SalesOrder ON (name = salesPerson) 
WHERE (
	SELECT city FROM Customer 
	WHERE 
		custName = name) = 'Memphis' 
GROUP BY name;

# ------------ 21. Show the names of salespeople along with the names of the customers which have ordered from them. Include salespeople who have had no orders
SELECT p.name FROM SalesPerson p, Customer c LEFT JOIN SalesOrder o ON (o.salesPerson = p.name);

# ------------ 22. Show the names of salespeople who have two or more orders
SELECT name FROM SalesPerson 
WHERE 
	(SELECT COUNT(salesPerson) FROM SalesOrder 
	 WHERE 
		name = salesPerson) >=2;