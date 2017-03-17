-- Create a view that for the CPDB “birthday czar” that includes each person’s full name, age (using TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) ) and birthdate (only)
CREATE MATERIALIZED VIEW BirthdayCzarView(FirstName, LastName, Age, BirthDate) AS
SELECT P.FirstName, P.LastName, TRUNC(MONTHS_BETWEEN(SYSDATE, P.birthdate)/12), P.birthdate
FROM Person P;

-- Retrieve the GenX people from the database (i.e., those born from 1961–1975).
SELECT * FROM BirthdayCzarView WHERE Birthdate < TO_DATE('01_JAN-1976') AND Birthdate >= TO_DATE('01_JAN-1961');

-- Update the Person base table to include a GenX birthdate for some person who had a NULL birthdate before. Now, try to re-run your query on the view from the previous question. Do the results of the view query change? Why or why not?
UPDATE PERSON
  SET BIRTHDATE=TO_DATE('02_JAN-1961')
  WHERE ID = 7;
  
SELECT * FROM BirthdayCzarView WHERE Birthdate < TO_DATE('01_JAN-1976') AND Birthdate >= TO_DATE('01_JAN-1961');

	-- The updated record is included in the results of the query. Either the view is nonmaterialized or the material view was updated by the UPDATE command. 

-- Insert a new person using your new view. If this doesn’t work, explain (but do not implement) the modifications you’d have to make to your view so that it does. Be sure that you understand what is required for a view to be updateable and what happens to the fields of the inserted record in the base table not included in the view.
INSERT INTO Person VALUES(16, 'mr.', 'Fake', 'Person', 'm', 'm', TO_DATE('02_JAN-1961'), 0, 'child', 0, 'member');

SELECT * FROM BirthdayCzarView WHERE Birthdate < TO_DATE('01_JAN-1976') AND Birthdate >= TO_DATE('01_JAN-1961');
	-- As before, the view updated to include the inserted person.

-- Drop your new view. Does this affect your base tables in any way?
DROP VIEW BirthdayCzarView;
-- I get an error saying that the table or view does not exist. The table is not dropped. It still contains records from before.
