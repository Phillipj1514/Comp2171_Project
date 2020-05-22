import 'package:flutter/material.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:getflutter/getflutter.dart';
import 'package:Vainfitness/UI/ClientProgressReport.dart';

class ViewClientList extends StatefulWidget {

  ViewClientList({Key key}): super(key:key);

  @override
  _ViewClientListState createState() => _ViewClientListState();
}

class _ViewClientListState extends State<ViewClientList> {
  static Future clientList;
  static List<String> clients;
  static int count;
  static Fitness_Coach bigcoach;
  Future fetchclients() async{
    //String result = "This meal plan have the meals: \n";
    try{
      if(ProfileManager.isFitnessCoach()){
        Fitness_Coach activeCoach =  ProfileManager.getUser();
        List<String> clientlst =  activeCoach.getClientsId();

        setState(() {
          _update(clientlst);
          count= clientlst.length;
          clientlst = clientlst;
          bigcoach = activeCoach;
        });
      }
    }catch(e){
      print(e.toString());
    }
  }
  
  void _update(clientLst) async{
    setState(()=>clientList = clientLst);
  
  }


  Widget ClientCard(Client client){
    return Container(
      child: Column( children: [
      GFCard(
        content: GFListTile(

          titleText: '${client.getFirstname()} ${client.getLastname()}',
          //subtitleText: 'Open source UI library',
          icon: Icon(Icons.account_circle ),
        ),
      ),
      GFButton(
        onPressed: () {
          Navigator.push( context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                //TODO: Progress report should probably take in a user so that we can get the specific report
                    ClientProgressReport(),
              )
          );
        },
        child: const Text(
          'Get Report',
        ),
        color: GFColors.PRIMARY,
        size: GFSize.LARGE,
        buttonBoxShadow: true,
      ),
      ]
    )

    );
  }

  Widget listOfAllClients(){
    return Container(
      child: FutureBuilder(
        future: clientList,
        builder: (context, clientSnap){

          if(clientSnap.hasData){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (context, i) {
                        //TODO Fix this such that we get the list of clients iterating
                        return ClientCard( bigcoach.getClientByIndex(i) );
                      }
                  )
                ]
              ),
            );
          }else if(clientSnap.hasError){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child:Text("Nothing to Show",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //List<MealPlan> insMp = MealPlan_List.mealPlanLst;
    return Scaffold(
        body: Container(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                listOfAllClients(),
              ],
            )
        )
    );
  }
}
























  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
