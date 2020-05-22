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
  List<Client> clients = [];

  Widget clientCard(Client client){
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
        future: ProfileManager.getCoachClients(),
        builder: (context, clientSnap){
          clients = clientSnap.data;
          if(clientSnap.hasData){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
<<<<<<< HEAD
                      itemCount: count,
                      itemBuilder: (context, i) {
                        //TODO Fix this such that we get the list of clients iterating
//                        return ClientCard( bigcoach.getClientByIndex(i) );
=======
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        return clientCard(clients[index]);
>>>>>>> 9e0a6559696424fde1234a821f718ad8be7c1d7a
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
      appBar:  AppBar(title:  Text("Coach Clients"), backgroundColor: Colors.amberAccent),
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
<<<<<<< HEAD



=======
>>>>>>> 9e0a6559696424fde1234a821f718ad8be7c1d7a
