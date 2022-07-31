import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/models/user.dart';

import '../color/colors.dart';
import '../provider/user_provider.dart';
import '../screens/favorite.dart';
import '../screens/profile.dart';
import '../screens/saved.dart';
import '../screens/search.dart';
import '../screens/settings.dart';

class AppDrawer extends StatelessWidget {

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

  Widget buildHeader(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Profile(uid: FirebaseAuth.instance.currentUser!.uid)));
        },
        child: Container(

          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userProvider.getUser.image),
              ),
              SizedBox(height: 10),
              Text(
                userProvider.getUser.username,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: primary,
                ),
              ),
              Text(
                userProvider.getUser.name,
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
  }

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.only(left: 10, right: 24, bottom: 24, top: 24),
    child: Wrap(
      runSpacing: 16, //vertical spacing
      children: [
        ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Profile(uid: FirebaseAuth.instance.currentUser!.uid)));
            }),
        ListTile(
            leading: Icon(Icons.search),
            title: Text(
              'Search',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Search()));
            }),
        ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text(
              'Favorite',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => Favorite()));
            }),
        ListTile(
            leading: Icon(Icons.star_border),
            title: Text(
              'Saved',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Saved()));
            }),
        Divider(color: primary),
        ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Settings()));
            })
      ],
    ),
  );
}