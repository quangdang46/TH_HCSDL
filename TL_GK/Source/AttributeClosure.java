import java.util.*;

public class AttributeClosure {
  private HashSet<String> U;
  private HashSet<FD> F;

  public AttributeClosure(HashSet<String> U, HashSet<FD> F) {
    this.U = U;
    this.F = F;
  }

  public HashSet<String> getAttributeClosure(HashSet<String> X) {
    HashSet<String> closure = new HashSet<String>(X);
    int len = 0;
    do {
      len = closure.size();
      for (FD fd : F) {
        if (closure.containsAll(fd.getLHS()) && !closure.contains(fd.getRHS())) {
          closure.add(fd.getRHS());
        }
      }
    } while (closure.size() > len);
    return closure;
  }

  private HashSet<String> getSetRights() {
    HashSet<String> setRights = new HashSet<String>();
    for (FD fd : F) {
      setRights.add(fd.getRHS());
    }
    return setRights;
  }

  private HashSet<String> getSetLefts() {
    HashSet<String> setLefts = new HashSet<String>();
    for (FD fd : F) {
      setLefts.addAll(fd.getLHS());
    }
    return setLefts;
  }

  private HashSet<String> subtractHashSet(HashSet<String> set1, HashSet<String> set2) {
    HashSet<String> set = new HashSet<String>(set1);
    set.removeAll(set2);
    return set;
  }

  private HashSet<String> retainHashSet(HashSet<String> set1, HashSet<String> set2) {
    HashSet<String> set = new HashSet<String>(set1);
    set.retainAll(set2);
    return set;
  }

  private HashSet<String> getTN() {
    return subtractHashSet(U, getSetRights());
  }

  private HashSet<String> getTG() {
    return retainHashSet(getSetLefts(), getSetRights());
  }

  private HashSet<String> add2HashSet(HashSet<String> set1, HashSet<String> set2) {
    HashSet<String> set = new HashSet<String>(set1);
    set.addAll(set2);
    return set;
  }

  public ArrayList<HashSet<String>> findAllKeys() {
    ArrayList<HashSet<String>> listKeys = new ArrayList<HashSet<String>>();
    HashSet<String> TN = getTN();
    HashSet<String> TG = getTG();
    if (TN.isEmpty()) {
      return listKeys;
    }
    SubsetsOfSetJava<String> subsetsOfSetJava = new SubsetsOfSetJava<String>();
    HashSet<HashSet<String>> subsets = subsetsOfSetJava.getSubsets(TG);

    for (HashSet<String> subset : subsets) {
      if (getAttributeClosure(add2HashSet(subset, TN)).containsAll(U)) {
        listKeys.add(add2HashSet(subset, TN));
      }
    }
    // // get HashSet<String> by length min
    // int min = Integer.MAX_VALUE;
    // for (HashSet<String> key : listKeys) {
    //   if (key.size() < min) {
    //     min = key.size();
    //   }
    // }
    // ArrayList<HashSet<String>> listKeysMin = new ArrayList<HashSet<String>>();
    // for (HashSet<String> key : listKeys) {
    //   if (key.size() == min) {
    //     listKeysMin.add(key);
    //   }
    // }
    return listKeys;
  }

}
