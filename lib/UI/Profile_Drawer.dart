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
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        GFDrawerHeader(
          currentAccountPicture: GFAvatar(
            radius: 80.0,
            backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"),
          ),
          otherAccountsPictures: <Widget>[
            Image(
              image: NetworkImage("https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg"),
              fit: BoxFit.cover,
            ),
            GFAvatar(
              child: Text("ab"),
            )
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('user name'),
              Text('user@userid.com'),
            ],
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: null,
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: null,
        ),
      ],
    ),
  );
  
}
