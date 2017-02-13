-- This schema is modified slightly from the original IMDB database schema.
-- The Genre table and its related foreign keys are new as are CHECK constraints. 

CREATE TABLE Actor (
	id integer,
	firstName varchar(100),
	lastName varchar(100),
	gender char(1),
	PRIMARY KEY (id)
	);

CREATE TABLE Director (
	id integer,
	firstName varchar(100),
	lastName varchar(100),
	PRIMARY KEY (id)
	);
	
CREATE TABLE Genre (
	genre varchar(20),
	PRIMARY KEY (genre)
	);

CREATE TABLE DirectorGenre (
	directorId integer,
	genre varchar(20),
	probability number(12,10),
	FOREIGN KEY (directorId) REFERENCES Director(id),
	FOREIGN KEY (genre) REFERENCES Genre(genre),
	CHECK ((probability >= 0.0) AND (probability <= 1.0))
	);

CREATE TABLE Movie (
	id integer,
	name varchar(100),
	year integer,
	rank number(10,2),
	sequelId integer,
	PRIMARY KEY (id),
	FOREIGN KEY (sequelId) REFERENCES Movie(id),
	CHECK (rank >= 0)
	); 

CREATE TABLE MovieDirector (
	directorId integer,
	movieId integer,
	FOREIGN KEY (directorId) REFERENCES Director(id), 
	FOREIGN KEY (movieId) REFERENCES Movie(id)
	);

CREATE TABLE MovieGenre (
	movieId integer,
	genre varchar(20),
	FOREIGN KEY (movieId) REFERENCES Movie(id),
	FOREIGN KEY (genre) REFERENCES Genre(genre)	
	);
	
CREATE TABLE Role (
	actorId integer,
	movieId integer,
	role varchar(100),
	PRIMARY KEY (actorId, movieId, role),
	FOREIGN KEY (actorId) REFERENCES Actor(id),
	FOREIGN KEY (movieId) REFERENCES Movie(id)
	);
	

