import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/screens/favorite.dart';
import 'package:sociafy/screens/profile.dart';
import 'package:sociafy/screens/saved.dart';
import 'package:sociafy/screens/search.dart';
import 'package:sociafy/screens/settings.dart';

class AppDrawer extends StatelessWidget {
  static String routeName = '/';

  final padding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: padding,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
  Widget buildHeader(BuildContext context) => Material(
    child: InkWell(
      onTap: () {
        Navigator.pop(context);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Profile()
        ));
      },
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(currentUser.image),
            ),
            SizedBox(height: 10),
            Text(
              currentUser.username,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            Text(
              currentUser.name,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.only(left: 10, right: 24, bottom: 24, top: 24),
    child: Wrap(
      runSpacing: 16, //vertical spacing
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),),
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Profile()
            ));
          }
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('Search',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Search()
              ));
            }
        ),
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('Favorite',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Favorite()
              ));
            }
        ),
        ListTile(
          leading: Icon(Icons.star_border),
          title: Text('Saved',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Saved()
              ));
            }
        ),
        Divider(color: primary),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings()
              ));
            }
        )
      ],
    ),
  );
}
