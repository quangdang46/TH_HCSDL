﻿
----------------------------------------------------------------
--TRẦN QUANG ĐÃNG 52100174
----------------------------------------------------------------

USE MASTER
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME='TRANQUANGDANG_52100174')
DROP DATABASE TRANQUANGDANG_52100174
GO
CREATE DATABASE TRANQUANGDANG_52100174
GO
USE TRANQUANGDANG_52100174
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
  PRIMARY KEY (MASV,MAMH,LANTHI)
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


---A QUERY
-- 1. Danh sách các sinh viên khoa “Tin học”
SELECT MASV,HOSV+' '+TENSV AS TENSV,PHAI,NGAYSINH
FROM DMSV AS SV,DMKHOA AS K
WHERE SV.MAKHOA=K.MAKHOA AND TENKHOA LIKE N'TIN HỌC'

--2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên, Phái, Ngày sinh.
-- Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
SELECT * FROM DMSV
ORDER BY PHAI
--​ 3. &quot;Cho biết các thông tin (MSSV, họ tên ,năm sinh) của các sinh viên học sớm hơn tuổi qui định
-- (theo tuổi qui định thi sinh viên đủ 18 tuổi khi bắt đầu khóa học)&quot;
-- Day(GETDATE()) -&gt; lấy ngày trong tháng
-- Month(GETDATE()) -&gt; lấy Tháng trong Năm
-- Year(GETDATE()) -&gt; lấy năm
SELECT MASV,HOSV+' '+TENSV AS HOTEN,DATEDIFF(YEAR,NGAYSINH,GETDATE()) AS NAMSINH
FROM DMSV
WHERE DATEDIFF(YEAR,NGAYSINH,GETDATE())>=18
--4. Cho biết sinh viên khoa CNTT, chưa học môn cấu trúc dữ liệu 1
SELECT MASV,HOSV+' '+TENSV AS HOTEN
FROM DMSV
WHERE MASV NOT IN (
	SELECT K.MASV
	FROM KETQUA AS K,DMMH AS H
	WHERE K.MAMH=H.MAMH AND TENMH LIKE N'CAU TRUC DU LIEU'
)

-- 5. Cho biết sinh viên thi không đậu (Diem &lt;5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại.
SELECT MASV,HOSV+' '+TENSV AS HOTEN
FROM DMSV
WHERE MASV IN (
	SELECT K.MASV
	FROM KETQUA AS K,DMMH AS H
	WHERE K.MAMH=H.MAMH AND TENMH LIKE N'CAU TRUC DU LIEU'
	GROUP BY K.MASV,K.MASV,DIEM
	HAVING COUNT(LANTHI)=1 AND DIEM<5
)

--6. Cho biết kết quả điểm thi của các sinh viên, gồm các thông tin: Họ tên sinh viên, Mã môn học,
-- lần thi, điểm, kết quả (nếu điểm nhỏ hơn 5 thì rớt ngược lại đậu).

SELECT HOSV+' '+TENSV AS HOTEN,KQ.MAMH,LANTHI,
		RESULT=(
			CASE WHEN DIEM>5 THEN 'DAU' ELSE 'ROT' END
		)
FROM DMSV AS SV,KETQUA AS KQ
WHERE SV.MASV=KQ.MASV


-- 7. Cho biết những nơi nào có hơn 2 sinh viên đang theo học tại trường.
SELECT NOISINH
FROM DMSV
GROUP BY NOISINH
HAVING COUNT(NOISINH)=2
--8. Cho biết danh sách các sinh viên rớt trên 2 môn ở lần thi 1.
SELECT MASV,HOSV+' '+TENSV AS HOTEN
FROM DMSV
WHERE MASV IN (
	SELECT MASV
	FROM KETQUA
	WHERE DIEM<5 AND LANTHI=1
	GROUP BY MASV,LANTHI
	HAVING COUNT(DIEM)=2
)
--9.Cho biết sinh viên khoa anh văn học môn văn phạm có điểm thi lần 1 thấp nhất.
SELECT MASV,HOSV+' '+TENSV AS HOTEN
FROM DMSV AS SV,DMKHOA AS K
WHERE SV.MAKHOA=K.MAKHOA AND TENKHOA LIKE N'ANH VĂN'
AND MASV IN (
	SELECT MASV
	FROM KETQUA
	WHERE LANTHI=1 AND MAMH IN (
		SELECT MAMH
		FROM DMMH
		WHERE TENMH LIKE N'VĂN PHẠM'
	)
	GROUP BY MASV,LANTHI
	HAVING MIN(DIEM)=(
		SELECT MIN(DIEM)
		FROM KETQUA
		WHERE LANTHI=1 AND MAMH IN (
			SELECT MAMH
			FROM DMMH
			WHERE TENMH LIKE N'VĂN PHẠM'
		)
	)

)


--10. Cho biết những sinh viên có học bổng lớn hơn tất cả học bổng của sinh viên thuộc khoa anh văn

SELECT MASV,HOSV+' '+TENSV AS HOTEN
FROM DMSV
WHERE HOCBONG>(
	SELECT SUM(HOCBONG)
	FROM DMSV AS SV,DMKHOA AS K
	WHERE SV.MAKHOA=K.MAKHOA AND TENKHOA LIKE N'ANH VĂN'
)

--11. Cho biết những sinh viên khoa anh văn chưa học môn văn phạm.
SELECT MASV,HOSV+' '+TENSV AS HOTEN
FROM DMSV AS SV,DMKHOA AS K
WHERE MASV NOT IN(
	SELECT KQ.MASV
	FROM DMMH AS MH,KETQUA AS KQ
	WHERE KQ.MAMH=MH.MAMH AND TENMH LIKE N'VĂN PHẠM'

)
AND SV.MAKHOA = K.MAKHOA AND TENKHOA LIKE N'ANH VĂN'

---B FUNCTION

-- 1. Với 1 mã sinh viên và 1 mã khoa, kiểm tra xem sinh viên có thuộc khoa này không (trả về đúng
-- hoặc sai)
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='KTSINHVIEN')
BEGIN
	DROP FUNCTION KTSINHVIEN
