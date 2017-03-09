-- Get a list of the employees who have finished all of their jobs (i.e., all their jobs in the job_history table have non-null end_dates).
SELECT DISTINCT E.Employee_ID, E.First_Name, E.Last_Name
FROM Employees E, Job_History JH
WHERE JH.Employee_ID = E.Employee_ID AND END_DATE IS NOT NULL;

-- Get a list of employees along with their manager such that the managers have less seniority at the company and that all the employees’ jobs have been within the manager’s department.
(SELECT E.Employee_ID AS Employee_ID, M.Employee_ID AS Manager_ID
FROM Employees E, Employees M
WHERE E.Manager_ID = M.Employee_ID AND E.Hire_Date > M.Hire_Date)
INTERSECT
(SELECT DISTINCT E.Employee_ID AS Employee_ID, M.Employee_ID AS Manager_ID
FROM Employees E, Employees M, Job_History JH
WHERE E.Manager_ID = M.Employee_ID AND JH.Employee_ID = E.Employee_ID AND JH.Department_ID = M.Department_ID);

-- The countries in which at least one department is located. Try to write this as both a join and a nested query. If you can, explain which is better. If you can’t, explain which is not possible and why.
SELECT DISTINCT C.Country_ID, C.Country_Name
FROM Countries C, Locations L, Departments D
WHERE D.Location_ID = L.Location_ID AND C.Country_ID = L.Country_ID;

-- Nested query
SELECT DISTINCT Country_Name
FROM (SELECT * FROM Countries C, Locations L, Departments D
WHERE D.Location_ID = L.Location_ID AND C.Country_ID = L.Country_ID);

-- I feel like I may have misunderstood the question. The first query I wrote uses an implicit join and is very short and simple. I don't understand why a nested query or an explicit join would improve the query.