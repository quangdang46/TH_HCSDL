
USE MASTER

GO
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME = 'QLQUAYHANG')
  BEGIN
    DROP DATABASE QLQUAYHANG
  END
GO


CREATE DATABASE QLQUAYHANG
GO
USE QLQUAYHANG
GO
----------------------------------------------------------------
/*
KHUVUC
LOAIQUAYHANG
THUYSAN
NONGSAN
QUAYHANG
NHANVIEN
LAMVIEC
HOPDONGTHUE
NGUOITHUE
NGUOITHAN

*/
------------------------------------------------------------
--FUNCTION INSERT KHUVUC
------------------------------------------------------------

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_KHUVUC')
  BEGIN
    DROP FUNCTION ADD_KHUVUC
  END
GO
CREATE FUNCTION ADD_KHUVUC(@TENKHUVUC NVARCHAR(50),@TIENTHUE INT)
RETURNS INT
AS
  BEGIN
    DECLARE @ID_KHUVUC VARCHAR(10)
    DECLARE @SQL NVARCHAR(1000)
    SET @ID_KHUVUC = 'KV' + RIGHT('000' + CAST((SELECT COUNT(*) FROM KHUVUC) + 1 AS VARCHAR(3)), 3)
    SET @SQL = 'INSERT INTO KHUVUC VALUES(' + '''' + @ID_KHUVUC + '''' + ',' + '''' + @TENKHUVUC + '''' + ',' + CONVERT(VARCHAR(10),@TIENTHUE) + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END

------------------------------------------------------------
--FUNCTION INSERT LOAIQUAYHANG
------------------------------------------------------------

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_LOAIQUAYHANG')
  BEGIN
    DROP FUNCTION ADD_LOAIQUAYHANG
  END
GO
CREATE FUNCTION ADD_LOAIQUAYHANG(@GIATHUE INT,@TENQUAYHANG NVARCHAR(10),@DIENTICH INT)
RETURNS INT
AS
  BEGIN
    DECLARE @ID_LOAIQUAYHANG VARCHAR(10)
    DECLARE @SQL NVARCHAR(1000)
    SET @ID_LOAIQUAYHANG = 'LQ' + RIGHT('000' + CAST((SELECT COUNT(*) FROM LOAIQUAYHANG) + 1 AS VARCHAR(3)), 3)
    SET @SQL = 'INSERT INTO LOAIQUAYHANG VALUES(' + '''' + @ID_LOAIQUAYHANG + '''' + ',' + CONVERT(VARCHAR(10),@GIATHUE) + ',' + '''' + @TENQUAYHANG + '''' + ',' + CONVERT(VARCHAR(10),@DIENTICH) + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO


------------------------------------------------------------
--FUNCTION INSERT CHITIETQUAYHANG
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_CHITIETQUAYHANG')
  BEGIN
    DROP FUNCTION ADD_CHITIETQUAYHANG
  END
GO
CREATE FUNCTION ADD_CHITIETQUAYHANG(@MALOAIQUAY VARCHAR(10),@LOAIQUAY VARCHAR(10),@TENBANG VARCHAR(10))
RETURNS INT
AS
  BEGIN
    DECLARE @SQL NVARCHAR(1000)
    SET @SQL = 'INSERT INTO '+@TENBANG+' VALUES(' + '''' + @MALOAIQUAY + '''' + ',' + '''' + @LOAIQUAY + '''' + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO

------------------------------------------------------------
--FUNCTION INSERT QUAYHANG
------------------------------------------------------------


IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_QUAYHANG')
  BEGIN
    DROP FUNCTION ADD_QUAYHANG
  END
GO

CREATE FUNCTION ADD_QUAYHANG(@MANHANVIEN NVARCHAR(50),@MALOAIQUAY VARCHAR(10),@MAKHUVUC VARCHAR(10))
RETURNS INT
AS
  BEGIN
    DECLARE @ID_QUAYHANG VARCHAR(10)
    DECLARE @SQL NVARCHAR(1000)
    SET @ID_QUAYHANG = 'QH' + RIGHT('000' + CAST((SELECT COUNT(*) FROM QUAYHANG) + 1 AS VARCHAR(3)), 3)
    SET @SQL = 'INSERT INTO QUAYHANG VALUES(' + '''' + @ID_QUAYHANG + '''' + ',' + '''' + @MANHANVIEN + '''' + ',' + '''' + @MALOAIQUAY + '''' + ',' + '''' + @MAKHUVUC + '''' + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO

