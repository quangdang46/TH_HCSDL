package entries;
public class LoaiQuayHang {
  private String maLoaiQuay;
  private String giaThe;
  private String tenQuay;
  private String dienTich;


  public LoaiQuayHang() {
  }

  public LoaiQuayHang(String maLoaiQuay, String giaThe, String tenQuay, String dienTich) {
    this.maLoaiQuay = maLoaiQuay;
    this.giaThe = giaThe;
    this.tenQuay = tenQuay;
    this.dienTich = dienTich;
  }

  public String getMaLoaiQuay() {
    return maLoaiQuay;
  }

  public void setMaLoaiQuay(String maLoaiQuay) {
    this.maLoaiQuay = maLoaiQuay;
  }

  public String getGiaThe() {
    return giaThe;
  }

  public void setGiaThe(String giaThe) {
    this.giaThe = giaThe;
  }

  public String getTenQuay() {
    return tenQuay;
  }

  public void setTenQuay(String tenQuay) {
    this.tenQuay = tenQuay;
  }

  public String getDienTich() {
    return dienTich;
  }

  public void setDienTich(String dienTich) {
    this.dienTich = dienTich;
  }

  @Override
  public String toString() {
    return maLoaiQuay + "_" + giaThe + "_" + tenQuay + "_" + dienTich;
  }
}
