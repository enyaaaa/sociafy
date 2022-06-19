import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: getAppBar(),
          preferredSize: Size.fromHeight(60),
      ),
    );
  }
  Widget getAppBar(){
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text( "Settings",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        )
    );
  }
}