------------------------------------------------------------
--FUNCTION INSERT NHANVIEN
------------------------------------------------------------


IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_NHANVIEN')
  BEGIN
    DROP FUNCTION ADD_NHANVIEN
  END
GO
CREATE FUNCTION ADD_NHANVIEN(@HOTEN VARCHAR(50),@CHUCVU NVARCHAR(50),@LUONG INT)
RETURNS INT
AS
  BEGIN
    DECLARE @ID_NHANVIEN VARCHAR(10)
    DECLARE @SQL NVARCHAR(1000)
    SET @ID_NHANVIEN = 'NV' + RIGHT('000' + CAST((SELECT COUNT(*) FROM NHANVIEN) + 1 AS VARCHAR(3)), 3)
    SET @SQL = 'INSERT INTO NHANVIEN VALUES(' + '''' + @ID_NHANVIEN + '''' + ',' + '''' + @HOTEN + '''' + ',' + '''' + @CHUCVU + '''' + ',' + CONVERT(VARCHAR(10),@LUONG) + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO

------------------------------------------------------------
--FUNCTION INSERT LAMVIEC
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_LAMVIEC')
  BEGIN
    DROP FUNCTION ADD_LAMVIEC
  END

GO
CREATE FUNCTION ADD_LAMVIEC(@MAQUAYHANG VARCHAR(10),@MANHANVIEN VARCHAR(10))
RETURNS INT
AS
  BEGIN
    DECLARE @SQL NVARCHAR(1000)
    SET @SQL = 'INSERT INTO LAMVIEC VALUES(' + '''' + @MAQUAYHANG + '''' + ',' + '''' + @MANHANVIEN + '''' + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO

------------------------------------------------------------
--FUNCTION INSERT NGUOITHUE
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_NGUOITHUE')
  BEGIN
    DROP FUNCTION ADD_NGUOITHUE
  END
GO
CREATE FUNCTION ADD_NGUOITHUE(@HOTEN VARCHAR(50),@CMND VARCHAR(50),@DIENTHOAI NVARCHAR(50))
RETURNS INT
AS
  BEGIN
    DECLARE @ID_NGUOITHUE VARCHAR(10)
    DECLARE @SQL NVARCHAR(1000)
    SET @ID_NGUOITHUE = 'NT' + RIGHT('000' + CAST((SELECT COUNT(*) FROM NGUOITHUE) + 1 AS VARCHAR(3)), 3)
    SET @SQL = 'INSERT INTO NGUOITHUE VALUES(' + '''' + @ID_NGUOITHUE + '''' + ',' + '''' + @HOTEN + '''' + ',' + '''' + @CMND + '''' + ',' + '''' + @DIENTHOAI + '''' + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO

------------------------------------------------------------
--FUNCTION INSERT HOPDONGTHUE
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_HOPDONGTHUE')
  BEGIN
    DROP FUNCTION ADD_HOPDONGTHUE
  END
GO
CREATE FUNCTION ADD_HOPDONGTHUE(@NGAYBATDAU VARCHAR(10),@MANGUOITHUE VARCHAR(10),@MAQUAYHANG VARCHAR(10),@GIATRIHOPDONG INT)
RETURNS INT
AS
  BEGIN
    DECLARE @ID_HOPDONGTHUE VARCHAR(10)
    DECLARE @SQL NVARCHAR(1000)
    SET @ID_HOPDONGTHUE = 'HD' + RIGHT('000' + CAST((SELECT COUNT(*) FROM HOPDONGTHUE) + 1 AS VARCHAR(3)), 3)
    SET @SQL = 'INSERT INTO HOPDONGTHUE VALUES(' + '''' + @ID_HOPDONGTHUE + '''' + ',' + '''' + @NGAYBATDAU + '''' + ',' + '''' + @MANGUOITHUE + '''' + ',' + '''' + @MAQUAYHANG + '''' + ',' + CONVERT(VARCHAR(10),@GIATRIHOPDONG) + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END
GO

------------------------------------------------------------
--FUNCTION INSERT NGUOITHAN
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'ADD_NGUOITHAN')
  BEGIN
    DROP FUNCTION ADD_NGUOITHAN
  END
