INSERT INTO Player VALUES(0, '1upD');

INSERT INTO Engine VALUES(0, 'Half-Life 2: Episode Two Source Engine', TO_DATE('2007-10-10', 'YYYY-MM-DD'));
INSERT INTO Engine VALUES(1, 'Source SDK 2013 Source Engine', TO_DATE('2013-06-26', 'YYYY-MM-DD'));

INSERT INTO Game VALUES (0, 'Half-Life 2: Episode 2', 'http://store.steampowered.com/app/420/', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 0, NULL);
INSERT INTO Game VALUES (2, 'Estranged Act 2', 'http://store.steampowered.com/app/582890/', TO_DATE('2017-05-17', 'YYYY-MM-DD'), 1, NULL);
INSERT INTO Game VALUES (1, 'Estranged Act 1', 'http://store.steampowered.com/app/261820/', TO_DATE('2014-01-16', 'YYYY-MM-DD'), 1, 2);

INSERT INTO Chapter VALUES ('To the White Forest', 1, 0);
INSERT INTO Chapter VALUES ('This Vortal Coil', 2, 0);
INSERT INTO Chapter VALUES ('Freeman Pontifex', 3, 0);
INSERT INTO Chapter VALUES ('Riding Shotgun', 4, 0);
INSERT INTO Chapter VALUES ('Under the Radar', 5, 0);
INSERT INTO Chapter VALUES ('Our Mutual Fiend', 6, 0);
INSERT INTO Chapter VALUES ('T-Minus One', 7, 0);

INSERT INTO Chapter VALUES ('Chapter 1', 1, 1);
INSERT INTO Chapter VALUES ('Chapter 2', 2, 1);
INSERT INTO Chapter VALUES ('Chapter 3', 3, 1);

INSERT INTO GameplayCategory VALUES (1, 'Tools and Weapons');
INSERT INTO GameplayCategory VALUES (2, 'Enemy NPCs');
INSERT INTO GameplayCategory VALUES (3, 'Friendly NPCs');
INSERT INTO GameplayCategory VALUES (4, 'Vehicles');
INSERT INTO GameplayCategory VALUES (5, 'Puzzle Elements');

INSERT INTO GameplayElement VALUES (0, 'Alyx', 3);
INSERT INTO GameplayElement VALUES (1, 'Zombies', 2);
INSERT INTO GameplayElement VALUES (2, 'Gravity Gun', 1);

INSERT INTO Review VALUES (0, 0, 0, NULL, 10, 'I have not completed my full review of this game yet but it is a classic.');

INSERT INTO ReviewChapter VALUES (0, 1, 30, NULL, 7, 'This chapter sets the story in motion but it is not the most exciting.');

INSERT INTO IntroducedElement VALUES (0, 1, 0, NULL);
INSERT INTO IntroducedElement VALUES (0, 1, 1, NULL);
INSERT INTO IntroducedElement VALUES (0, 1, 2, NULL);

INSERT INTO TestedElement VALUES (0, 1, 1, NULL);
INSERT INTO TestedElement VALUES (0, 1, 2, NULL);