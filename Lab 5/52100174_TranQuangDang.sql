﻿USE master
GO

IF EXISTS(SELECT * FROM SYSDATABASES WHERE NAME='QLSV')
DROP DATABASE QLSV
GO

CREATE DATABASE QLSV
GO

USE QLSV
GO


IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='DEPARTMENT')
DROP TABLE DEPARTMENT
GO

CREATE TABLE DEPARTMENT(
	DID VARCHAR(30) PRIMARY KEY,
	DNAME VARCHAR(30),
	DYEAR INT,
)
GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='STUDENT')
DROP TABLE STUDENT
GO

CREATE TABLE STUDENT (
	SID VARCHAR(30) PRIMARY KEY,
	NAME NVARCHAR(30) NOT NULL,
	BIRTHDAY DATE,
	DID VARCHAR(30),
	FOREIGN KEY (DID) REFERENCES DEPARTMENT(DID),
)

GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='COURSES')
DROP TABLE COURSES
GO

CREATE TABLE COURSES (
	CID VARCHAR(30) PRIMARY KEY,
	CNAME VARCHAR(30),
	CREDIT INT,
	DID VARCHAR(30),
	FOREIGN KEY (DID) REFERENCES DEPARTMENT(DID),
)

GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='CONDITION')
DROP TABLE CONDITION
GO

CREATE TABLE CONDITION (
	CID VARCHAR(30),
	PRECID VARCHAR(30),
	PRIMARY KEY (CID ,PRECID),
	FOREIGN KEY (CID) REFERENCES COURSES(CID),
	FOREIGN KEY (PRECID) REFERENCES COURSES(CID),
)

GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='RESULTS')
DROP TABLE RESULTS
GO

CREATE TABLE RESULTS (
	SID VARCHAR(30),
	CID VARCHAR(30),
	SCORE FLOAT,
	--PRIMARY KEY(SID,CID),
	FOREIGN KEY (CID) REFERENCES COURSES(CID),
	FOREIGN KEY (SID) REFERENCES STUDENT(SID),
)
-- LAB 2
--P1
-- DEPARTMENT
INSERT INTO DBO.DEPARTMENT VALUES('IT','Information Technology',2012)
INSERT INTO DBO.DEPARTMENT VALUES('ET','Electronic Technology',1997)
INSERT INTO DBO.DEPARTMENT VALUES('BT','Biotechnology',1997)
INSERT INTO DBO.DEPARTMENT VALUES('FL','Foreign language',2000)
INSERT INTO DBO.DEPARTMENT VALUES('CT','Chemical Technology',2011)

-- SELECT * FROM DBO.DEPARTMENT
--STUDENT
INSERT INTO DBO.STUDENT VALUES('S01',N'Phước Trần','1990-02-24','IT')
INSERT INTO DBO.STUDENT VALUES('S02',N'Timothy','2000-12-12','IT')
INSERT INTO DBO.STUDENT VALUES('S03',N'Kaily','2001-10-01','ET')
INSERT INTO DBO.STUDENT VALUES('S04',N'Tâm Nguyễn','1998-12-20','ET')
INSERT INTO DBO.STUDENT VALUES('S05',N'Lee Nguyễn','1999-02-28','BT')

-- SELECT * FROM DBO.STUDENT

--COURSES
INSERT INTO DBO.COURSES VALUES('OOP','Object oriented Programming',4,'IT')
INSERT INTO DBO.COURSES VALUES('PM','Programming method',4,'IT')
INSERT INTO DBO.COURSES VALUES('DBS','Database system',4,'IT')
INSERT INTO DBO.COURSES VALUES('SE','Software engineering',4,'IT')
INSERT INTO DBO.COURSES VALUES('CN','Computer network',3,'IT')

-- SELECT * FROM DBO.COURSES

--CONDITION
INSERT INTO DBO.CONDITION VALUES('OOP','PM')
INSERT INTO DBO.CONDITION VALUES('DBS','PM')
INSERT INTO DBO.CONDITION VALUES('DBS','OOP')
INSERT INTO DBO.CONDITION VALUES('SE','OOP')
INSERT INTO DBO.CONDITION VALUES('SE','DBS')

-- SELECT * FROM DBO.CONDITION

--RESULTS

INSERT INTO DBO.RESULTS VALUES('S01','PM',9.5)
INSERT INTO DBO.RESULTS VALUES('S01','OOP',10)
INSERT INTO DBO.RESULTS VALUES('S02','PM',4.5)
INSERT INTO DBO.RESULTS VALUES('S02','DBS',6)
INSERT INTO DBO.RESULTS VALUES('S03','DBS',8)

-- SELECT * FROM DBO.RESULTS

--5.1

GO
CREATE VIEW DBO.VIEW_DEPARTMENT AS
SELECT DNAME,DYEAR
FROM DBO.DEPARTMENT
WHERE DID NOT IN (SELECT DID FROM DBO.STUDENT)
GO
SELECT * FROM DBO.VIEW_DEPARTMENT
--5.2
GO
CREATE VIEW DBO.VIEW_DEPARTMENT2 AS
SELECT DNAME,DYEAR
FROM DBO.DEPARTMENT
WHERE DID NOT IN (SELECT DID FROM DBO.COURSES)
GO