GO
CREATE FUNCTION ADD_NGUOITHAN(@MANGUOITHUE VARCHAR(50),@HOTEN VARCHAR(50),@CMND VARCHAR(50))
RETURNS INT
AS
  BEGIN
    DECLARE @SQL NVARCHAR(1000)
    SET @SQL = 'INSERT INTO NGUOITHAN VALUES(' + '''' + @MANGUOITHUE + '''' + ',' + '''' + @HOTEN + '''' + ',' + '''' + @CMND + '''' + ')'
    EXECUTE sp_executesql @SQL
    RETURN 1
  END

-----------------------------------------
--TABLE KHUVUC
-----------------------------------------

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'KHUVUC')
  BEGIN
    DROP TABLE KHUVUC
  END
GO
CREATE TABLE KHUVUC
(
  MAKHUVUC VARCHAR(10) PRIMARY KEY,
  TENKHUVUC VARCHAR(10) NOT NULL,
  TIENTHUE INT NOT NULL,
)
------------------------------------------------------------
--TABLE LOAIQUAYHANG
------------------------------------------------------------

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'LOAIQUAYHANG')
  BEGIN
    DROP TABLE LOAIQUAYHANG
  END
GO
CREATE TABLE LOAIQUAYHANG
(
  MALOAIQUAY VARCHAR(10) PRIMARY KEY,
  GIATHUE INT NOT NULL,
  TENQUAY VARCHAR(10) NOT NULL,
  DIENTICH INT NOT NULL,
)
GO

------------------------------------------------------------
--TABLE THUYSAN
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'THUYSAN')
  BEGIN
    DROP TABLE THUYSAN
  END
GO
CREATE TABLE THUYSAN
(
  MALOAIQUAY VARCHAR(10) NOT NULL,
  LOAIQUAY VARCHAR(10) NOT NULL CHECK(LOAIQUAY IN ('NGOAIBIEN','NUOI')),
  FOREIGN KEY (MALOAIQUAY) REFERENCES LOAIQUAYHANG(MALOAIQUAY)
)
GO

------------------------------------------------------------
--TABLE NONGSAN
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'NONGSAN')
  BEGIN
    DROP TABLE NONGSAN
  END
GO
CREATE TABLE NONGSAN
(
  MALOAIQUAY VARCHAR(10) NOT NULL,
  LOAIQUAY VARCHAR(10) NOT NULL CHECK(LOAIQUAY IN ('RAU','CUQUA')),
  FOREIGN KEY (MALOAIQUAY) REFERENCES LOAIQUAYHANG(MALOAIQUAY)
)

------------------------------------------------------------
--TABLE QUAYHANG
------------------------------------------------------------

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'QUAYHANG')
  BEGIN
    DROP TABLE QUAYHANG
  END
GO
CREATE TABLE QUAYHANG
(
  MAQUAYHANG VARCHAR(10) PRIMARY KEY,
  MANHANVIEN VARCHAR(10) NOT NULL,
  MALOAIQUAY VARCHAR(10) NOT NULL,
  MAKHUVUC VARCHAR(10) NOT NULL,
  FOREIGN KEY (MAKHUVUC) REFERENCES KHUVUC(MAKHUVUC),
  FOREIGN KEY (MALOAIQUAY) REFERENCES LOAIQUAYHANG(MALOAIQUAY),

)
GO

------------------------------------------------------------
--TABLE NHANVIEN
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'NHANVIEN')
  BEGIN
    DROP TABLE NHANVIEN
  END
GO	
CREATE TABLE NHANVIEN
(
  MANHANVIEN VARCHAR(10) PRIMARY KEY,
  HOTEN VARCHAR(50) NOT NULL,
  CHUCVU VARCHAR(10) NOT NULL,
  LUONG INT NOT NULL,
)

------------------------------------------------------------
--TABLE LAMVIEC
------------------------------------------------------------

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'LAMVIEC')
  BEGIN
    DROP TABLE LAMVIEC
  END
GO
CREATE TABLE LAMVIEC (
  MAQUAYHANG VARCHAR(10) NOT NULL,
  MANHANVIEN VARCHAR(10) NOT NULL,
  FOREIGN KEY (MAQUAYHANG) REFERENCES QUAYHANG(MAQUAYHANG),
  FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN),
)
GO



