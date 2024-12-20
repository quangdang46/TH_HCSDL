USE MASTER
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME='CSDL' )
DROP DATABASE CSDL
GO
CREATE DATABASE CSDL
GO
USE CSDL
GO
IF EXISTS (SELECT * FROM SYSOBJECTS  WHERE NAME='KETQUA')
DROP TABLE KETQUA;
GO
CREATE TABLE KETQUA (
  -- MASV VARCHAR(255) NOT NULL,
  -- MAMH VARCHAR(255) NOT NULL,
  -- LANTHI INT NOT NULL,
  MASV VARCHAR(255),
  MAMH VARCHAR(255),
  LANTHI INT,
  DIEM FLOAT,
  -- PRIMARY KEY (MASV,MAMH,LANTHI)
)
GO
IF EXISTS (SELECT * FROM SYSOBJECTS  WHERE NAME = 'DMKHOA')
DROP TABLE DMKHOA
GO
CREATE TABLE DMKHOA (
  MAKHOA VARCHAR(255) NOT NULL,
  TENKHOA NVARCHAR(255),
  PRIMARY KEY (MAKHOA)
)
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'DMSV')
DROP TABLE DMSV
GO
CREATE TABLE DMSV (
  MASV VARCHAR(255) NOT NULL,
  HOSV NVARCHAR(255),
  TENSV NVARCHAR(255),
  PHAI INT,
  NGAYSINH DATE,
  NOISINH NVARCHAR(255),
  MAKHOA VARCHAR(255),
  HOCBONG INT,
  -- SOMH INT,
  PRIMARY KEY (MASV)
)
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='DMMH')
DROP TABLE DMMH
GO
CREATE TABLE DMMH(
  MAMH VARCHAR(255) NOT NULL,
  TENMH NVARCHAR(255),
  SOTIET INT,
  PRIMARY KEY (MAMH)
)

ALTER TABLE KETQUA ALTER COLUMN MASV VARCHAR(255) NOT NULL
ALTER TABLE KETQUA ALTER COLUMN MAMH VARCHAR(255) NOT NULL
ALTER TABLE KETQUA ALTER COLUMN LANTHI INT NOT NULL
GO
ALTER TABLE KETQUA ADD CONSTRAINT KQ_PK PRIMARY KEY (MASV, MAMH, LANTHI)
ALTER TABLE KETQUA ADD CONSTRAINT KQ_MASV_FK FOREIGN KEY(MASV) REFERENCES DMSV(MASV) 
ALTER TABLE KETQUA ADD CONSTRAINT KQ_MAMH_FK FOREIGN KEY(MAMH) REFERENCES DMMH(MAMH)

--3.1
ALTER TABLE DMKHOA ADD NAMTL INT
--3.2
ALTER TABLE DMKHOA ALTER COLUMN NAMTL SMALLINT
--3.3
EXEC SP_RENAME 'DMKHOA.NAMTL','NAMTHANHLAP' 
--3.4 
ALTER TABLE DMKHOA DROP COLUMN NAMTHANHLAP
--3.6
ALTER TABLE DMSV ADD CONSTRAINT FK_DMSV_KHOA FOREIGN KEY(MAKHOA) REFERENCES DMKHOA(MAKHOA)
--3.5
ALTER TABLE DMSV DROP FK_DMSV_KHOA


--ADD DATA
INSERT INTO DMMH VALUES('01',N'CƠ SỞ DỮ LIỆU',45)
INSERT INTO DMMH VALUES('02',N'TRÍ TUỆ NHÂN TẠO',45)
INSERT INTO DMMH VALUES('03',N'TRUYỀN TIN',45)
INSERT INTO DMMH VALUES('04',N'ĐỒ HOẠ',60)
INSERT INTO DMMH VALUES('05',N'VĂN PHẠM',60)
INSERT INTO DMMH VALUES('06',N'KỸ THUẬT LẬP TRÌNH',45)
SELECT * FROM DMMH


INSERT INTO DMKHOA VALUES('AV',N'ANH VĂN')
INSERT INTO DMKHOA VALUES('TH',N'TIN HỌC')
INSERT INTO DMKHOA VALUES('TR',N'TRIẾT')
INSERT INTO DMKHOA VALUES('VL',N'VẬT LÝ')
SELECT * FROM DMKHOA


SET DATEFORMAT DMY

