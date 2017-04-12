-- Query the movie table.
SELECT * FROM Movie;

-- Delete a movie and query the modified table.
DELETE 
FROM Movie
WHERE Movie.id = 238071;

-- Rollback and query.
ROLLBACK;
SELECT * FROM Movie;

-- Add a new movie and query.
INSERT INTO Movie
VALUES(99999, 'Test Movie', 2017, 1.0, NULL);

SELECT * FROM Movie WHERE Movie.id = 99999;

-- Commit.
COMMIT;