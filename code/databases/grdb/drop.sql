-- The cascade constraints clause on some of the tables drops foreign key constraints 
-- created automatically by Hibernate/Oracle.
DROP TABLE Enrollment;
DROP TABLE GradeValue;
DROP TABLE AssignmentType;
DROP TABLE StudentAssignment;
DROP TABLE TeamAssignment;
DROP TABLE Assignment;
DROP TABLE StudentTeam;
DROP TABLE Team;
DROP TABLE Student cascade constraints;
DROP TABLE Section cascade constraints;
DROP TABLE Prerequisite;
DROP TABLE Course cascade constraints;
