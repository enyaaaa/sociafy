import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/messages.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/widgets/drawer.dart';
import 'package:sociafy/widgets/message_item.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SafeArea(child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                width: 360,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: background
                ),
                child: TextField(
                  cursorColor: primary,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search direct message",
                      hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ),
                      prefixIcon: Icon(Icons.search,color: primary,)
                  ),
                  style: TextStyle(
                    color: primary,
                    fontFamily: "poppins",
                  ),
                ),
              ),
            ],
          )),
          Column(children: List.generate(messages.length, (index){
            final Faker faker = Faker();
            final date = Helpers.randomDate();
            return message_item(
              message: Messages(
                username: messages[index].username,
                userprofilePic: messages[index].userprofilePic,
                message: faker.lorem.sentence(),
                messageDate: date,
                dateMessage: Jiffy(date).fromNow(),
              ),
            );
          })
          ),
        ],
      ),
    );
  }
}

