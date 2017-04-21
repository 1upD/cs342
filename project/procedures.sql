CREATE SEQUENCE review_ID_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

-- This is a short procedure to open a new review. It creates a review of the desired game with the appropriate user.
-- Rating will be left NULL to show that this review is in progress.
CREATE OR REPLACE PROCEDURE startReview(gameID IN INTEGER, userID IN INTEGER)
	AS
	BEGIN
		INSERT INTO Review(reviewID, playerID, gameID) VALUES(review_ID_sequence.nextval, userID, gameID);
		COMMIT;
	END;
	/

-- Find the correct review by looking up the only review where gameID and userID match AND the rating is NULL.
-- Multiple reviews may exist, but only one incomplete review may exist at a time.
-- A trigger will enforce this constraint.
CREATE OR REPLACE PROCEDURE submitReview(gameID IN INTEGER, userID IN INTEGER, rating IN NUMBER, reviewComment IN VARCHAR(512))
IS
	-- Exception for when rating is less than 0 or greater than 10
	invalidRatingException EXCEPTION;
BEGIN
	IF rating < 0.0 THEN
		RAISE invalidRatingException;
	END IF;
	
		
	COMMIT;
EXCEPTION
	WHEN invalidRatingException THEN ROLLBACK;
END;
/