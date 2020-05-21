import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/forms/updateUserProfile.dart';
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar:  AppBar(title:  Text("Profile Settings"), backgroundColor: Colors.amberAccent),
      body:  Container(
        child:  Center(
          child:  UpdateUserProfile(),
        )
      ),
    );
  }
}
