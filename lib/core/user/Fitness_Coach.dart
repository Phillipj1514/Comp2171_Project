import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';

class Fitness_Coach extends User_Profile{
  // UNIQUE FITNESS COACH ATTRIBUTES__________

  /// The Fitness Coach is alowed to set and reset the Daily recommended
  /// caloric value for each MealPlan being created. 
  double recommendedDailyCaloricValue;

  /// A list containing all the clients a coach is responsible for.
  List allClientsId;
  
  // CONSTRUCTOR________________________________
  /// Default constructor for creating a Fitness Coach. 
  Fitness_Coach(String uid, String firstname, String lastname, String username,String email, 
    int month, int day, int year, int age, double height, double weight)
    :super(uid, firstname, lastname, username, email, month, day, year, age, height, weight){
      this.allClientsId = [];
    }
    

  //GETTERS FOR CLIENT___________________________

  /// Used to retrieve a list containing all the clients 
  /// a coach is responsible for.
  List getClientsId()=> this.allClientsId;

  // /// Used to retrieve a specific Client via their username.
  // Client getSpecificClient(String username){
  //   Client gotit;
  //   for(var client in allClients){
  //     if(client.getUsername() == username){
  //       gotit = client;
  //       break;
  //     }
  //   }
  //   return gotit;
  // }

  String getClientByIndex(int index){
    try{
      String tmp = allClientsId[index];
      return tmp;
    }catch(e){
      print(e.toString());
      print("client doesnt exist");
      return null;
    }
  }
  
  //MODIFIERS FOR CLIENT_______________________________

  /// Allows a Fitness Coach to Add a Client to his List of Clients
  void addClient(String clientId)=> this.allClientsId.add(clientId);

  /// Allows a client to be removed from the Client List given their username.
  void removeClientById(String clientId){
    try{
      allClientsId.remove(clientId);
    } catch(e){
      print(e.toString());
      print("client doesnt exist");
    }
  }

  void removeClint(int index){
    try{
      allClientsId.removeAt(index);
    } catch(e){
      print(e.toString());
      print("client doesnt exist");
    }
  }
  

  // SETTERS FOR MEALPLAN__________________________________
  /// Allows a FitnessCoach to update the Daily Recommended Caloric value.
  void setDailyRecommendedCaloricValue(double value)=> this.recommendedDailyCaloricValue = value;

  /// Before a MealPlan is created a check is done through this method 
  /// to ensure that the daily caloric value is not exceeded per day by any meal 
  /// in the proposed MealPlan. 
  bool checkMPAppropriateness(MealPlan mealPlan){
    List<bool> boolHolder = List();
    mealPlan.getMealList().forEach((meal) { 
      if(meal.getTotalNutrients().getCalorie()> this.recommendedDailyCaloricValue){
        return false;
      }
    });
    return true;
  }

  // GETTERS FOR MEALPLAN___________________________________
  /// Retrieves the Daily Recommended Caloric Value set by the Fitness Coach.
  double getRecommemdedCalVal()=>this.recommendedDailyCaloricValue;
  
  /// Retrieves a list of all Mealplans in the MealPlan List. 

  
  // MODIFIERS FOR MEALPLAN__________________________________
  /// Allows the FitnessCoach to add a new MealPlan to the global MealPlan List.
  /// Provided that the proposed MealPlan is appropriate.
  void createMealPlan(MealPlan mealplan){
    try{
      if(checkMPAppropriateness(mealplan) == true){
        MealPlan_List.addMealPlan(mealplan);
      }else{
        print("Meal Plan not appropriate");
      }      
    }catch(e){
      print(e.toString());
      print("meal plan wasnt added");
    }
  }

  /// Allows for the removal of a particular MealPlan from the Global MealPlan List 
  /// given an index.
  void removeMealPlanAt(int id)=> MealPlan_List.removeMealPlanAt(id);
    /// Allows for the removal of a particular MealPlan from the Global MealPlan List 
  /// given a MealPlan Object.
  void removeMealPlan(MealPlan mealplanObj) => MealPlan_List.removeMealPlan(mealplanObj);
  /// Allows for the removal of a particular MealPlan from the Global MealPlan List 
  /// given a MealPlan name.
  void removeMealPlanThroughName(String name) => MealPlan_List.removeMealPlanByName(name);

  //Database Manager methods
  Map<String, dynamic> mapify(){
    return {
      "id":this.uid,
      "type":"coach",
      "username":this.username,
      "email": this.email,
      "firstname": this.firstname,
      "lastname":this.lastname,
      "age": this.age,
      "DOB": this.dob,
      "height": this.height,
      "weight": this.weight,
      "date_created": this.dateCreated,
      "recommendedDailyCaloricValue":this.recommendedDailyCaloricValue,
      "clients": this.allClientsId
    };
  }
  
  Fitness_Coach.fromMap(Map mapdata):super.withDate(mapdata["id"],mapdata["firstname"],mapdata["lastname"], 
                mapdata["username"], mapdata["email"], new DateTime.fromMillisecondsSinceEpoch(mapdata["DOB"].millisecondsSinceEpoch), 
                mapdata["age"],mapdata["height"],mapdata["weight"],new DateTime.fromMillisecondsSinceEpoch(mapdata["date_created"].millisecondsSinceEpoch)){
    this.recommendedDailyCaloricValue = mapdata["recommendedDailyCaloricValue"];
    this.allClientsId = mapdata["clients"];
  }
}
// unit testing
void main(List<String> args) {
  Fitness_Coach tfc = new Fitness_Coach("sd23ek32k","Simon", "Peter","sp","s@p.com",1,1,1982,26,5,150);
  print(tfc.getName());
  print(tfc.getDOB().toString());

}
