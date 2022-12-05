import java.util.*;
import java.io.*;

public class Model {

  public Model() {

  }

  private Object createObjectByStringName(String clasName) {
    switch (clasName) {
      case "THUYSAN":
        return new ThuySan();
      case "QUAYHANG":
        return new QuayHang();
      case "NONGSAN":
        return new NongSan();
      case "NHANVIEN":
        return new NhanVien();
      case "NGUOITHUE":
        return new NguoiThue();
      case "NGUOITHAN":
        return new NguoiThan();
      case "LOAIQUAYHANG":
        return new LoaiQuayHang();
      case "LAMVIEC":
        return new LamViec();
      case "KHUVUC":
        return new KhuVuc();
      case "HOPDONGTHUE":
        return new HopDongThue();
      default:
        return null;
    }
  }

  private ThuySan thuySan(String maLoaiQuay, String loai) {
    return new ThuySan(maLoaiQuay, loai);
  }

  private QuayHang quayHang(String maQuayHang, String maNhanVien, String maLoaiQuay, String maKhuVuc) {
    return new QuayHang(maQuayHang, maNhanVien, maLoaiQuay, maKhuVuc);
  }

  private NongSan nongSan(String maLoaiQuay, String loai) {
    return new NongSan(maLoaiQuay, loai);
  }

  private NhanVien nhanVien(String maNhanVien, String hoTen, String chucVu, String luong) {
    return new NhanVien(maNhanVien, hoTen, chucVu, luong);
  }

  private NguoiThue nguoiThue(String maNguoiThue, String hoTen, String SDT, String CMND) {
    return new NguoiThue(maNguoiThue, hoTen, SDT, CMND);
  }

  private NguoiThan nguoiThan(String maNguoiThue, String hoTen, String CMND) {
    return new NguoiThan(maNguoiThue, hoTen, CMND);
  }

  private LoaiQuayHang loaiQuayHang(String maLoaiQuay, String giaThe, String tenQuay, String dienTich) {
    return new LoaiQuayHang(maLoaiQuay, giaThe, tenQuay, dienTich);
  }

  private LamViec lamViec(String maQuayHang, String maNhanVien) {
    return new LamViec(maQuayHang, maNhanVien);
  }

  private KhuVuc khuVuc(String maKhuVuc, String tenKhuVuc, String tienThue) {
    return new KhuVuc(maKhuVuc, tenKhuVuc, tienThue);
  }

  private HopDongThue hopDongThue(String maHopDong,
      String giaTriHopDong, String ngayBatDau, String maNguoiThue,
      String maQuayHang) {
    return new HopDongThue(maHopDong, giaTriHopDong, ngayBatDau, maNguoiThue, maQuayHang);
  }

  private Object createClass(String className, String[] args) {
    switch (className) {
      case "THUYSAN":
        return thuySan(args[0], args[1]);
      case "QUAYHANG":
        return quayHang(args[0], args[1], args[2], args[3]);
      case "NONGSAN":
        return nongSan(args[0], args[1]);
      case "NHANVIEN":
        return nhanVien(args[0], args[1], args[2], args[3]);
      case "NGUOITHUE":
        return nguoiThue(args[0], args[1], args[2], args[3]);
      case "NGUOITHAN":
        return nguoiThan(args[0], args[1], args[2]);
      case "LOAIQUAYHANG":
        return loaiQuayHang(args[0], args[1], args[2], args[3]);
      case "LAMVIEC":
        return lamViec(args[0], args[1]);
      case "KHUVUC":
        return khuVuc(args[0], args[1], args[2]);
      case "HOPDONGTHUE":
        return hopDongThue(args[0], args[1], args[2], args[3], args[4]);
      default:
        return null;
    }
  }

  public void readRelationship(String fileName, ArrayList<Relationship<Object, Object>> listRelationship,
      Set<String> listClass) throws IOException {
    File file = new File(fileName);
    Scanner scanner = new Scanner(file);
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] tokens = line.split(",");
      Object objA = createObjectByStringName(tokens[0].toUpperCase());
      Object objB = createObjectByStringName(tokens[1].toUpperCase());
      String typeObjectA = tokens[2];
      String typeObjectB = tokens[3];
      Relationship<Object, Object> relationship = new Relationship<>(objA, objB,
          typeObjectA, typeObjectB);
      listRelationship.add(relationship);
      listClass.add(tokens[0]);
      listClass.add(tokens[1]);
    }
    scanner.close();
  }

  public void initRelationship(String fileName, ArrayList<Relationship<Object, Object>> listRelationship,
      Set<String> listClass) {
    try {
      readRelationship(fileName, listRelationship, listClass);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public HashMap<String, ArrayList<Object>> handleReadData(String fileName, HashMap<String, ArrayList<Object>> map,
      Set<String> listClass)
      throws IOException {
    File file = new File(fileName);
    Scanner scanner = new Scanner(file);
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] tokens = line.split(",");
      String className = tokens[0].toUpperCase();
      Object obj = createClass(className, Arrays.copyOfRange(tokens, 1, tokens.length));
      ArrayList<Object> list = map.get(className);
      if (list == null) {
        list = new ArrayList<Object>();
      }
      list.add(obj);
      map.put(className, list);
    }
    scanner.close();
    return map;
  }

  public void readAttributesTable(String pathFileAtribute, HashSet<String> listAtribute) throws IOException {
    File file = new File(pathFileAtribute);
    Scanner scanner = new Scanner(file);
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] tokens = line.split("->");
      if (tokens.length == 1) {
        int indexArrow = tokens[0].indexOf("(");
        String className = tokens[0].substring(0, indexArrow).toUpperCase();
        listAtribute.add(className);
      }
    }
    scanner.close();

  }

  public void readFuncDependency(String pathFileFuncDependency, HashSet<FD> listFD) throws IOException {
    File file = new File(pathFileFuncDependency);
    Scanner scanner = new Scanner(file);
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] tokens = line.split("->");
      if (tokens.length == 2) {
        HashSet<String> lhs = new HashSet<String>();
        String[] lhsTokens = tokens[0].split("_");
        for (String lhsToken : lhsTokens) {
          lhs.add(lhsToken.toUpperCase());
        }
        String[] rhs = tokens[1].split("_");
        for (String s : rhs) {
          listFD.add(new FD(lhs, s.toUpperCase()));
        }
      }
    }
    scanner.close();
  }
}
