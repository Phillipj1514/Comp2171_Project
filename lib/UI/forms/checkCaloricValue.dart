import 'package:Vainfitness/core/nutrition/Food.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckCaloricValue extends StatefulWidget{
  @override
  _CheckCaloricValueState createState() => _CheckCaloricValueState();

}

class _CheckCaloricValueState extends State<CheckCaloricValue>{
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  String measure = "NUMBER";

  String calorieResult = "The Calorie value is";

  List foodMeasure = [
    ["WEIGHT","Pound / lb"],
    ["NUMBER","Number count of item"]
  ];


  Future checkFoodCalorie()async{
    try{
      String name = nameController.text;
      double quantity = double.parse(quantityController.text);
      String foodmeasure  = measure; 
      Food food = new Food(name: name, quantity: quantity, measure: foodmeasure);
      Client client = ProfileManager.getUser();
      int calorie = await client.checkFoodCalorie(food);
      setState(() {
        calorieResult = "Total Calorie of food is "+ calorie.toString();
      });
    }catch(e){
      print(e.toString());
      setState(() {
        calorieResult = "Something went wrong!";
      });
    }

  }

  Widget foodForm(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Food Name',
                hintText: 'Enter the food name',
              ),
            )
          ),

          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: quantityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Food Quantity',
                hintText: 'Enter the food quantity',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),
          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: DropdownButton(
              hint: Text("Measure"),
              value: measure,
              items: foodMeasure.map((value) {
                return DropdownMenuItem(
                  child: Text(value[1],
                  textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: value[0],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  measure = value;  //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget result(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2.0
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //         <--- border radius here
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom:15),
            child: Text(calorieResult,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.cyan,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget controlButtons(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15, bottom:10),
            child:  ButtonTheme(
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Colors.blue,
                shape: StadiumBorder(),
                onPressed: () {
                  checkFoodCalorie();
                },
                child: Text("Check",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10, bottom:10),
            child:  ButtonTheme(
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Colors.red,
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          )
         
        ],
      ),
    );
  }
   
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:  AppBar(title:  Text("Check food calorie"), backgroundColor: Colors.amberAccent),
      body: Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  foodForm(),
                  result(),
                  controlButtons()
                  ],
                ),
              ),              
            ],
          ),
        ),
      ),
    );
  }

}