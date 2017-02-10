This is a mysql conversion of the hr database created by Micah Ng, CS 342, Spring, 2015.  
According to his notes, it can be loaded by extracting and executing it, or more easily with:

	echo CREATE DATABASE hr | mysql -u <user_name> -p
	cat hr.sql | mysql -u <user_name> -p hr

The only change to the schema is that it enforces the check constraints using triggers. 

