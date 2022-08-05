import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sociafy/screens/explore.dart';
import 'package:sociafy/screens/home.dart';
import 'package:sociafy/screens/login.dart';
import 'package:sociafy/screens/message.dart';

class Rootpage extends StatefulWidget {
  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  //default page index to be the home page
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    //addData();
  }

  //main pages to navigate to
  List<Widget> children = [
    Home(uid: FirebaseAuth.instance.currentUser!.uid),
    Message(uid: FirebaseAuth.instance.currentUser!.uid),
    Explore(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return Scaffold(
                body: children[pageIndex],
                bottomNavigationBar: getFooter(),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Login();
        });
  }

  //navigation bar
  Widget getFooter() {
    List icons = [
      pageIndex == 0
          ? "assets/icon/home_active_icon.svg"
          : "assets/icon/home_icon.svg",
      pageIndex == 1
          ? "assets/icon/message_active_icon.svg"
          : "assets/icon/message_icon.svg",
      pageIndex == 2
          ? "assets/icon/explore_active_icon.svg"
          : "assets/icon/explore_icon.svg",
    ];
    return Container(
      width: double.infinity,
      height: 80,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 70, right: 70, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: SvgPicture.asset(
                  icons[index],
                  width: 27,
                ));
          }),
        ),
      ),
    );
  }

  //selected page that user have clicked on
  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
