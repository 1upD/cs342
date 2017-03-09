-- Sample version of the Movies database for guide 6 (copied from unit 5)
--
-- CS 342, Spring, 2017
-- kvlinden

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL,
	year decimal(4),
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	firstName varchar(20),
	lastName varchar(25),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison', 'Ford');
INSERT INTO Performer VALUES (2,'Rutger', 'Hauer');
INSERT INTO Performer VALUES (3,'Chewbacca', NULL);
INSERT INTO Performer VALUES (4,'Rachael', NULL);
INSERT INTO Performer VALUES (5,'Rex', 'Harrison');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');


-- Implement an inner join (Section 7.1.6).
SELECT Performer.firstName, Performer.lastName, Casting.status
FROM Casting
INNER JOIN Performer
ON Performer.id = Casting.performerId;

-- Implement an outer join (Section 7.1.6).
SELECT Performer.firstName, Performer.lastName, Casting.status
FROM Casting
FULL OUTER JOIN Performer
ON Performer.id = Casting.performerId;

-- Use an aggregate function (Section 7.1.7).
SELECT COUNT(1) FROM Casting;

-- Use grouping (Section 7.1.8).
SELECT status, COUNT(1) FROM Casting GROUP BY status;
