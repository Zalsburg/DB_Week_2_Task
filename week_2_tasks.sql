DROP TABLE IF EXISTS PLAYERREGISTRATION;
DROP TABLE IF EXISTS TEAMENTRY;
DROP TABLE IF EXISTS PLAYER;
DROP TABLE IF EXISTS SEASON;
DROP TABLE IF EXISTS CLUB;

CREATE TABLE CLUB (
    ClubName    NVARCHAR(100),
    ContactName NVARCHAR(100),
    PRIMARY KEY (ClubName)
);

CREATE TABLE SEASON (
    SeasonYear  INT,
    SeasonName  NVARCHAR(6),
    PRIMARY KEY (SeasonYear, SeasonName),
        CHECK (SeasonName IN ('Winter', 'Summer'))
);

CREATE TABLE PLAYER (
    PlayerId    INT IDENTITY(1000, 1),
    FName       NVARCHAR(100) NOT NULL,
    LName       NVARCHAR(100) NOT NULL,
    Phone       NVARCHAR(50),
    PRIMARY KEY (PlayerId)
);

CREATE TABLE TEAMENTRY (
    ClubName    NVARCHAR(100),
    SeasonYear  INT,
    SeasonName  NVARCHAR(6),
    AgeGroup    NVARCHAR(3),
    TeamNumber  INT,
    PRIMARY KEY (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY (ClubName) references CLUB,
    FOREIGN KEY (SeasonYear, SeasonName) references SEASON
);

CREATE TABLE PLAYERREGISTRATION (
    PlayerId    INT,
    ClubName    NVARCHAR(100),
    SeasonYear  INT,
    SeasonName  NVARCHAR(6),
    AgeGroup    NVARCHAR(3),
    TeamNumber  INT,
    DataRegistered  DATE NOT NULL,
    PRIMARY KEY (PlayerId, ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY (PlayerId) references PLAYER,
    FOREIGN KEY (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber) references TEAMENTRY
);

INSERT INTO CLUB (ClubName, ContactName)
VALUES  ('Bird Club', 'Rosella Dawson'),
        ('Laser Club', 'Mike Dingle'),
        ('Funky Brain Club', 'Zali Spurgeon'),
        ('Coffee Club', 'Scary Dude');

INSERT INTO SEASON (SeasonYear, SeasonName)
VALUES  (2019, 'Summer'),
        (2019, 'Winter'),
        (2020, 'Summer'),
        (2020, 'Winter');

INSERT INTO PLAYER (FName, LName, Phone)
VALUES  ('Bicycle', 'Johnson', '0499 764 982'),
        ('Peter', 'Jackson', '0473 739 373'),
        ('Simile', 'Peters', '0493 429 298'),
        ('Maia', 'Warren', '0468 455 872');

INSERT INTO TEAMENTRY (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber)
VALUES  ('Bird Club', 2019, 'Summer', 'U13', 1),
        ('Laser Club', 2020, 'Winter', 'U8', 1),
        ('Funky Brain Club', 2020, 'Summer', 'U21', 1),
        ('Funky Brain Club', 2020, 'Summer', 'U21', 2);

INSERT INTO PLAYERREGISTRATION (PlayerId, ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber, DataRegistered)
VALUES  (1000, 'Bird Club', 2019, 'Summer', 'U13', 1, '18 Nov 2018'),
        (1001, 'Funky Brain Club', 2020, 'Summer', 'U21', 2, '9 Aug 2019'),
        (1002, 'Laser Club', 2020, 'Winter', 'U8', 1, '7 Sep 2019'),
        (1003, 'Laser Club', 2020, 'Winter', 'U8', 1, '5 Feb 2020');

SELECT P.PlayerId, P.FName, P.LName, P.Phone, C.ClubName, C.ContactName, PR.SeasonYear, PR.SeasonName, TE.AgeGroup, TE.TeamNumber
FROM PLAYER P
INNER JOIN PLAYERREGISTRATION PR
ON P.PlayerId = PR.PlayerId
INNER JOIN TEAMENTRY TE
ON PR.ClubName = TE.ClubName AND PR.SeasonYear = TE.SeasonYear AND PR.SeasonName = TE.SeasonName AND PR.AgeGroup = TE.AgeGroup AND PR.TeamNumber = TE.TeamNumber
INNER JOIN CLUB C
ON C.ClubName = TE.ClubName
ORDER BY P.PlayerId asc;

SELECT SeasonYear, AgeGroup, Count(*) AS "Number of Player"
FROM PLAYERREGISTRATION
GROUP BY SeasonYear, AgeGroup
ORDER BY SeasonYear, AgeGroup ASC

SELECT *
FROM PLAYERREGISTRATION
WHERE PlayerId >    (SELECT AVG(PlayerId)
                    FROM PLAYERREGISTRATION);