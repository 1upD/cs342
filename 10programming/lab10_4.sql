CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
	END LOOP;
	COMMIT;
END;
/

-- Commits should not take place until the entire procedure is finished to isolate and atomize the procedure.
-- This way if the procedure is run more than once in parallel, the results won't stack on top of each other.