package entries;
public class NguoiThue {
  private String maNguoiThue;
  private String hoTen;
  private String SDT;
  private String CMND;
  
  public NguoiThue() {
    
  }
  public NguoiThue(String maNguoiThue, String hoTen, String SDT, String CMND) {
    this.maNguoiThue = maNguoiThue;
    this.hoTen = hoTen;
    this.SDT = SDT;
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

  public String getSDT() {
    return SDT;
  }

  public void setSDT(String SDT) {
    this.SDT = SDT;
  }

  public String getCMND() {
    return CMND;
  }

  public void setCMND(String CMND) {
    this.CMND = CMND;
  }

  @Override
  public String toString() {
    return maNguoiThue+"_"+hoTen+"_"+SDT+"_"+CMND;
  }
}
