import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';

class Fitness_Coach extends User_Profile{
  // UNIQUE FITNESS COACH ATTRIBUTES__________

  /// A list containing all the MealPlans created by the Fitness Coach.
  MealPlan_List allMealPlans = new MealPlan_List();

  /// The Fitness Coach is alowed to set and reset the Daily recommended
  /// caloric value for each MealPlan being created. 
  double recommendedDailyCaloricValue;

  /// A list containing all the clients a coach is responsible for.
  List<Client> allClients;
  
  // CONSTRUCTOR________________________________
  /// Default constructor for creating a Fitness Coach. 
  Fitness_Coach(String firstname, String lastname, String username, 
    String password, int month, int day, int year, int age, double height, double weight)
    :super(firstname, lastname, username, password, month, day, year, age, height, weight){
      this.allClients = List<Client>();
      this.allMealPlans = new MealPlan_List();
    }
    

  //GETTERS FOR CLIENT___________________________

  /// Used to retrieve a list containing all the clients 
  /// a coach is responsible for.
  List<Client> getClients()=> this.allClients;

  /// Used to retrieve a specific Client via their username.
  Client getSpecificClient(String username){
    Client gotit;
    for(var client in allClients){
      if(client.getUsername() == username){
        gotit = client;
        break;
      }
    }
    return gotit;
  }

  Client getClientByIndex(int index){
    Client tmp;
    try{
      tmp = allClients[index];
    }on Exception catch(e){
      print('Exception details:\n $e');
    }
    return tmp;
  }
  
  //MODIFIERS FOR CLIENT_______________________________

  /// Allows a Fitness Coach to Add a Client to his List of Clients
  void addClient(Client client)=> allClients.add(client);

  /// Allows a client to be removed from the Client List given their username.
  Future<void> removeClientThroughName(String clientName) async {
    try{
      allClients.forEach((clienT) {if(super.getUsername() == clientName){allClients.remove(clienT);}});
    } catch(e, s){
      print("$e \n $s");
    }
  }

  Future<void> removeClint(Client clientObj) async {
    try{
      allClients.remove(clientObj);
    } catch(e, s){
      print("$e \n $s");
    }
  }
  
  ///Allows a Fitness Coach to create a userProfile for a client 
  void createClientProfile(String uid, String firstname, String lastname, String username, 
   int month, int day, int year, int age, double height, 
    double weight, double expectedWeight, int numDays){
    // Creating the new client object with the new clients details
    Client myClients = Client(uid, firstname,  lastname,  username, 
     month, day, year, age, height, weight, expectedWeight, numDays);
     addClient(myClients);
     //Establish a profile for the created user
  }

  // SETTERS FOR MEALPLAN__________________________________
  /// Allows a FitnessCoach to update the Daily Recommended Caloric value.
  void setDailyRecommendedCaloricValue(double value)=> this.recommendedDailyCaloricValue = value;

  /// Before a MealPlan is created a check is done through this method 
  /// to ensure that the daily caloric value is not exceeded per day by any meal 
  /// in the proposed MealPlan. 
  bool checkMPAppropriateness(MealPlan preMP, double recDailyCalVal, int daysPlanWillLast){
    List<bool> boolHolder = List();
    double calValPerDay;

    for( int i=0; i<=daysPlanWillLast;i++){
      preMP.getMealList()[i].getFoods().forEach((fooditems) {calValPerDay += fooditems.getCalorie(); });
      if(calValPerDay> recDailyCalVal){
        boolHolder.add(false);
      }else{
        boolHolder.add(true);
      }
    }

    if(boolHolder.contains(false)){
      return false;
    }else{
      return true;
    }
  }

  // GETTERS FOR MEALPLAN___________________________________
  /// Retrieves the Daily Recommended Caloric Value set by the Fitness Coach.
  double getRecommemdedCalVal()=>this.recommendedDailyCaloricValue;
  /// Retrieves a list of all Mealplans in the MealPlan List. 
  MealPlan_List viewMealPlans()=> this.allMealPlans;

  
  // MODIFIERS FOR MEALPLAN__________________________________
  /// Allows the FitnessCoach to add a new MealPlan to the global MealPlan List.
  /// Provided that the proposed MealPlan is appropriate.
  void createMealPlan(MealPlan mealplan){
    int days = mealplan.getNumDays();
    double calValPerDay = getRecommemdedCalVal();
    bool appropriate = checkMPAppropriateness(mealplan, calValPerDay, days);
    try{

      MealPlan newMealPlan = mealplan;
      allMealPlans.addMealPlan(newMealPlan);
    }catch(e, s){
      print("$e \n $s");
    }
  }

  /// Allows for the removal of a particular MealPlan from the Global MealPlan List 
  /// given an index.
  void removeMealPlanAt (int id)=> allMealPlans.removeMealPlanAt(id);
    /// Allows for the removal of a particular MealPlan from the Global MealPlan List 
  /// given a MealPlan Object.
  void removeMealPlan(MealPlan mealplanObj) => allMealPlans.removeMealPlan(mealplanObj);
  /// Allows for the removal of a particular MealPlan from the Global MealPlan List 
  /// given a MealPlan name.
  void removeMealPlanThroughName(String name) => allMealPlans.removeMealPlanThroughName(name);

  
  Map<String, dynamic> mapify(){
    return {
      "id":this.uid,
      "type":"coach",
      "username":this.username,
      "firstname": this.firstname,
      "lastname":this.lastname,
      "age": this.age,
      "DOB": this.dob,
      "height": this.height,
      "weight": this.weight,
      "date_created": this.dateCreated,
      "recommendedDailyCaloricValue":this.recommendedDailyCaloricValue,
      "clients": [for (var client in this.allClients) client.getUid()]
    };
  }
  Fitness_Coach.fromMap(Map mapdata):super.withDate(mapdata["id"],mapdata["firstname"],mapdata["lastname"], 
                mapdata["username"],new DateTime.fromMillisecondsSinceEpoch(mapdata["DOB"].millisecondsSinceEpoch), 
                mapdata["age"],mapdata["height"],mapdata["weight"],new DateTime.fromMillisecondsSinceEpoch(mapdata["date_created"].millisecondsSinceEpoch)){
    this.recommendedDailyCaloricValue = mapdata["recommendedDailyCaloricValue"];
  }
}
// unit testing
void main(List<String> args) {
  Fitness_Coach tfc = new Fitness_Coach("sd23ek32k","Simon", "Peter","sp",1,1,1982,26,5,150);
  print(tfc.getName());
  print(tfc.getDOB().toString());
  tfc.createClientProfile("John","Paul","jp","pswd",3,12,1990,30,5,160,140,20);

  //print(tfc.getClientByIndex(0));
  print(tfc.getClientByIndex(0).getName());
}
