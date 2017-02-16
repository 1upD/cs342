-- If these tables have already been created, drop them.
DROP TABLE Order_Item;
DROP TABLE Item;
DROP TABLE Shipment;
DROP TABLE Warehouse;
DROP TABLE Customer_Order;
DROP TABLE Customer;
DROP TABLE City;


CREATE TABLE City (
	City_id NUMBER(5) PRIMARY KEY,
	CityName VARCHAR2(15) -- If a city name is null, the only identifying information is which records have a reference that that City ID
);


-- Create tables
CREATE TABLE Customer (
	Cust_id NUMBER(5) PRIMARY KEY,
	CName VARCHAR2(15),
	City_id NUMBER(5),
	CONSTRAINT City_id_constraint
		FOREIGN KEY (City_id)
		REFERENCES City(City_id)
		ON DELETE SET NULL -- Don't cascade delete - we don't want to drop customers if we delete their city
);




-- I am not calling this table Order in order to avoid ambiguity with the 'ORDER' keyword
CREATE TABLE Customer_Order (
	Order_id NUMBER(5) PRIMARY KEY,
	Odate DATE,
	Cust_id Number(5) NOT NULL, -- Every order my have a customer.
	Ord_amt Number(9),
	CONSTRAINT Cust_id_constraint
		FOREIGN KEY (Cust_id)
		REFERENCES Customer(Cust_id)
		ON DELETE CASCADE -- If a customer is deleted, delete all of their orders.
);


CREATE TABLE Item (
	Item_id NUMBER(5) PRIMARY KEY,
	Item_name VARCHAR(32),
	Unit_price NUMBER(9)
);



CREATE TABLE Order_Item (
	Order_id NUMBER(5) NOT NULL, -- Order ID and Item ID cannot be null because they identify the order item
	Item_id NUMBER(5) NOT NULL,
	City_id NUMBER(5),
	CONSTRAINT Order_Item_pk
		PRIMARY KEY (Order_id, Item_id),
	CONSTRAINT Order_id_constraint
		FOREIGN KEY (Order_id)
		REFERENCES Customer_Order(Order_id)
		ON DELETE CASCADE,
	CONSTRAINT Item_id_constraint
		FOREIGN KEY (Item_id)
		REFERENCES Item(Item_id)
		ON DELETE CASCADE,
	CONSTRAINT City_id_order_item_constraint
		FOREIGN KEY (City_id)
		REFERENCES City(City_id)
		ON DELETE SET NULL -- Don't cascade delete - we don't want to drop customers if we delete their city
);



CREATE TABLE Warehouse (
	Warehouse_id NUMBER(5) PRIMARY KEY,
	City_id NUMBER(5)
);



CREATE TABLE Shipment (
	Order_id NUMBER(5) NOT NULL, -- Order ID and Warehouse ID cannot be null because they identify a shipment
	Warehouse_id NUMBER(5) NOT NULL,
	Ship_date DATE,
	CONSTRAINT Shipment_pk
	PRIMARY KEY (Order_id, Warehouse_id),
	CONSTRAINT Warehouse_id_constraint
	FOREIGN KEY (Warehouse_id)
	REFERENCES Warehouse(Warehouse_id)
	ON DELETE CASCADE,
	CONSTRAINT Shipment_Order_id_constraint
	FOREIGN KEY (Order_id)
	REFERENCES Customer_Order(Order_id)
	ON DELETE CASCADE
);

-- Populate database with dummy values
INSERT INTO City
VALUES (1, 'Grand Rapids');
INSERT INTO City
VALUES (2, 'Lansing');

INSERT INTO Customer
VALUES (1, 'Test User', 2);
INSERT INTO Customer
VALUES (2, 'Derek Dik', 1);

INSERT INTO Customer_Order
VALUES (1, DATE '2017-3-23', 1, 1);

INSERT INTO Item
VALUES (1, 'Mass Effect: Andromeda', 59.99);

INSERT INTO Order_Item
VALUES (1, 1, 1);

INSERT INTO Warehouse
VALUES (1, 2);

INSERT INTO Shipment
VALUES (1, 1, DATE '2017-3-20');