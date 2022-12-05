
package entries;
public class ChiTietQuayHang {
  private String maLoaiQuay;
  private String hinhThucQuayHang;

  public ChiTietQuayHang() {
  }

  public ChiTietQuayHang(String maLoaiQuay, String hinhThucQuayHang) {
    this.maLoaiQuay = maLoaiQuay;
    this.hinhThucQuayHang = hinhThucQuayHang;
  }

  public String getMaLoaiQuay() {
    return maLoaiQuay;
  }

  public void setMaLoaiQuay(String maLoaiQuay) {
    this.maLoaiQuay = maLoaiQuay;
  }

  public String getHinhThucQuayHang() {
    return hinhThucQuayHang;
  }

  public void setHinhThucQuayHang(String hinhThucQuayHang) {
    this.hinhThucQuayHang = hinhThucQuayHang;
  }

  public boolean checkLoai(String loai, String[] arr) {
    for (String s : arr) {
      if (!s.equalsIgnoreCase(loai)) {
        return false;
      }
    }
    return true;
  }

  @Override
  public String toString() {
    return maLoaiQuay + "_" + hinhThucQuayHang;
  }
}
