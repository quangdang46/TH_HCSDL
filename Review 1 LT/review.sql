USE MASTER
GO
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME='CSDL')
BEGIN
    DROP DATABASE CSDL
END
GO
CREATE DATABASE CSDL
GO
USE CSDL
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='NSX')
BEGIN
    DROP TABLE NSX
END
GO
CREATE TABLE NSX(
  MaNSX VARCHAR(255) PRIMARY KEY,
  TENNSX NVARCHAR(255) UNIQUE NOT NULL,
)

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='XEMAY')
BEGIN
    DROP TABLE XEMAY
END
GO
CREATE TABLE XEMAY(
  MAXE VARCHAR(255) PRIMARY KEY,
  TENXE NVARCHAR(255) NOT NULL,
  MANSX VARCHAR(255),
  SOLUONG INT CHECK (SOLUONG > 0),
  DONGIA INT CHECK (DONGIA > 0),
  FOREIGN KEY (MANSX) REFERENCES NSX(MANSX)
)

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='KHACHHANG')
BEGIN
    DROP TABLE KHACHHANG
END
GO
CREATE TABLE KHACHHANG(
  SDT VARCHAR(11),
  HOTEN NVARCHAR(255) NOT NULL,
  CONSTRAINT KH_SDT_PRI PRIMARY KEY(SDT),
  DIACHI NVARCHAR(20) CHECK(DIACHI IN ('TPHCM', 'DONG NAI', 'LONG AN', 'TAY NINH'))
)
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='HOADON')
BEGIN
    DROP TABLE HOADON
END
GO
CREATE TABLE HOADON(
  SOHOADON VARCHAR(20) PRIMARY KEY, 
  NGAYLAP DATE DEFAULT GETDATE(),
  MAKHACHHANG VARCHAR(11),
  CONSTRAINT PK_SDT FOREIGN KEY(MAKHACHHANG) REFERENCES KHACHHANG(SDT)
)
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='CHITIETHOADON')
BEGIN
    DROP TABLE CHITIETHOADON
END
GO
CREATE TABLE CHITIETHOADON(
  SOHOADON VARCHAR(20),
  MAXE VARCHAR(255),
  SOLUONGMUA INT,
  DONGIA INT,
  CONSTRAINT CHECK_SOLUONGMUA CHECK(SOLUONGMUA > 0),
  CONSTRAINT CHECK_DONGIA CHECK(DONGIA > 0),
  CONSTRAINT PRI_CHITIETHOADON PRIMARY KEY (SOHOADON, MAXE),
  CONSTRAINT PK_SOHOADON FOREIGN KEY(SOHOADON) REFERENCES HOADON(SOHOADON),
  CONSTRAINT PK_MAUXE FOREIGN KEY(MAXE) REFERENCES XEMAY(MAXE)
)
-- 2A
ALTER TABLE NSX ADD QUOCGIA NVARCHAR(30)
GO
-- 2B
ALTER TABLE NSX ADD CONSTRAINT CHECK_QUOCGIA CHECK(QUOCGIA IN ('NHAT', 'HAN', 'MY', 'DUC'))
--2C
ALTER TABLE HOADON ADD NGAYGIAOHANG DATE
GO
--2D
ALTER TABLE HOADON ADD CONSTRAINT CHECK_NGAYGIAOHANG CHECK(NGAYGIAOHANG>=NGAYLAP)
--2E
ALTER TABLE HOADON DROP CONSTRAINT PK_SDT
ALTER TABLE KHACHHANG DROP CONSTRAINT KH_SDT_PRI

ALTER TABLE KHACHHANG ALTER COLUMN SDT INT NOT NULL
ALTER TABLE KHACHHANG ADD PRIMARY KEY(SDT)

ALTER TABLE HOADON ALTER COLUMN MAKHACHHANG INT NOT NULL 
ALTER TABLE HOADON ADD CONSTRAINT PK_SDT FOREIGN KEY(MAKHACHHANG) REFERENCES KHACHHANG(SDT)
--2F
ALTER TABLE HOADON DROP CONSTRAINT PK_SDT
--2G

