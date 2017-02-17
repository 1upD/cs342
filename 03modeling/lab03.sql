-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden


drop table PersonHouseHold;
drop table Mentorship;
drop table Role;
drop table PersonTeam;
drop table Team;
drop table Request;
drop table Person;
drop table Homegroup;
drop table HouseHold;

create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Homegroup(
	ID integer PRIMARY KEY
);
	
create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	-- Each person has 0 or 1 homegroup. If an individual does not have a homegroup set this field to NULL.
	homegroupID integer, 
	-- Do not cascade delete
	FOREIGN KEY (homegroupID) REFERENCES Homegroup(ID) ON DELETE SET NULL 
	);
	
CREATE TABLE Team (
	ID integer PRIMARY KEY,
	teamName varchar(16)
);

CREATE TABLE PersonTeam (
	personID INTEGER,
	teamID INTEGER,
	 -- There is no table for team roles because each team might arbitrarily create roles for each individual
	role varchar(16),
	PRIMARY KEY (personID, teamID),
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE CASCADE,
	FOREIGN KEY (teamID) REFERENCES Team(ID) ON DELETE CASCADE
);

CREATE TABLE Mentorship (
	mentorID integer,
	menteeID integer,
	FOREIGN KEY (mentorID) REFERENCES Person(ID) ON DELETE CASCADE,
	FOREIGN KEY (menteeID) REFERENCES Person(ID) ON DELETE CASCADE,
	PRIMARY KEY (mentorID, menteeID)
);
	
CREATE TABLE Role (
	ID integer PRIMARY KEY,
	name varchar(16)
);

CREATE TABLE PersonHouseHold (
	personID integer,
	houseHoldID integer,
	roleID integer,
	PRIMARY KEY (personID, houseHoldID),
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE CASCADE,
	FOREIGN KEY (houseHoldID) REFERENCES HouseHold(ID) ON DELETE CASCADE,
	FOREIGN KEY (roleID) REFERENCES Role(ID) ON DELETE CASCADE
);

CREATE TABLE Request (
	requestorID INTEGER,
	responderID INTEGER,
	requestDate DATE,
	text VARCHAR(256),
	-- TODO Enforce some sort of enumeration on access, possibly using a separate table
	requestAccess VARCHAR(15),
	response VARCHAR(256),
	PRIMARY KEY (requestorID, responderID),
	FOREIGN KEY (requestorID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY (responderID) REFERENCES Person(ID) ON DELETE SET NULL
);

 -- What about married people without children? Roles don't really make sense.
INSERT INTO Role VALUES (0, 'Parent');
-- What about children that are also adults? I need more clarification on the specifics of the role table.
INSERT INTO Role VALUES(1, 'Child'); 

INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Homegroup VALUES (0);

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m', 0);
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m', 0);

INSERT INTO Team VALUES (0, 'Test Team');
INSERT INTO PersonTeam VALUES (0, 0, 'Test Role A');
INSERT INTO PersonTeam VALUES (1, 0, 'Test Role B');

INSERT INTO PersonHouseHold VALUES (0, 0, 0);
INSERT INTO PersonHouseHold VALUES (1, 0, 0);

INSERT INTO Request VALUES (0, 1, DATE '2017-2-17', 'Test request', 'Private', 'Test response');