-- Use an appropriate combination of SQL, stored procedures and/or triggers to implement the ability to allow programmers to cast a new actor (by ID#) to a movie (by ID#).
CREATE OR REPLACE PROCEDURE cast_actor (actor_ID IN INTEGER, movie_ID IN INTEGER, role_Name IN VARCHAR ) AS
BEGIN
  INSERT INTO Role
  VALUES (actor_ID, movie_ID, role_Name);
END cast_actor;

-- Do not allow actors to be cast more than once for each movie and do not allow more than 230 castings for any movie.
CREATE OR REPLACE TRIGGER casting_Restrictions 
	BEFORE INSERT ON ROLE
	FOR EACH ROW
DECLARE
	num_castings NUMBER;
BEGIN
	SELECT COUNT(actorID)
	INTO num_castings
	FROM Role
	WHERE movieID = :NEW.movieID;
	IF(num_castings >= 230) THEN
          raise_application_error( -20001, 'There are already 230 castings for this movie.'); --to restrict the insetion`.
    END IF;
	IF(:OLD.movieID = :NEW.movieID AND :OLD.actorID = :NEW.actorID) THEN
          raise_application_error( -20001, 'This actor is already cast for this movie.'); --to restrict the insetion`.	
	END IF;
END;

-- Cast George Clooney (# 89558) as “Danny Ocean” in Oceans Eleven (#238072). N.b., he’s already cast in this movie.
EXECUTE cast_actor(89558, 238072, 'Danny Ocean');

-- Cast George Clooney as “Danny Ocean” in Oceans Twelve (#238073). N.b., he’s not currently cast in this movie.
EXECUTE cast_actor(89558, 238073, 'Danny Ocean');

-- Cast George Clooney as “Danny Ocean” in JFK (#167324). N.b., this movie already has 230 castings.
EXECUTE cast_actor(89558, 167324, 'Danny Ocean');
