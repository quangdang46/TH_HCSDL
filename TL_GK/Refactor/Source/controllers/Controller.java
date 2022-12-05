package controllers;

import helps.*;
import models.*;
import views.*;
import java.util.*;
import java.io.*;

public class Controller {
  private ArrayList<Relationship<Object, Object>> listRelationship;
  private Set<String> listClass;
  private AttributeClosure attributeClosure;
  private Model model;
  private Views views;

  public Controller() {
    this.listRelationship = new ArrayList<Relationship<Object, Object>>();
    this.listClass = new HashSet<String>();
    this.model = new Model();
    this.views = new Views();
  }

  public ArrayList<Relationship<Object, Object>> getListRelationship() {
    return listRelationship;
  }

  public Set<String> getListClass() {
    return listClass;
  }

  public void handleRelationship(String fileName) {
    model.initRelationship(fileName, listRelationship, listClass);
  }

  public void displayData(String fileName) throws IOException {
    HashMap<String, ArrayList<Object>> map = new HashMap<String, ArrayList<Object>>();
    model.handleReadData(fileName, map, listClass);

  }

  public void solveQuestion_1(String pathFileTable, String pathFileRelationships, String pathFileOutput)
      throws IOException {
    HashMap<String, ArrayList<Object>> map = new HashMap<String, ArrayList<Object>>();
    // read data from file
    handleRelationship(pathFileRelationships);
    model.handleReadData(pathFileTable, map, listClass);

    // display data question 1
    views.renderAnswerRelationships(pathFileOutput, listRelationship);
    for (String key : map.keySet()) {
      views.renderAnswerTable(pathFileOutput, key, map.get(key));
    }
  }

  public void configureQuestion_2(String pathFileAtribute)
      throws IOException {
    HashSet<String> listAtribute = new HashSet<String>();
    HashSet<FD> listFD = new HashSet<FD>();

    // read data from file
    model.readAttributesTable(pathFileAtribute, listAtribute);
    model.readFuncDependency(pathFileAtribute, listFD);
    attributeClosure = new AttributeClosure(listAtribute, listFD);

  }

  public HashSet<String> convertString2Set(String str, String regex) {
    HashSet<String> set = new HashSet<String>();
    String[] arr = str.split(regex);
    for (String s : arr) {
      set.add(s.toUpperCase());
    }
    return set;
  }

  public String convertSet2String(HashSet<String> set, String regex) {
    String str = "";
    for (String s : set) {
      str += s + regex;
    }
    return str.substring(0, str.length() - regex.length());
  }

  public void solveQuestion_2(String pathFileOutput, String X) throws IOException {

    // closure of X
    HashSet<String> setX = convertString2Set(X, "_");
    HashSet<String> closures = attributeClosure.getAttributeClosure(setX);
    String closure ="("+ X.toUpperCase()+")+" + "->" + convertSet2String(closures, "_");
    // find all keys
    ArrayList<HashSet<String>> allKeys = attributeClosure.findAllKeys();
    ArrayList<String> keys = new ArrayList<String>();
    for (HashSet<String> key : allKeys) {
      keys.add(convertSet2String(key, "_"));
    }

    if (X.isEmpty()) {
      views.renderAnswerClosure(pathFileOutput, "X is empty");
      return;
    } else {
      // render solveQuestion_2
      views.renderAnswerClosure(pathFileOutput, closure);

    }

    // check empty key
    if (allKeys.size() == 0) {
      views.renderAnswerAllKeys(pathFileOutput, new ArrayList<String>() {
        {
          add("No key");
        }
      });
    } else {

      // render solveQuestion_2
      views.renderAnswerAllKeys(pathFileOutput, keys);
    }

  }
}