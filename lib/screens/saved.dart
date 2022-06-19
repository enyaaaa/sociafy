import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';

class Saved extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text( "Saved",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        )
    );
  }
  Widget getBody(){
    return Scaffold(
      body: Center(child: Text('saved')),
    );
  }
}
