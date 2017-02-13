-- Create the user.
DROP USER imdbLarge CASCADE;
CREATE USER imdbLarge
	IDENTIFIED BY bjarne
	QUOTA 800M ON System;
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
	TO imdbLarge;
--GRANT IMP_FULL_DATABASE, EXP_FULL_DATABASE TO imdbLarge;

-- Set up the Oracle directory for the dump database feature.
-- Use Oracle directories for input/output files to avoid permissions problems. (?)
-- This is needed both to create and to load the *.dmp files.
DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'D:\projects\cs342\cs342-resources\databases\imdbLarge';
GRANT READ, WRITE ON DIRECTORY exp_dir to imdbLarge;

-- Load the database from the dump file using:
-- impdp imdbLarge/bjarne parfile=imdbLarge.par



