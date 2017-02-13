-- Create the Centrepointe church user and database. 
-- See ../README.md for details.

-- Create the user.
DROP USER cpdbTest CASCADE;
CREATE USER cpdbTest
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
	TO cpdbTest;

-- Connect to the user's account/schema.
CONNECT cpdbTest/bjarne;

-- Create the database (schema only).
DEFINE cpdbTest=D:\projects\cs342\code\databases\cpdbTest
@&cpdbTest\load