-- CREATE TABLE CHITIETHOADON(
--   SOHOADON INT,
--   MAXE VARCHAR(255),
--   SOLUONGMUA INT,
--   DONGIA INT,

--   CONSTRAINT CHECK_SOLUONGMUA CHECK(SOLUONGMUA > 0),
--   CONSTRAINT CHECK_DONGIA CHECK(DONGIA > 0),
--   CONSTRAINT PRI_CHITIETHOADON PRIMARY KEY (SOHOADON, MAXE),
--   CONSTRAINT PK_SOHOADON FOREIGN KEY(SOHOADON) REFERENCES HOADON(SOHOADON),
--   CONSTRAINT PK_MAUXE FOREIGN KEY(MAXE) REFERENCES XEMAY(MAXE)
-- )

ALTER TABLE CHITIETHOADON DROP CONSTRAINT CHECK_SOLUONGMUA
ALTER TABLE CHITIETHOADON DROP CONSTRAINT CHECK_DONGIA
ALTER TABLE CHITIETHOADON DROP CONSTRAINT PRI_CHITIETHOADON
ALTER TABLE CHITIETHOADON DROP CONSTRAINT PK_SOHOADON
ALTER TABLE CHITIETHOADON DROP CONSTRAINT PK_MAUXE

--3A
INSERT INTO NSX VALUES('NSX001', 'HONDA','NHAT')
INSERT INTO NSX VALUES('NSX002','YAMAHA','DUC')
INSERT INTO NSX VALUES('NSX003','SUZUKI','HAN')
INSERT INTO NSX VALUES('NSX004','DREAM','MY')
-- SELECT * FROM NSX
-- CREATE TABLE XEMAY(
--   MAXE VARCHAR(255) PRIMARY KEY,
--   TENXE NVARCHAR(255) NOT NULL,
--   MANSX VARCHAR(255),
--   SOLUONG INT CHECK (SOLUONG > 0),
--   DONGIA INT CHECK (DONGIA > 0),
--   FOREIGN KEY (MANSX) REFERENCES NSX(MANSX)
-- )


INSERT INTO XEMAY VALUES('YMH01','YAMAHA','NSX002',1000,20000000)
INSERT INTO XEMAY VALUES('HD01','HOANDA T2','NSX001',800,15000000)
INSERT INTO XEMAY VALUES('HD02','HOANDA Y7','NSX001',100,10000000)
INSERT INTO XEMAY VALUES('SZ05','SUZUKI 06','NSX003',200,23000000)
INSERT INTO XEMAY VALUES('DR001','DREAM H7','NSX004',300,33000000)
INSERT INTO XEMAY VALUES('DR002','DREAM Q2','NSX004',500,12000000)
INSERT INTO XEMAY VALUES('DR003','DREAM A6','NSX004',700,21000000)
SELECT * FROM XEMAY
-- CREATE TABLE KHACHHANG(
--   SDT VARCHAR(11),
--   HOTEN NVARCHAR(255) NOT NULL,
--   CONSTRAINT KH_SDT_PRI PRIMARY KEY(SDT),
--   DIACHI NVARCHAR(20) CHECK(DIACHI IN ('TPHCM', 'ĐONG NAI', 'LONG AN', 'TAY NINH'))
-- )


INSERT INTO KHACHHANG VALUES (0193213462,N'TRẦN VĂN A','LONG AN')
INSERT INTO KHACHHANG VALUES (0999999999,N'NGUYỄN THỊ C','TAY NINH')
INSERT INTO KHACHHANG VALUES (0233245131,N'TRẦN QUANG D','DONG NAI')
INSERT INTO KHACHHANG VALUES (0567345453,N'HUYNH VĂN G','TPHCM')
-- SELECT * FROM KHACHHANG

-- CREATE TABLE HOADON(
--   SOHOADON INT PRIMARY KEY, 
--   NGAYLAP DATE DEFAULT GETDATE(),
--   MAKHACHHANG VARCHAR(11),
--   CONSTRAINT PK_SDT FOREIGN KEY(MAKHACHHANG) REFERENCES KHACHHANG(SDT)
-- )


SET DATEFORMAT DMY
INSERT INTO HOADON VALUES('HD01','19/12/2020',0999999999,'20/10/2025')
INSERT INTO HOADON VALUES('HD02','5/7/2018',0193213462,'10/6/2010')
INSERT INTO HOADON VALUES('HD03','4/6/2003',0233245131,'10/2/2010')
INSERT INTO HOADON VALUES('HD04','3/9/2010',0567345453,'1/1/2011')
SELECT * FROM HOADON

