-- Get the youngest person in the database. 
-- Write this both as a sub-select and as a ROWNUM query (see the notes below). 
-- Consider implementing your sub-select without using aggregate functions (e.g., MAX()).
SELECT * FROM (SELECT * FROM Person ORDER BY Person.birthdate) WHERE ROWNUM = 1;
-- This is not a correlated subquery.

-- Get the IDs and full names of people who share the same first name. What happens when there are three or more people who share the same name?
SELECT P2.ID, P2.firstName, P2.lastName FROM Person P1, Person P2 WHERE P2.firstName = P1.firstName AND P2.ID <> P1.ID;

-- Get the names of all people who are on the music team but not in Byl’s home group. Write this both as a sub-select and as a set operations query.
-- As a set operations query
(SELECT Person.firstName, Person.lastName FROM Person, PersonTeam WHERE Person.ID = PersonTeam.personID AND PersonTeam.teamName = 'Music') INTERSECT (SELECT Person.firstName, Person.lastName FROM Person, Homegroup WHERE Person.homeGroupID = Homegroup.ID AND Homegroup.name <> 'Byl');
-- As a subquery.
SELECT firstName, lastName FROM (SELECT Person.ID, Person.firstName, Person.lastName FROM Person, Homegroup WHERE Person.homeGroupID = Homegroup.ID AND Homegroup.name <> 'Byl'), PersonTeam WHERE ID = PersonTeam.personID AND PersonTeam.teamName = 'Music';
-- This is not a correlated subqery, although it almost looks like one. (The tables referenced in the outer 'FROM' clause are not actually used in the inner query.)