import 'package:Vainfitness/UI/forms/AddMeal.dart';
import 'package:Vainfitness/UI/forms/addCurrentPlanMeal.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/util/MealPlan_Manager.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMealPlan extends StatefulWidget{
  @override
  _AddMealPlanState createState() => _AddMealPlanState();
}

 class _AddMealPlanState extends State<AddMealPlan>{
   

  TextEditingController nameController = TextEditingController();
  TextEditingController numDaysController = TextEditingController();
  TextEditingController maxCalorieController = TextEditingController();

  String mealPlanId = "";
  String message = "";

  bool createMealPlan(){
    try{
      String name = nameController.text;
      String numDays = numDaysController.text;
      int maxCalorie = int.parse(maxCalorieController.text);
      if(ProfileManager.isFitnessCoach()){
        MealPlan mealPlan = new MealPlan.noMeals(name:name);
        MealPlan_List.addMealPlan(mealPlan);
        setState(() { mealPlanId = mealPlan.getId(); });
        return true;
      }else{ 
        final snackBar = SnackBar(content: Text("You need to be a coach!"));
        Scaffold.of(context).showSnackBar(snackBar); 
        }
    }catch(e){
      print(e.toString());
      final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
      Scaffold.of(context).showSnackBar(snackBar); 
    }
    return false;
  }

  Future addMealToPlan() async{
    try{
      bool mealPlanValid = true;
      if(mealPlanId == ""){
        mealPlanValid = createMealPlan();
      }
      if(mealPlanValid){
        final mealPlanID = await Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => AddCurrentPlanMeal(mealPlanId)));
      setState(() { mealPlanId = mealPlanID; });
      }
    }catch(e){
      print(e.toString());
      setState(() { message = "something went wrong!"; });
    }
  }

  Future saveMealPlan() async{
    try{
      bool mealPlanValid = true;
      if(mealPlanId == ""){
        mealPlanValid = createMealPlan();
      }
      if(mealPlanValid){
        var response = await MealPlanManager.addMealPlan(MealPlan_List.getMealPlanByID(mealPlanId));
        if(response){
          setState(() { message = "MealPlan Created Successfully"; });
        }else{setState(() { message = "something went wrong!"; });}
      }
    }catch(e){
      print(e.toString());
      setState(() { message = "something went wrong!"; });
    }
  }

  void setUpFields(){
    MealPlan mealPlan = MealPlan_List.getMealPlanByID(mealPlanId);
    nameController = TextEditingController(text: mealPlan.getName());
    numDaysController = TextEditingController(text: mealPlan.getNumDays().toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(mealPlanId == ""){
      MealPlanManager.loadMealPlanList().then((value) => null);
    }else{
      setUpFields();
    }
  }

  Widget mealElement(Meal meal) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Name: "+meal.getName(),
          style: TextStyle(
            fontSize: 18
            ),
          ),
          Text("Calorie: "+meal.getTotalNutrients().getCalorie().toString(),
          style: TextStyle(
            fontSize: 15
            ),
          ),
        ],
      ),
    );
  }

  Widget mealPlanDetails(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Name edit text 
          Padding(
            padding: EdgeInsets.only(top: 5, bottom:10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'MealPlan Name',
                hintText: 'Enter the mealplan name',
              ),
              
            )
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: numDaysController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number Of Days',
                hintText: 'Enter the number of days',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),

          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: maxCalorieController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Max Daily Calorie',
                hintText: 'Enter the maximum Daily Calorie',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),
        ],
      ),
    );
  }
  
  Widget meals(String mealPlanID){
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

           Text("Meals\n---------------- ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,

              ),
            ),

          // List of all the meals 
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MealPlan_List.getMealPlanByID(mealPlanID) != null ? 
                  MealPlan_List.getMealPlanByID(mealPlanID).getMealList().length: 0,
              itemBuilder: (BuildContext context, int index){
                return  mealElement(MealPlan_List.getMealPlanByID(mealPlanID).getMealList()[index]); 
              }
            ),

          // Adding button
          Padding(
            padding: EdgeInsets.only(top: 15, bottom:10),
            child:GestureDetector(
              onTap: () async{
                 await addMealToPlan();
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
                  saveMealPlan();
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
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(title:  Text("Add new Meal Plan"), backgroundColor: Colors.amberAccent),
      body: Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    mealPlanDetails(),
                    meals(mealPlanId),
                    controlButtons(),
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