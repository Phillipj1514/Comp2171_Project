import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Food.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/core/util/Report_Manager.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart' show MealPlan;

class Client extends User_Profile{
  double initialWeight;
  double expectedWeight;
  int dailyCalorie;
  List<Daily_Consumption> dailyConsumptions;
  int numDays;
  Report_Manager nutritionalReportManager;
  MealPlan_List availableMealPlans = new MealPlan_List();

  Client(String uid, String firstname, String lastname, String username, 
   int month, int day, int year, int age, double height, double weight, this.expectedWeight, this.numDays)
    :super(uid,firstname, lastname, username, month, day, year, age, height, weight){
      this. initialWeight = weight;
      this.dailyCalorie = 0;
      this.dailyConsumptions = [];
      nutritionalReportManager = new Report_Manager();
    }
    

  // Getters
  double getInitialWeight() => this.initialWeight;
  double getExpectedWeight() => this.expectedWeight;
  int getDailyCalorie() => this.dailyCalorie;
  List<Daily_Consumption> getDailyConsumptions() => this.dailyConsumptions;
  Daily_Consumption getDailyConsumption(int index) => this.dailyConsumptions.elementAt(index);
  int getNumDays() => this.numDays;
  Report_Manager getnutritionalReportManager()=> this.nutritionalReportManager;
  MealPlan_List getAvailableMealPlans() => this.availableMealPlans;

  // Setters
  void setExpectedWeight(double expectedWeight) => this.expectedWeight = expectedWeight;
  void setDailyCalorie(int dailyCalorie) => this.dailyCalorie = dailyCalorie;
  void setNumDays(int numDays) => this.numDays = numDays;
  void setAvailableMealPlans(MealPlan_List mealPlan_List) => this.availableMealPlans = mealPlan_List;

  //modifiers
  void addDailyConsumption( Daily_Consumption consumption) => this.dailyConsumptions.add(consumption);
  bool removeDailyConsumption(var dailyConsumption){
    if(dailyConsumption is Daily_Consumption){
      this.dailyConsumptions.remove(dailyConsumption);
      return true;
    }else if(dailyConsumption is int){
      this.dailyConsumptions.removeAt(dailyConsumption);
      return true;
    }
    return false;
  }

  void addMealPlanToConsumptions(){

  }

  void removeMealPlanFromConsumption(){

  }

  Future<int> checkFoodCalorie(Food food) async{
    Food newFood = food;
    await newFood.updateNutritionalDetail();
    print(newFood.getCalorie());
    return newFood.getCalorie();
  } 

  Map<String, dynamic> mapify(){
    return {
      "id":this.uid,
      "type":"client",
      "username":this.username,
      "firstname": this.firstname,
      "lastname":this.lastname,
      "age": this.age,
      "DOB": this.dob,
      "height": this.height,
      "weight": this.weight,
      "initial_weight": this.initialWeight,
      "expected_weight": this.expectedWeight,
      "daily_calorie": this.dailyCalorie,
      "num_days": this.numDays,
      "date_created": this.dateCreated,
      "daily_consumptions":  [for (var dailyCons in this.dailyConsumptions) dailyCons.mapify()] 
    };
  }
  Client.fromMap(Map mapdata):super.withDate(mapdata["id"],mapdata["firstname"],mapdata["lastname"], 
                mapdata["username"],new DateTime.fromMillisecondsSinceEpoch(mapdata["DOB"].millisecondsSinceEpoch), 
                mapdata["age"],mapdata["height"],mapdata["weight"],new DateTime.fromMillisecondsSinceEpoch(mapdata["date_created"].millisecondsSinceEpoch)){
    this.initialWeight = mapdata["initial_weight"];
    this.expectedWeight = mapdata["expected_weight"];
    this.dailyCalorie = mapdata["daily_calorie"];
    this.numDays = mapdata["num_days"];
    this.dailyConsumptions = [for(var dailyCon in mapdata["daily_consumptions"]) new Daily_Consumption.fromMap(dailyCon)];
  }

}
void main(List<String> args) async{
  Client tc = new Client("John","Paul","jp","pswd",3,12,1990,30,5,160,140,20);
  print(tc.getExpectedWeight());
  tc.setExpectedWeight(200);
  print(tc.getExpectedWeight());
  await tc.checkFoodCalorie(new Food(name:"mango",quantity:3));
  print(tc.availableMealPlans.getPlanCount());
  tc.availableMealPlans.addMealPlan(new MealPlan.defaultConst());
  print(tc.availableMealPlans.getPlanCount());

  
}