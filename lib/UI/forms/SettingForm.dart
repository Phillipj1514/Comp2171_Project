import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SettingForm extends StatefulWidget{
  @override
  _SettingFormState createState() => _SettingFormState();
  
  }

class _SettingFormState extends State<SettingForm>{

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController expectedWController = TextEditingController();
  TextEditingController numDaysController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime date;
  String message = "";

  Future updateProfileDetails() async{
    try{
      String firstname = fnameController.text;
      String lastname = lnameController.text;
      String username = usernameController.text;
      String email = emailController.text;
      int age  = int.parse(ageController.text);
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
     
      if(ProfileManager.isClient()){
        double expectedWeight = double.parse(expectedWController.text);
        int numDays = int.parse(numDaysController.text);

        Client client =  ProfileManager.getUser();

        client.setFirstname(firstname);
        client.setLastname(lastname);
        client.setUsername(username);
        client.setEmail(email);
        client.setDOB(date.month, date.day, date.year);
        client.setAge(age);
        client.setHeight(height);
        client.setWeight(weight);
        client.setExpectedWeight(expectedWeight);
        client.setNumDays(numDays);
        ProfileManager.setUser(client);
        var response = await ProfileManager.updateCurrentUser();
        if(response){
          final snackBar = SnackBar(content: Text("Client Profile updated for "+username ));
          Scaffold.of(context).showSnackBar(snackBar);
        }else{ 
          final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
          Scaffold.of(context).showSnackBar(snackBar);
        } 
      }else if(ProfileManager.isFitnessCoach()){
        Fitness_Coach fitness_coach = ProfileManager.getUser();
        fitness_coach.setFirstname(firstname);
        fitness_coach.setLastname(lastname);
        fitness_coach.setUsername(username);
        fitness_coach.setEmail(email);
        fitness_coach.setDOB(date.month, date.day, date.year);
        fitness_coach.setAge(age);
        fitness_coach.setHeight(height);
        fitness_coach.setWeight(weight);
        ProfileManager.setUser(fitness_coach);
        var response = await ProfileManager.updateCurrentUser();
        if(response){
          final snackBar = SnackBar(content: Text("Coach Profile updated for "+username ));
          Scaffold.of(context).showSnackBar(snackBar);
        }else{ 
          final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
          Scaffold.of(context).showSnackBar(snackBar);
        } 

      }else { 
        final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
      final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void populateFields(){
    print("--> Inital state change");
    if(ProfileManager.isClient()){
      Client client = ProfileManager.getUser();
      fnameController = TextEditingController(text: client.getFirstname());
      lnameController = TextEditingController(text: client.getLastname());
      usernameController = TextEditingController(text: client.getUsername());
      emailController = TextEditingController(text: client.getEmail());
      ageController = TextEditingController(text: client.getAge().toString());
      heightController = TextEditingController(text: client.getHeight().toString());
      weightController = TextEditingController(text: client.getWeight().toString());
      expectedWController = TextEditingController(text: client.getExpectedWeight().toString());
      numDaysController = TextEditingController(text: client.getNumDays().toString());
      setState(() {
        date = client.getDOB();
      });
    }else if(ProfileManager.isFitnessCoach()){
      Fitness_Coach fitness_coach = ProfileManager.getUser();
      fnameController = TextEditingController(text: fitness_coach.getFirstname());
      lnameController = TextEditingController(text: fitness_coach.getLastname());
      usernameController = TextEditingController(text: fitness_coach.getUsername());
      emailController = TextEditingController(text: fitness_coach.getEmail());
      ageController = TextEditingController(text: fitness_coach.getAge().toString());
      heightController = TextEditingController(text: fitness_coach.getHeight().toString());
      weightController = TextEditingController(text: fitness_coach.getWeight().toString());
      setState(() {
        date = fitness_coach.getDOB();
      });


    }

   
  }

  Widget userCreationForm(){
     return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Name edit text 
          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: fnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
                hintText: 'Enter the user firstname',
              ),
              
            )
          ),

          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: lnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
                hintText: 'Enter the user lastname',
              ),
            )
          ),

          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Enter the user username',
              ),
            )
          ),

          Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter the user email',
              ),
            )
          ),

          DateTimeField(
            format: format,
            initialValue: date,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date Of birth',
                hintText: 'Enter the user date of birth',
              ),
            onChanged: (dt) => setState(() => date = dt),
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            },
          ),

          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
                hintText: 'Enter the user age',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),

          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: heightController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Height',
                hintText: 'Enter the user height',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),

          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: weightController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Weight',
                hintText: 'Enter the user weight',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),

          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: expectedWController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Expected Wright',
                hintText: 'Enter the user expected weight after workout',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            )
          ),

          Padding(
            padding: EdgeInsets.only( top: 5, bottom:15),
            child: TextField(
              controller: numDaysController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number Of Days',
                hintText: 'Enter number of days to loose weight',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
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
                  await updateProfileDetails();
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
  void initState() {
    super.initState();
    populateFields();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    userCreationForm(),
                    controlButtons()

                  ],
                ),
              ),              
            ],
          ),
        ),
      );
  }

}