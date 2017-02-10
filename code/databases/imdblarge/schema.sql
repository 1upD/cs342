CREATE TABLE Actor (
  id integer NOT NULL,
  firstName varchar(100),
  lastName varchar(100),
  gender char(1),
  PRIMARY KEY (id)
  );

CREATE TABLE Director (
  id integer NOT NULL,
  firstName varchar(100),
  lastName varchar(100),
  PRIMARY KEY (id)
  );

CREATE TABLE DirectorGenre (
  directorId integer REFERENCES Director(id),
  genre varchar(100),
  probability number(12,10)
  );

CREATE TABLE Movie (
  id integer NOT NULL,
  name varchar(100),
  year integer,
  rank number(10,2),
  PRIMARY KEY (id)
  ); 

CREATE TABLE MovieDirector (
  directorId integer REFERENCES Director(id),
  movieId integer REFERENCES Movie(id) ON DELETE CASCADE
  );

CREATE TABLE MovieGenre (
  movieId integer REFERENCES Movie(id) ON DELETE CASCADE,
  genre varchar(100)
  );
  
CREATE TABLE Role (
  actorId integer REFERENCES Actor(id),
  movieId integer REFERENCES Movie(id) ON DELETE CASCADE,
  role varchar(100)
  );


