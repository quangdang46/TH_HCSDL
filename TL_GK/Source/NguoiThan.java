public class NguoiThan {
  private String maNguoiThue;
  private String hoTen;
  private String CMND;

  public NguoiThan() {
    
  }

  public NguoiThan(String maNguoiThue, String hoTen, String CMND) {
    this.maNguoiThue = maNguoiThue;
    this.hoTen = hoTen;
    this.CMND = CMND;
  }

  public String getMaNguoiThue() {
    return maNguoiThue;
  }

  public void setMaNguoiThue(String maNguoiThue) {
    this.maNguoiThue = maNguoiThue;
  }

  public String getHoTen() {
    return hoTen;
  }

  public void setHoTen(String hoTen) {
    this.hoTen = hoTen;
  }

  public String getCMND() {
    return CMND;
  }

  public void setCMND(String CMND) {
    this.CMND = CMND;
  }

  @Override
  public String toString() {
    return maNguoiThue+"_"+hoTen+"_"+CMND;
  }

}
