package helps;
public class Relationship<A, B> {
  private A ObjectA;
  private B ObjectB;
  private String typeObjectA;
  private String typeObjectB;

  public Relationship() {
  }

  public Relationship(A ObjectA, B ObjectB, String typeObjectA, String typeObjectB) {
    this.ObjectA = ObjectA;
    this.ObjectB = ObjectB;
    this.typeObjectA = typeObjectA;
    this.typeObjectB = typeObjectB;
  }

  public A getObjectA() {
    return ObjectA;
  }

  public void setObjectA(A ObjectA) {
    this.ObjectA = ObjectA;
  }

  public B getObjectB() {
    return ObjectB;
  }

  public void setObjectB(B ObjectB) {
    this.ObjectB = ObjectB;
  }

  public String getTypeObjectA() {
    return typeObjectA;
  }

  public void setTypeObjectA(String typeObjectA) {
    this.typeObjectA = typeObjectA;
  }

  public String getTypeObjectB() {
    return typeObjectB;
  }

  public void setTypeObjectB(String typeObjectB) {
    this.typeObjectB = typeObjectB;
  }

  @Override
  public String toString() {
    return ObjectA.getClass().getSimpleName() + ": " + typeObjectA + " <-> " + typeObjectB + " :" + ObjectB.getClass()
        .getSimpleName();
  }
}