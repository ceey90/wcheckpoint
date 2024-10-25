	---Create Wcheckpoint db
CREATE DATABASE Wcheckpoint;
GO

USE Wcheckpoint;
GO

	---Create wine table
CREATE TABLE wine (
	WineNum INT PRIMARY KEY,
	Category VARCHAR(25),
	Year INT,
	Degree DECIMAL(5,2)
);

---Create producer table
CREATE TABLE producer (
	ProdNum INT PRIMARY KEY,
	FirstName VARCHAR(25),
	LastName VARCHAR(25),
	Region VARCHAR(25),
	WineNum INT FOREIGN KEY references wine(WineNum)
);

	---Create harvest table
CREATE TABLE harvest (
	WineNum INT FOREIGN KEY references wine (WineNum),
	ProdNum INT FOREIGN KEY references producer (ProdNum),
	Quantity INT
);


INSERT INTO wine (WineNum, Category, Year, Degree)
VALUES
(1, 'Red', 2019, 13.5),
(2, 'White', 2020, 12.0),
(3, 'Rose', 2018, 11.5),
(4, 'Red', 2021, 14.0),
(5, 'Sparkling', 2017, 10.5),
(6, 'White', 2019, 12.5),
(7, 'Red', 2022, 13.0),
(8, 'Rose', 2020, 11.0),
(9, 'Red', 2018, 12.0),
(10, 'Sparkling', 2019, 10.0),
(11, 'White', 2021, 11.5),
(12, 'Red', 2022, 15.0)

SELECT * FROM wine

INSERT INTO producer (ProdNum, FirstName, LastName, Region, WineNum)
VALUES
(1, 'John', 'Smith', 'Sousse', 1),
(2, 'Emma', 'Johnson', 'Tunis',2),
(3, 'Michael', 'Williams', 'Sfax',3),
(4, 'Emily', 'Brown', 'Sousse',4),
(5, 'James', 'Jones', 'Sousse',5),
(6, 'Sarah', 'Davis', 'Tunis', 6),
(7, 'David', 'Miller', 'Sfax', 7),
(8, 'Olivia', 'Wilson', 'Monastir', 8),
(9, 'Daniel', 'Moore', 'Sousse', 9),
(10, 'Sophia', 'Taylor', 'Tunis', 10),
(11, 'Matthew', 'Anderson', 'Sfax', 11),
(12, 'Amelia', 'Thomas', 'Sousse', 12)

SELECT * FROM producer

INSERT INTO harvest (WineNum, ProdNum, Quantity)
VALUES
(1, 1, 1000),
(2, 2, 850),
(3, 3, 500),
(4, 4, 1100),
(5, 5, 4000),
(6, 6, 900),
(7, 7, 1200),
(8, 8, 450),
(9, 9, 600),
(10, 10, 900),
(11, 11, 350),
(12, 12, 700)

SELECT * FROM harvest

	---Retrieve a list of all producers.
SELECT FirstName, LastName
FROM producer

	---Retrieve a sorted list of producers by name.
SELECT FirstName, LastName
FROM producer
ORDER BY FirstName, LastName ASC

	---Retrieve a list of producers from Sousse.
SELECT FirstName, LastName
FROM producer
WHERE Region = 'Sousse'

	---Calculate the total quantity of wine produced with the wine number 12.
SELECT SUM(Quantity) AS TQ
FROM harvest
WHERE WineNum = 12

	---Calculate the quantity of wine produced for each category.
SELECT wine.Category, SUM(harvest.Quantity) AS QWP
FROM harvest
INNER JOIN wine ON harvest.WineNum = wine.WineNum
GROUP BY wine.Category

	---Find producers in the Sousse region who have harvested at least one wine in quantities greater than 300 liters. Display their names and first names, sorted alphabetically.
SELECT producer.FirstName, producer.LastName, harvest.Quantity
FROM producer
INNER JOIN harvest ON producer.ProdNum = harvest.ProdNum
WHERE producer.Region = 'Sousse' AND harvest.Quantity > 300
ORDER BY  producer.FirstName, producer.LastName ASC

	---List the wine numbers with a degree greater than 12, produced by producer number 24.
SELECT wine.WineNum, wine.Degree, producer.ProdNum
FROM wine
INNER JOIN producer ON wine.WineNum = producer.ProdNum
WHERE wine.Degree > 12 AND producer.ProdNum = 24

	---Find the producer who has produced the highest quantity of wine.
SELECT TOP 1 harvest.ProdNum, harvest.Quantity, producer.FirstName, producer.LastName
FROM harvest
INNER JOIN producer ON harvest.ProdNum = producer.ProdNum
ORDER BY Quantity DESC

	---Find the average degree of wine produced.
SELECT AVG(Degree) AS AD
FROM wine

	---Find the oldest wine in the database.
SELECT TOP 1 WineNum, Year
FROM wine
ORDER BY Year ASC

	---Retrieve a list of producers along with the total quantity of wine they have produced.
SELECT producer.ProdNum, SUM(harvest.Quantity) AS TQ
FROM producer
INNER JOIN harvest ON producer.ProdNum = harvest.ProdNum
GROUP BY producer.ProdNum

	---Retrieve a list of wines along with their producer details.
SELECT wine.WineNum, wine.Category, producer.FirstName, producer.LastName, producer.Region
FROM wine
INNER JOIN producer ON wine.WineNum = producer.WineNum
