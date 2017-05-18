CREATE SEQUENCE review_ID_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

-- This is a short procedure to open a new review. It creates a review of the desired game with the appropriate user.
-- Rating will be left NULL to show that this review is in progress.
CREATE OR REPLACE PROCEDURE startReview(reviewedGameID IN INTEGER, userID IN INTEGER)
	IS
		reviewExistsException EXCEPTION;
	
		openReviews INTEGER;
	BEGIN
		LOCK TABLE Review IN EXCLUSIVE MODE;
		SELECT COUNT(Review.reviewID) INTO openReviews FROM Review WHERE Review.gameID = reviewedGameID AND Review.playerID = userID AND Review.dateSubmitted IS NULL AND Review.Rating IS NULL;
		
		IF openReviews > 0 THEN
			RAISE reviewExistsException;
		END IF;
		
		INSERT INTO Review(reviewID, playerID, gameID) VALUES(review_ID_sequence.nextval, userID, reviewedGameID);
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN ROLLBACK;
	END;
	/

-- Procedure to add a chapter comment and rating to an incomplete review.
--
-- Find the correct review by looking up the only review where gameID and userID match AND the rating is NULL.
-- Multiple reviews may exist, but only one incomplete review may exist at a time.
-- A trigger will enforce this constraint.
CREATE OR REPLACE PROCEDURE submitChapterReview(reviewedGameID IN INTEGER, userID IN INTEGER, chapterNum IN INTEGER, dateChapterPlayed IN DATE, chapterRating IN NUMBER, minsPlayed IN INTEGER, chapterComment in VARCHAR)
IS
	-- Exception for when the review ID is invalid or not found
	reviewIDExecption EXCEPTION;
	thisReviewID INTEGER;
	BEGIN
		-- If the review does not already exist, create it
		startReview(reviewedGameID, userID);
	
		-- Lock the table
		LOCK TABLE Review IN EXCLUSIVE MODE;
		
		-- Get the review ID
		SELECT Review.reviewID INTO thisReviewID FROM Review WHERE Review.gameID = reviewedGameID AND Review.playerID = userID AND Review.dateSubmitted IS NULL AND Review.Rating IS NULL;

		-- If the ID cannot be found, raise an exception	
		IF thisReviewID = NULL THEN
			RAISE reviewIDExecption;
		END IF;
		
		INSERT INTO ReviewChapter VALUES (thisReviewID, chapterNum, minsPlayed, dateChapterPlayed, chapterRating, chapterComment);
		
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN ROLLBACK;
	END;
	/

-- Procedure to complete a game review by updating it with a rating, comment, and date.	
CREATE OR REPLACE PROCEDURE submitGameReview(reviewedGameID IN INTEGER, userID IN INTEGER, userRating IN NUMBER, newReviewComment IN VARCHAR)
IS
	-- Exception for when rating is less than 0 or greater than 10
	invalidRatingException EXCEPTION;
	-- Exception for when the review ID is invalid or not found
	reviewIDExecption EXCEPTION;
	
	thisReviewID INTEGER;
BEGIN
	-- If the review does not already exist, create it
	startReview(reviewedGameID, userID);

	-- Lock the table
	LOCK TABLE Review IN EXCLUSIVE MODE;
	
	IF userRating < 0.0 THEN
		RAISE invalidRatingException;
	END IF;
	
	-- Get the review ID
	SELECT Review.reviewID INTO thisReviewID FROM Review WHERE Review.gameID = reviewedGameID AND Review.playerID = userID AND Review.dateSubmitted IS NULL AND Review.Rating IS NULL;

	-- If the ID cannot be found, raise an exception
	IF thisReviewID = NULL THEN
		RAISE reviewIDExecption;
	END IF;
	
	-- Add the comment, rating, and submit date
	UPDATE Review SET Review.Rating = userRating, Review.reviewComment = newReviewComment, Review.dateSubmitted = SYSDATE WHERE Review.reviewID = thisReviewID;
		
	COMMIT;
EXCEPTION
	WHEN invalidRatingException THEN ROLLBACK;
	WHEN reviewIDExecption THEN ROLLBACK;
	WHEN OTHERS THEN ROLLBACK;
END;
/