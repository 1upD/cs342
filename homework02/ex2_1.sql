CREATE TABLE Customer (
	Cust_id	NUMBER(5) PRIMARY KEY,
	CName VARCHAR2(15) NOT NULL,
	City_id NUMBER(5)
);

CREATE TABLE City (
	City_id	NUMBER(5) PRIMARY KEY,
	CityName VARCHAR2(15) NOT NULL,
);

-- I am not calling this table Order in order to avoid ambiguity with the 'ORDER' keyword
CREATE TABLE Customer_Order (
	Order_id NUMBER(5),
	Odate	DATE,
	Cust_id Number(5) NOT NULL,
	Ord_amt Number(9),
);

CREATE TABLE Order_Item (
	Order_id NUMBER(5) PRIMARY KEY,
	Item_id NUMBER(5) PRIMARY KEY,
	City_id NUMBER(5)
		-- Ensure the city id matches the corresponding customer - should these really be stored in separate fields?
		CONSTRAINT check_city_id CHECK(Order_Item.City_id = Customer.City_id WHERE Customer_Order.Order_id = Order_item.Order_id and Customer.Cust_id = Customer_Order.Cust_id)
);

CREATE TABLE Item (
	Item_id NUMBER(5) PRIMARY KEY,
	Unit_price NUMBER(9)
);

CREATE TABLE Shipment (
	Order_id NUMBER(5) PRIMARY KEY,
	Warehouse_id NUMBER(5) PRIMARY KEY,
	Ship_date DATE
);

CREATE TABLE Warehouse (
	Warehouse_id NUMBER(5) PRIMARY KEY,
	City_id NUMBER(5)
);