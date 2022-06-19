import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/widgets/drawer.dart';

class Notif extends StatelessWidget {

  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldkey,
      drawer:AppDrawer(),
      appBar: PreferredSize(
          child: getAppBar(),
          preferredSize: Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              scaffoldkey.currentState?.openDrawer();
            },
            icon: CircleAvatar(
              child: ClipOval(
                child: Image(
                  width: 30.0,
                  height: 30.0,
                  image: AssetImage(currentUser.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: Text( "Activity",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        )
    );
  }
  Widget getBody(){
    return Scaffold(
      body: Center(child: Text('notif')),
    );
  }
}
