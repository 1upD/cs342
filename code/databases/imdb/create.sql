-- Create a user and database for a small version of the Internet Movie Database.
-- See ../README.md for details.

-- Create the user.
DROP USER imdb CASCADE;
CREATE USER imdb 
	IDENTIFIED BY bjarne
	QUOTA 500M ON System;
GRANT 
	CONNECT, 
	CREATE TABLE, 
	CREATE SESSION, 
	CREATE ANY DIRECTORY,
	DROP ANY DIRECTORY,
	CREATE SEQUENCE, 
	CREATE VIEW, 
	CREATE MATERIALIZED VIEW, 
	CREATE PROCEDURE, 
	CREATE TRIGGER, 
	PLUSTRACE,
	UNLIMITED TABLESPACE 
	TO imdb;

-- Connect to the user's account/schema.
CONNECT imdb/bjarne;

-- (Re)Create the database.
DEFINE imdb=D:\projects\cs342\code\databases\imdb
@&imdb\load