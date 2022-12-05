package entries;
public class KhuVuc {
  private String maKhuVuc;
  private String tenKhuVuc;
  private String tienThue;

  public KhuVuc() {
    
  }

  public KhuVuc(String maKhuVuc, String tenKhuVuc, String tienThue) {
    this.maKhuVuc = maKhuVuc;
    this.tenKhuVuc = tenKhuVuc;
    this.tienThue = tienThue;
  }

  public String getMaKhuVuc() {
    return maKhuVuc;
  }

  public void setMaKhuVuc(String maKhuVuc) {
    this.maKhuVuc = maKhuVuc;
  }

  public String getTenKhuVuc() {
    return tenKhuVuc;
  }

  public void setTenKhuVuc(String tenKhuVuc) {
    this.tenKhuVuc = tenKhuVuc;
  }

  public String getTienThue() {
    return tienThue;
  }

  public void setTienThue(String tienThue) {
    this.tienThue = tienThue;
  }

  @Override
  public String toString() {
    return maKhuVuc + "_" + tenKhuVuc + "_" + tienThue;
  }
}
