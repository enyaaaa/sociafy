import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/messages.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/widgets/drawer.dart';
import 'package:sociafy/widgets/message_item.dart';
import 'package:sociafy/widgets/search_item.dart';

class Message extends StatelessWidget {

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
      title: Padding(
        padding: const EdgeInsets.only(left: 80),
        child: Row(
          children: [
            Text("Messages", style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),),
            SizedBox(width: 90),
            SvgPicture.asset("assets/icon/add_new_message_icon.svg"),
          ],
        ),
      ),
    );
  }
  Widget getBody(){
    return Column(
      children: [
        search_item(),
        message_item(),
      ],
    );
  }
}

