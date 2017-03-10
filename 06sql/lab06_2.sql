-- Compute the average age of all the people in the database. Note you can use the following Oracle features in this query.
	-- MONTHS_BETWEEN(laterDate, earlierDate) computes the number of months between the earlier and later dates.
	-- SYSDATE gives the current date.
	-- TRUNC() rounds a number down to the nearest integer.
SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, Person.birthdate) / 12)) FROM Person;

-- Get the household ID and count of members of all households in Grand Rapids having at least 2 members. Order the results by decreasing size.
SELECT household.ID AS HouseholdID, COUNT(Person.id) AS PersonCount
FROM household INNER JOIN Person
ON Person.householdID = household.ID GROUP BY Person.householdID ORDER BY PersonCount DESC;

-- Modify the previous query to retrieve the phone number of the household as well.
SELECT household.ID AS HouseholdID, household.PhoneNumber AS PhoneNumber, COUNT(Person.id) AS PersonCount
FROM household INNER JOIN Person
ON Person.householdID = household.ID GROUP BY household.ID, household.PhoneNumber
ORDER BY PersonCount DESC;

