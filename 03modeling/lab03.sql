-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden


drop table PersonHouseHold;
drop table Role;
drop table Person;
drop table HouseHold;

create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c'))
	);
	
CREATE TABLE Role (
	ID integer PRIMARY KEY,
	name varchar(16)
);

CREATE TABLE Mentorship (
	mentorID integer,
	menteeID integer,
	FOREIGN KEY (mentorID) REFERENCES Person(ID) ON DELETE CASCADE,
	FOREIGN KEY (menteeID) REFERENCES Person(ID) ON DELETE CASCADE,
	PRIMARY KEY (mentorID, menteeID)
)

CREATE TABLE PersonHouseHold (
	personID integer,
	houseHoldID integer,
	roleID integer,
	PRIMARY KEY (personID, houseHoldID),
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE CASCADE,
	FOREIGN KEY (houseHoldID) REFERENCES HouseHold(ID) ON DELETE CASCADE,
	FOREIGN KEY (roleID) REFERENCES Role(ID) ON DELETE CASCADE
);	

 -- What about married people without children? Roles don't really make sense.
INSERT INTO Role VALUES (0, 'Parent');
-- What about children that are also adults? I need more clarification on the specifics of the role table.
INSERT INTO Role VALUES(1, 'Child'); 

INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m');

INSERT INTO PersonHouseHold VALUES (0, 0, 0);
INSERT INTO PersonHouseHold VALUES (1, 0, 0);
