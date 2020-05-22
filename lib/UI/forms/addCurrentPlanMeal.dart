import 'package:Vainfitness/core/nutrition/Food.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/util/Consumption_Manager.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddCurrentPlanMeal extends StatefulWidget {

  final String mealPlanId;
  AddCurrentPlanMeal(this.mealPlanId);
  
  @override
  _AddCurrentPlanMealState createState() => _AddCurrentPlanMealState();

}

class _AddCurrentPlanMealState extends State<AddCurrentPlanMeal> {

  List<Widget> foodFields = [];
  List<Map> foodControlers = [];
  List foodMeasure = [
    ["WEIGHT","Pound / lb"],
    ["NUMBER","Number count of item"]
  ];

  final _nameCtrl = TextEditingController();
  final _methodCtrl = TextEditingController();

  String message = "";

  Future addMealToMealPlan() async{
    try{
      String name = _nameCtrl.text;
      String method = _methodCtrl.text;
      Meal meal = new Meal(name: name, method: method);
      foodControlers.forEach((controller) async{ 
        String name = controller["name"].text;
        double quantity = double.parse(controller["quantity"].text); 
        String measure = controller["measure"];
        if(name.length > 0 && measure.length > 0  && quantity != null){
          Food food = new Food(name: name, quantity: quantity, measure: measure);
          await setState(() async{ await meal.addFoodItem(food); });
        }
      });
      if(ProfileManager.isFitnessCoach()){
        MealPlan_List.getMealPlanByID(widget.mealPlanId).addMeal(meal);
        Navigator.pop(context, widget.mealPlanId);
        
      }else{
        final snackBar = SnackBar(content: Text("Only Coaches Allowed!"));
        Scaffold.of(context).showSnackBar(snackBar); 
        }
    }catch(e){
      print(e.toString());
      final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
      Scaffold.of(context).showSnackBar(snackBar); 
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    addFoodField();
    super.initState();
  }

  void addFoodField(){
    int index = foodFields.length;
    setState(() {
      foodControlers.add({
      "num":foodFields.length+1,
      "name": new TextEditingController(),
      "quantity": new TextEditingController(),
      "measure":"NUMBER"
    });
      foodFields.add(foodField(foodControlers[index]["num"],
          foodControlers[index]["name"], foodControlers[index]["quantity"],
          foodControlers[index]["measure"]
        ));
    });
  }
  
  Widget foodField(int numCnt, var nameCtrl, var quantityCtrl, String measure){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom:15),
            child: Text("Food Item #"+numCnt.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom:15),
            child: TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Food Name',
                hintText: 'Enter the food name',
              ),
            )
          ),

          Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom:15),
            child: TextField(
              controller: quantityCtrl,
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
            padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom:15),
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

        ]
      )
    );
  }
  
  Widget mealDetails(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Name edit text 
          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Meal Name',
                hintText: 'Enter the meal name',
              ),
              
            )
          ),
          // Field for adding the method of preparation 
          // or any additional information about the meal
          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: _methodCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Method Of Preparation / additional details',
                hintText: 'Enter method of preparation',
              ),
            )
          )
        ],
      ),
    );
  }
  
  Widget foodItems(){
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
          // List of all the Food Forms
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foodFields.length,
              itemBuilder: (BuildContext context, int index){
                return  foodFields[index];
              }
            ),

          // Adding button
          Padding(
            padding: EdgeInsets.only(top: 15, bottom:10),
            child:GestureDetector(
              onTap: () {
                addFoodField();
              },
              child: ClipOval(
                child: Container(
                  color: Colors.blue,
                  height: 50.0, // height of the button
                  width: 50.0, // width of the button
                  child: Center(child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Add New Food',
                    ),
                  ),
                ),
              ),
            )
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
                onPressed: () async{
                  await addMealToMealPlan();
                },
                child: Text("Save",
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
                  Navigator.pop(context, widget.mealPlanId);
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
      appBar:  AppBar(title:  Text("Add Meal"), backgroundColor: Colors.amberAccent),
      body: Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    mealDetails(),
                    foodItems(),
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
  