import 'package:Comp2171_Project/core/foodObjects/Daily_Consumption.dart';
import 'package:Comp2171_Project/core/foodObjects/MealPlan_List.dart';
import 'package:Comp2171_Project/core/usersDetails/User_Profile.dart';
import 'package:Comp2171_Project/core/util/Report_Manager.dart';

class Client extends User_Profile{
  double initialWeight;
  double expectedWeight;
  int dailyCalorie;
  List<Daily_Consumption> dailyConsumptions;
  int numDays;
  Report_Manager nutritionalReportManager;
  MealPlan_List availableMealPlans;

  Client(String firstname, String lastname, String username, 
    String password, int month, int day, int year, int age, double height, double weight, this.expectedWeight, this.numDays)
    :super(firstname, lastname, username, password, month, day, year, age, height, weight){
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


}
void main(List<String> args) {
  Client tc = new Client("John","Paul","jp","pswd",3,12,1990,30,5,160,140,20);
  print(tc.getExpectedWeight());
  tc.setExpectedWeight(200);
  print(tc.getExpectedWeight());
  
}