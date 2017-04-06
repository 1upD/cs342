-- Insert your results into this table.
CREATE TABLE SequelsTemp (
  id INTEGER,
  name varchar2(100),
  PRIMARY KEY (id)
 );
 
CREATE OR REPLACE PROCEDURE getSequels (movieIdIn IN Movie.id%type) AS
	SELECT * FROM Movie
	INTO SequelsTemp
	
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