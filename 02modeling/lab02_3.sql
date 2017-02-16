-- The sequence movie_seq is used to generate ids for the movie table.
-- A subquery is used when casting records are added to identify the movie 
-- a casting is for by title.

-- Would you need an additional sequence for the performer relation primary key values? Why or why not?
--	The same sequence could potentially be used, but it would create gaps in the ids and would have the effect
--	of ensuring that no performer and movie had the same id.

-- Do you see any problems with using sequences in a DDL command file to construct the full movies database?
--	One problem I ran into was that foreign keys could no longer be hard coded in insert statements. I had to use a
--	subquery to find the correct id. I don't see this as a problem because those values shouldn't be hard coded anyway.

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP TABLE Status;

-- This sequence should be used for the Movie table
CREATE SEQUENCE movie_seq
START WITH      1000
INCREMENT BY    1
NOCACHE
NOCYCLE;

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


INSERT INTO Movie VALUES (movie_seq.nextval,'Star Wars',1977,8.9, 10000);
INSERT INTO Movie VALUES (movie_seq.nextval,'Blade Runner',1982,8.6, 2000);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

-- Normally some sort of join would have to be used to get the correct id for the movie
INSERT INTO Casting VALUES ((SELECT movie.id FROM movie WHERE movie.title = 'Star Wars'),1,1);
INSERT INTO Casting VALUES ((SELECT movie.id FROM movie WHERE movie.title = 'Star Wars'),3,3);
INSERT INTO Casting VALUES ((SELECT movie.id FROM movie WHERE movie.title = 'Blade Runner'),1,1);
INSERT INTO Casting VALUES ((SELECT movie.id FROM movie WHERE movie.title = 'Blade Runner'),2,2);
INSERT INTO Casting VALUES ((SELECT movie.id FROM movie WHERE movie.title = 'Blade Runner'),4,2);