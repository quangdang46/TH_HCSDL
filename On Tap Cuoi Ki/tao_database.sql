use master
go

create database on_tap_cuoi_ky
go

use on_tap_cuoi_ky
go
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='NhaSanXuat')
BEGIN
		DROP TABLE NhaSanXuat
END
go
create table NhaSanXuat(
	maNSX varchar(20) primary key,
	tenNSX nvarchar(50)	
)
go
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='XeMay')
BEGIN
		DROP TABLE XeMay
END
go
create table XeMay (
	maXe varchar(20) primary key,
	tenXe nvarchar(50),
	maNSX varchar(20) foreign key references NhaSanXuat(maNSX),
	soLuong int,
	donGia float
)
go
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='KhachHang')
BEGIN
		DROP TABLE KhachHang
END
go
create table KhachHang (
	soDienThoai varchar(20) primary key,
	hoTen nvarchar(50),
	diaChi varchar(20)
)
go 
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='HoaDon')
BEGIN
		DROP TABLE HoaDon
END
go
create table HoaDon (
	soHoaDon varchar(20) primary key,
	ngayLap date,
	maKhachHang varchar(20),
	foreign key (maKhachHang) references KhachHang(soDienThoai)
)
go
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='ChiTietHoaDon')
BEGIN
	DROP TABLE ChiTietHoaDon
END
go
create table ChiTietHoaDon(
	soHoaDon varchar(20) foreign key references HoaDon(soHoaDon),
	maXe varchar(20) foreign key references XeMay(maXe),
	soLuong int,
	donGia float,
	primary key (soHoaDon, maXe)

)
go
use on_tap_cuoi_ky
go
/* NSX */
insert into NhaSanXuat
values
	('Honda', N'Honda')
go
insert into NhaSanXuat
values
	('Hero', N'Hero Moto Corp')
go
insert into NhaSanXuat
values
	('Yamaha', N'Yamaha Motor')
go
insert into NhaSanXuat
values
	('Bajaj Auto', N'Bajaj Auto')
go
insert into NhaSanXuat
values
	('TVS', N'TVS')
go
insert into NhaSanXuat
values
	('Suzuki', N'Suzuki')
go
/* Xe May */
/* Honda */
insert into XeMay
values
	('1', N'Gold Wing phiên bản 2022', 'Honda', 100, 1231000000)
go

insert into XeMay
values
	('2', N'Vision', 'Honda', 300, 30721091)
go

insert into XeMay
values
	('3', N'Winner X', 'Honda', 150, 46160000)
go

insert into XeMay
values
	('4', N'Wave Alpha 110cc', 'Honda', 200, 17859273)
go

insert into XeMay
values
	('5', N'Air Blade 125/160', 'Honda', 100, 41324727)
go

insert into XeMay
values
	('6', N'Blade 110', 'Honda', 250, 18841091)
go

insert into XeMay
values
	('7', N'CBR650R', 'Honda', 10, 254490000)
go

insert into XeMay
values
	('8', N'LEAD 125cc', 'Honda', 120, 39066545)
go
/* Yamaha */
insert into XeMay
values
	('9', N'FREEGO', 'Yamaha', 120, 33800000)
go

insert into XeMay
values
	('10', N'Sirius FI 2023', 'Yamaha', 120, 21000000)
go

insert into XeMay
values
	('11', N'Exciter 155', 'Yamaha', 140, 47590000)
go

insert into XeMay
values
	('12', N'MT-15', 'Yamaha', 60, 68000000)
go

insert into XeMay
values
	('13', N'Yamaha R3', 'Yamaha', 15, 132000000)
go

insert into XeMay
values
	('14', N'Yamaha R7 ', 'Yamaha', 10, 268000000)
go

insert into XeMay
values
	('15', N'Janus 125 Giới hạn', 'Yamaha', 200, 32200000)
go

insert into XeMay
values
	('16', N'NVX 155 VVA Monster Energy Yamaha MotoGP', 'Yamaha', 30, 55500000)
go
/* Suzuki */
insert into XeMay
values
	('17', N'SATRIA F150 FI', 'Suzuki', 70, 53490000)
go

insert into XeMay
values
	('18', N'RAIDER R150 FI', 'Suzuki', 120, 50990000)
go

insert into XeMay
values
	('19', N'BURGMAN STREET', 'Suzuki', 60, 48600000)
go

insert into XeMay
values
	('20', N'GSX-S150', 'Suzuki', 70, 54000000)
go

insert into XeMay
values
	('21', N'GZ 150 màu Đen, Đỏ', 'Suzuki', 70, 70200000)
go

