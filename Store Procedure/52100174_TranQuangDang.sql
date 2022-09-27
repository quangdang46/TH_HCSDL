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
--SELECT * FROM DMMH


INSERT INTO DMKHOA VALUES('AV',N'ANH VĂN')
INSERT INTO DMKHOA VALUES('TH',N'TIN HỌC')
INSERT INTO DMKHOA VALUES('TR',N'TRIẾT')
INSERT INTO DMKHOA VALUES('VL',N'VẬT LÝ')
--SELECT * FROM DMKHOA


SET DATEFORMAT DMY

INSERT INTO DMSV VALUES('A01',N'NGUYỄN THỊ',N'HẢI',1,'23/02/1993',N'HÀ NỘI','TH',130000)
INSERT INTO DMSV VALUES('A02',N'TRẦN VĂN',N'CHÍNH',0,'24/12/1992',N'BÌNH ĐỊNH','VL',150000)
INSERT INTO DMSV VALUES('A03',N'LÊ THU BẠCH',N'YẾN',1,'21/02/1993',N'TPHCM','TH',170000)
INSERT INTO DMSV VALUES('A04',N'TRẦN ANH',N'TUẤN',0,'20/12/1994',N'HÀ NỘI','AV',80000)
INSERT INTO DMSV VALUES('B01',N'TRẦN THANH',N'MAI',1,'12/08/1993',N'HẢI PHÒNG','TR',0)
INSERT INTO DMSV VALUES('B02',N'TRẦN THỊ THU',N'THUỶ',1,'02/01/1994',N'TPHCM','AV',0)
--SELECT * FROM DMSV


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
--SELECT * FROM KETQUA




--1
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='INDANHSACH')
BEGIN
  DROP PROCEDURE INDANHSACH
END
GO
CREATE PROCEDURE INDANHSACH @MAKHOA VARCHAR(255)
AS
BEGIN
  SELECT * FROM DMSV WHERE MAKHOA=@MAKHOA
END


GO
EXEC INDANHSACH 'TH'
GO


--2

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME ='GETDIEM')
BEGIN
  DROP FUNCTION GETDIEM
END
GO


CREATE FUNCTION GETDIEM (@MASV VARCHAR(255), @MAMH VARCHAR(255), @LANTHI INT)
RETURNS FLOAT
AS
BEGIN
  DECLARE @DIEM FLOAT
  SELECT @DIEM=DIEM FROM KETQUA WHERE MASV=@MASV AND MAMH=@MAMH AND LANTHI=@LANTHI
  RETURN @DIEM
END
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME ='SOSANHSINHVIEN')
BEGIN
  DROP PROCEDURE SOSANHSINHVIEN
END
GO


CREATE PROCEDURE SOSANHSINHVIEN @MASV1 VARCHAR(255), @MASV2 VARCHAR(255),@MAMH VARCHAR(255)
AS
BEGIN
  DECLARE @DIEM1 FLOAT, @DIEM2 FLOAT
  SELECT @DIEM1=DBO.GETDIEM(@MASV1,@MAMH,1), @DIEM2=DBO.GETDIEM(@MASV2,@MAMH,1)
  IF @DIEM1>@DIEM2
    BEGIN
      PRINT 'DIEM CAO HON LA: '+@MASV1
    END
  ELSE
    BEGIN
      PRINT 'DIEM CAO HON LA: '+@MASV2
    END
END


GO
EXEC SOSANHSINHVIEN 'A01','A02','01'
GO


--3
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'KIEMTRADAU')
BEGIN
  DROP PROCEDURE KIEMTRADAU
END
GO
CREATE PROCEDURE KIEMTRADAU  @MAMH VARCHAR(255),@MASV VARCHAR(255)
AS
BEGIN
  DECLARE @DIEM FLOAT
  SELECT @DIEM=DBO.GETDIEM(@MASV,@MAMH,1)
  IF @DIEM>=5
    BEGIN
      PRINT 'DAU'
    END
  ELSE
    BEGIN
      PRINT 'ROT'
    END
END


GO
EXEC KIEMTRADAU '01','A01'
GO


--4
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'INDANHSACHSINHVIEN')
BEGIN
  DROP PROCEDURE INDANHSACHSINHVIEN
END
GO

CREATE PROCEDURE INDANHSACHSINHVIEN @MAKHOA VARCHAR(255)
AS
BEGIN
  SELECT MASV,HOSV+' '+TENSV AS HOTENSV,NGAYSINH FROM DMSV WHERE MAKHOA=@MAKHOA
END


GO
EXEC INDANHSACHSINHVIEN 'TH'
GO


--5
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'INDIEMLANTHI')
BEGIN
  DROP PROCEDURE INDIEMLANTHI
END

GO
CREATE PROCEDURE INDIEMLANTHI @MASV VARCHAR(255),@MAMH VARCHAR(255)
AS
BEGIN
  DECLARE @MAX_LANTHI INT
  SELECT @MAX_LANTHI=MAX(LANTHI)
  FROM KETQUA
  WHERE MASV=@MASV AND MAMH=@MAMH


  DECLARE @I INT
  SET @I=1

  -- Ví dụ: Lần 1 : 10
  --         Lần 2: 8


  WHILE @I<=@MAX_LANTHI
    BEGIN
      PRINT 'LAN '+CONVERT(VARCHAR(255),@I)+': '+CONVERT(VARCHAR(255),DBO.GETDIEM(@MASV,@MAMH,@I))
      SET @I+=1
    END
  
END


GO
EXEC INDIEMLANTHI 'A01','01'
GO
--6

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'INDANHSACHDAU')
BEGIN
  DROP PROCEDURE INDANHSACHDAU
END
GO

CREATE PROCEDURE INDANHSACHDAU @MAMH VARCHAR(255)
AS
BEGIN
  SELECT HOSV+' '+TENSV AS HOTENSV
  FROM DMSV
  WHERE MASV IN (
    SELECT MASV
    FROM KETQUA 
    WHERE MAMH=@MAMH AND DIEM>=5 AND LANTHI=1
  )
END

--show result
GO
EXEC dbo.INDANHSACHDAU '01'
GO