-- Get an average rating and number of players for all games
-- This query can be used to return the average rating of all games. This would be used by someone interesed in quickly sorting games by average rating.
SELECT Game.GameID, Game.GameName, Count(playerID), Avg(Rating)
FROM Game LEFT OUTER JOIN Review
On Review.gameID = Game.gameID
GROUP BY Game.GameID, Game.GameName;

-- Get a total number of minutes played by a particular player review
-- This query can be used to return the total number of minutes played during each review. Someone might want to use this to sort reviews by minutes played.
SELECT Review.ReviewID, SUM(ReviewChapter.MinutesPlayed)
FROM Review LEFT OUTER JOIN ReviewChapter
ON Review.ReviewID = ReviewChapter.ReviewID
GROUP BY Review.ReviewID;

-- Get all gameplay elements from all reviews for each chapter. 
-- Used by someone looking for all gameplay elements found in all games and the comments on them.
SELECT GameID, GameName, GameElementChapterNumber, GameplayElement.gamePlayElementID as GamePlayElementID, GameplayElement.categoryID As GamePlayCategoryID, GamePlayElement.GamePlayElementName as GamePlayElementName, GameElementComment
FROM
	(SELECT Game.GameID as GameID, Game.GameName As GameName, GameElementChapterNumber, ChapterGameplayElementID, GameElementComment
	FROM
		(SELECT DISTINCT Review.gameID AS GameElementGameID, GameElementChapterNumber, ChapterGameplayElementID, GameElementComment
		FROM 
			((SELECT DISTINCT ReviewID AS GameElementReviewID, ChapterNumber AS GameElementChapterNumber, gamePlayElementID As ChapterGameplayElementID, introducedElementComment As GameElementComment
			FROM IntroducedElement)
			UNION
			(SELECT DISTINCT ReviewID AS GameElementReviewID, ChapterNumber AS GameElementChapterNumber, gamePlayElementID As ChapterGameplayElementID, testedElementComment As GameElementComment
			FROM testedElement))
		INNER JOIN Review
		ON GameElementReviewID = Review.ReviewID)
	INNER JOIN Game
	ON GameElementGameID = Game.GameID)
INNER JOIN GameplayElement
ON ChapterGameplayElementID = GamePlayElement.GamePlayElementID;

-- Create a view that displays each game reviewed, the number of players who have played it, the average rating, total hours played, and average hours played.
-- This view would be used to display aggregate data about a given game/mod based on all reviews. It would be used by application uses who want to know how much a game has been played and what the average rating of the game is.
-- I decided ato make this view a materialized view because the query it runs off of involves multiple joins. Updating the view will be faster than rerunning the query.
DROP MATERIALIZED VIEW GameReviewAggregateView;
CREATE MATERIALIZED VIEW GameReviewAggregateView(GameID, GameName, EngineID, EngineName, PlayersReviewed, AvgRating, TotalHours, AvgHours) AS
SELECT GameID, GameName, GameEngineID, Engine.EngineName, PlayerCount, AvgRating, TimePlayed, AvgTime
FROM (
	SELECT GameID, GameName, EngineID AS GameEngineID, Count(playerID) As PlayerCount, Avg(Rating) As AvgRating, Sum(timePlayed) As TimePlayed, Avg(timePlayed) as AvgTime
	FROM Game LEFT OUTER JOIN 
		(
		SELECT Review.GameID as ReviewGameID, Review.ReviewID as ReviewID, Review.PlayerID AS PlayerID, Review.Rating As Rating, SUM(ReviewChapter.MinutesPlayed) AS timePlayed
		FROM Review LEFT OUTER JOIN ReviewChapter
		ON Review.ReviewID = ReviewChapter.ReviewID
		GROUP BY Review.GameID, Review.ReviewID, Review.PlayerID, Review.Rating
		)
	On ReviewGameID = Game.gameID
	GROUP BY GameID, GameName, EngineID
	)
INNER JOIN Engine
ON GameEngineID = Engine.EngineID;

