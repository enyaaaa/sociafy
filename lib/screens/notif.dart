import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../models/notifs.dart';
import '../providers/data.dart';
import '../widgets/drawer.dart';

class Notif extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: AppDrawer(),
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: Column(
        children: [
          getNotifs(),
        ],
      ),
    );
  }

  Widget getAppBar() {
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
        title: Text(
          "Activity",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        ));
  }

  //displaying the notifications that user have receive from the post she have posted
  Widget getNotifs() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: ListView.builder(
            itemCount: notifs.length,
            itemBuilder: (BuildContext context, int index) {
              Notifs notif = notifs[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 59,
                          height: 62,
                          child: Stack(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(notif.user.image),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SvgPicture.asset(
                                    notif.icon,
                                    width: 20,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 180,
                              child: Text(
                                notif.user.username + " " + notif.notiftype,
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                timeago.format(notif.datetime),
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    notif.postreact != null
                        ? Container(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(notif.postreact!),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
