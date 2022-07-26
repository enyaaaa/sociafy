import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociafy/screens/login.dart';

import '../color/colors.dart';
import '../services/auth_service.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //initialise toggle button to display off
  bool valNotify1 = false;
  bool valNotify2 = false;

  onChangeFunction1(bool newValue1) {
    //when user click on the toggle button
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    //when user click on the toggle button
    setState(() {
      valNotify2 = newValue2;
    });
  }

  logout() {
    AuthService authService = AuthService();

    return authService.logout().then((value) {
      FocusScope.of(context).unfocus();
      Fluttertoast.showToast(msg: "Logout successfully :D");
      Navigator.pushAndRemoveUntil(
          (context), MaterialPageRoute(builder: (context) => Login()), (
          route) => false);
    }).catchError((e) {
      FocusScope.of(context).unfocus();
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  //displaying all the settings user when change
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: primary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primary,
                  ),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(height: 10),
            buildAccountOption(context, "Change Password"),
            buildAccountOption(context, "Edit Profile"),
            buildAccountOption(context, "Language"),
            buildAccountOption(context, "Privacy and Security"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.notifications_active,
                  color: primary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primary,
                  ),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOption(
                "Dark Theme", valNotify1, onChangeFunction1),
            buildNotificationOption(
                "Notifications", valNotify2, onChangeFunction2),
            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () {
                  logout();
                },
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        ));
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: primary,
                )),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: primary,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: textbutton,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }
}
