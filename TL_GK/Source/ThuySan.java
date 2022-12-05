public class ThuySan extends ChiTietQuayHang {

  public ThuySan() {
    super();
  }

  public ThuySan(String maLoaiQuay, String loai) {
    super(maLoaiQuay, loai);
    if (!this.checkLoai(loai, new String[] { "NgoaiBien", "Nuoi" })) {
      this.setHinhThucQuayHang("NgoaiBien");
    }
  }

  @Override
  public String toString() {
    return "Thuy San: "+super.toString();
  }

}
