import 'package:Vainfitness/UI/Settings.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';
import 'package:getflutter/components/drawer/gf_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';    

class Profile_Drawer extends StatefulWidget {
  @override
  _Profile_DrawerState createState() => _Profile_DrawerState();
}

class _Profile_DrawerState extends State<Profile_Drawer> {
  @override
  Widget build(
    BuildContext context
  ) => GFDrawer(
    color: Colors.white,
    child: ListView(
    padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Color(0xFFD685FF), Color(0xFF7466CC)])),
            height: 250,
            child: GFDrawerHeader(
              closeButton: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                    Icons.arrow_back,
                    color: Colors.amber,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [Color(0xFFD685FF), Color(0xFF7466CC)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const GFAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        'assets/images/avatar_woman.jpg',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'username',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ListTile(
          title: Text('Settings'),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                Settings(),
              ),
            );
          }
        ),
        ListTile(
          title: Text('Progress Report'),
          onTap: null,
        ),
      ],
    ),
  );
  
}
