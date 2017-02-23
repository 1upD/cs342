DROP TABLE OrderParts;
DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Employees;
DROP TABLE Parts;

CREATE TABLE Parts(
	partID INTEGER PRIMARY KEY,
	name VARCHAR(16),
	price INTEGER,
	instock INTEGER
);

CREATE TABLE Employees(
	employeeID INTEGER PRIMARY KEY,
	firstName VARCHAR(16),
	lastName VARCHAR(16),
	zip INTEGER
);

CREATE TABLE Customers(
	customerID INTEGER PRIMARY KEY,
	firstName VARCHAR(16),
	lastName VARCHAR(16),
	zip INTEGER
);

CREATE TABLE Orders(
	orderID INTEGER PRIMARY KEY,
	customerID INTEGER,
	employeeID INTEGER,
	dateOfReceipt DATE,
	expectedShipDate DATE,
	actualShipDate DATE,
	FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE,
	FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE SET NULL 
);

CREATE TABLE OrderParts(
	orderID INTEGER,
	partID INTEGER,
	quantity INTEGER,
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE,
	FOREIGN KEY (partID) REFERENCES Parts(partID) ON DELETE CASCADE
);