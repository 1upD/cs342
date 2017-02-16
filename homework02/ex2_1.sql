-- If these tables have already been created, drop them.
DROP TABLE Customer;
DROP TABLE City;
DROP TABLE Customer_Order;
DROP TABLE Order_Item;
DROP TABLE Item;
DROP TABLE Shipment;
DROP TABLE Warehouse;

-- Create tables
CREATE TABLE Customer (
	Cust_id NUMBER(5) PRIMARY KEY,
	CName VARCHAR2(15),
	City_id NUMBER(5)
);

CREATE TABLE City (
	City_id NUMBER(5) PRIMARY KEY,
	CityName VARCHAR2(15) -- If a city name is null, the only identifying information is which records have a reference that that City ID
);

-- I am not calling this table Order in order to avoid ambiguity with the 'ORDER' keyword
CREATE TABLE Customer_Order (
	Order_id NUMBER(5) PRIMARY KEY,
	Odate DATE,
	Cust_id Number(5) NOT NULL, -- Every order my have a customer.
	Ord_amt Number(9)
);

CREATE TABLE Order_Item (
	Order_id NUMBER(5) NOT NULL, -- Order ID and Item ID cannot be null because they identify the order item
	Item_id NUMBER(5) NOT NULL,
	City_id NUMBER(5)
);

CREATE TABLE Item (
	Item_id NUMBER(5) PRIMARY KEY,
	Unit_price NUMBER(9)
);

CREATE TABLE Shipment (
	Order_id NUMBER(5) NOT NULL, -- Order ID and Warehouse ID cannot be null because they identify a shipment
	Warehouse_id NUMBER(5) NOT NULL,
	Ship_date DATE
);

CREATE TABLE Warehouse (
	Warehouse_id NUMBER(5) PRIMARY KEY,
	City_id NUMBER(5)
);