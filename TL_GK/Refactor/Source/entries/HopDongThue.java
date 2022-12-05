package entries;
public class HopDongThue {
  private String maHopDong;
  private String giaTriHopDong;
  private String ngayBatDau;
  private String maNguoiThue;
  private String maQuayHang;
  
  public HopDongThue() {
    
  }

  public HopDongThue(String maHopDong, String giaTriHopDong, String ngayBatDau, String maNguoiThue, String maQuayHang) {
    this.maHopDong = maHopDong;
    this.giaTriHopDong = giaTriHopDong;
    this.ngayBatDau = ngayBatDau;
    this.maNguoiThue = maNguoiThue;
    this.maQuayHang = maQuayHang;
  }

  public String getMaHopDong() {
    return maHopDong;
  }

  public void setMaHopDong(String maHopDong) {
    this.maHopDong = maHopDong;
  }

  public String getGiaTriHopDong() {
    return giaTriHopDong;
  }

  public void setGiaTriHopDong(String giaTriHopDong) {
    this.giaTriHopDong = giaTriHopDong;
  }

  public String getNgayBatDau() {
    return ngayBatDau;
  }

  public void setNgayBatDau(String ngayBatDau) {
    this.ngayBatDau = ngayBatDau;
  }

  public String getMaNguoiThue() {
    return maNguoiThue;
  }

  public void setMaNguoiThue(String maNguoiThue) {
    this.maNguoiThue = maNguoiThue;
  }

  public String getMaQuayHang() {
    return maQuayHang;
  }

  public void setMaQuayHang(String maQuayHang) {
    this.maQuayHang = maQuayHang;
  }

  @Override
  public String toString() {
    return maHopDong + "_" + giaTriHopDong + "_" + ngayBatDau + "_" + maNguoiThue + "_" + maQuayHang;
  }
}