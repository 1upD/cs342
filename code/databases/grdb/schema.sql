CREATE TABLE Course(
    id integer PRIMARY KEY,    -- the same as number(38)
	department varchar2(4),
	code varchar2(3),
	name varchar2(40) NOT NULL,
	description varchar2(250),
	hours integer DEFAULT 3,
	crossListId integer,
	UNIQUE (department, code),
	CHECK (hours >= 0),
	CHECK (crossListId <> id)
	);

CREATE TABLE Prerequisite(
    courseId integer,
    prerequisiteId integer,
    PRIMARY KEY (courseId, prerequisiteId)
    );

CREATE TABLE Section(
	id integer PRIMARY KEY,
	courseId integer REFERENCES Course(id),
	letter char(2),
	semester varchar2(2) CHECK (semester in ('FA', 'SP', 'IN')),
	year varchar2(4),
	professor varchar2(15),
	UNIQUE (courseId, letter, semester, year)
	);

CREATE TABLE Student(
	id integer PRIMARY KEY,
	firstName varchar2(15),
	lastName varchar2(15),
	gender char(1) CHECK (gender IN ('m', 'f')),
	birthdate date,
	email varchar2(20) UNIQUE,
	mentorId integer,
	CHECK (id <> mentorId)
	);

CREATE TABLE GradeValue (
	value varchar2(2) PRIMARY KEY,
	ordinal integer UNIQUE
	);

CREATE TABLE Enrollment(
	studentId integer REFERENCES Student(id) ON DELETE CASCADE,
	sectionId integer REFERENCES Section(id),
	grade varchar2(2) REFERENCES GradeValue(value),
	PRIMARY KEY (studentId, sectionId)
	);

CREATE TABLE Assignment(
	id integer,       -- The number, e.g., the 1 in lab 1
	sectionId integer REFERENCES Section(id),
	type varchar2(5), -- The type, e.g., the 'lab' in lab 1
	totalPoints integer,
	PRIMARY KEY (id, sectionId, type)
	);

CREATE TABLE AssignmentType(
	sectionId integer REFERENCES Section(id),
	type varchar2(5),
	weight number(2,2),
	PRIMARY KEY (sectionId, type)
	);

CREATE TABLE StudentAssignment(
	studentId integer REFERENCES Student(id) ON DELETE CASCADE,
	assignmentId integer,
	assignmentType varchar2(5),
	sectionId integer REFERENCES Section(id),
	score number(5,2),
	PRIMARY KEY (studentId, assignmentId, assignmentType, sectionId)
	);

CREATE TABLE Team(
	id integer,
	sectionId integer REFERENCES Section(id),
	name varchar2(20),
	PRIMARY KEY (id, sectionId)
	);

CREATE TABLE StudentTeam(
	studentID integer REFERENCES Student(id) ON DELETE CASCADE,
	teamId integer,
	sectionId integer REFERENCES Section(id),
	PRIMARY KEY (teamId, studentId, sectionId)
	);

CREATE TABLE TeamAssignment(
	teamId integer,
	assignmentId integer,
	assignmentType varchar2(5),
	sectionId integer REFERENCES Section(id),
	score number(5,2),
	FOREIGN KEY (teamId, sectionId) REFERENCES Team(id, sectionId),
	PRIMARY KEY (teamId, assignmentId, assignmentType, sectionId)
	);
