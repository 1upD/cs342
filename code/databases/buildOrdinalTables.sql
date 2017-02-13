-- This script creates an ordinal numbering for IMDB actors/movies where
-- the numbering is continuous, 0..n, rather than sparse, as the 
-- ID values are in the actor/movie tables. This helps support certain
-- types of sample timing queries.
--
-- This works for both the IMDB and IMDBLarge because they are structured
-- in a similar manner. Run this once to create the ActorOrdinal and
-- MovieOrdinal tables. This will run successfully on imdbLarge in a few minutes.
--
-- With this done, you can query random actors or movies using a command such as this,
-- where the random values are selected from 0 through the number of actor records.
--SELECT a.firstName || ' ' || a.lastName
--FROM Actor a, ActorOrdinal ao
--WHERE a.id = ao.id
--  AND ao.ordinal = (SELECT TRUNC(dbms_random.value(0,380917)) FROM Dual)
--; 


DROP TRIGGER ActorOrdinalTrigger;
DROP TRIGGER MovieOrdinalTrigger;
DROP TABLE ActorOrdinal;
DROP TABLE MovieOrdinal;
DROP SEQUENCE ActorOrdinalSequence;
DROP SEQUENCE MovieOrdinalSequence;

CREATE SEQUENCE ActorOrdinalSequence MINVALUE 0 INCREMENT BY 1;
CREATE SEQUENCE MovieOrdinalSequence MINVALUE 0 INCREMENT BY 1;

CREATE TABLE ActorOrdinal (
	ordinal INTEGER PRIMARY KEY,
	id INTEGER
);
CREATE TABLE MovieOrdinal (
	ordinal INTEGER PRIMARY KEY,
	id INTEGER
);

CREATE OR REPLACE TRIGGER ActorOrdinalTrigger
	BEFORE INSERT ON ActorOrdinal
	FOR EACH ROW
	WHEN (new.ordinal IS NULL)
DECLARE
	newOrdinal ActorOrdinal.ordinal%TYPE;
BEGIN
	SELECT ActorOrdinalSequence.NEXTVAL INTO newOrdinal FROM Dual;
	:new.ordinal := newOrdinal;
END;
/
CREATE OR REPLACE TRIGGER MovieOrdinalTrigger
	BEFORE INSERT ON MovieOrdinal
	FOR EACH ROW
	WHEN (new.ordinal IS NULL)
DECLARE
	newOrdinal MovieOrdinal.ordinal%TYPE;
BEGIN
	SELECT MovieOrdinalSequence.NEXTVAL INTO newOrdinal FROM Dual;
	:new.ordinal := newOrdinal;
END;
/

INSERT INTO ActorOrdinal(id)
SELECT id
FROM Actor
;
INSERT INTO MovieOrdinal(id)
SELECT id
FROM Movie
;