-- CREATE TABLE CHITIETHOADON(
--   SOHOADON VARCHAR(20),
--   MAXE VARCHAR(255),
--   SOLUONGMUA INT,
--   DONGIA INT,
--   CONSTRAINT CHECK_SOLUONGMUA CHECK(SOLUONGMUA > 0),
--   CONSTRAINT CHECK_DONGIA CHECK(DONGIA > 0),
--   CONSTRAINT PRI_CHITIETHOADON PRIMARY KEY (SOHOADON, MAXE),
--   CONSTRAINT PK_SOHOADON FOREIGN KEY(SOHOADON) REFERENCES HOADON(SOHOADON),
--   CONSTRAINT PK_MAUXE FOREIGN KEY(MAXE) REFERENCES XEMAY(MAXE)
-- )


INSERT INTO CHITIETHOADON VALUES('SHD01','YMH01',2,20000000)
INSERT INTO CHITIETHOADON VALUES('SHD02','SZ05',0,23000000)
INSERT INTO CHITIETHOADON VALUES('SHD03','YAMAHA',2,20000000)
INSERT INTO CHITIETHOADON VALUES('SHD04','DR002',1,12000000)

SELECT * FROM CHITIETHOADON



--3B
UPDATE XEMAY SET SOLUONG+=10 WHERE MAXE='YMH01'
--3C
UPDATE KHACHHANG SET DIACHI='TPHCM' WHERE SDT=0193213462
--3D
UPDATE XEMAY SET DONGIA+=(
  CASE WHEN DONGIA>20000000 THEN 0 ELSE 10000000 END
) WHERE MAXE='HD01'
--3E
UPDATE CHITIETHOADON SET SOLUONGMUA+=(
  CASE WHEN SOLUONGMUA>15 THEN 0 ELSE 10 END
) WHERE SOHOADON='SHD01' AND MAXE='YMH01'
--3F
DELETE FROM KHACHHANG
WHERE SDT IN (
  SELECT MAKHACHHANG
  FROM HOADON
  WHERE YEAR(GETDATE())-YEAR(NGAYLAP)>10
)
--3G
DELETE FROM XEMAY
WHERE SOLUONG=0
--3H
DELETE FROM CHITIETHOADON
WHERE SOHOADON IN (
  SELECT SOHOADON
  FROM HOADON
  WHERE YEAR(NGAYLAP)<2010
)
--3I
DELETE FROM HOADON
WHERE YEAR(NGAYLAP)<2010


--4A
SELECT MAXE,TENXE
FROM NSX AS N,XEMAY AS X
WHERE N.MaNSX=X.MANSX AND TENNSX='YAMAHA'

--4B
SELECT SDT,HOTEN FROM KHACHHANG WHERE DIACHI='TPHCM'
--4C
SELECT SDT,HOTEN,DIACHI
FROM KHACHHANG,HOADON
WHERE MAKHACHHANG=SDT AND YEAR(NGAYLAP)=2020 AND MONTH(NGAYLAP) IN (1,2,3)
--4D
SELECT CT.MAXE,TENXE
FROM XEMAY AS X,KHACHHANG AS KH,HOADON AS HD,CHITIETHOADON AS CT
WHERE CT.SOHOADON=HD.SOHOADON 
      AND MAKHACHHANG=SDT 
      AND CT.MAXE=X.MAXE 
      AND DIACHI='LONG AN' 
      AND MONTH(NGAYLAP)=10 
      AND YEAR(NGAYLAP)=2020
--4E
SELECT SDT,HOTEN,DIACHI
FROM KHACHHANG AS K ,HOADON AS HD
WHERE MAKHACHHANG=SDT AND YEAR(NGAYLAP)!=2020
--4F
SELECT X.MAXE,X.TENXE
FROM XEMAY AS X
LEFT JOIN (
  SELECT CT.MAXE,TENXE
  FROM XEMAY AS X,HOADON AS HD,CHITIETHOADON AS CT
  WHERE X.MAXE=CT.MAXE AND CT.SOHOADON=HD.SOHOADON AND YEAR(NGAYLAP)=2020
) AS T
ON X.MAXE=T.MAXE