------------------------------------------------------------
--TABLE NGUOITHUE
------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'NGUOITHUE')
  BEGIN
    DROP TABLE NGUOITHUE
  END
GO
CREATE TABLE NGUOITHUE
(
  MANGUOITHUE VARCHAR(10) PRIMARY KEY,
  HOTEN VARCHAR(50) NOT NULL,
  CMND VARCHAR(11) NOT NULL,
  DIENTHOAI VARCHAR(10) NOT NULL,
)
GO

------------------------------------------------------------
--TABLE HOPDONGTHUE
------------------------------------------------------------


IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'HOPDONGTHUE')
  BEGIN
    DROP TABLE HOPDONGTHUE
  END

GO
CREATE TABLE HOPDONGTHUE
(
  MAHOPDONG VARCHAR(10) PRIMARY KEY,
  NGAYLAP DATE NOT NULL,
  MANGUOITHUE VARCHAR(10) NOT NULL,
  MAQUAYHANG VARCHAR(10) NOT NULL,
  GIATRIHOPDONG INT NOT NULL,
  FOREIGN KEY (MANGUOITHUE) REFERENCES NGUOITHUE(MANGUOITHUE),
  FOREIGN KEY (MAQUAYHANG) REFERENCES QUAYHANG(MAQUAYHANG),
)
GO

------------------------------------------------------------
--TABLE NGUOITHAN
------------------------------------------------------------


IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'NGUOITHAN')
  BEGIN
    DROP TABLE NGUOITHAN
  END
GO

CREATE TABLE NGUOITHAN
(
  MANGUOITHUE VARCHAR(10) NOT NULL,
  HOTEN VARCHAR(50) NOT NULL,
  CMND VARCHAR(10) NOT NULL,
  FOREIGN KEY (MANGUOITHUE) REFERENCES NGUOITHUE(MANGUOITHUE)
)
GO


-------------------------------------------------------------------------------
-- trigger để kiểm tra ràng buộc khoá ngoại, ràng buộc miền giá trị. 
-------------------------------------------------------------------------------
-- TRIGGER THUYSAN
-------------------------------------------------------------------------------
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_THUYSAN')
  BEGIN
    DROP TRIGGER TRIGGER_THUYSAN
  END
GO

CREATE TRIGGER TRIGGER_THUYSAN ON THUYSAN
FOR INSERT, UPDATE, DELETE
AS
  DECLARE @LOAIQUAY VARCHAR(10)
  DECLARE @MALOAIQUAY VARCHAR(10)

  SELECT @LOAIQUAY = LOAIQUAY FROM INSERTED
  SELECT MALOAIQUAY = MALOAIQUAY FROM INSERTED

  IF @LOAIQUAY NOT IN ('NGOAIBIEN','NUOI')
    BEGIN
      RAISERROR('LOAIQUAY phai la NGOAIBIEN hoac NUOI',16,1)
      ROLLBACK
    END
  IF @MALOAIQUAY NOT IN (SELECT MALOAIQUAY FROM LOAIQUAYHANG)
    BEGIN
      RAISERROR('MALOAIQUAY khong ton tai',16,1)
      ROLLBACK
    END
GO

-------------------------------------------------------------------------------
-- TRIGGER NONGSAN
-------------------------------------------------------------------------------
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_NONGSAN')
  BEGIN
    DROP TRIGGER TRIGGER_NONGSAN
  END
GO

CREATE TRIGGER TRIGGER_NONGSAN ON NONGSAN
FOR INSERT, UPDATE, DELETE
AS
  DECLARE @LOAIQUAY VARCHAR(10)
  DECLARE @MALOAIQUAY VARCHAR(10)

  SELECT @LOAIQUAY = LOAIQUAY FROM INSERTED
  SELECT MALOAIQUAY = MALOAIQUAY FROM INSERTED

  IF @LOAIQUAY NOT IN ('RAU','CUQUA')
    BEGIN
      RAISERROR('LOAIQUAY phai la RAU hoac CUQUA',16,1)
      ROLLBACK
    END
  IF @MALOAIQUAY NOT IN (SELECT MALOAIQUAY FROM LOAIQUAYHANG)
    BEGIN
      RAISERROR('MALOAIQUAY khong ton tai',16,1)
      ROLLBACK
    END
