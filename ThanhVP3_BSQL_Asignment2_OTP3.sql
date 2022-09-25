Create database BSQL_Assignments 
Go
Use BSQL_Assignments 
Go
--Q1
--a
create table Movie(
   MovieID int not null primary key,
   [Name] varchar(50) not null,
   Duration time not null,
   Genre nvarchar(100) not null, 
   Director nvarchar(100) not null,
   Amount money not null,
   Comments varchar(max),
   Constraint Duration check (Duration >= '1:00:00'),
   Constraint Genre check ( Genre >=1 and Genre <=8)
   )
Go
--b
create table Actor (
    ActorID int not null ,
	ActorName varchar(50) not null,
	ActorAge int not null,
	AvgSalary  money not null,
	Nationality varchar(50) not null,
	constraint PK_ActorID  PRIMARY KEY (ActorID)
)
--c
create table ActedIn(
    MovieID int not null,
    ActorID int not null,
	constraint PK_actedIn PRIMARY KEY(MovieID, ActorID),
	constraint FK_MovieID Foreign Key(MovieID) References Movie(MovieID),
	constraint FK_ActorID Foreign Key(ActorID) References Actor(ActorID)
)
--Q2
--a
ALTER TABLE Movie 
ADD ImageLink varchar(255);
Go

ALTER TABLE Movie
Add Constraint UK_ImageLink Unique (ImageLink)
Go
--b
Insert Into Movie ([MovieID] ,[Name],[Duration],[Genre],[Director],[Amount] ,[Comments],[ImageLink])
Values
       (1,'Watch The Boys','01:46:00',1,'Mikko Niskanen',70000,'Four young London teen boys hold the key to an unsolved crime.','https://cdn.watchnow.com/images/movie/635/poster-180x270.jpg'),
       (2,'Valkyrie','02:00:00',3,'Bryan Singer',50000,'Valkyrie is a 2008 action film about a group of renegade German officers who plot to kill Adolph Hitler.','https://cdn.watchnow.com/images/movie/29142/poster-180x270.jpg'),
	   (3,'Joyeux Noel','1:46:00',2,'Christian Carion',70000,'Joyeux Noel tells the story of the first Christmas during World War I','https://cdn.watchnow.com/images/movie/23410/poster-180x270.jpg'),
	   (4,'Bohemian Rhapsody','02:14:00',8,'Bryan Singer',70000,'This dramatic biopic tells the story of the 70s rock supergroup Queen and their charismatic lead singer Freddie Mercury. ','https://cdn.watchnow.com/images/movie/141319/poster-180x270.jpg'),
	   (5,'Shutter Island','2:28:00',1,'Martin Scorsese',10000,'U.S. Marshal Edward Daniels and his new partner Chuck Aule investigate the disappearance of a patient at a secluded island mental institution for the criminally insane in 1954.','https://cdn.watchnow.com/images/movie/30249/poster-180x270.jpg')

UPDATE Movie SET [Director] = 'Bryan Darwin' WHERE [MovieID] = 2;

INSERT INTO [dbo].[Actor] ([ActorID] ,[ActorName],[ActorAge],[AvgSalary] ,[Nationality])
     VALUES(1,'Milis' ,25 ,10000000,'US'),
	        (2,'Halu' ,50 ,200000,'US'),
			(3,'Geoge' ,52 ,10000000,'US'),
			(4,'Lilia' ,60 ,10000000,'US'),
			(5,'Binary' ,19 ,10000000,'US')

INSERT INTO [dbo].[ActedIn] ([MovieID],[ActorID])
     VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(1,2)

--Q3
--c
SELECT * FROM Actor WHERE ActorAge > 50;
--d
SELECT ActorName,AvgSalary FROM Actor
ORDER BY AvgSalary ASC;
--e
SELECT dbo.Movie.Name
FROM     dbo.ActedIn INNER JOIN dbo.Actor ON dbo.ActedIn.ActorID = dbo.Actor.ActorID INNER JOIN dbo.Movie ON dbo.ActedIn.MovieID = dbo.Movie.MovieID
where Actor.ActorName = 'Geoge'
--f
SELECT MovieID, COUNT(ActorID) AS NumActor FROM ActedIn
GROUP BY MovieID;