import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class ConsumptionManager{
  static DatabaseManager db = DatabaseManager();

  /// Add a meal to the clients account that was submitted
  /// Most preferably the current signed in client user should use this method
  static Future addUserMeal(ProfileManager profileManager, Meal meal, DateTime date) async{
    Client client;
    try{
      print("--> Add Meal For User");
      if(profileManager.isClient()){
        client = profileManager.getUser();
        Daily_Consumption consump = client.getDailyConsumptionByDate(date);
        if(consump == null){
          consump = new Daily_Consumption.dateTime(date);
          await db.addNewDailyConsumption(consump, client.getUid());
        }
        await db.addNewMeal(meal, client.getUid(), consump.getDate());
        client.addMealToConsumption(meal, date);
        
      }else{
        print("client is invalid");
      }
    }catch(e){
      print(e.toString());
    }
    return client;

  }

  /// Delete a meal from the consumption list for a specific day
  static Future deleteUserMeal(ProfileManager profileManager, DateTime consumpId, String mealId) async{
    Client client;
    try{
      print("--> Delete Meal For User");
      if(profileManager.isClient()){
        client = profileManager.getUser();
        await db.deleteMeal(client.getUid(), consumpId, mealId);
        client.deleteMealFromConsumption(mealId, consumpId);
        await db.updateDailyConsumption(client.getUid(), client.getDailyConsumptionByDate(consumpId));
      }else{
        print("client is invalid");
      }
    }catch(e){
      print(e.toString());
    }
    return client;
  }

  /// Update a meal in a specific daily consumption
  static Future updateUserMeal(ProfileManager profileManager, DateTime consumpId, Meal meal) async{
    Client client;
    try{
      print("--> Update Meal For User");
       if(profileManager.isClient()){
        client = profileManager.getUser();
        await db.updateMeal(client.getUid(), consumpId, meal);
        client.updateMealInConsumption(meal, consumpId);
        await db.updateDailyConsumption(client.getUid(), client.getDailyConsumptionByDate(consumpId));
      }else{
        print("client is invalid");
      }
    }catch(e){
      print(e.toString());
    }
    return client;
  }
  /// update all the daily consumption in the object to the database
  /// very slow inefficient, dont use alot 
  static Future updateUserDailyConsumptions(ProfileManager profileManager) async{
    try{
      print("--> updating user daily consumptions to database");
      if(profileManager.isClient()){
        Client client = profileManager.getUser();
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