INSERT INTO DMSV VALUES('A01',N'NGUYỄN THỊ',N'HẢI',1,'23/02/1993',N'HÀ NỘI','TH',130000)
INSERT INTO DMSV VALUES('A02',N'TRẦN VĂN',N'CHÍNH',0,'24/12/1992',N'BÌNH ĐỊNH','VL',150000)
INSERT INTO DMSV VALUES('A03',N'LÊ THU BẠCH',N'YẾN',1,'21/02/1993',N'TPHCM','TH',170000)
INSERT INTO DMSV VALUES('A04',N'TRẦN ANH',N'TUẤN',0,'20/12/1994',N'HÀ NỘI','AV',80000)
INSERT INTO DMSV VALUES('B01',N'TRẦN THANH',N'MAI',1,'12/08/1993',N'HẢI PHÒNG','TR',0)
INSERT INTO DMSV VALUES('B02',N'TRẦN THỊ THU',N'THUỶ',1,'02/01/1994',N'TPHCM','AV',0)
SELECT * FROM DMSV


INSERT INTO KETQUA VALUES('A01','01',1,3)
INSERT INTO KETQUA VALUES('A01','01',2,6)
INSERT INTO KETQUA VALUES('A01','02',2,6)
INSERT INTO KETQUA VALUES('A01','03',1,5)
INSERT INTO KETQUA VALUES('A02','01',1,4.5)
INSERT INTO KETQUA VALUES('A02','01',2,7)
INSERT INTO KETQUA VALUES('A02','03',1,10)
INSERT INTO KETQUA VALUES('A02','05',1,9)

INSERT INTO KETQUA VALUES('A03','01',1,2)
INSERT INTO KETQUA VALUES('A03','01',2,5)
INSERT INTO KETQUA VALUES('A03','03',1,2.5)
INSERT INTO KETQUA VALUES('A03','05',2,4)
INSERT INTO KETQUA VALUES('A04','05',2,10)

INSERT INTO KETQUA VALUES('B01','01',1,7)
INSERT INTO KETQUA VALUES('B01','03',1,2.5)
INSERT INTO KETQUA VALUES('B01','03',2,5)

INSERT INTO KETQUA VALUES('B02','02',1,6)
INSERT INTO KETQUA VALUES('B02','04',1,10)
SELECT * FROM KETQUA


--5.1
SELECT YEAR(NGAYSINH) AS NAMSINH
FROM DMSV AS SV
GROUP BY YEAR(NGAYSINH)
HAVING COUNT(MASV)>2
--5.2
SELECT NOISINH
FROM DMSV AS SV
GROUP BY NOISINH
HAVING COUNT(MASV)>=2

--5.3
SELECT TENMH
FROM KETQUA AS K,DMMH AS MH
WHERE K.MAMH=MH.MAMH
GROUP BY K.MAMH,TENMH
HAVING COUNT(DISTINCT K.MASV)>3
--5.4
SELECT HOSV,TENSV
FROM KETQUA AS K,DMSV AS SV
WHERE K.MASV=SV.MASV
GROUP BY K.MASV,HOSV,TENSV
HAVING COUNT(LANTHI)>2

--5.5
SELECT HOSV,TENSV,AVG(DIEM) AS DTB
FROM KETQUA AS K,DMSV AS SV
WHERE K.MASV=SV.MASV AND LANTHI=1 AND PHAI=0
GROUP BY LANTHI,HOSV,TENSV
HAVING AVG(DIEM)>=7
--5.6
SELECT HOSV,TENSV
FROM KETQUA AS K,DMSV AS SV
WHERE K.MASV=SV.MASV AND LANTHI=1
GROUP BY K.MASV,HOSV,TENSV
HAVING SUM(
  CASE WHEN DIEM <5 THEN 1 ELSE 0 END
)>=2
--5.7
SELECT TENKHOA
FROM DMKHOA AS K,DMSV AS SV
WHERE K.MAKHOA=SV.MAKHOA AND PHAI=0
GROUP BY TENKHOA,SV.MAKHOA
HAVING COUNT(MASV)>=2
--5.8
SELECT TENKHOA
FROM DMKHOA AS K,DMSV AS SV
WHERE K.MAKHOA=SV.MAKHOA
GROUP BY TENKHOA,SV.MAKHOA
HAVING SUM(
  CASE WHEN HOCBONG BETWEEN 100000 AND 200000 THEN 1 ELSE 0 END
)=2
--5.9
SELECT HOSV,TENSV
FROM DMSV AS SV,KETQUA AS KQ
WHERE SV.MASV=KQ.MASV AND PHAI=0
GROUP BY HOSV,TENSV,KQ.MASV
HAVING COUNT(DISTINCT MAMH)>=3
