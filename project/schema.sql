CREATE TABLE Player(
	playerID INTEGER PRIMARY KEY,
	username VARCHAR(32)
);

CREATE TABLE Engine(
	engineID INTEGER PRIMARY KEY,
	engineName VARCHAR(64),
	dateReleased DATE
);

CREATE TABLE Game(
	gameID INTEGER PRIMARY KEY,
	gameName VARCHAR(32),
	gameURL VARCHAR(64),
	dateReleased DATE,
	engineID INTEGER,
	FOREIGN KEY (engineID) REFERENCES Engine(engineID)
);

CREATE TABLE Review(
	reviewID INTEGER PRIMARY KEY,
	playerID INTEGER,
	gameID INTEGER,
	dateSubmitted DATE,
	rating INTEGER,
	reviewComment VARCHAR(512),
	FOREIGN KEY (playerID) REFERENCES Player(playerID),
	FOREIGN KEY (gameID) REFERENCES Game(gameID),
	UNIQUE (playerID, gameID, dateSubmitted)
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
	FOREIGN KEY (reviewID) REFERENCES Review(reviewID) 
	-- There needs to be a constraint that the chapter number must actually correspond to a chapter of the given game
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