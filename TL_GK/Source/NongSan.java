public class NongSan extends ChiTietQuayHang {
  
  public NongSan() {
    super();
  }

  public NongSan(String maLoaiQuay, String loai) {
    super(maLoaiQuay, loai);
    if (!this.checkLoai(loai, new String[] { "Rau", "CuQua" })) {
      this.setHinhThucQuayHang("CuQua");
    }
  }

  @Override
  public String toString() {
    return "Nong San: "+super.toString();
  }
}