END
GO
CREATE FUNCTION KTSINHVIEN(@MASV VARCHAR(255),@MAKHOA VARCHAR(255))
RETURNS BIT
AS
BEGIN
	IF EXISTS(SELECT * FROM DMSV WHERE @MASV=MASV AND @MAKHOA=@MAKHOA)
	BEGIN
		RETURN 1
	END
	RETURN 0
END
GO

PRINT DBO.KTSINHVIEN('A01','TH')

-- 2.Tính điểm thi sau cùng của một sinh viên trong một môn học cụ thể
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='GETDIEM')
BEGIN
	DROP FUNCTION GETDIEM
END
GO
CREATE FUNCTION GETDIEM(@MASV VARCHAR(255),@MAMH VARCHAR(255))
RETURNS FLOAT
AS
BEGIN
	DECLARE @MAXLANTHI INT
	SELECT @MAXLANTHI=MAX(LANTHI)
	FROM KETQUA
	WHERE @MASV=MASV AND @MAMH=MAMH

	DECLARE @ENDDIEM FLOAT
	SELECT @ENDDIEM=DIEM
	FROM KETQUA
	WHERE @MASV=MASV AND @MAMH=MAMH AND LANTHI=@MAXLANTHI

	RETURN @ENDDIEM

END
GO
SELECT DBO.GETDIEM('A01','01') AS DIEM

-- 3. Tính điểm trung bình của một sinh viên (chú ý : điểm trung bình được tính dựa trên lần thi sau
-- cùng), sử dụng function 2 đã viết
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='GETDIEMTB')
BEGIN
	DROP FUNCTION GETDIEMTB
END
GO
CREATE FUNCTION GETDIEMTB(@MASV VARCHAR(255))
RETURNS FLOAT
AS
BEGIN
	DECLARE @DIEMTONG FLOAT
	SET @DIEMTONG=0
	DECLARE @TONGSOMON INT

	SELECT @TONGSOMON=COUNT(DISTINCT LANTHI)
	FROM KETQUA
	WHERE @MASV=MASV
	GROUP BY MASV


	SELECT @DIEMTONG+=DBO.GETDIEM(@MASV,MAMH)
	FROM KETQUA
	WHERE @MASV=MASV
	GROUP BY MASV,MAMH

	RETURN @DIEMTONG/@TONGSOMON



END

GO
SELECT DBO.GETDIEMTB('A01') AS DIEMTB


