-- Create the schema for the level design database.

-- Table represents a user that can write reviews of games for the level design database.
-- Satisfies 4NF (see data.txt)
CREATE TABLE Player(
	playerID INTEGER PRIMARY KEY,
	username VARCHAR(32)
);

-- Table representing the game engine used for any games or mods in the database.
-- Since the database was intended to be used for Source engine mods, it is important to specify
-- which engine was used to create the mod. Currently the database does not suppport related
-- versions of an engine such as the 2007 Source Engine vs the 2013 Source Engine.
-- Satisfies 4NF (see data.txt)
CREATE TABLE Engine(
	engineID INTEGER PRIMARY KEY,
	engineName VARCHAR(64),
	dateReleased DATE
);

-- Table representing a game, expansion pack, or game mod. Each game can have a URL and an engine ID
-- Satisfies 4NF (see data.txt)
CREATE TABLE Game(
	gameID INTEGER PRIMARY KEY,
	gameName VARCHAR(32),
	gameURL VARCHAR(64),
	dateReleased DATE,
	engineID INTEGER,
	FOREIGN KEY (engineID) REFERENCES Engine(engineID)
);

-- Review table models a review of a game by a user. It could have been defined as a weak entity 
-- identified by playerID and gameID, however giving Review it's own reviewID simplifies other tables 
-- and additionally means a user can create multiple reviews of the same game if the game changes or 
-- over time.
-- Constraints ensure that the rating of a game is always between 0 and 10.
-- Satisfies 4NF (see data.txt)
CREATE TABLE Review(
	reviewID INTEGER PRIMARY KEY,
	playerID INTEGER,
	gameID INTEGER,
	dateSubmitted DATE,
	rating INTEGER,
	reviewComment VARCHAR(512),
	FOREIGN KEY (playerID) REFERENCES Player(playerID),
	FOREIGN KEY (gameID) REFERENCES Game(gameID),
	UNIQUE (playerID, gameID, dateSubmitted),
	CHECK (rating >= 0),
	CHECK (rating <= 10) -- Ratings will go from 0 to 10
);

CREATE TABLE Chapter(
	chapterName VARCHAR(32),
	chapterNumber INTEGER,
	gameID INTEGER,
	PRIMARY KEY (chapterNumber, gameID),
	FOREIGN KEY (gameID) REFERENCES Game(gameID)
);

CREATE TABLE GameplayCategory(
	categoryID INTEGER PRIMARY KEY,
	categoryName VARCHAR(32)
);

CREATE TABLE GameplayElement(
	gameplayElementID INTEGER PRIMARY KEY,
	gameplayElementName VARCHAR(32),
	categoryID INTEGER,
	FOREIGN KEY (categoryID) REFERENCES GameplayCategory(categoryID)
);

CREATE TABLE ReviewChapter(
	reviewID INTEGER,
	chapterNumber INTEGER,
	minutesPlayed INTEGER,
	datePlayed DATE,
	rating INTEGER,
	chapterComment VARCHAR(512),
	PRIMARY KEY (reviewID, chapterNumber),
	FOREIGN KEY (reviewID) REFERENCES Review(reviewID),
	CHECK (rating >= 0),
	CHECK (rating <= 10)
);


CREATE TABLE IntroducedElement(
	reviewID INTEGER,
	chapterNumber INTEGER,
	gameplayElementID INTEGER,
	introducedElementComment VARCHAR(256),
	PRIMARY KEY (reviewID, chapterNumber, gameplayElementID),
	FOREIGN KEY (reviewID) REFERENCES Review(reviewID),
	FOREIGN KEY (gameplayElementID) REFERENCES GameplayElement(gameplayElementID)
);

CREATE TABLE TestedElement(
	reviewID INTEGER,
	chapterNumber INTEGER,
	gameplayElementID INTEGER,
	testedElementComment VARCHAR(256),
	PRIMARY KEY (reviewID, chapterNumber, gameplayElementID),
	FOREIGN KEY (reviewID) REFERENCES Review(reviewID),
	FOREIGN KEY (gameplayElementID) REFERENCES GameplayElement(gameplayElementID)
);