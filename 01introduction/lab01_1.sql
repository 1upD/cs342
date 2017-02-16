-- List all of the rows of the departments table
SELECT * FROM departments;

-- Find the number of employees in the database
SELECT COUNT(employee_id) FROM employees;

-- List the employees who make more than $15,000 per year.
SELECT * FROM employees WHERE SALARY > 15000;

-- List the employees who were hired from 2002-2004 (inclusive)
SELECT * FROM employees WHERE hire_date >= DATE '2002-01-01' AND hire_date < DATE '2005-01-01';

-- List the employees who have a phone number that doesn't have the area code 515
SELECT * FROM employees WHERE phone_number NOT LIKE '515%';

-- List the names of employees who are in the finance department.
SELECT first_name || ' ' || last_name FROM employees, departments WHERE employees.department_id = departments.department_id AND department_name LIKE 'Finance' ORDER BY first_name, last_name;

-- List the city, state, and country name for all locations in the Asian region
SELECT city, state_province, country_name FROM locations, countries, regions WHERE locations.country_id = countries.country_id AND countries.region_id = regions.region_id AND region_name LIKE 'Asia';

-- List the locations that have no state or province specified in the database.
SELECT * from locations WHERE state_province IS NULL;
