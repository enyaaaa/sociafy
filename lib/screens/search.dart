import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/user.dart';

class Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserList Users = Provider.of<UserList>(context);
    return Scaffold(
      appBar: PreferredSize(
          child: getAppBar(),
          preferredSize: Size.fromHeight(60),
      ),
      // body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text( "Search",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: primary,
        ),
      ),
    );
  }
  // Widget getBody(){
  //   return ListView.builder(
  //     itemCount: Users.getUsersList().length,
  //       itemBuilder: (context, index) {
  //         Users currentPost = Users.getUsersList()[index];
  //
  //   },
  //   ))
  // }
}
