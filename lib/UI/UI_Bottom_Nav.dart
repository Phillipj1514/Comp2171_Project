import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/UI_Dashboard.dart' as first;
import 'package:Vainfitness/UI/UI_ConsumptionLst.dart' as second;
import 'package:Vainfitness/UI/UI_MealPlans.dart' as first;
import 'package:Vainfitness/UI/UI_Dashboard.dart';
import 'package:Vainfitness/UI/UI_ConsumptionLst.dart';
import 'package:Vainfitness/UI/UI_MealPlans.dart';




void main() {
  runApp(
    new MaterialApp(
      home: new Tabs(),
      routes: <String, WidgetBuilder> {}   
  )
  );
}

class Tabs extends StatefulWidget {
  @override
  
  MyTabState createState() => new MyTabState();
}


class MyTabState extends State<Tabs> with SingleTickerProviderStateMixin {

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.tealAccent,
        child: new TabBar(
          controller: controller,
          tabs: <Tab>[ 
            new Tab(icon: new Icon(Icons.home)),
            new Tab(icon: new Icon(Icons.favorite)),
            new Tab(icon: new Icon(Icons.portrait)),  
          ] 
        )
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new first.Homepage(),
          new second.UI_ConsumptionLst(),
          new third.UI_MealPlans()
        ]
      )
    );
  }
}


