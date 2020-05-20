import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class ConsumptionManager{
  static DatabaseManager db = DatabaseManager();

  /// Add a meal to the clients account that was submitted
  /// Most preferably the current signed in client user should use this method
  static Future addUserMeal(Client client, Meal meal, DateTime date) async{
    try{
      print("--> Add Meal For User");
      if(client != null){
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
  static Future deleteUserMeal(Client client, DateTime consumpId, String mealId) async{
    try{
      print("--> Delete Meal For User");
      if(client != null){
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
  static Future updateUserMeal(Client client, DateTime consumpId, Meal meal) async{
    try{
      print("--> Update Meal For User");
      if(client != null){
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
  static Future updateUserDailyConsumptions(Client client) async{
    try{
      if(client != null){
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