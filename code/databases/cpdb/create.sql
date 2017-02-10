-- Create the Centrepointe church user and database. 
-- See ../README.md for details.

-- Create the user.
DROP USER cpdb CASCADE;
CREATE USER cpdb 
	IDENTIFIED BY bjarne
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO cpdb;

-- Connect to the user's account/schema.
CONNECT cpdb/bjarne;

-- Create the database.
DEFINE cpdb=D:\projects\cs342\code\databases\cpdb
@&cpdb\load
