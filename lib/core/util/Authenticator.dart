import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/firebase_services/auth.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class Authenticator{
  static AuthService _auth =  AuthService();
  static DatabaseManager db = DatabaseManager();

  static Future authenticateUser(String email, String password) async{
    try{  
      dynamic authUser = await _auth.signInUser(email, password);
      print("--> in authenticator authent");
      String uid = authUser.uid.toString();
      print(uid);
      User_Profile user = await db.fetchUser(uid);
      ProfileManager profileManager = new ProfileManager(user);
      return profileManager;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future logoutUser(ProfileManager profileManager) async{
    try{
      await profileManager.updateCurrentUser();
      await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}