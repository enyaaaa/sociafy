import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sociafy/screens/view_message.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../models/messages.dart';
import '../providers/data.dart';
import '../widgets/drawer.dart';
import '../widgets/search_item.dart';

class Message extends StatefulWidget {
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  //creating an empty string
  String query = '';
  //list of user chats
  late List<UserChats> chat;
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    chat = chats;
  }

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
            buildSearch(),
            getMessages(),
          ],
        ));
  }


  Widget getAppBar() {
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
            Text(
              "Messages",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: primary,
              ),
            ),
            SizedBox(width: 90),
            SvgPicture.asset("assets/icon/add_new_message_icon.svg"),
          ],
        ),
      ),
    );
  }

  //displaying the list of messages the user has chat with
  Widget getMessages() {
    return Expanded(
      child: ListView.builder(
          itemCount: chat.length,
          itemBuilder: (BuildContext context, int index) {
            UserChats userchat = chat[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewMessage(
                    user: userchat.userchats,
                  ),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset(userchat.userchats.image,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  userchat.userchats.username,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: SizedBox(
                                  width: 180,
                                  child: Text(
                                    userchat.text,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 55,
                            child: Text(
                              timeago.format(userchat.datetime),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 9,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          userchat.unread
                              ? CircleAvatar(
                                  backgroundColor: iconbutton,
                                  radius: 10,
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildSearch() => search_item(
      text: query, onChanged: searchMessages, hintText: "Search Messages");

  void searchMessages(String query) {
    final chat = chats.where((userchat) {
      final titleLower = userchat.userchats.username.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.chat = chat;
    });
  }
}