-- 4. Nhập vào 1 sinh viên và 1 môn học, trả về các điểm thi của sinh viên này trong các lần thi của
-- môn học đó.
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'INDIEMLANTHI')
BEGIN
  DROP FUNCTION INDIEMLANTHI
END
GO

CREATE FUNCTION INDIEMLANTHI(@MASV VARCHAR(255),@MAMH VARCHAR(255))
RETURNS TABLE
AS
RETURN(
	SELECT LANTHI,DIEM
	FROM KETQUA
	WHERE @MASV=MASV AND @MAMH=MAMH
)
GO

SELECT * FROM DBO.INDIEMLANTHI('A01','01')


---C STORE PROCUDERE

--1. Nhập vào 1 khoa, in danh sách các sinh viên (mã sinh viên, họ tên, ngày sinh) thuộc khoa này.

GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='THUOCKHOA')
BEGIN
	DROP PROCEDURE THUOCKHOA
END
GO
CREATE PROCEDURE THUOCKHOA(@MASV VARCHAR(255),@MAKHOA VARCHAR(255))
AS
BEGIN
	IF EXISTS(SELECT * FROM DMSV WHERE @MASV=MASV AND @MAKHOA=@MAKHOA)
		BEGIN
			PRINT 'SINH VIEN NAY THUOC KHOA NAY'
			RETURN
		END
	PRINT 'SINH VIEN NAY KHONG THUOC KHOA NAY'
END

GO
EXEC THUOCKHOA 'A01','TH'

-- 2. Nhập vào 2 sinh viên, 1 môn học, tìm xem sinh viên nào có điểm thi môn học đó lần đầu tiên là
-- cao hơn
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME ='GETDIEM_1')
BEGIN
  DROP FUNCTION GETDIEM_1
END
GO


CREATE FUNCTION GETDIEM_1 (@MASV VARCHAR(255), @MAMH VARCHAR(255), @LANTHI INT)
RETURNS FLOAT
AS
BEGIN
  DECLARE @DIEM FLOAT
  SELECT @DIEM=DIEM FROM KETQUA WHERE MASV=@MASV AND MAMH=@MAMH AND LANTHI=@LANTHI
  RETURN @DIEM
END
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME ='SOSANHDIEM')
BEGIN
	DROP PROCEDURE SOSANHDIEM
END
GO
CREATE PROCEDURE SOSANHDIEM(@MASV1 VARCHAR(255),@MASV2 VARCHAR(255),@MAMH VARCHAR(255))
AS
BEGIN
	DECLARE @DIEM1 FLOAT
	DECLARE @DIEM2 FLOAT
	SET @DIEM1=DBO.GETDIEM_1(@MASV1,@MAMH,1)
	SET @DIEM2=DBO.GETDIEM_1(@MASV2,@MAMH,1)
	IF @DIEM1>@DIEM2
	BEGIN
		PRINT 'SINH VIEN 1 CO DIEM CAO HON'
		RETURN
	END
	PRINT 'SINH VIEN 2 CO DIEM CAO HON'
END

GO
EXEC SOSANHDIEM 'A01','A02','01'
-- Nhập vào 1 sinh viên và 1 môn học, in điểm thi của sinh viên này của các lần thi môn học đó.
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='KIEMTRADAU')
BEGIN
	DROP PROCEDURE KIEMTRADAU
END
GO
CREATE PROCEDURE KIEMTRADAU(@MASV VARCHAR(255),@MAMH VARCHAR(255))
AS
BEGIN
	DECLARE @DIEM FLOAT
	SET @DIEM=DBO.GETDIEM(@MASV,@MAMH)
	IF @DIEM>=5
	BEGIN
		PRINT 'SINH VIEN NAY DA DAT'
		RETURN
	END
	PRINT 'SINH VIEN NAY CHUA DAT'
END

GO
EXEC KIEMTRADAU 'A01','01'



--4Nhập vào 1 sinh viên và 1 môn học, in điểm thi của sinh viên này của các lần thi môn học đó.
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='INDIEM')
BEGIN
	DROP PROCEDURE INDIEM
END
GO
CREATE PROCEDURE INDIEM @MASV VARCHAR(255),@MAMH VARCHAR(255)
AS
BEGIN
	SELECT * FROM DBO.INDIEMLANTHI(@MASV,@MAMH)
END
GO
EXEC INDIEM 'A01','01'
GO

