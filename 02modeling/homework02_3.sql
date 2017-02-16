-- all the order dates and amounts for orders made by a customer with a particular name (one that exists in your database), ordered chronologically by date
SELECT Odate, Ord_amt FROM Customer_Order, Customer WHERE Customer_Order.Cust_id = Customer.Cust_id AND CName = 'Derek Dik' ORDER BY Odate;

-- all the customer ID numbers for customers who have at least one order in the database
SELECT Customer.Cust_id FROM Customer, Customer_Order WHERE Customer_Order.Cust_id = Customer.Cust_id;

-- the customer IDs and names of the people who have ordered an item with a particular name (one that exists in your database)
SELECT Customer.Cust_id, Customer.CName
FROM Customer, Customer_Order, Order_Item, Item
WHERE Customer_Order.Cust_id = Customer.Cust_id
AND Customer_Order.Order_id = Order_Item.Order_id
AND Order_Item.Item_Id = Item.Item_id
AND Item.Item_name = 'Mass Effect: Andromeda';