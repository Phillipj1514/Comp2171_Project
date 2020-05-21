import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/MealPlanDetail.dart';


class MealPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar:  AppBar(title:  Text("Profile Settings"), backgroundColor: Colors.amberAccent),
      body:  Container(
        child:  Center(
          child:  MealPlanDetails()
        )
      ),
    );
  }
}
