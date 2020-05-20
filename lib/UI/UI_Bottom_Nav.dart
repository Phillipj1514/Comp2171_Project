import 'package:Vainfitness/UI/Custom_Icons.dart';
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
      appBar: 
        AppBar(
          centerTitle: true,
        
          title: 
            SizedBox(
              height: kToolbarHeight,
              child: Image.asset("assets/images/Logo_Blue_out.png"),
            ),
          leading:
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {Profile_Drawer();},
            ), 
        ),
      drawer: Profile_Drawer(),
      bottomNavigationBar:  Material(
        color: Colors.blue[700],
        child:  TabBar(
          controller: controller,
          tabs: <Tab>[ 
             Tab(icon:  Icon(Icons.dashboard)),
             Tab(icon:  Icon(CustomIcons.plan)),
             Tab(icon:  Icon(Icons.fastfood)),  
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


