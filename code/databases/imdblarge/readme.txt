See the cs342/kvlinden/src/databases GitHub repo for notes on the general
structure of the command files in this directory.

-----------------------------
This database is taken from the IMDB. The original SQL command file from
Peter Sanderson is imdbOriginalMySQL.sql. He dumped it from IMDB using legal
export tools that exist for mySQL. For his notes, see 
	http://faculty.otterbein.edu/psanderson/COMP481WEB/mysql/mysql.html

-----------------------------
I ended up creating the set of Oracle command files in this directory mostly 
manually, with help from emacs macros. Notes: 

- I started with the imdb.sql and created Oracle-compatible drop and schema files. 
Then I copied the INSERT VALUES lines into one command file per table. I left the 
.sql off the table names to avoid the inefficiencies created by emacs's 
font-lock-mode. mySQL split its INSERT commands in a few separate lines, each 
with on the order of 31000 records. Oracle didn't like those long lines so I 
formatted into individual INSERT commands, one per line (and I did this using 
M-x replace-string rather than using macros, which were much slower - note that
you can add a newline in a modified string using M-qM-j).   

- I did the loading from the SQL command line available in the Oracle Start menu.
Sqlplus treats some of the characters in the text fields as special characters
(i.e., \' \" & $). I ended up replacing mySQL's \' with ' and \" with " and
leaving the others as is. I had to SET DEFINE OFF so that SQL would treat & as a
normal character rather than a definition marker. 

- There are problems with the integrity of some of the data, so not all of the
records come through in Oracle. E.g., there are DirectorGenre records that
reference non-existent directors. Most all of the data is there.

-----------------------------
This database is too large to (responsibly) commit to GitHub or Bitbucket. 
	They allow <1G repos with <100M files, which could hold this database if I 
	split the data_actors.sql into two, but they also say that large SQL command 
	files don't work that well.

The command files roughly match those of the the CS 342 sample databases in GitHub.

I removed the adult movies using the commands in removeAdult.sql.
	imdbLargeWithAdult.dmp has the adult records
	imdbLarge.dmp doesn't.
The imdbLargeWithAdult.dmp file is a dump with adult movies.
	Role: 3432624 records
	Actor: 817718
	Movie: 388267 (7349 adult movies)
The imdbLarge.dmp file is a dump without adult movies.
	Role: 3403516 records
	Actor: 817718
	Movie: 380918
These dump files load in around a minute.
Loading from the SQL command files takes around 2 hours (on my slow home machine).
Deleting the adult movies longer; I had to turn off sleep mode and run it overnight.

