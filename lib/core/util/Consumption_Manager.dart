import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class ConsumptionManager{
  static DatabaseManager db = DatabaseManager();

  /// Add a meal to the clients account that was submitted
  /// Most preferably the current signed in client user should use this method
  static Future addUserMeal(Meal meal, DateTime date) async{
    try{
      print("--> Add Meal For User");
      if(ProfileManager.isClient()){
        Client client = ProfileManager.getUser();
        Daily_Consumption consump = client.getDailyConsumptionByDate(date);
        if(consump == null){
          consump = new Daily_Consumption.dateTime(date);
          await db.addNewDailyConsumption(consump, client.getUid());
        }
        await db.addNewMeal(meal, client.getUid(), consump.getDate());
        client.addMealToConsumption(meal, date);
        ProfileManager.setUser(client);
      }else{print("client is invalid");}
    }catch(e){
      print(e.toString());
    }
  }

  /// Delete a meal from the consumption list for a specific day
  static Future deleteUserMeal(DateTime consumpId, String mealId) async{
    try{
      print("--> Delete Meal For User");
      if(ProfileManager.isClient()){
        Client client = ProfileManager.getUser();
        await db.deleteMeal(client.getUid(), consumpId, mealId);
        client.deleteMealFromConsumption(mealId, consumpId);
        await db.updateDailyConsumption(client.getUid(), client.getDailyConsumptionByDate(consumpId));
        ProfileManager.setUser(client);
      }else{
        print("client is invalid");
      }
    }catch(e){
      print(e.toString());
    }
  }

  /// Update a meal in a specific daily consumption
  static Future updateUserMeal(DateTime consumpId, Meal meal) async{
    try{
      print("--> Update Meal For User");
       if(ProfileManager.isClient()){
        Client client = ProfileManager.getUser();
        await db.updateMeal(client.getUid(), consumpId, meal);
        client.updateMealInConsumption(meal, consumpId);
        await db.updateDailyConsumption(client.getUid(), client.getDailyConsumptionByDate(consumpId));
        ProfileManager.setUser(client);
      }else{
        print("client is invalid");
      }
    }catch(e){
      print(e.toString());
    }
  }
  
  /// update all the daily consumption in the object to the database
  /// very slow inefficient, dont use alot 
  static Future updateUserDailyConsumptions() async{
    try{
      print("--> updating user daily consumptions to database");
      if(ProfileManager.isClient()){
        Client client = ProfileManager.getUser();
        client.getDailyConsumptions().forEach((daily_consumption) async{ 
            await db.updateDailyConsumption(client.getUid(), daily_consumption);
        });
      }else{
        print("client is invalid");
      }
    }catch(e){
      print(e.toString());
    }
  }
  
}