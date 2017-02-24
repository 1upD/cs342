-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;



-- a. Demonstrate, formally, whether the relations implemented by the tables PersonTeam and PersonVisit are in BCNF and/or 4NF (or not).
--	Since PersonTeam and PersonVisit do not have functional dependencies, they satisfy BCNF. They also do not have multivalued dependencies and satisfy 4NF.

-- b. Consider the output of the data queried by the combined “view” query at the end of the command file. Demonstrate, formally, whether this view, when considered as a (single) relation, is in BCNF and/or 4NF (or not).
--	The view has no functional dependencies and satisfies BCNF, however it does have multivalue dependencies. Since the dependency is not a superkey of the relation, it does not satisfy 4NF.

-- c. The view has the same number of records as the original tables. Does this mean that the original schema and the derived “view” schema are equally appropriate? If so, explain why; if not, explain why one of the schemata is better. Does your choice depend on context?
--	Team name is duplicated in the latter schema. The former schema with two tables is preferable.

-- d. Create a new table to store the data queried by the combined “view” query at the end of the command file and load it with the queried data. Note that you can load the data either using hard-coded INSERT commands (for some credit) or by inserting data selected from the original tables (for full credit).
CREATE TABLE ViewTable(
	personName VARCHAR(10),
	teamName VARCHAR(10),
	personVisit DATE
);

INSERT INTO ViewTable
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

SELECT * FROM ViewTable;