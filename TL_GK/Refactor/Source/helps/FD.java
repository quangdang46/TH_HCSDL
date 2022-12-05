package helps;
import java.util.*;
public class FD {
  private HashSet<String> lhs;
  private String rhs;

  public FD(HashSet<String> l, String r) {
    lhs = l;
    rhs = r;
  }

  public boolean equals(Object obj) {
    FD fd2 = (FD) obj;
    return lhs.equals(fd2.lhs) && rhs.equals(fd2.rhs);
  }

  public HashSet<String> getLHS() {
    return lhs;
  }

  public String getRHS() {
    return rhs;
  }

  public String toString() {
    String s = "";
    for (String c : lhs)
      s += c+" ";
    s += " -> " + rhs;
    return s;
  }

}
