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
    PlayerId    INT,
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
)