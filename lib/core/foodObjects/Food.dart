import 'package:Comp2171_Project/core/util/Calorie_manager.dart';

enum MeasureType{number, weight}
class Food{
  String name;
  double measure;
  MeasureType measureType;
  int calorie;
  Calorie_Manager calorie_manager;

  Food(this.name, this.measure, String measureType){
    if(measureType == "NUMBER"){this.measureType = MeasureType.number;}
    else{this.measureType = MeasureType.weight;}
    this.calorie = 0;
    this.calorie_manager = new Calorie_Manager();
  }

  // Getters
  String getName() => this.name;
  double getMeasure() => this.measure;
  String getMeasureType(){
    if(measureType == MeasureType.number){return "NUMBER";}
    return "WEIGHT";
  }
  int getCalorie() => this.calorie;

  // Setters
  void setName(String name) => this.name = name;
  void setMeasure(double measure) => this.measure = measure;
  void  setMeasureType(String measureType){
    this.measureType = measureType == "NUMBER" ? MeasureType.number : MeasureType.weight;
  }

  // Modifiers
  void updateCalorie(){

  }


}

void main(List<String> args) {
  Food tf = new Food("apple",1,"NUMBER");
  print(tf.getMeasureType());
  tf.setMeasureType("WEIGHT");
  print(tf.getMeasureType());

}