/* Khach Hang*/
insert into KhachHang
values
	('0000000000', N'Văn Trường Kỳ', N'Đồng Nai')
go
insert into KhachHang
values
	('0000000001', N'Cà Công Bằng', N'Đồng Nai')
go
insert into KhachHang
values
	('0000000002', N'Kiểu Bảo Hoàng', N'Đồng Nai')
go
insert into KhachHang
values
	('0000000003', N'Anh Tường Lâm', N'TP HCM')
go
insert into KhachHang
values
	('0000000004', N'Nhan Nam Lộc', N'Long An')
go
insert into KhachHang
values
	('0000000005', N'Tấn Hiểu Minh', N'Đồng Nai')
go
insert into KhachHang
values
	('0000000006', N'Công Ðức Quyền', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000007', N'', N'Long An')
go
insert into KhachHang
values
	('0000000008', N'Cung Ðức Tâm', N'Long An')
go
insert into KhachHang
values
	('0000000009', N'Thoa Quang Triều', N'Tây Ninh')
go
insert into KhachHang
values
	('0000000010', N'Yên Chí Vịnh', N'TP HCM')
go
insert into KhachHang
values
	('0000000011', N'Âu Dương Ðình Tuấn', N'Đồng Nai')
go
insert into KhachHang
values
	('0000000012', N'Quảng Quốc Hoàng ', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000013', N'Khu Công Sơn', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000014', N'Dương Minh Thuận', N'TP HCM')
go
insert into KhachHang
values
	('0000000015', N'Lương Văn Can', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000016', N'Tôn Trung Sơn', N'Tây Ninh')
go
insert into KhachHang
values
	('0000000017', N'Cù Chính Lan', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000018', N'Ngô Thị Thùy Trang', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000019', N'Phùng Đức Mạng', N'Long An')
go
insert into KhachHang
values
	('0000000020', N'Nông Văn Dần', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000021', N'Nguyễn Trung Nghĩa', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000022', N'Cao Thị Thùy Tiên', N'TP HCM')
go
insert into KhachHang
values
	('0000000023', N'Lê Khang', N'Long An')
go
insert into KhachHang
values
	('0000000024', N'Cao Hải Yến Nhi', N'TP HCM')
go
insert into KhachHang
values
	('0000000025', N'Lưu Kỳ Sơn', N'Tây Ninh')
go
insert into KhachHang
values
	('0000000026', N'Huỳnh Ngọc Như', N'Đồng Nai')
go
insert into KhachHang
values
	('0000000027', N'Võ Trung Hậu', N'Biên Hòa')
go
insert into KhachHang
values
	('0000000028', N'Trương Quang Duy', N'TP HCM')
go

/* hoa don */
insert into HoaDon
values
	('HD0000', '2019-08-20', '0000000000')
go
insert into HoaDon
values
	('HD0001', '2022-04-04', '0000000001')
go
insert into HoaDon
values
	('HD0002', '2016-03-02', '0000000002')
go
insert into HoaDon
values
	('HD0003', '2014-06-15', '0000000003')
go
insert into HoaDon
values
	('HD0004', '2006-07-04', '0000000004')
go
insert into HoaDon
values
	('HD0005', '2009-03-24', '0000000005')
go
insert into HoaDon
values
	('HD0006', '2009-05-09', '0000000006')
go
insert into HoaDon
values
	('HD0007', '2005-03-03', '0000000007')
go
insert into HoaDon
values
	('HD0008', '2002-12-05', '0000000008')
go
insert into HoaDon
values
	('HD0009', '2006-08-27', '0000000009')
go
insert into HoaDon
values
	('HD0010', '2002-10-17', '0000000010')
go
insert into HoaDon
values
	('HD0011', '2005-09-23', '0000000011')
go
insert into HoaDon
values
	('HD0012', '2013-03-09', '0000000012')
go
insert into HoaDon
values
	('HD0013', '2013-02-02', '0000000013')
go
insert into HoaDon
values
	('HD0014', '2007-07-15', '0000000014')
go
insert into HoaDon
values
	('HD0015', '2010-03-08', '0000000015')
go
insert into HoaDon
values
	('HD0016', '2019-06-16', '0000000016')
go
insert into HoaDon
values
	('HD0017', '2011-08-23', '0000000017')
go
insert into HoaDon
values
	('HD0018', '2012-10-03', '0000000018')
go
insert into HoaDon
values
	('HD0019', '2012-12-20', '0000000019')
go
insert into HoaDon
values
	('HD0020', '2000-11-03', '0000000020')
go
insert into HoaDon
values
	('HD0021', '2014-04-08', '0000000021')
go
insert into HoaDon
values
	('HD0022', '2007-03-23', '0000000022')
go
insert into HoaDon
values
	('HD0023', '2006-05-09', '0000000022')
go
insert into HoaDon
values
	('HD0024', '2000-10-08', '0000000022')
go
insert into HoaDon
values
	('HD0025', '2013-03-06', '0000000025')
go
insert into HoaDon
values
	('HD0026', '2005-04-11', '0000000026')
go
insert into HoaDon
values
	('HD0027', '2017-02-16', '0000000027')
go
insert into HoaDon
values
	('HD0028', '2012-01-21', '0000000000')
go
insert into HoaDon
values
	('HD0029', '2016-11-17', '0000000001')
go
insert into HoaDon
values
	('HD0030', '2006-08-26', '0000000002')
go
insert into HoaDon
values
	('HD0031', '2016-02-08', '0000000003')
go
insert into HoaDon
values
	('HD0032', '2015-05-13', '0000000004')
go
insert into HoaDon
values
	('HD0033', '2010-08-12', '0000000005')
go
insert into HoaDon
values
	('HD0034', '2017-04-24', '0000000006')
go
insert into HoaDon
values
	('HD0035', '2016-12-15', '0000000007')
go
insert into HoaDon
values
	('HD0036', '2011-10-01', '0000000008')
go
/*chi tiet hoa don*/insert into ChiTietHoaDon
values
	('HD0000', '0', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0001', '1', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0002', '2', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0003', '3', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0004', '4', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0005', '5', 3, 0)
go
insert into ChiTietHoaDon
values
	('HD0006', '6', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0007', '7', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0008', '8', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0009', '9', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0010', '10', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0011', '11', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0012', '12', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0013', '13', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0014', '14', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0015', '15', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0016', '16', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0017', '17', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0018', '18', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0019', '19', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0020', '20', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0021', '1', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0022', '1', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0023', '2', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0024', '3', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0025', '4', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0026', '5', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0027', '6', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0028', '7', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0029', '8', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0030', '9', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0031', '10', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0032', '11', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0033', '12', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0034', '13', 1, 0)
go
insert into ChiTietHoaDon
values
	('HD0035', '14', 4, 0)
go
insert into ChiTietHoaDon
values
	('HD0036', '15', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0000', '16', 2, 0)
go
insert into ChiTietHoaDon
values
	('HD0001', '17', 0, 0)
go
insert into ChiTietHoaDon
values
	('HD0002', '18', 1, 0)
go

-- SELECT * FROM NhaSanXuat
-- SELECT * FROM XeMay
-- SELECT * FROM KhachHang
-- SELECT * FROM HoaDon
-- SELECT * FROM ChiTietHoaDon


--YC 1
-- A
select * from KhachHang
where DiaChi like N'%TPHCM%' 
			and soDienThoai in (select maKhachHang from HoaDon
								where NgayLap between '2020-04-01' and '2020-06-30')

-- B
select * from XeMay
where maXe in (select maXe from ChiTietHoaDon
	where soHoaDon in (select soHoaDon from HoaDon
		where maKhachHang in (select maKhachHang from KhachHang
			where DiaChi like N'%TPHCM%')))
			and maNSX = 'Yamaha'

-- C
select * from XeMay
where maXe in (
	select maXe from ChiTietHoaDon
	group by maXe
	having sum(soLuong) = (select max(soLuong) from ChiTietHoaDon)
) and maXe in (select maXe from ChiTietHoaDon
	where soHoaDon in (select soHoaDon from HoaDon
		where ngayLap between '2020-01-01' and '2020-12-31'))

-- D
select * from XeMay
where maXe not in (select maXe from ChiTietHoaDon)

-- E
select * from NhaSanXuat
where maNSX in (
	select maNSX from XeMay
	where maXe in (
		select maXe from ChiTietHoaDon
		group by maXe
		having sum(soLuong) = (select max(soLuong) from ChiTietHoaDon)
	) and maXe in (select maXe from ChiTietHoaDon
		where soHoaDon in (select soHoaDon from HoaDon
			where ngayLap between '2020-01-01' and '2020-12-31'))
)

-- F
select month(ngayLap) as Thang, sum(soLuong) as SoLuong
from ChiTietHoaDon as cthd, HoaDon as hd
where cthd.soHoaDon = hd.soHoaDon
	and hd.ngayLap between '2020-01-01' and '2020-12-31'
group by month(ngayLap)

--YC2
--a
if exists (select * from sys.objects where name = 'PhatSinhSoHoaDon')
	drop function PhatSinhSoHoaDon
go
create function PhatSinhSoHoaDon(@ngayLap date)
returns varchar(10)
as
begin
	declare @soThuTu int
	declare @soHoaDon varchar(10)
	select @soThuTu = count(*) + 1 from HoaDon
		where ngayLap = @ngayLap
	set @soHoaDon = convert(varchar(10), @ngayLap, 112) + right('0000' + convert(varchar(10), @soThuTu), 4)
	return @soHoaDon
end
go

--b
if exists (select * from sys.objects where name = 'TinhTongTien')
	drop function TinhTongTien
go
create function TinhTongTien(@soHoaDon varchar(10))
returns money
as
begin
	declare @tongTien money
	select @tongTien = sum(cthd.soLuong * x.donGia) from ChiTietHoaDon as cthd, XeMay as x
		where cthd.soHoaDon = @soHoaDon and cthd.maXe = x.maXe
	return @tongTien
end
go
--c
if exists (select * from sys.objects where name = 'ThongKeSoLuongXeMay')
	drop function ThongKeSoLuongXeMay
go
create function ThongKeSoLuongXeMay(@nam int)
returns table
as
return
select x.maNSX, sum(cthd.soLuong) as SoLuong
from ChiTietHoaDon as cthd, HoaDon as hd, XeMay as x
where cthd.soHoaDon = hd.soHoaDon and cthd.maXe = x.maXe
	and year(hd.ngayLap) = @nam
group by x.maNSX
go


execute PhatSinhSoHoaDon '2020-07-01'
execute TinhTongTien 'HD0032'
select * from ThongKeSoLuongXeMay(2020)

--YC 3
--a
if exists (select * from sys.objects where name = 'ThemXeMay')
	drop procedure ThemXeMay
go
create procedure ThemXeMay
@maXe varchar(10),
@maNSX varchar(10),
@tenXe nvarchar(50),
@soLuong int,
@donGia money
as
begin
	if exists (select * from XeMay where maXe = @maXe)
		print 'Ma xe da ton tai'
	else
		if exists (select * from NhaSanXuat where maNSX = @maNSX)
			if @soLuong > 0 and @donGia > 0
				BEGIN
				insert into XeMay values (@maXe, @maNSX, @tenXe, @soLuong, @donGia)
				print 'Them xe thanh cong'
				end
			else
				print 'So luong va don gia phai lon hon 0'
		else
			print 'Ma NSX khong ton tai'
end
GO
--b
if exists (select * from sys.objects where name = 'XoaXeMay')
	drop procedure XoaXeMay
go
create procedure XoaXeMay
@maXe varchar(10)
as
begin
	if exists (select * from ChiTietHoaDon where maXe = @maXe)
		print 'Khong the xoa xe may nay vi da ton tai trong hoa don'
	else
		delete from XeMay where maXe = @maXe
		print 'Xoa thanh cong'
end
go
--c
if exists (select * from sys.objects where name = 'ThongKeTongTien')
	drop procedure ThongKeTongTien
go
create procedure ThongKeTongTien
as
begin
	select hd.soHoaDon, sum(cthd.soLuong * x.donGia) as TongTien
	from ChiTietHoaDon as cthd, HoaDon as hd, XeMay as x
	where cthd.soHoaDon = hd.soHoaDon and cthd.maXe = x.maXe
	group by hd.soHoaDon
end
go

execute ThemXeMay 'XM001', 'NSX001', N'Xe may 1', 10, 1000000
execute XoaXeMay 'XM001'
execute ThongKeTongTien


--YC 4
--a
if exists (select * from sys.objects where name = 'Trigger_HoaDon')
	drop trigger Trigger_HoaDon
go
create trigger Trigger_HoaDon on HoaDon
for insert
as
begin
	declare @maKhachHang varchar(10)

	select @maKhachHang = maKhachHang from inserted
	if not exists (select * from KhachHang where soDienThoai = @maKhachHang)
		raiserror('Ma khach hang khong ton tai', 16, 1)
end

--b
if exists (select * from sys.objects where name = 'Trigger_ChiTietHoaDon')
	drop trigger Trigger_ChiTietHoaDon
go
create trigger Trigger_ChiTietHoaDon on ChiTietHoaDon
for insert
as
begin
	declare @maXe varchar(10)
	declare @soLuong int
	declare @donGia money

	select @maXe = maXe, @soLuong = soLuong, @donGia = donGia from inserted
	if not exists (select * from XeMay where maXe = @maXe)
		raiserror('Ma xe khong ton tai', 16, 1)
	else
		if @donGia != (select donGia from XeMay where maXe = @maXe)
			raiserror('Don gia khong dung', 16, 1)
		else
			if @soLuong > (select soLuong from XeMay where maXe = @maXe)
				raiserror('So luong khong hop le', 16, 1)
end


