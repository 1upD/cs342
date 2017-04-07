-- Bacon Number — Implement a tool that loads a table (named BaconTable) with records that specify an actor ID and that actor’s Bacon number. An actor’s bacon number is the length of the shortest path between the actor and Kevin Bacon (KB) in the “co-acting” graph. That is, KB has bacon number 0; all actors who acted in the same movie as KB have bacon number 1; all actors who acted in the same movie as some actor with Bacon number 1 but have not acted with Bacon himself have Bacon number 2, etc. Actors who have never acted with anyone with a bacon number should not have a record in the table. Stronger solutions will be configured so that the number can be based on any actor, not just Kevin Bacon.
DROP TABLE BaconTable;
CREATE TABLE BaconTable(
	ActorID INTEGER,
	BaconNumber INTEGER
);

INSERT INTO BaconTable
VALUES (22591, 0);

DECLARE 
	actorsRemaining NUMBER := 1;
	prevActorsRemaining NUMBER := 0;
	baconNumber INTEGER := 1;
BEGIN	
	WHILE actorsRemaining > 0 AND prevActorsRemaining <> actorsRemaining
	LOOP
		INSERT INTO BaconTable
		SELECT DISTINCT B.ActorID, baconNumber 
			FROM Role A, Role B 
			WHERE B.MovieID = A.MovieID 
			AND EXISTS(
				SELECT * FROM BaconTable Where BaconTable.ActorID = A.ActorID) 
			AND NOT EXISTS(
				SELECT * FROM BaconTable Where BaconTable.ActorID = B.ActorID);
		prevActorsRemaining := actorsRemaining;
		SELECT COUNT(1) INTO actorsRemaining FROM (SELECT * FROM Actor A WHERE NOT EXISTS(SELECT * FROM BaconTable WHERE BaconTable.ActorID = A.ID));
		baconNumber := baconNumber + 1;
	END LOOP;
END;
/