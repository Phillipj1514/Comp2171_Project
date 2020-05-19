import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/firebase_services/auth.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class ProfileManager{
  /// The currently authenticated user
  User_Profile authenticatedUser;

  // Authentication object through firebase
  AuthService _auth =  AuthService();
  DatabaseManager db = DatabaseManager();
  
  // CONSTRUCTOR
  ProfileManager(this.authenticatedUser);
  
  // GETTERS
  User_Profile getUser() => this.authenticatedUser;

  // SETTERS
  void setUser(User_Profile user) => this.authenticatedUser = user;

  // MODIFIERS AND LOGIC
  /// Create a new client add the client to the database and creat an authentication
  Future createFitnessCoachProfile(String firstname, String lastname, String username, String email,
      int month, int day, int year, int age, double height, double weight, String password) async{
    try{
      if(this.authenticatedUser is Fitness_Coach){
        dynamic regUser = await _auth.registerUser(email, password);
        String uid = regUser.uid.toString();
        Fitness_Coach newCoach = new Fitness_Coach(uid, firstname, lastname, username, email, month, day, year, age, height, weight);
        db.addNewUser(newCoach);
      }else{
        print("access denied!");
      }
    }catch(e){
      print(e.toString());
    }
  }
  // creates a new coach along with its authentication and adding to the database
  Future createClientProfile(String firstname, String lastname, String username, String email,
      int month, int day, int year, int age, double height, double weight, double expectedWeight, int numDays,
      String password) async{
    try{
      if(this.authenticatedUser is Fitness_Coach){
        dynamic regUser = await _auth.registerUser(email, password);
        String uid = regUser.uid.toString();
        Client newClient = new Client(uid, firstname, lastname, username, email, month, day, year, age, height, weight, expectedWeight, numDays);
        db.addNewUser(newClient);
      }else{
        print("access denied!");
      }
    }catch(e){
      print(e.toString());
    }
  }
}