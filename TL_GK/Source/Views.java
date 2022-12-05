
import java.util.*;
import java.io.*;

public class Views {
  public Views() {

  }

  public void renderAnswerRelationships(String fileName, ArrayList<Relationship<Object, Object>> listRelationship)
      throws IOException {
    FileWriter fileWriter = new FileWriter(fileName);
    fileWriter.write("Cac quan he giua cac doi tuong trong tap tin Input1.txt la:");
    fileWriter.write("\n");
    for (Relationship<Object, Object> relationship : listRelationship) {
      fileWriter.write(relationship.toString());
      fileWriter.write("\n");
    }
    fileWriter.close();
  }

  public void renderAnswerTable(String fileName, String nameTable, ArrayList<Object> listObject) throws IOException {
    FileWriter fileWriter = new FileWriter(fileName, true);
    fileWriter.write("Du lieu bang " + nameTable + " la:");
    fileWriter.write("\n");
    for (Object object : listObject) {
      fileWriter.write(object.toString());
      fileWriter.write("\n");
    }
    fileWriter.close();
  }

  public void renderAnswerClosure(String pathFileOutput, String closure) throws IOException {
    FileWriter fileWriter = new FileWriter(pathFileOutput);
    fileWriter.write("Bao dong cua tap dau vao la:");
    fileWriter.write("\n");
    fileWriter.write(closure);
    fileWriter.write("\n");
    fileWriter.close();
  }

  public void renderAnswerAllKeys(String pathFileOutput, ArrayList<String> keys) throws IOException {
    FileWriter fileWriter = new FileWriter(pathFileOutput, true);
    fileWriter.write("Cac khoa cua tap dau vao la:");
    fileWriter.write("\n");
    for (String key : keys) {
      fileWriter.write(key);
      fileWriter.write("\n");
    }
    fileWriter.close();
  }

}
