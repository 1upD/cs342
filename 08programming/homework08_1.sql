-- Auditing — Implement a “shadow” log that records every update to the rank of any Movie record. Store your log in a separate table ( RankLog ) and include the ID of the user who made the change (accessed using the system constant user), the date of the change (accessed using sysdate) and both the original and the modified ranking values.
DROP TABLE RankLog;
CREATE TABLE RankLog(
	rankUser VARCHAR(32),
	OldRank NUMBER,
	NewRank NUMBER,
	rankDate DATE
);
DROP TRIGGER triggerRankLog;
CREATE TRIGGER triggerRankLog
	BEFORE
		UPDATE
	ON Movie
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
	IF :New.rank <> :Old.rank THEN
		INSERT INTO RankLog
		VALUES (USER, :Old.rank, :New.Rank, SYSDATE);
	END IF;
END;
/