GO

-------------------------------------------------------------------------------
-- TRIGGER QUAYHANG
-------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_QUAYHANG')
  BEGIN
    DROP TRIGGER TRIGGER_QUAYHANG
  END
GO
CREATE TRIGGER TRIGGER_QUAYHANG ON QUAYHANG
FOR INSERT, UPDATE
AS
  DECLARE @MAKHUVUC VARCHAR(10)
  DECLARE @MALOAIQUAY VARCHAR(10)

  SELECT @MAKHUVUC = MAKHUVUC FROM INSERTED
  SELECT @MALOAIQUAY = MALOAIQUAY FROM INSERTED

  IF NOT EXISTS (SELECT * FROM KHUVUC WHERE MAKHUVUC = @MAKHUVUC)
    BEGIN
      RAISERROR('Khong ton tai ma khuvuc', 16, 1)
      ROLLBACK
    END
  IF NOT EXISTS (SELECT * FROM LOAIQUAYHANG WHERE MALOAIQUAY = @MALOAIQUAY)
    BEGIN
      RAISERROR('Khong ton tai ma loai quay', 16, 1)
      ROLLBACK
    END
GO

-------------------------------------------------------------------------------
-- TRIGGER NHANVIEN
-------------------------------------------------------------------------------
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_NHANVIEN')
  BEGIN
    DROP TRIGGER TRIGGER_NHANVIEN
  END
GO

CREATE TRIGGER TRIGGER_NHANVIEN ON NHANVIEN
FOR INSERT, UPDATE
AS
  DECLARE @LUONG INT
  DECLARE @CHUCVU VARCHAR(10)

  SELECT @LUONG = LUONG FROM INSERTED
  SELECT @CHUCVU = CHUCVU FROM INSERTED

  IF @LUONG < 0
    BEGIN
      RAISERROR('LUONG phai lon hon 0',16,1)
      ROLLBACK
    END

  IF @CHUCVU NOT IN ('QUAN LY','NHAN VIEN')
    BEGIN
      RAISERROR('CHUCVU phai la QUANLY hoac NHANVIEN',16,1)
      ROLLBACK
    END
GO

-------------------------------------------------------------------------------
-- TRIGGER NGUOITHUE
-------------------------------------------------------------------------------
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_NGUOITHUE')
  BEGIN
    DROP TRIGGER TRIGGER_NGUOITHUE
  END
GO

CREATE TRIGGER TRIGGER_NGUOITHUE ON NGUOITHUE
FOR INSERT, UPDATE
AS
  DECLARE @CMND VARCHAR(10)

  SELECT @CMND = CMND FROM INSERTED

  IF LEN(@CMND) <> 9
    BEGIN
      RAISERROR('CMND phai co 9 chu so',16,1)
      ROLLBACK
    END
GO

-------------------------------------------------------------------------------
-- TRIGGER LAMVIEC
-------------------------------------------------------------------------------
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_LAMVIEC')
  BEGIN
    DROP TRIGGER TRIGGER_LAMVIEC
  END
GO

CREATE TRIGGER TRIGGER_LAMVIEC ON LAMVIEC
FOR INSERT, UPDATE
AS
  DECLARE @MAQUAYHANG VARCHAR(10)
  DECLARE @MANHANVIEN VARCHAR(10)

  SELECT @MAQUAYHANG = MAQUAYHANG FROM INSERTED
  SELECT @MANHANVIEN = MANHANVIEN FROM INSERTED

  IF NOT EXISTS (SELECT * FROM QUAYHANG WHERE MAQUAYHANG = @MAQUAYHANG)
    BEGIN
      RAISERROR('Khong ton tai ma quay hang', 16, 1)
      ROLLBACK
    END
  IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MANHANVIEN = @MANHANVIEN)
    BEGIN
      RAISERROR('Khong ton tai ma nhan vien', 16, 1)
      ROLLBACK
    END

GO

-------------------------------------------------------------------------------
-- TRIGGER HOPDONGTHUE
-------------------------------------------------------------------------------
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_HOPDONGTHUE')
  BEGIN
    DROP TRIGGER TRIGGER_HOPDONGTHUE
  END
GO

