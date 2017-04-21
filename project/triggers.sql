-- If multiple unifinished reviews of the same game by the same user are opened at the same time, raise an error.
CREATE OR REPLACE TRIGGER onInsertOrUpdateReview
	BEFORE
		INSERT OR
		UPDATE OF gameID, playerID
	ON Review

FOR EACH ROW
DECLARE
	openReviews INTEGER;
BEGIN
	SELECT COUNT(Review.reviewID) INTO openReviews FROM Review WHERE Review.gameID = :new.gameID AND Review.playerID = :new.playerID AND Review.dateSubmitted IS NULL AND Review.Rating IS NULL;
	IF openReviews > 0 THEN
		RAISE_APPLICATION_ERROR (-1, msg=> 'Multiple open reviews of the same game by the same user');
	END IF;
END;
/