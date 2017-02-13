-- a. Try adding records to the movie relation that cause these intra-relation issues:

	-- i.	a repeated primary key value
	INSERT INTO performer VALUES (1, 'Harrison Ford Again');
		-- Executing this command returns the following error:
		-- ORA-00001: unique constraint (DRD26.SYS_C007000) violated
	
	-- ii.	a NULL primary key value
	INSERT INTO performer VALUES (NULL, 'Mark Hamill');
		-- Executing this command returns the following error:	
		-- ORA-01400: cannot insert NULL into ("DRD26"."PERFORMER"."ID")
	
	-- iii.	a violation of a CHECK constraint
		INSERT INTO casting VALUES (1, 4, 'none');
		-- Executing this command returns the following error:		
		-- ORA-02290: check constraint (DRD26.SYS_C007001) violated
		
		
	-- iv.	a violation of an SQL datatype constraint
	INSERT INTO casting VALUES (1, 'Harrison Ford', 'star');
		-- Executing this command returns the following error:		
		-- ORA-01722: invalid number
		
	-- v.	a negative score value
	INSERT INTO movie VALUES (3, 'The Phantom Menace', 1999, -1.0);
		-- There is no entity integrity protecting movies from negative score values!
		-- For the record, I don't actually hate the Phantom Menace that much.
		
-- b. Try adding records that cause these inter-relation issues:

	-- i.	a new record with a NULL value for a foreign key value
	INSERT INTO casting VALUES (1, NULL, 'star');
		-- Where is Mark Hamill?
		-- There is no relational integrity protecting a NULL value from being used as a foreign key.
		
		
	-- ii.	a foreign key value in a referencing (aka child) table that doesn’t match any key value in the referenced (aka parent) table
	INSERT INTO casting VALUES (1, 5, 'star');
		-- Executing this command returns the following error:		
		-- ORA-02291: integrity constraint (DRD26.SYS_C007003) violated - parent key not found
	
	-- iii.	a key value in a referenced table with no related records in the referencing table
	INSERT INTO performer VALUES (5, 'Mark Hamill');
		-- This is fine.
		
-- c. Try deleting/modifying records as follows:

	-- i.	Delete a referenced record that is referenced by a referencing record.
	DELETE FROM performer WHERE id=1;
		-- This works. The record is deleted and the referencing record no longer references a record.
	
	-- ii.	Delete a referencing record that references a referenced record.
	DELETE FROM casting WHERE movieID=1;
		-- 3 rows deleted. 
		
	-- iii.	Modify the ID of a movie record that is referenced by a casting record.
	UPDATE movie SET id = 4 WHERE id = 2;
		-- Executing this command returns the following error:		
		-- ORA-02292: integrity constraint (DRD26.SYS_C007002) violated - child record found