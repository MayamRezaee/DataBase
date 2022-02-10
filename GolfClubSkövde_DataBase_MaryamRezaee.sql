drop database if exists GolfCup_Maryam ;
create database GolfCup_Maryam;
use GolfCup_Maryam;

#-------------------------------------------
#Creating needed tables
#-------------------------------------------

CREATE TABLE Contest (
    contestName CHAR(50) NOT NULL,
    contestDate DATE,
    rainType VARCHAR(100) NOT NULL,
    PRIMARY KEY (contestName)
)  ENGINE=INNODB;

CREATE TABLE Rain (
    rainType VARCHAR(100) NOT NULL,
    windSpeed VARCHAR(50),
    contestName CHAR(50) NOT NULL,
    PRIMARY KEY (rainType , contestName),
    FOREIGN KEY (contestName)
        REFERENCES Contest (contestName)
)  ENGINE=INNODB;

CREATE TABLE ContestWeather (
    contestTime TIME,
    contestName CHAR(50) NOT NULL,
    rainType CHAR(100) NOT NULL,
    PRIMARY KEY (contestName , rainType),
    FOREIGN KEY (contestName)
        REFERENCES Contest (contestName),
    FOREIGN KEY (rainType)
        REFERENCES Rain (rainType)
)  ENGINE=INNODB;

CREATE TABLE Player (
    personalID BIGINT NOT NULL,
    playerName CHAR(100),
    Age INT,
    PRIMARY KEY (personalID)
)  ENGINE=INNODB;

CREATE TABLE PlayerContest_Participation (
    personalID BIGINT NOT NULL,
    contestName CHAR(50) NOT NULL,
    PRIMARY KEY (personalID , contestName),
    FOREIGN KEY (personalId)
        REFERENCES Player (personalID),
    FOREIGN KEY (contestName)
        REFERENCES Contest (contestName)
)  ENGINE=INNODB;

CREATE TABLE SticksConstruction (
    stickSerialNum INT NOT NULL,
    hardness INT,
    PRIMARY KEY (stickSerialNum)
)  ENGINE=INNODB;

CREATE TABLE HockeySticks (
    sticksMaterial VARCHAR(100),
    sticksNum INT NOT NULL,
    personalID BIGINT NOT NULL,
    stickSerialNum INT NOT NULL,
    PRIMARY KEY (sticksNum , personalID),
    FOREIGN KEY (personalID)
        REFERENCES Player (personalID),
    FOREIGN KEY (stickSerialNum)
        REFERENCES SticksConstruction (stickSerialNum)
)  ENGINE=INNODB;

CREATE TABLE Jacket (
    JacketMaterial VARCHAR(100),
    size CHAR,
    brand VARCHAR(100) NOT NULL,
    personalID BIGINT NOT NULL,
    PRIMARY KEY (brand , personalID),
    FOREIGN KEY (personalID)
        REFERENCES Player (personalID)
)  ENGINE=INNODB;

#-------------------------------------------
# Insert data in tables.
#-------------------------------------------

insert into player(personalID, playerName, age)
values('199701031111', 'Johan Andersson','25'),
 ('199805272222', 'Annika Persson', '23'),
('199110103333','Nicklas Johansson', '31');

insert into Contest (contestName, contestDate, rainType)
values('Big Golf Cup Skövde', '2021-06-10', 'hail');

insert into PlayerContest_Participation(personalID, contestName)
values ('199701031111', 'Big Golf Cup Skövde'),
('199805272222', 'Big Golf Cup Skövde'),
('199110103333', 'Big Golf Cup Skövde');

insert into Jacket(jacketMaterial, size, brand, personalID)
values ('Fleece', 'L','Didriksson','199701031111'),
('Goretex','L', 'Puma', '199701031111'),
('leather', 'M','Adidas', '199805272222');

insert into SticksConstruction (stickSerialNum, hardness)
values(02222, '5'), (03333, '10'), (011111, '7');

insert into HockeySticks (sticksMaterial, sticksNum, personalID, stickSerialNum )
values ('tree', '1111', '199701031111', 011111);

insert into rain (rainType, windSpeed,contestName)
values ('hail', '10 m/s', 'Big Golf Cup Skövde'  ) ;

insert into ContestWeather(contestTime, contestName, rainType)
values ('10:30:00', 'Big Golf Cup Skövde',  'hail');

#-------------------------------------------
#SQL Querry
#-------------------------------------------

# 1. Hämta ålder för spelaren Johan Andersson.
select age from Player where playerName = 'Johan Andersson';

# 2. Hämta datum för tävlingen Big Golf Cup Skövde.
select contestDate from Contest where contestName = 'Big Golf Cup Skövde';

# 3. Hämta materialet för Johan Anderssons klubba.
select sticksMaterial from HockeySticks where personalID = '199701031111'; 

# 4. Hämta alla jackor som tillhör Johan Andersson.
select jacketMaterial, size, brand from Jacket where personalID = '199701031111';

# 5. Hämta alla spelare som deltog i Big Golf Cup Skövde.
select personalID from PlayerContest_Participation where contestName = 'Big Golf Cup Skövde';


# 6. Hämta regnens vindstyrka för Big Golf Cup Skövde.
select windSpeed from rain where contestName = 'Big Golf Cup Skövde';

# 7. Hämta alla spelare som är under 30 år.
select playerName from Player where age <30;

# 8. Ta bort Johan Anderssons jackor.
delete from Jacket where personalID = '199701031111';

# 9. Ta bort Nicklas Jansson.
set FOREIGN_KEY_CHECKS= off;  
Delete from Player where playerName = 'Nicklas Johansson';
set FOREIGN_KEY_CHECKS= on;

# 10. Hämta medelåldern för alla spelare.
select avg(age) from Player;






























 