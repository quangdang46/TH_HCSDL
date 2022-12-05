public class LamViec {
  private String maQuayHang;
  private String maNhanVien;

  public LamViec() {
  }

  public LamViec(String maQuayHang, String maNhanVien) {
    this.maQuayHang = maQuayHang;
    this.maNhanVien = maNhanVien;
  }

  public String getMaQuayHang() {
    return maQuayHang;
  }

  public void setMaQuayHang(String maQuayHang) {
    this.maQuayHang = maQuayHang;
  }

  public String getMaNhanVien() {
    return maNhanVien;
  }

  public void setMaNhanVien(String maNhanVien) {
    this.maNhanVien = maNhanVien;
  }

  @Override
  public String toString() {
    return maQuayHang + "_" + maNhanVien;
  }

}