CREATE TRIGGER TRIGGER_HOPDONGTHUE ON HOPDONGTHUE
FOR INSERT, UPDATE
AS
  DECLARE @GIATRIHOPDONG INT
  DECLARE @MANGUOITHUE VARCHAR(10)
  DECLARE @MAQUAYHANG VARCHAR(10)
  DECLARE @NGAYLAP DATE

  SELECT @GIATRIHOPDONG = GIATRIHOPDONG FROM INSERTED
  SELECT @MANGUOITHUE = MANGUOITHUE FROM INSERTED
  SELECT @MAQUAYHANG = MAQUAYHANG FROM INSERTED
  SELECT @NGAYLAP = NGAYLAP FROM INSERTED

  IF @GIATRIHOPDONG < 0
    BEGIN
      RAISERROR('GIATRIHOPDONG phai lon hon 0',16,1)
      ROLLBACK
    END

  IF NOT EXISTS (SELECT * FROM NGUOITHUE WHERE MANGUOITHUE = @MANGUOITHUE)
    BEGIN
      RAISERROR('Khong ton tai ma nguoi thue', 16, 1)
      ROLLBACK
    END
  IF NOT EXISTS (SELECT * FROM QUAYHANG WHERE MAQUAYHANG = @MAQUAYHANG)
    BEGIN
      RAISERROR('Khong ton tai ma quay hang', 16, 1)
      ROLLBACK
    END
  IF @NGAYLAP > GETDATE()
    BEGIN
      RAISERROR('Ngay lap phai nho hon ngay hien tai',16,1)
      ROLLBACK
    END
GO

-------------------------------------------------------------------------------
-- TRIGGER NGUOITHAN
-------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'TRIGGER_NGUOITHAN')
  BEGIN
    DROP TRIGGER TRIGGER_NGUOITHAN
  END
GO

CREATE TRIGGER TRIGGER_NGUOITHAN ON NGUOITHAN
FOR INSERT, UPDATE
AS
  DECLARE @MANGUOITHUE VARCHAR(10)
  DECLARE @CMND VARCHAR(10)

  SELECT @MANGUOITHUE = MANGUOITHUE FROM INSERTED
  SELECT @CMND = CMND FROM INSERTED

  IF NOT EXISTS (SELECT * FROM NGUOITHUE WHERE MANGUOITHUE = @MANGUOITHUE)
    BEGIN
      RAISERROR('Khong ton tai ma nguoi thue', 16, 1)
      ROLLBACK
    END
  IF LEN(@CMND) <> 9
    BEGIN
      RAISERROR('CMND phai co 9 chu so',16,1)
      ROLLBACK
    END
GO


/*
KHUVUC
LOAIQUAYHANG
THUYSAN
NONGSAN
QUAYHANG
NHANVIEN
LAMVIEC
HOPDONGTHUE
NGUOITHUE
NGUOITHAN
*/
-- KHUVUC
EXECUTE DBO.ADD_KHUVUC 'KHU VUC 1',100000
EXECUTE DBO.ADD_KHUVUC 'KHU VUC 2',200000
EXECUTE DBO.ADD_KHUVUC 'KHU VUC 3',300000
EXECUTE DBO.ADD_KHUVUC 'KHU VUC 4',400000
EXECUTE DBO.ADD_KHUVUC 'KHU VUC 5',500000


-- LOAIQUAYHANG
EXECUTE DBO.ADD_LOAIQUAYHANG 100000,'QUAY 1',100
EXECUTE DBO.ADD_LOAIQUAYHANG 200000,'QUAY 2',200
EXECUTE DBO.ADD_LOAIQUAYHANG 300000,'QUAY 3',300
EXECUTE DBO.ADD_LOAIQUAYHANG 400000,'QUAY 4',400
EXECUTE DBO.ADD_LOAIQUAYHANG 500000,'QUAY 5',500

-- THUYSAN
EXECUTE DBO.ADD_CHITIETQUAYHANG 'LQ001','NGOAIBIEN','THUYSAN'
EXECUTE DBO.ADD_CHITIETQUAYHANG 'LQ002','NUOI','THUYSAN'
EXECUTE DBO.ADD_CHITIETQUAYHANG 'LQ003','NGOAIBIEN','THUYSAN'
-- NONGSAN
EXECUTE DBO.ADD_CHITIETQUAYHANG 'LQ004','RAU','NONGSAN'
EXECUTE DBO.ADD_CHITIETQUAYHANG 'LQ005','CUQUA','NONGSAN'

