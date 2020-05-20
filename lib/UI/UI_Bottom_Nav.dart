import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/UI_Dashboard.dart' as first;
import 'package:Vainfitness/UI/UI_ConsumptionLst.dart' as second;
import 'package:Vainfitness/UI/UI_MealPlans.dart' as third;

import 'Profile_Drawer.dart';

void main() {
  runApp(
     MaterialApp(
      home:  Tabs(),
      routes: <String, WidgetBuilder> {}   
  )
  );
}

class Tabs extends StatefulWidget {
  @override
  
  MyTabState createState() =>  MyTabState();
}


class MyTabState extends State<Tabs> with SingleTickerProviderStateMixin {

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller =  TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Profile_Drawer(),
      bottomNavigationBar:  Material(
        color: Colors.redAccent[700],
        child:  TabBar(
          controller: controller,
          tabs: <Tab>[ 
             Tab(icon:  Icon(Icons.home)),
             Tab(icon:  Icon(Icons.favorite)),
             Tab(icon:  Icon(Icons.portrait)),  
          ] 
        )
      ),
      body:  TabBarView(
        controller: controller,
        children: <Widget>[
           first.UI_Dashboard(),
           second.UI_ConsumptionLst(),
           third.UI_MealPlans()
        ]
      )
    );
  }
}


