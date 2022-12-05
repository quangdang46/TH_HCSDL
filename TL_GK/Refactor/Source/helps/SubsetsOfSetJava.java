package helps;
import java.util.*;

public class SubsetsOfSetJava<T> {


  public SubsetsOfSetJava() {
  }

  public HashSet<HashSet<T>> getSubsets(HashSet<T> set) {
    HashSet<HashSet<T>> subsets = new HashSet<HashSet<T>>();
    if (set.isEmpty()) {
      subsets.add(new HashSet<T>());
      return subsets;
    }
    List<T> list = new ArrayList<T>(set);
    T head = list.get(0);
    HashSet<T> rest = new HashSet<T>(list.subList(1, list.size()));
    for (HashSet<T> set1 : getSubsets(rest)) {
      HashSet<T> newSet = new HashSet<T>();
      newSet.add(head);
      newSet.addAll(set1);
      subsets.add(newSet);
      subsets.add(set1);
    }
    return subsets;

  }

}