--5Nhập vào 1 sinh viên, in ra các môn học mà sinh viên này phải học.
GO
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='INTENMH')
BEGIN
	DROP PROCEDURE INTENMH
END
GO
CREATE PROCEDURE INTENMH(@MASV VARCHAR(255))
AS
BEGIN
	SELECT TENMH
	FROM DMMH
	WHERE MAMH IN (SELECT MAMH FROM KETQUA WHERE @MASV=MASV)
END
GO
EXEC INTENMH 'A01'
GO 
--6Nhập vào 1 môn học, in danh sách các sinh viên đậu môn này trong lần thi đầu tiên
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='KIEMTRADAULAN1')
BEGIN
	DROP PROCEDURE KIEMTRADAULAN1
END
GO
CREATE PROCEDURE KIEMTRADAULAN1(@MASV VARCHAR(255),@MAMH VARCHAR(255))
AS
BEGIN
	DECLARE @DIEM FLOAT
	SET @DIEM=DBO.GETDIEM_1(@MASV,@MAMH,1)
	IF @DIEM>=5
	BEGIN
		PRINT 'SINH VIEN NAY DA DAT'
		RETURN
	END
	PRINT 'SINH VIEN NAY CHUA DAT'
END
GO
EXEC KIEMTRADAULAN1 'A01','01'
GO
--7Viết thủ tục nhập sinh viên mới
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='NHAPSINHVIEN')
BEGIN
	DROP PROCEDURE NHAPSINHVIEN
END
GO


  -- MASV VARCHAR(255) NOT NULL,
  -- HOSV NVARCHAR(255),
  -- TENSV NVARCHAR(255),
  -- PHAI INT,
  -- NGAYSINH DATE,
  -- NOISINH NVARCHAR(255),
  -- MAKHOA VARCHAR(255),
  -- HOCBONG INT,


CREATE PROCEDURE NHAPSINHVIEN @MASV VARCHAR(255)
								,@HOSV VARCHAR(255)
								,@TENSV VARCHAR(255)
								,@PHAI INT
								,@NGAYSINH DATE
								,@NOISINH VARCHAR(255)
								,@MAKHOA VARCHAR(255)
								,@HOCBONG INT
AS
BEGIN
	IF EXISTS(SELECT * FROM DMSV WHERE @MASV=MASV)
	BEGIN
		PRINT 'SINH VIEN NAY DA TON TAI'
		RETURN
	END
	INSERT INTO DMSV VALUES(@MASV,@HOSV,@TENSV,@PHAI,@NGAYSINH,@NOISINH,@MAKHOA,@HOCBONG)
	PRINT 'NHAP THANH CONG'
END
GO
EXEC NHAPSINHVIEN 'A100','NGUYEN','THI','1','1/1/2011','HUE','A','1000000'
GO
SELECT * FROM DMSV
GO
--8 Viết thủ tục nhập sinh viên mới có kiểm tra ràng buộc khóa chính, ràng buộc khóa ngoại
-- với bảng Khoa và ràng buộc tuổi của sinh viên lớn hơn hoặc bằng 18 và nhỏ hơn 40.
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='NHAPSINHVIEN2')
BEGIN
	DROP PROCEDURE NHAPSINHVIEN2
END
GO
CREATE PROCEDURE NHAPSINHVIEN2 @MASV VARCHAR(255)
								,@HOSV VARCHAR(255)
								,@TENSV VARCHAR(255)
								,@PHAI INT
								,@NGAYSINH DATE
								,@NOISINH VARCHAR(255)
								,@MAKHOA VARCHAR(255)
								,@HOCBONG INT
AS
BEGIN
	DECLARE @TUOI INT
	SET @TUOI=DATEDIFF(YEAR,@NGAYSINH,GETDATE())
	IF EXISTS(SELECT * FROM DMSV WHERE @MASV=MASV)
	BEGIN
		PRINT 'SINH VIEN NAY DA TON TAI'
		RETURN
	END
	IF NOT EXISTS(SELECT * FROM DMKHOA WHERE @MAKHOA=MAKHOA)
	BEGIN
		PRINT 'MA KHOA KHONG TON TAI'
		RETURN
	END
	IF @TUOI<18 OR @TUOI>40
	BEGIN
		PRINT 'TUOI KHONG HOP LE'
		RETURN
	END
	INSERT INTO DMSV VALUES(@MASV,@HOSV,@TENSV,@PHAI,@NGAYSINH,@NOISINH,@MAKHOA,@HOCBONG)
	PRINT 'NHAP THANH CONG'
