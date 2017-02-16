-- To enumerate the casting status types without using a constraint, instead create a separate table for statuses.
-- This way statuses can be added or removed as necessary.
-- Casting relations have references to statuses.
-- If a status is deleted, it any referencing records should have their status foreign keys set to null.

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP TABLE Status;

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900),
	CHECK (votes > 1000 OR score is NULL)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);
	
CREATE TABLE Status (
	id integer,
	name varchar(6),
	PRIMARY KEY (id)
);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	statusId integer,
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	FOREIGN KEY (statusId) REFERENCES Status(Id) ON DELETE SET NULL
	);

-- Load sample data
INSERT INTO Status VALUES (1, 'star');
INSERT INTO Status VALUES (2, 'costar');
INSERT INTO Status VALUES (3, 'extra');


INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 10000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 2000);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,1);
INSERT INTO Casting VALUES (1,3,3);
INSERT INTO Casting VALUES (2,1,1);
INSERT INTO Casting VALUES (2,2,2);
INSERT INTO Casting VALUES (2,4,2);