--5.3
GO
CREATE VIEW DBO.VIEW_COURSES AS
SELECT CID,CNAME,CREDIT
FROM DBO.COURSES
WHERE CID NOT IN (SELECT CID FROM DBO.RESULTS)
GO
--5.4
GO
CREATE VIEW DBO.VIEW_STUDENT AS
SELECT SID,NAME,BIRTHDAY
FROM DBO.STUDENT
WHERE SID NOT IN (SELECT SID FROM DBO.RESULTS)
GO
--5.5
CREATE VIEW DBO.VIEW_STUDENT2 AS
SELECT SID,NAME,BIRTHDAY
FROM DBO.STUDENT
WHERE SID IN (
	SELECT SID FROM DBO.RESULTS
	GROUP BY SID
	HAVING AVG(SCORE) < 5
)
GO
--5.6
GO
CREATE VIEW DBO.VIEW_STUDENT3 AS
SELECT SID,NAME,BIRTHDAY,DID
FROM DBO.STUDENT
WHERE SID IN (
	SELECT SID FROM DBO.RESULTS
	GROUP BY SID
	HAVING AVG(SCORE) = (
		SELECT MAX(AVG_SCORE) FROM (
			SELECT SID,AVG(SCORE) AS AVG_SCORE
			FROM DBO.RESULTS
			GROUP BY SID
		) AS A
	)
)
GO
--5.7
GO
CREATE VIEW DBO.VIEW_COURSES2 AS
SELECT CID,CNAME,CREDIT
FROM DBO.COURSES
WHERE CID IN (
	SELECT CID FROM DBO.RESULTS
	GROUP BY CID
	HAVING COUNT(SID) = (
		SELECT MAX(COUNT_SID) FROM (
			SELECT CID,COUNT(SID) AS COUNT_SID
			FROM DBO.RESULTS
			GROUP BY CID
		) AS A
	)
)
--5.8
GO
CREATE VIEW DBO.VIEW_COURSES3 AS
SELECT CID,CNAME,CREDIT
FROM DBO.COURSES
WHERE CID IN (
	SELECT CID FROM DBO.RESULTS
	GROUP BY CID
	HAVING COUNT(SID) < 5
)
GO
--5.9
GO
CREATE VIEW DBO.VIEW_COURSES4 AS
SELECT CID,CNAME,CREDIT
FROM DBO.COURSES
WHERE CID IN (
	SELECT CID FROM DBO.RESULTS
	GROUP BY CID
	HAVING COUNT(SID) >= 2
)
GO
--5.10
GO
CREATE VIEW DBO.VIEW_DEPARTMENT3 AS
SELECT DNAME,DYEAR,DID
FROM DBO.DEPARTMENT,DBO.VIEW_STUDENT3
WHERE DBO.DEPARTMENT.DID = DBO.VIEW_STUDENT3.DID
GROUP BY DNAME,DYEAR,DID
GO

--5.11
GO
UPDATE DBO.RESULTS
SET SCORE+=1
WHERE SID IN (
	SELECT SID FROM DBO.STUDENT
	WHERE DID = 'IT'
)
GO
--5.12
GO
CREATE VIEW DBO.VIEW_RESULTS AS
SELECT SID,CID,SCORE
FROM DBO.RESULTS
WHERE SID IN (
	SELECT SID FROM DBO.STUDENT
	WHERE DID = 'IT'
)
GO
UPDATE DBO.VIEW_RESULTS
SET SCORE=(
	CASE WHEN SCORE > 10 THEN 10
	ELSE SCORE+1
	END
)
GO

--5.13
GO
CREATE VIEW DBO.VIEW_STUDENT4 AS
SELECT SID,NAME,BIRTHDAY
FROM DBO.STUDENT
ORDER BY AVG(SCORE) DESC, BIRTHDAY ASC
GO
--5.14
GO
CREATE VIEW DBO.VIEW_COURSES5 AS
SELECT CID,CNAME,CREDIT
FROM DBO.COURSES
WHERE CID IN (
	SELECT CID FROM DBO.RESULTS
	GROUP BY CID
	HAVING MIN(SCORE) = (
		SELECT MIN(SCORE) FROM DBO.RESULTS
	)
)
GO
--5.15
GO
CREATE VIEW DBO.VIEW_STUDENT5 AS
SELECT SID,NAME,BIRTHDAY
FROM DBO.STUDENT
WHERE SID IN (
	SELECT SID FROM DBO.RESULTS
	GROUP BY SID
	HAVING AVG(SCORE) > (
		SELECT AVG(SCORE) FROM DBO.RESULTS
		WHERE DID = 'IT'
	)
)
GO
--5.16
GO
CREATE VIEW DBO.VIEW_STUDENT6 AS
SELECT SID,NAME,BIRTHDAY
FROM DBO.STUDENT
WHERE SID IN (
	SELECT SID FROM DBO.RESULTS
	GROUP BY SID
	HAVING AVG(SCORE) >= 5
)
AND NAME LIKE 'Nguyễn%'
AND DATEDIFF(YEAR,BIRTHDAY,GETDATE()) > 20
GO











