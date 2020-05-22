import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CreateUserProfile extends StatefulWidget{
  @override
  _CreateUserProfileState createState() => _CreateUserProfileState();
  
  }

class _CreateUserProfileState extends State<CreateUserProfile>{
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final expectedWController = TextEditingController();
  final numDaysController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime date;
  String message = "";

  Future createNewClient() async{
    try{
      String firstname = fnameController.text;
      String lastname = lnameController.text;
      String username = usernameController.text;
      String email = emailController.text;
      int age  = int.parse(ageController.text);
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
      double expectedWeight = double.parse(expectedWController.text);
      int numDays = int.parse(numDaysController.text);
      String password = passwordController.text;
      String passwordConfirm = confirmPassController.text;

      if(ProfileManager.isFitnessCoach()){
        if(passwordConfirm == password){
          var response = await ProfileManager.createClientProfile(
          firstname, lastname, username, email, date.month, date.day, date.year, age, height, weight, expectedWeight, numDays, password);
          if(response){
            final snackBar = SnackBar(content: Text("Client Profile created for "+username));
            Scaffold.of(context).showSnackBar(snackBar);
          }else{ 
            final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
            Scaffold.of(context).showSnackBar(snackBar); }
          
        }else{ 
          final snackBar = SnackBar(content: Text("password and confirgm password must be the same"));
          Scaffold.of(context).showSnackBar(snackBar);}
      }else{ 
        final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
        Scaffold.of(context).showSnackBar(snackBar); 
      }
    }catch(e){
      print(e.toString());
      final snackBar = SnackBar(content: Text("Something went wrong / network issue"));
      Scaffold.of(context).showSnackBar(snackBar);

      
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

           Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password (6 charater or more)',
                hintText: 'Enter the user password',
              ),
            )
          ),

           Padding(
            padding: EdgeInsets.only(top: 5, bottom:15),
            child: TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                hintText: 'Enter the user password again',
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
                  await createNewClient();
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
        appBar:  AppBar(title:  Text("Add new user"), backgroundColor: Colors.amberAccent),
        body: Container(
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
        ),
      );
  }

}