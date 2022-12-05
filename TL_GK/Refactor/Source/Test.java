import controllers.*;
public class Test {

  public static void main(String[] args) throws Exception {
    Controller controller = new Controller();
    // answer question 1
    // controller.solveQuestion_1("data/data.csv", "data/Input1.txt", "Output/Output1.txt");
  
    // question 2
    // config data question 2
    controller.configureQuestion_2("data/Input4.txt");
    //answer question 2
    controller.solveQuestion_2("Output/Output2.txt","QUAYHANG");

  
  }
}