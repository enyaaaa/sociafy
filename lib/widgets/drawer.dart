import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../color/colors.dart';
import '../screens/favorite.dart';
import '../screens/profile.dart';
import '../screens/search.dart';
import '../screens/settings.dart';

class AppDrawer extends StatefulWidget {
  final String uid;

  const AppDrawer({Key? key, required this.uid}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final padding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      userData = usersnap.data()!;
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: iconbutton, textColor: primary
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Drawer(
            child: Material(
              child: ListView(
                padding: padding,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Profile(
                                uid: FirebaseAuth.instance.currentUser!.uid)));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(userData['image']),
                            ),
                            SizedBox(height: 10),
                            Text(
                              userData['username'],
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: primary,
                              ),
                            ),
                            Text(
                              userData['name'],
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
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 24, bottom: 24, top: 24),
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

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Profile(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)));
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

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Search(uid: FirebaseAuth
                                      .instance.currentUser!.uid)));
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

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Favorite(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                      )));
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

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Setting()));
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
