import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';


class TimelineCL extends StatefulWidget {
	TimelineCL({Key key}) : super(key: key);

		@override
	_TimelineCLState createState() => _TimelineCLState();
}

class _TimelineCLState extends State<TimelineCL> {

	Daily_Consumption clientConsumption ;
	Client client = ProfileManager.getUser();

	Daily_Consumption updater (Daily_Consumption clientClst)=> this.clientConsumption = clientClst;

	void fetchConsumptionList() async {
		Daily_Consumption tempCL;
		try{
			tempCL =  client.getDailyConsumptionByDate(DateTime.now());
			setState(() {
				updater(tempCL);
			});

		} catch(e){
			print(e);
		}
	}
	
	@override
	Widget build(BuildContext context) {
		fetchConsumptionList();
		return Container(child: ListView(
				children: [
					const SizedBox(
						height: 10,
					),
					cLtimelineModel(TimelinePosition.Left),
				]
		)
		);
	}

	cLtimelineModel(TimelinePosition position) => Timeline.builder(
			itemBuilder: rightTimelineBuilder,
			itemCount: clientConsumption.getMeals().length,
			physics: position == TimelinePosition.Right
					? ClampingScrollPhysics()
					: BouncingScrollPhysics(),
			position: position);

	TimelineModel rightTimelineBuilder(BuildContext context, int i) {
		final Daily_Consumption clientDC = clientConsumption;
		final textTheme = Theme.of(context).textTheme;
		final Meal meals = clientDC.getMeal(i.toString());
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
								const SizedBox(
									height: 8.0,
								),
								Text({clientDC.getDate()}.toString(), style: textTheme.caption),
								const SizedBox(
									height: 8.0,
								),
								Text(
									//{clientDC.getMeal(i.toString()).getName()}.toString() ,
									meals.getName(),
									style: textTheme.bodyText1 ,
									textAlign: TextAlign.center,
								),
								const SizedBox(
									height: 8.0,
								),
							],
						),
					),
				),
				position:	TimelineItemPosition.right,
				isFirst: i == 0,
				isLast: i == clientDC.getMeals().length,
				iconBackground: Colors.lime,
				icon: Icon(VainIcons.food_and_restaurant)
		);
	}
}
