import 'package:Comp2171_Project/core/util/Calorie_manager.dart';

enum Measure{number, weight}
class Food{
  String name;
  double quantity;
  Measure measure;
  int calorie;
  Calorie_Manager calorie_manager;

  Food(this.name, this.quantity, String measure){
    if(measure == "NUMBER"){this.measure = Measure.number;}
    else{this.measure = Measure.weight;}
    this.calorie = 0;
    this.calorie_manager = new Calorie_Manager();
  }

  // Getters
  String getName() => this.name;
  double getQuantity() => this.quantity;
  String getMeasure(){
    if(measure == Measure.number){return "NUMBER";}
    return "WEIGHT";
  }
  int getCalorie() => this.calorie;

  // Setters
  void setName(String name) => this.name = name;
  void setMeasure(double quantity) => this.quantity = quantity;
  void  setMeasureType(String measure){
    this.measure = measure == "NUMBER" ? Measure.number : Measure.weight;
  }

  // Modifiers
  void updateCalorie(){

  }


}

void main(List<String> args) {
  Food tf = new Food("apple",1,"NUMBER");
  print(tf.getMeasure());
  tf.setMeasure("WEIGHT");
  print(tf.getMeasure());

}