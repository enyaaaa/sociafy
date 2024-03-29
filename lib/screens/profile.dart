import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/screens/edit_profile.dart';
import 'package:sociafy/screens/media_post.dart';
import 'package:sociafy/screens/socia_post.dart';
import 'package:sociafy/screens/view_message.dart';
import 'package:sociafy/services/firestore_service.dart';

import '../color/colors.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //creating a variable
  var userData = {};
  var currentUser = {};

  //initialise post length, followers, following to default 0
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  //getting current users post and details
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();
      var postsnap = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: widget.uid)
          .get();

      postLen = postsnap.docs.length;
      userData = usersnap.data()!;
      followers = usersnap.data()!['followers'].length;
      following = usersnap.data()!['following'].length;
      isFollowing = usersnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: iconbutton, textColor: primary);
    }
    setState(() {
      isLoading = false;
    });
  }

  // create a chatroom, send user to the chatroom, other user details
  sendMessage() async {
    List<String> users = [
      FirebaseAuth.instance.currentUser!.email.toString(),
      userData['email']
    ];
    String chatRoomId = getChatRoomId(
        FirebaseAuth.instance.currentUser!.email.toString(), userData['email']);
    DateTime time = DateTime.now();

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
      "time": time,
    };

    FireStoreService().addChatRoom(chatRoom, chatRoomId);
    var otherUser = (await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: widget.uid)
            .get())
        .docs[0];

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  otherUser: otherUser,
                )));
  }

  //getting the chat room id with users email
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              child: getAppBar(),
              preferredSize: Size.fromHeight(60),
            ),
            body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, snapshot) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.only(left: 18, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                    userData["image"])),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: iconbutton),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: FirebaseAuth.instance
                                                            .currentUser!.uid ==
                                                        widget.uid
                                                    ? MaterialButton(
                                                        color: Colors.white,
                                                        elevation: 0,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => EditProfile(
                                                                    uid: FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)),
                                                          );
                                                        },
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          "Edit Profile",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              color: primary),
                                                        ),
                                                      )
                                                    : isFollowing
                                                        ? Row(
                                                            children: [
                                                              MaterialButton(
                                                                color:
                                                                    iconbutton,
                                                                elevation: 0,
                                                                onPressed: () {
                                                                  sendMessage();
                                                                },
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Text(
                                                                  "chat",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color:
                                                                          primary),
                                                                ),
                                                              ),
                                                              MaterialButton(
                                                                color: Colors
                                                                    .white,
                                                                elevation: 0,
                                                                onPressed:
                                                                    () async {
                                                                  await FireStoreService()
                                                                      .followUser(
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                    userData[
                                                                        'uid'],
                                                                  );

                                                                  setState(() {
                                                                    isFollowing =
                                                                        false;
                                                                    followers--;
                                                                  });
                                                                },
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Text(
                                                                  "Unfollow",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color:
                                                                          primary),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : MaterialButton(
                                                            color: iconbutton,
                                                            elevation: 0,
                                                            onPressed:
                                                                () async {
                                                              await FireStoreService()
                                                                  .followUser(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                userData['uid'],
                                                              );

                                                              setState(() {
                                                                isFollowing =
                                                                    true;
                                                                followers++;
                                                              });
                                                            },
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Text(
                                                              "Follow",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  color:
                                                                      primary),
                                                            ),
                                                          )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userData["name"],
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        userData["bio"] != ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 110),
                                                child: ReadMoreText(
                                                  userData["bio"],
                                                  trimLines: 2,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      " Show More ",
                                                  trimExpandedText:
                                                      " Show Less ",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    EdgeInsets.only(right: 0)),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  postLen.toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "Post",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  followers.toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "Followers",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  following.toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  "Following",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ];
                  },
                  body: Column(
                    children: [
                      Material(
                        child: TabBar(
                          labelColor: primary,
                          unselectedLabelColor: Colors.grey[400],
                          indicatorWeight: 1,
                          indicatorColor: primary,
                          tabs: [
                            Tab(text: 'media'),
                            Tab(text: 'socia'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            media(
                              uid: widget.uid,
                            ),
                            socia(
                              uid: widget.uid,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )));
  }

  Widget getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        userData['username'],
        style: TextStyle(
          color: primary,
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.qr_code_2_rounded,
            color: primary,
          ),
        ),
      ],
    );
  }
}
