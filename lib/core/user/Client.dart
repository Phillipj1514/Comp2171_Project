import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Food.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/core/util/Report_Manager.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart' show MealPlan;
import 'package:intl/intl.dart';

class Client extends User_Profile{
  double initialWeight;
  double expectedWeight;
  int dailyCalorie;
  List<Daily_Consumption> dailyConsumptions;
  int numDays;
  Report_Manager nutritionalReportManager;
  MealPlan_List availableMealPlans;

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
  
  Daily_Consumption getDailyConsumption(int index){
    try{
      Daily_Consumption daily_consumption = this.dailyConsumptions.elementAt(index);
      return daily_consumption;
    }catch(e){
      print(e.toStringa());
      print("no such daily consumption");
      return null;
    }
  }

  Daily_Consumption getDailyConsumptionByDate(DateTime date){
    try{
      Daily_Consumption daily_consumption = this.dailyConsumptions.firstWhere((consump) 
        => DateFormat('yyyy-MM-dd').format(consump.getDate()) == DateFormat('yyyy-MM-dd').format(date));
      return daily_consumption;
    }catch(e){
      print(e.toString());
      print("no such daily consumption");
      return null;
    }
  }
  
  int getNumDays() => this.numDays;
  
  Report_Manager getnutritionalReportManager()=> this.nutritionalReportManager;
  
  // Setters
  void setExpectedWeight(double expectedWeight) => this.expectedWeight = expectedWeight;
  
  void setDailyCalorie(int dailyCalorie) => this.dailyCalorie = dailyCalorie;
  
  void setNumDays(int numDays) => this.numDays = numDays;

  //modifiers
  /// Add a new dailyConsumption to the list
  void addDailyConsumption( Daily_Consumption consumption){
    try{
      if(this.getDailyConsumptionByDate(consumption.getDate()) == null){
        this.dailyConsumptions.add(consumption);
      }else{
        print("consumption at date already exist, try updating it instead");
      }
    }catch(e){
      print(e.toString());
    }
    
  }
  
  /// Update an already existing daily consumption or add if its new
  void updateDailyConsumption(Daily_Consumption daily_consumption){
    try{
      Daily_Consumption existing = this.getDailyConsumptionByDate(daily_consumption.getDate());
      if(existing != null){
        int indexOfExisting = dailyConsumptions.indexOf(existing);
        dailyConsumptions[indexOfExisting] = daily_consumption;
      }else{
        this.addDailyConsumption(daily_consumption);
      }
    }catch(e){
      print(e.toString());
      print("The consumption wasnt updated");
    }
  }
  
  /// Remove daily consumption with the index or the daily consumption object
  void removeDailyConsumption(dynamic dailyConsumption){
    try{
      // check to see if an daily consumption object was entered and delte it
      if(dailyConsumption is Daily_Consumption){
        this.dailyConsumptions.remove(dailyConsumption);
      }else if(dailyConsumption is int){ //check to see if the variable is an interger and delete the value where the index at
        this.dailyConsumptions.removeAt(dailyConsumption);
      }
    }catch(e){
      print(e.toString());
      print("Daily Consumption wasnt deleted");
    }
  }

  // remove daily consumption by the date entered
  void removeDailyConsumptionByDate(DateTime date){
    try{
      dailyConsumptions.removeWhere((Daily_Consumption consump) => consump.getDate() == date);
      
    }catch(e){
      print(e.toString());
      print("Daily Consumption wasnt deleted");
    }
  }

  void addMealPlanToConsumptions(DateTime startTime, MealPlan mealPlan){
    try{
      for(var day= 0; day < mealPlan.getNumDays(); day++){
        DateTime date = startTime.add(new Duration(days: day));
        Daily_Consumption days_consumption = this.getDailyConsumptionByDate(date);
        if(days_consumption == null){
          days_consumption = new Daily_Consumption.dateTime(date);
        }
        days_consumption.addMeal(mealPlan.getMeal(day));
        this.updateDailyConsumption(days_consumption);
      }
    }catch(e){
      print(e.toString());
      print("MealPlan wasnt added successfully");
    }
  }

  void removeMealPlanFromConsumption(String mealPlanId){
    try{
      for(Daily_Consumption daily_consumption in dailyConsumptions){
        daily_consumption.removeMealWithMealPlanId(mealPlanId);
      }
    }catch(e){
      print(e.toString());
      print("Meals for the selected meal plan were not found");
    }
  }

  Future<int> checkFoodCalorie(Food food) async{
    Food newFood = food;
    await newFood.updateNutritionalDetail();
    print(newFood.getNutrients().getCalorie());
    return newFood.getNutrients().getCalorie();
  } 
  
  //Database Manager Methods
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
  print(MealPlan_List.getPlanCount());
  MealPlan_List.addMealPlan(new MealPlan.noMeals());
  print(MealPlan_List.getPlanCount());
  // Checking the mealplan adding tothe consumption
  print("-------Meal Plan Data ------");
  MealPlan testPlan = new MealPlan.noMeals();
  print(testPlan.getId());
  testPlan.addMeal(new Meal(name: "meal 1"));
  testPlan.addMeal(new Meal(name: "meal 2"));
  print(testPlan.getNumDays());
  tc.addMealPlanToConsumptions(DateTime.now(), testPlan);
  print(tc.getDailyConsumptions().length);
  print(tc.getDailyConsumption(0).getMeals().elementAt(0).getName());
  print(tc.getDailyConsumption(0).getDate().toString());
  print(tc.getDailyConsumption(1).getMeals().elementAt(0).getName());
  print(tc.getDailyConsumption(1).getDate().toString());
  tc.removeMealPlanFromConsumption("mealplan_2");
  print(tc.getDailyConsumption(1).getMeals().length);
}