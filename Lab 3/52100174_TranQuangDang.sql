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
	PRIMARY KEY(SID,CID),
	FOREIGN KEY (CID) REFERENCES COURSES(CID),
	FOREIGN KEY (SID) REFERENCES STUDENT(SID),
)
-- DEPARTMENT
INSERT INTO DBO.DEPARTMENT VALUES('IT','Information Technology',2012)
INSERT INTO DBO.DEPARTMENT VALUES('ET','Electronic Technology',1997)
INSERT INTO DBO.DEPARTMENT VALUES('BT','Biotechnology',1997)
INSERT INTO DBO.DEPARTMENT VALUES('FL','Foreign language',2000)
INSERT INTO DBO.DEPARTMENT VALUES('CT','Chemical Technology',2011)

--SELECT * FROM DBO.DEPARTMENT
--STUDENT
INSERT INTO DBO.STUDENT VALUES('S01',N'Phước Trần','1990-02-24','IT')
INSERT INTO DBO.STUDENT VALUES('S02',N'Timothy','2000-12-12','IT')
INSERT INTO DBO.STUDENT VALUES('S03',N'Kaily','2001-10-01','ET')
INSERT INTO DBO.STUDENT VALUES('S04',N'Tâm Nguyễn','1998-12-20','ET')
INSERT INTO DBO.STUDENT VALUES('S05',N'Lee Nguyễn','1999-02-28','BT')

SELECT * FROM DBO.STUDENT

--COURSES
INSERT INTO DBO.COURSES VALUES('OOP','Object oriented Programming',4,'IT')
INSERT INTO DBO.COURSES VALUES('PM','Programming method',4,'IT')
INSERT INTO DBO.COURSES VALUES('DBS','Database system',4,'IT')
INSERT INTO DBO.COURSES VALUES('SE','Software engineering',4,'IT')
INSERT INTO DBO.COURSES VALUES('CN','Computer network',3,'IT')

--SELECT * FROM DBO.COURSES

--CONDITION
INSERT INTO DBO.CONDITION VALUES('OOP','PM')
INSERT INTO DBO.CONDITION VALUES('DBS','PM')
INSERT INTO DBO.CONDITION VALUES('DBS','OOP')
INSERT INTO DBO.CONDITION VALUES('SE','OOP')
INSERT INTO DBO.CONDITION VALUES('SE','DBS')

--SELECT * FROM DBO.CONDITION

--RESULTS

INSERT INTO DBO.RESULTS VALUES('S01','PM',9.5)
INSERT INTO DBO.RESULTS VALUES('S01','OOP',10)
INSERT INTO DBO.RESULTS VALUES('S02','PM',4.5)
INSERT INTO DBO.RESULTS VALUES('S02','DBS',6)
INSERT INTO DBO.RESULTS VALUES('S03','DBS',8)

SELECT * FROM DBO.RESULTS


--1
SELECT * FROM STUDENT WHERE DID='IT'

--2
SELECT * FROM DEPARTMENT WHERE YEAR(GETDATE())-DYEAR>20

--3
SELECT * FROM COURSES WHERE DID='IT' AND CREDIT>5

--4
SELECT * FROM COURSES WHERE CID='DBS'

--5
SELECT RESULTS.SID,NAME,RESULTS.CID,SCORE,CNAME
FROM RESULTS,COURSES,STUDENT WHERE STUDENT.SID=RESULTS.SID AND COURSES.CID=RESULTS.CID AND COURSES.DID='IT'

--6
SELECT STUDENT.SID,RESULTS.CID,RESULTS.SCORE
FROM STUDENT
LEFT JOIN RESULTS ON STUDENT.SID=RESULTS.SID

--7
SELECT * FROM COURSES
WHERE COURSES.CID NOT IN (SELECT CID FROM CONDITION)

--8
SELECT DEPARTMENT.DNAME,COUNT(STUDENT.SID) AS SOLUONG
FROM DEPARTMENT
LEFT JOIN STUDENT
ON DEPARTMENT.DID=STUDENT.DID
GROUP BY STUDENT.DID,DEPARTMENT.DNAME

--9

SELECT DEPARTMENT.DNAME,COUNT(COURSES.DID) AS SOLUONG
FROM DEPARTMENT
LEFT JOIN COURSES
ON COURSES.DID=DEPARTMENT.DID
GROUP BY DEPARTMENT.DNAME,COURSES.DID


--10
SELECT DEPARTMENT.DID, DEPARTMENT.DNAME, DEPARTMENT.DYEAR
FROM DEPARTMENT
LEFT JOIN STUDENT
ON DEPARTMENT.DID = STUDENT.DID
GROUP BY DEPARTMENT.DID, DEPARTMENT.DNAME, DEPARTMENT.DYEAR, STUDENT.SID, STUDENT.NAME, STUDENT.DID, STUDENT.BIRTHDAY
HAVING COUNT(STUDENT.SID)>10

--11
SELECT COURSES.CID, COURSES.CNAME, COURSES.CREDIT, COURSES.DID
FROM COURSES
LEFT JOIN RESULTS
ON COURSES.CID = RESULTS.CID
GROUP BY COURSES.CID, COURSES.CNAME, COURSES.CREDIT, COURSES.DID, RESULTS.CID
HAVING COUNT(RESULTS.CID)>10

--12
SELECT STUDENT.SID, STUDENT.NAME, AVG(RESULTS.SCORE) AS AVERAGE
FROM STUDENT
LEFT JOIN RESULTS
ON STUDENT.SID=RESULTS.SID
GROUP BY STUDENT.SID, STUDENT.NAME

--14
SELECT MIN(DTB) AS MIN_DTB FROM
(
	SELECT AVG(RESULTS.SCORE) AS DTB
	FROM STUDENT
	LEFT JOIN RESULTS
	ON STUDENT.SID=RESULTS.SID
	GROUP BY STUDENT.SID,STUDENT.NAME
) AS T

--13

SELECT MAX(DTB) AS MAX_DTB FROM
(
	SELECT AVG(RESULTS.SCORE) AS DTB
	FROM STUDENT
	LEFT JOIN RESULTS
	ON STUDENT.SID=RESULTS.SID
	GROUP BY STUDENT.SID,STUDENT.NAME
) AS T




























