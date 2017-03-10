-- Compute the average age of all the people in the database. Note you can use the following Oracle features in this query.
	-- MONTHS_BETWEEN(laterDate, earlierDate) computes the number of months between the earlier and later dates.
	-- SYSDATE gives the current date.
	-- TRUNC() rounds a number down to the nearest integer.
SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, Person.birthdate) / 12)) FROM Person;

-- Get the household ID and count of members of all households in Grand Rapids having at least 2 members. Order the results by decreasing size.
SELECT *
FROM (SELECT GRHouseholdID, COUNT(Person.id) AS PersonCount
	FROM (SELECT household.ID AS GRHouseholdID FROM Household WHERE City = 'Grand Rapids') INNER JOIN Person
	ON Person.householdID = GRhouseholdID 
	GROUP BY GRhouseholdID 
	ORDER BY PersonCount DESC) 
WHERE PersonCount > 1;

-- Modify the previous query to retrieve the phone number of the household as well.
SELECT *
FROM (SELECT GRHouseholdID, PhoneNumber, COUNT(Person.id) AS PersonCount
	FROM (SELECT household.ID AS GRHouseholdID, Household.PhoneNumber As PhoneNumber FROM Household WHERE City = 'Grand Rapids') INNER JOIN Person
	ON Person.householdID = GRhouseholdID 
	GROUP BY GRhouseholdID, PhoneNumber
	ORDER BY PersonCount DESC) 
WHERE PersonCount > 1;

