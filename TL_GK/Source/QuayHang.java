public class QuayHang {
  private String maQuayHang;
  private String maNhanVien;
  private String maLoaiQuay;
  private String maKhuVuc;

  public QuayHang() {
  }

  public QuayHang(String maQuayHang, String maNhanVien, String maLoaiQuay, String maKhuVuc) {
    this.maQuayHang = maQuayHang;
    this.maNhanVien = maNhanVien;
    this.maLoaiQuay = maLoaiQuay;
    this.maKhuVuc = maKhuVuc;
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

  public String getMaLoaiQuay() {
    return maLoaiQuay;
  }

  public void setMaLoaiQuay(String maLoaiQuay) {
    this.maLoaiQuay = maLoaiQuay;
  }

  public String getMaKhuVuc() {
    return maKhuVuc;
  }

  public void setMaKhuVuc(String maKhuVuc) {
    this.maKhuVuc = maKhuVuc;
  }

  @Override
  public String toString() {
    return maQuayHang + "_" + maNhanVien + "_" + maLoaiQuay + "_" + maKhuVuc;
  }
}
