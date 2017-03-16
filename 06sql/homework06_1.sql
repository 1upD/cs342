-- The IDs and full names of managers and the number of employees each of them manages. Order the results by decreasing number of employees and return only the top ten results.
SELECT * FROM
(SELECT M.Employee_ID AS Manager_ID, M.First_Name AS First_Name, M.Last_Name AS Last_Name, COUNT(E.Employee_ID) AS Num_Employees FROM
Employees M INNER JOIN Employees E
ON E.Manager_ID=M.Employee_ID
GROUP BY M.Employee_ID, M.First_Name, M.Last_Name, E.Manager_ID
ORDER BY Num_Employees DESC)
WHERE ROWNUM <= 10;

-- The name, number of employees and total salary for each department outside of the US with less than 100 employees. The total salary is the sum of the salaries of each of the department's employees.
SELECT NonUS_Department_ID, Department_Name, COUNT(E.Employee_ID) AS Employee_Count, SUM(E.Salary) AS Total_Salary
FROM (SELECT D.Department_ID AS NonUS_Department_ID, D.Department_Name As Department_Name
FROM Departments D, Locations L, Countries C
WHERE L.Location_ID = D.Location_ID AND C.Country_ID = L.Country_ID AND C.Country_Name <> 'United States of America') INNER JOIN Employees E
ON E.Department_ID = NonUS_Department_ID
GROUP BY NonUS_Department_ID, Department_Name;

-- The department name, department manager name and manager job title for all departments. If the department has no manager, include it in the output with NULL values for the manager and title.

-- The name of each department along with the average salary of the employees of that department. If a department has no employees, include it in the list with no salary value. Order your results by decreasing salary. You may order the NULL-valued salaries however you’d like.