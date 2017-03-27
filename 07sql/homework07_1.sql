-- Create a view of all employees and their department; include the employee ID, name, email, hire date and department name. 
DROP VIEW EmployeeDepartmentView;
CREATE VIEW EmployeeDepartmentView(Employee_ID, First_Name, Last_Name, Email, Hire_Date, Department_Name) AS
SELECT E.Employee_ID, E.First_Name, E.Last_Name, E.Email, E.Hire_Date, D.Department_Name
FROM Employees E, Departments D
WHERE E.Department_ID = D.Department_ID;

-- Then write SQL commands to do the following:
-- Get the name and ID of the newest employee in the “Executive” department.
SELECT * 
FROM (SELECT Employee_ID, First_Name, Last_Name
FROM EmployeeDepartmentView
ORDER BY Hire_Date ASC)
WHERE ROWNUM <= 1;

-- Change the name of the “Administration” department to “Bean Counting”.
UPDATE EmployeeDepartmentView
	SET Department_Name = 'Bean Counting'
	WHERE Department_Name = 'Administration';

-- Change the name of “Jose Manuel” to just “Manuel”
UPDATE EmployeeDepartmentView
	SET First_Name = 'Manuel'
	WHERE First_Name = 'Jose Manuel';

-- Insert a new employee in the “Payroll” department (make up appropriate data for this record).
INSERT INTO EmployeeDepartmentView
VALUES (300, 'Cousin', 'Tim', 'FakeEmail', TO_DATE('03/27/2017', 'mm/dd/yyyy'), 'Payroll');

-- If any of these view-based queries won’t work, show the query and explain why it generates an error.
UPDATE EmployeeDepartmentView
	SET Department_Name = 'Bean Counting'
	WHERE Department_Name = 'Administration';
-- The view is not key preserved on Department_ID, so the department name cannot be updated through the view.

INSERT INTO EmployeeDepartmentView
VALUES (300, 'Cousin', 'Tim', 'FakeEmail', TO_DATE('03/27/2017', 'mm/dd/yyyy'), 'Payroll');

-- The new record can't be inserted because it would require department name to match with the correct department ID in the base table.

-- Redo the previous exercise with a materialized view.
DROP VIEW EmployeeDepartmentView;
CREATE MATERIALIZED VIEW EmployeeDepartmentView(Employee_ID, First_Name, Last_Name, Email, Hire_Date, Department_Name) AS
SELECT E.Employee_ID, E.First_Name, E.Last_Name, E.Email, E.Hire_Date, D.Department_Name
FROM Employees E, Departments D
WHERE E.Department_ID = D.Department_ID;

-- Then write SQL commands to do the following:
-- Get the name and ID of the newest employee in the “Executive” department.
SELECT * 
FROM (SELECT Employee_ID, First_Name, Last_Name
FROM EmployeeDepartmentView
ORDER BY Hire_Date ASC)
WHERE ROWNUM <= 1;

-- Change the name of the “Administration” department to “Bean Counting”.
UPDATE EmployeeDepartmentView
	SET Department_Name = 'Bean Counting'
	WHERE Department_Name = 'Administration';

-- Change the name of “Jose Manuel” to just “Manuel”
UPDATE EmployeeDepartmentView
	SET First_Name = 'Manuel'
	WHERE First_Name = 'Jose Manuel';

-- Insert a new employee in the “Payroll” department (make up appropriate data for this record).
INSERT INTO EmployeeDepartmentView
VALUES (300, 'Cousin', 'Tim', 'FakeEmail', TO_DATE('03/27/2017', 'mm/dd/yyyy'), 'Payroll');


-- If any of these view-based queries won’t work, show the query and explain why it generates an error.
UPDATE EmployeeDepartmentView
	SET Department_Name = 'Bean Counting'
	WHERE Department_Name = 'Administration';
	
UPDATE EmployeeDepartmentView
	SET First_Name = 'Manuel'
	WHERE First_Name = 'Jose Manuel';
	
	INSERT INTO EmployeeDepartmentView
VALUES (300, 'Cousin', 'Tim', 'FakeEmail', TO_DATE('03/27/2017', 'mm/dd/yyyy'), 'Payroll');
	-- The view is not updatable.
	
	