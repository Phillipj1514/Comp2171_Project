import 'package:flutter/material.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
class ViewClientList extends StatefulWidget {

  ViewClientList({Key key}): super(key:key);

  @override
  _ViewClientListState createState() => _ViewClientListState();
}

class _ViewClientListState extends State<ViewClientList> {
  static Future clientList;

  Future fetchclients() async{
    //String result = "This meal plan have the meals: \n";
    try{
      if(ProfileManager.isFitnessCoach()){
        Fitness_Coach activeCoach =  ProfileManager.getUser();
        List<String> clientlst =  activeCoach.getClientsId();
        setState(() {
          _update(clientlst);
        });
      }
    }catch(e){
      print(e.toString());
    }
  }
  
  void _update(clientLst) async{
    setState(()=>clientList = clientLst);
  
  }
























  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
