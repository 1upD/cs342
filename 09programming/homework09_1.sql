SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;



-- Get the movies directed by Clint Eastwood.
DROP INDEX MovieDirectorIndex;
CREATE INDEX MovieDirectorIndex ON MovieDirector(DirectorID, MovieID);

-- SELECT Movie.ID, Movie.Name, Movie.Year, Movie.Rank
-- FROM Movie, Director, MovieDirector
-- WHERE  MovieDirector.DirectorID = Director.ID AND MovieDirector.MovieID = Movie.ID AND -- Director.FirstName = 'Clint' AND Director.LastName = 'Eastwood';

SELECT Movie.ID, Movie.Name, Movie.Year, Movie.Rank
FROM Movie INNER JOIN (
	SELECT MovieDirector.MovieID AS EastwoodMovieID
	FROM MovieDirector INNER JOIN
	(
		SELECT Director.ID AS EastwoodID
		FROM Director
		WHERE Director.FirstName = 'Clint' AND Director.LastName = 'Eastwood'
	) ON EastwoodID = MovieDirector.DirectorID
) ON Movie.ID = EastwoodMovieID;

-- I created an index on MovieDirector to optimize the join with Movie and Director. 
-- I tried two different implementations of the query, the latter of which selects only Clint Eastwood first before performing a join. Surprisingly, both seemed to execute about the same. Most likely, the DBMS has heuristics to filter by director name first and then execute joins.

-- Get the number of movies directed by each director who’s directed more than 200 movies.
SELECT MovieDirector.DirectorID, Count(MovieDirector.MovieID) As MovieCount
FROM MovieDirector
GROUP BY MovieDirector.DirectorID
HAVING Count(MovieDirector.MovieID) > 200;

-- I can't think of any better way to write this query. It also takes advantage of the index I created for the Clint Eastwood query.

-- Get the most popular actors, where actors are designated as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.
-- DROP INDEX RoleIndex;
-- CREATE INDEX RoleIndex ON Role(ActorID, MovieID);

SELECT Actor.ID, Actor.Firstname, Actor.Lastname, Actor.Gender, MovieCount, MovieRank
FROM ACTOR INNER JOIN (
	SELECT Role.ActorID AS PopularActorID, Count(Role.MovieID) AS MovieCount, Avg(Movie.Rank) AS MovieRank
	FROM Role INNER JOIN Movie
	ON Movie.ID = Role.MovieID
	GROUP BY Role.ActorID
	HAVING Count(Role.MovieID) > 9 AND Avg(Movie.Rank) > 8.5
) ON PopularActorID = Actor.ID;

-- I wanted to create an index to speed up this query but unfortunately there was a memory error in the database.
-- CREATE INDEX RoleIndex ON Role(ActorID, MovieID);
-- CREATE INDEX RoleIndex ON Role(ActorID, MovieID)
--                           *
-- ERROR at line 1:
-- ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM

