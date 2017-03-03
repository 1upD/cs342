-- Retrieve the cross-product of all person and all household records. 
SELECT * FROM Person, Household;

-- How many records to you get and why? 
	-- There are 16 people and 8 households, so there are a total of 128 rows in the cross product.
-- As an optional challenge, can you use SQL to compute this number?
SELECT COUNT(*) FROM Person, Household;

-- Retrieve the people who have birthdays specified in the database, ordered by day-of-year (i.e., Jan 1 birthdays go before Jan 2 birthdays, regardless of the year). 
-- Note that you can compute the day of year value using the Oracle function: TO_CHAR(birthdate, 'DDD').
SELECT * FROM Person WHERE Person.birthdate IS NOT NULL ORDER BY TO_CHAR(Person.birthdate, 'DDD');