-- QUAYHANG
-- INSERT INTO QUAYHANG VALUES('QH1','NV1','LQ1','KV1')
-- INSERT INTO QUAYHANG VALUES('QH2','NV2','LQ2','KV2')
-- INSERT INTO QUAYHANG VALUES('QH3','NV3','LQ3','KV3')
-- INSERT INTO QUAYHANG VALUES('QH4','NV4','LQ4','KV4')
-- INSERT INTO QUAYHANG VALUES('QH5','NV5','LQ5','KV5')

EXECUTE DBO.ADD_QUAYHANG 'NV001','LQ001','KV001'
EXECUTE DBO.ADD_QUAYHANG 'NV002','LQ002','KV002'
EXECUTE DBO.ADD_QUAYHANG 'NV003','LQ003','KV003'
EXECUTE DBO.ADD_QUAYHANG 'NV004','LQ004','KV004'
EXECUTE DBO.ADD_QUAYHANG 'NV005','LQ005','KV005'

-- NHANVIEN
EXECUTE DBO.ADD_NHANVIEN 'NGUYEN VAN A','NHAN VIEN',1000000
EXECUTE DBO.ADD_NHANVIEN 'HUYNH MINH B','QUAN LY',2000000
EXECUTE DBO.ADD_NHANVIEN 'TRAN NGOC C','NHAN VIEN',3000000
EXECUTE DBO.ADD_NHANVIEN 'LAM TRUONG D','NHAN VIEN',4000000
EXECUTE DBO.ADD_NHANVIEN 'NGUYEN HOANG E','QUAN LY',5000000


-- LAMVIEC

EXECUTE DBO.ADD_LAMVIEC 'QH001','NV001'
EXECUTE DBO.ADD_LAMVIEC 'QH002','NV002'
EXECUTE DBO.ADD_LAMVIEC 'QH003','NV003'
EXECUTE DBO.ADD_LAMVIEC 'QH004','NV004'
EXECUTE DBO.ADD_LAMVIEC 'QH005','NV005'

-- NGUOITHUE
EXECUTE DBO.ADD_NGUOITHUE 'TRAN TRONG CHUNG','342124512','0123456789'
EXECUTE DBO.ADD_NGUOITHUE 'NGUYEN QUANG KHOI','521363214','0213652147'
EXECUTE DBO.ADD_NGUOITHUE 'NGUYEN VAN ANH','923413521','0321652147'
EXECUTE DBO.ADD_NGUOITHUE 'HUYNH MINH DUNG','728271932','0987654321'
EXECUTE DBO.ADD_NGUOITHUE 'NGUYEN VAN HUNG','241231451','0432154123'

-- HOPDONGTHUE
EXECUTE DBO.ADD_HOPDONGTHUE '2018-01-01','NT001','QH001',1000000
EXECUTE DBO.ADD_HOPDONGTHUE '2018-01-02','NT002','QH002',2000000
EXECUTE DBO.ADD_HOPDONGTHUE '2018-01-03','NT003','QH003',3000000
EXECUTE DBO.ADD_HOPDONGTHUE '2018-01-04','NT004','QH004',4000000
EXECUTE DBO.ADD_HOPDONGTHUE '2018-01-05','NT005','QH005',5000000


-- NGUOITHAN
EXECUTE DBO.ADD_NGUOITHAN 'NT001','HUYNH MINH PHUOC','512365214'
EXECUTE DBO.ADD_NGUOITHAN 'NT002','PHAM VAN MAN','213456789'
EXECUTE DBO.ADD_NGUOITHAN 'NT003','VO MINH TAM','992345678'
EXECUTE DBO.ADD_NGUOITHAN 'NT004','LE HUYNH TU','124156789'
EXECUTE DBO.ADD_NGUOITHAN 'NT005','LE ANH TUAN','435678912'


SELECT * FROM KHUVUC
SELECT * FROM LOAIQUAYHANG
SELECT * FROM THUYSAN
SELECT * FROM NONGSAN
SELECT * FROM QUAYHANG
SELECT * FROM NHANVIEN
SELECT * FROM LAMVIEC
SELECT * FROM HOPDONGTHUE
SELECT * FROM NGUOITHUE
SELECT * FROM NGUOITHAN


