public class NhanVien {
  private String maNhanVien;
  private String hoTen;
  private String chucVu;
  private String luong;


  public NhanVien() {
    
  }

  public NhanVien(String maNhanVien, String hoTen, String chucVu, String luong) {
    this.maNhanVien = maNhanVien;
    this.hoTen = hoTen;
    this.chucVu = chucVu;
    this.luong = luong;
  }

  public String getMaNhanVien() {
    return maNhanVien;
  }

  public void setMaNhanVien(String maNhanVien) {
    this.maNhanVien = maNhanVien;
  }

  public String getHoTen() {
    return hoTen;
  }

  public void setHoTen(String hoTen) {
    this.hoTen = hoTen;
  }

  public String getChucVu() {
    return chucVu;
  }

  public void setChucVu(String chucVu) {
    this.chucVu = chucVu;
  }

  public String getLuong() {
    return luong;
  }

  public void setLuong(String luong) {
    this.luong = luong;
  }

  @Override
  public String toString() {
    return maNhanVien + "_" + hoTen + "_" + chucVu + "_" + luong;
  }

}