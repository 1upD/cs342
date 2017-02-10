These folders contain command files for loading the sample Oracle databases
used in CS 342, Calvin College.

The databases are as follows:
	cpdb - The Centrepointe Church database is a database of church members and families.
	cpdbTest - An empty version of the CPDB for enterprise testing the CPE app.
	grdb - The grading database is a database of students, courses and assignments.
	imdb - The imdb is a small version of the Internet Movie Database 
				(http://www.imdb.com/).	Its schema is modified slightly 
				from the original mySQL schema, downloaded by Pete Sanderson, 
				Otterbein University, circa 2010.
	imdbLarge - This is full IMDB circa 2010. It is too large to store on GitHub
				so this only includes the basic command files. The full SQL scripts
				take roughly two hours to load.	See cs342-resources/databases/imdbLarge.
				Load the database using DataPump rather than the script files.
	hr - This is a MySQL version of Oracle's HR database (see hr/readme.txt for details).

Each folder contains at least the following command files:
	create.sql - creates an Oracle user, connects to that account and loads the 
					database, assuming that you've logged in as system.
	load.sql - reloads the database, assuming that you've logged in as that 
					database's user.
	drop.sql - drops all the tables
	schema.sql - defines the full schema
	data.sql - loads the raw data using INSERT commands

Load/process the databases as follows:

	1. cd to your lab/homework directory.
			cd c:\<pathToYourLabScripts>\
	   On Windows, you may need to map the network drive (P:).
			net use p: \\Katz5\<LoginId>
			
	2. Login to SQLPlus using the Oracle system account.
			sqlplus system/<password>
			
	3. Create (from scratch) the database you need (e.g., cpdb, grdb, imdb).
			@C:\<pathToCs342RepoFiles>\src\databases\<theDatabase>\create
	   You will probably need to edit the path value of DEFINE *db=<fixThisPath> in this file first.
	   This connects you to the newly created database user.
	   In the lab, do this every time you login; on your own machine, once should be enough.
	   You can reload just the tables and data (not the db user) using \load rather than \create.
	   
	4. OPTIONAL - Reformat your sqlplus output.
			@C:\<pathToCs342RepoFiles>\src\format
		This formats the sqlplus output in helpful ways, assuming that 
		you've set your cmd.exe layout(s!) to 200 character width.
		 
	5. Run your class/lab scripts.
			@lab8_1
		