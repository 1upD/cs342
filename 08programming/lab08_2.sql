-- Insert your results into this table.
DROP TABLE SequelsTemp;
CREATE TABLE SequelsTemp (
  id INTEGER,
  name varchar2(100)
 );
 
CREATE OR REPLACE PROCEDURE getSequels (movieIdIn IN Movie.id%type) AS
	numSequels NUMBER := 0;
	prevSequels NUMBER := -1;
BEGIN
	INSERT INTO SequelsTemp
	SELECT DISTINCT sequel.id, sequel.name
	FROM Movie sequel, Movie original
	WHERE original.id = movieIdIn AND sequel.id = original.sequelID;

	WHILE numSequels <> prevSequels
	LOOP
		INSERT INTO SequelsTemp
		SELECT DISTINCT sequel.id, sequel.name
		FROM Movie sequel, Movie original, SequelsTemp
		WHERE original.ID = SequelsTemp.ID AND sequel.id = original.sequelID AND NOT EXISTS (SELECT * FROM SequelsTemp WHERE SequelsTemp.id = sequel.id) ;
		
		prevSequels := numSequels;
		SELECT Count(1) INTO numSequels FROM SequelsTemp;
		
	END LOOP;
	
END;
/

-- Get the sequels for Ocean's 11, i.e., 4 of them.
BEGIN  getSequels(238071);  END;
/
SELECT * FROM SequelsTemp;

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT * FROM SequelsTemp;

-- Clean up.
DROP TABLE SequelsTemp;