import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Consumption_Manager.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/forms/AddMeal.dart';
import 'package:Vainfitness/UI/forms/addMealPlan.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class UI_ConsumptionLst extends StatefulWidget {
  _UI_ConsumptionLstState createState() => _UI_ConsumptionLstState(); 
}

class _UI_ConsumptionLstState extends State<UI_ConsumptionLst>{
  
  Daily_Consumption todaysConsumption ;
	Client client = ProfileManager.getUser();
  
  List vainGridComp = [
    {
      'icon': const IconData(
        0xe836,
        fontFamily: 'VainIcons',
      ),
      'title': 'Plan your meal',
      'route': AddMeal(),
    },
    {
      'icon': const IconData(
        0xe80c,
        fontFamily: 'VainIcons',
      ),
      'title': 'Edit Meal Plan',
      'route': AddMeal()
    },

  ];

  Future removeMeal(DateTime consumpId, String mealId) async{
    try{
      var response  = await ConsumptionManager.deleteUserMeal(consumpId, mealId);
      setState(() {
        todaysConsumption;
      });
      if(response){
        final snackBar = SnackBar(content: Text("Meal Removed"));
        Scaffold.of(context).showSnackBar(snackBar); 
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

  Widget buildBoxTile(String title, IconData icon, Widget route) => InkWell(
	  onTap: () {
		  Navigator.push(
			  context,
			  MaterialPageRoute(builder: (BuildContext context) => route),
		  );
	  },
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCDDC39),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.white70,
              blurRadius: 6,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            //color: Color(0xFFCDDC39),
            color: Color(0xFF8D6E63),

            // GFColors.SUCCESS,
            size: 50,
          ),
//            Icon((icon),),
          Text(
            title,
            // style: const TextStyle(color: GFColors.WHITE, fontSize: 20),
            style: const TextStyle(color: Color(0xFF8D6E63), fontSize: 20),


          )
        ],
      ),
    ),
  );

  void fetchConsumptionList(){
		try{
      if(ProfileManager.isClient()){
			  setState(() {
				  todaysConsumption = client.getDailyConsumptionByDate(DateTime.now());
          
			  });
        print("---> Todays consumption");
        print(todaysConsumption.getMeals().length);
      }
		}catch(e){
			print(e.toString());
		}
	}
  Widget timelineCL(){
		return Container(
      child: cLtimelineModel(TimelinePosition.Left),
		  );
		
  }

  cLtimelineModel(TimelinePosition position) => Timeline.builder(
    shrinkWrap: true,
    itemBuilder: rightTimelineBuilder,
    itemCount: todaysConsumption != null? todaysConsumption.getMeals().length: 0,
    physics: position == TimelinePosition.Right
        ? ClampingScrollPhysics()
        : BouncingScrollPhysics(),
    position: position
  );

	TimelineModel rightTimelineBuilder(BuildContext context, int i) {
    final textTheme = Theme.of(context).textTheme;
		final Meal meal = todaysConsumption.getMeals()[i];
		return TimelineModel(
				Card(
					margin: EdgeInsets.symmetric(vertical: 16.0),
					shape:
					RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
					clipBehavior: Clip.antiAlias,
					child: Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							mainAxisSize: MainAxisSize.min,
							children: <Widget>[
								Image.asset('assets/images/meal_one.png'),
								const SizedBox(height: 8.0,),
								Text(todaysConsumption.getDate().toString(), style: textTheme.caption),
								const SizedBox(height: 8.0,),
								Text(
									meal.getName(),
									style: textTheme.bodyText1 ,
									textAlign: TextAlign.center,
								),
                const SizedBox(height: 8.0,),
								Text("Calories: "+meal.getTotalNutrients().getCalorie().toString(), style: textTheme.caption),
								const SizedBox(height: 8.0,),
                GFButton(
                  text: 'Remove',
                  color: Colors.red,
                  onPressed: () {
                    removeMeal(todaysConsumption.getDate(), meal.getId());
                  },
                ),
							],
						),
					),
				),
				position:	TimelineItemPosition.right,
				isFirst: i == 0,
				isLast: i == todaysConsumption.getMeals().length-1,
				iconBackground: Colors.lime,
				icon: Icon(VainIcons.food_and_restaurant)
		);
	}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchConsumptionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10) ,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: vainGridComp.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
//                    onTap: () {},
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (BuildContext context) =>
//                                AddMealPlan(),));

                    child: buildBoxTile(
                        vainGridComp[index]['title'],
                        vainGridComp[index]['icon'],
                        vainGridComp[index]['route']),
                  )
                ),
              ),
              timelineCL(),
            ],
          )
        ),
      ),
    );
  }
}