-- Use an appropriate combination of SQL, stored procedures and/or triggers to implement the ability to allow programmers to cast a new actor (by ID#) to a movie (by ID#).
CREATE PROCEDURE cast_actor (actor_ID IN INTEGER, movie_ID IN INTEGER, role_Name IN VARCHAR ) AS
BEGIN
  INSERT INTO Role
  VALUES (actor_ID, movie_ID, role_Name);
END cast_actor;

-- Do not allow actors to be cast more than once for each movie and do not allow more than 230 castings for any movie.
CREATE TRIGGER casting_Restrictions 
	BEFORE INSERT ON ROLE
	FOR EACH ROW
DECLARE
	num_castings NUMBER;
BEGIN
	SELECT COUNT(actor_ID)
	INTO num_castings
	FROM Actor
	WHERE movie_ID = :NEW.movie_ID;
	IF(num_castings >= 230) THEN
          raise_application_error( -20001, 'There are already 230 castings.'); --to restrict the insetion`.
    END IF;
END;

