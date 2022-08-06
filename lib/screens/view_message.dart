import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sociafy/services/firestore_service.dart';

import '../color/colors.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final QueryDocumentSnapshot<Map<String, dynamic>> otherUser;

  Chat({
    required this.chatRoomId,
    required this.otherUser,
  });

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> chats;

  //controller for text field
  TextEditingController controller = TextEditingController();

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                        "https://www.mindbrews.in/wp-content/uploads/2020/06/friend-interface-male-icon-with-png-and-vector-format-for-free-png-friend-512_512.png")),
                Text(
                  'Say Hello!',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(
              message: snapshot.data!.docs[index]["message"],
              time: snapshot.data!.docs[index]["time"],
              sendByMe: FirebaseAuth.instance.currentUser!.uid ==
                  snapshot.data!.docs[index]["sendBy"],
            );
          },
        );
      },
    );
  }

  //function to add a message
  addMessage() {
    if (controller.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": FirebaseAuth.instance.currentUser!.uid,
        "message": controller.text,
        'time': DateTime.now(),
      };

      FireStoreService().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        controller.text = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    chats = FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(widget.chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.otherUser["image"],
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.otherUser["username"],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icon/voice_call_icon.svg"),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icon/video_call_icon.svg"),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(Icons.close, color: primary),
                              onTap: () {
                                controller.clear();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Type your message here...",
                            hintStyle: TextStyle(
                                color: primary, fontFamily: "poppins"),
                            border: InputBorder.none),
                        style: TextStyle(
                          color: primary,
                          fontFamily: "poppins",
                        ),
                        onSubmitted: (text) {
                          addMessage();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: iconbutton,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () {
                            addMessage();
                          },
                          icon: Icon(
                            Icons.near_me,
                            size: 25,
                            color: primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final Timestamp time;

  MessageTile(
      {required this.message, required this.sendByMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0,
        ),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
            margin: sendByMe
                ? EdgeInsets.only(left: 30)
                : EdgeInsets.only(right: 30),
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            decoration: BoxDecoration(
                borderRadius: sendByMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomLeft: Radius.circular(23),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23),
                      ),
                gradient: LinearGradient(
                  colors: sendByMe
                      ? [Color(0xFFEBD8EE), Color(0xFFCDF3F1)]
                      : [Color(0xFFE2DDE2), Color(0xFFE9E1E1)],
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12, color: primary, fontFamily: "poppins"),
                ),
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(
                      fontSize: 10, color: primary, fontFamily: "poppins"),
                )
              ],
            )));
  }
}
