-- Create users.
DROP USER lddbUser CASCADE;
CREATE USER lddbUser IDENTIFIED BY bjarne; 
-- This password is a test password and is not for production.

-- These permissions are required by the scripts that load the database and it's procedures, triggers, and views
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, CREATE TRIGGER, CREATE VIEW, CREATE MATERIALIZED VIEW, UNLIMITED TABLESPACE, CREATE SEQUENCE TO lddbUser;

-- Create the directory for the datapump
DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\Users\drd26\Documents\project';
GRANT READ, WRITE ON DIRECTORY exp_dir to lddbUser;


-- Load the database.
@load.sql