END
GO
EXEC NHAPSINHVIEN2 'A1001','NGUYEN','minh','1','10/1/2003','HUE','A','1000000'
GO
SELECT * FROM DMSV
GO
--9Viết thủ tục nhập kết quả của sinh viên có kiểm tra ràng buộc khóa ngoại giữa bảng
-- Ketqua và bảng Sinhvien và bảng Monhoc.
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='NHAPKETQUA')
BEGIN
	DROP PROCEDURE NHAPKETQUA
END
GO
CREATE PROCEDURE NHAPKETQUA @MASV VARCHAR(255)
								,@MAMH VARCHAR(255)
								,@LAN INT
								,@DIEM FLOAT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM DMSV WHERE @MASV=MASV)
	BEGIN
		PRINT 'MA SINH VIEN KHONG TON TAI'
		RETURN
	END
	IF NOT EXISTS(SELECT * FROM DMMH WHERE @MAMH=MAMH)
	BEGIN
		PRINT 'MA MON HOC KHONG TON TAI'
		RETURN
	END
	IF EXISTS(SELECT * FROM KETQUA WHERE @MASV=MASV AND @MAMH=MAMH AND @LAN=LANTHI)
	BEGIN
		PRINT 'KET QUA NAY DA TON TAI'
		RETURN
	END
	INSERT INTO KETQUA VALUES(@MASV,@MAMH,@LAN,@DIEM)
	PRINT 'NHAP THANH CONG'
END
GO
EXEC NHAPKETQUA 'A1001','A1','1','10'
GO
SELECT * FROM KETQUA
GO
--10 Viết thủ tục cho biết số lượng sinh viên của khoa có mã nhập vào từ bàn phím.
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='SOLUONGSINHVIEN')
BEGIN
	DROP PROCEDURE SOLUONGSINHVIEN
END
GO
CREATE PROCEDURE SOLUONGSINHVIEN @MAKHOA VARCHAR(255)
AS
BEGIN
	SELECT COUNT(*) FROM DMSV WHERE @MAKHOA=MAKHOA
END
GO
EXEC SOLUONGSINHVIEN 'A'
GO
--11 Viết hàm xem danh sách sinh viên của khoa có mã được nhập vào từ bàn phím
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='DANHSACHSINHVIEN')
BEGIN
	DROP FUNCTION DANHSACHSINHVIEN
END
GO
CREATE FUNCTION DANHSACHSINHVIEN(@MAKHOA VARCHAR(255))
RETURNS TABLE
AS
RETURN(
	SELECT * FROM DMSV WHERE @MAKHOA=MAKHOA
)
GO
SELECT * FROM DANHSACHSINHVIEN('TH')
GO
--12 Viết hàm thống kê số lượng sinh viên của mỗi khoa
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='THONGKE')
BEGIN
	DROP PROCEDURE THONGKE
END
GO
CREATE PROCEDURE THONGKE
AS
BEGIN
	SELECT MAKHOA,COUNT(*) FROM DMSV GROUP BY MAKHOA
END
GO
EXEC THONGKE
GO
--13 Viết hàm xem kết quả học tập của sinh viên có mã được nhập từ bàn phím.
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='KETQUAHOCTAP')
BEGIN
	DROP FUNCTION KETQUAHOCTAP
END
GO
CREATE FUNCTION KETQUAHOCTAP(@MASV VARCHAR(255))
RETURNS TABLE
AS
RETURN(
	SELECT * FROM KETQUA WHERE @MASV=MASV
)
GO
SELECT * FROM KETQUAHOCTAP('A03')
GO
--14 Viết hàm đếm số lượng sinh viên của khoa có mã khoa được nhập vào từ bàn phím
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='SOLUONGSINHVIENKHOA')
BEGIN
	DROP PROCEDURE SOLUONGSINHVIENKHOA
END
GO
CREATE PROCEDURE SOLUONGSINHVIENKHOA @MAKHOA VARCHAR(255)
AS
BEGIN
	SELECT COUNT(*) FROM DMSV WHERE @MAKHOA=MAKHOA
END

GO
EXEC SOLUONGSINHVIENKHOA 'AV'








