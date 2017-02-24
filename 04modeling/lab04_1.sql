-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden
drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');

-- a. Explain, informally, why the relation is not well-designed and then prove your point formally.
--	The relation is not well designed because information is duplicated across multiple records. The relation
--	does not satisfy BCNF because mentorName and mentorStatus are functionally dependent on mentorID, which is
--	not a superkey of the relation.

-- b. Specify a properly normalized schema for this database.
--	Each person should only have a mentorID, which is a foreign key to another entry in the person table.
--	Additionally, there should be a separate table for teams with a team ID, team name, and team week day. 
--	Each person should have a team ID and team role, but since Shamkant demonstrates that one person can have
--	multiple teams, there should be a role table to define a many to many relationship in which each person can
--	have many teams, each with a separate role.

DROP TABLE Role;
DROP TABLE Team;
DROP TABLE Person;

CREATE TABLE Team(
	teamName VARCHAR(10) PRIMARY KEY,
	teamTime VARCHAR(10)
);

CREATE TABLE Person (
	personID INTEGER PRIMARY KEY,
	name VARCHAR(10),
	status CHAR(1),
	mentorID INTEGER,
	FOREIGN KEY (mentorID) REFERENCES Person(personID) ON DELETE SET NULL
);

CREATE TABLE Role (
	personID INTEGER,
	teamName VARCHAR(10),
	teamRole VARCHAR(10),
	PRIMARY KEY (personID, teamName),
	FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE,
	FOREIGN KEY (teamName) REFERENCES Team(teamName) ON DELETE CASCADE
);

-- Populate new person table from altperson
INSERT INTO Person SELECT UNIQUE personID, name, status, mentorID FROM AltPerson;

--Populate team table from altperson
INSERT INTO Team SELECT UNIQUE teamName, teamTime FROM AltPerson;

-- Create role table
INSERT INTO Role SELECT UNIQUE personID, teamName, teamRole FROM AltPerson;

-- Display data
SELECT Person.personID, Person.name, Person.status, Person.mentorID, Team.teamName, Role.teamRole, Team.teamTime FROM Person, Team, Role WHERE Team.teamName = Role.teamName AND Person.personID = Role.personID;