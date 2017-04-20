-- Create procedure to transfer ranking points from one movie to another like currency
CREATE OR REPLACE PROCEDURE transferRank(fromMovieID IN INTEGER, toMovieID IN INTEGER, rankTransfer IN NUMBER)
IS
	-- Exception for a received rank to transfer that is negative
	rankNegativeException EXCEPTION;
	-- Exception for when a balance is below zero and a transfer must be rejected
	balanceBelowZeroException EXCEPTION;
	-- Integer variable to store balance
	balance INTEGER;
BEGIN
	IF rankTransfer < 0.0 THEN
		RAISE rankNegativeException;
	END IF;
	
	UPDATE Movie SET Rank = Movie.Rank - rankTransfer WHERE Movie.ID = fromMovieID;
	SELECT Movie.Rank INTO balance FROM Movie  WHERE Movie.ID = fromMovieID;
	
	IF balance < 0.0 THEN
		RAISE balanceBelowZeroException;
	END IF;
	
	UPDATE Movie SET Rank = Movie.Rank + rankTransfer WHERE Movie.ID = toMovieID;
	
	COMMIT;
EXCEPTION
	WHEN rankNegativeException THEN ROLLBACK;
	WHEN balanceBelowZeroException THEN ROLLBACK;
END;
/

-- Test procedure
BEGIN
	dbms_output.enable; 
	FOR i IN 1..10000 LOOP
		transferRank(176712, 176711, 0.1);
		COMMIT;
		transferRank(176711, 176712, 0.1);
		COMMIT;
	END LOOP;
END;
/

-- Show results
SELECT * FROM Movie WHERE ID = 176712 OR ID = 176711;