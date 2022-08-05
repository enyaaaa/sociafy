import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociafy/screens/search.dart';
import 'package:sociafy/screens/view_message.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/search_item.dart';

class Message extends StatefulWidget {
  final String uid;

  const Message({Key? key, required this.uid}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  //creating an empty string
  String query = '';
  var userData = {};
  bool isLoading = false;
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      userData = usersnap.data()!;
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: iconbutton, textColor: primary);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            key: scaffoldkey,
            drawer: AppDrawer(uid: FirebaseAuth.instance.currentUser!.uid),
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
                  image: NetworkImage(userData['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text(
            "Messages",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Search(uid: FirebaseAuth.instance.currentUser!.uid)),
              );
            },
            child: SvgPicture.asset("assets/icon/add_new_message_icon.svg"),
          ),
          SizedBox(
            width: 10,
          )
        ]);
  }

  //displaying the list of messages the user has chat with
  Widget getMessages() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("chatRoom").snapshots(),
      builder: (context, chatRoomSnapshot) {
        if (chatRoomSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<QueryDocumentSnapshot<Map<String, dynamic>>> chat = [];
        for (var snapshot in chatRoomSnapshot.data!.docs) {
          List usersList = snapshot["users"];
          if (usersList.contains(FirebaseAuth.instance.currentUser!.email)) {
            chat.add(snapshot);
          }
        }
        if (chat.isEmpty) {
          return Column(
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
                'Start chatting with your friends',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                ),
              ),
              MaterialButton(
                color: iconbutton,
                elevation: 0,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Search(uid: FirebaseAuth.instance.currentUser!.uid)));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Search Friends",
                  style: TextStyle(fontFamily: "Poppins", color: primary),
                ),
              ),
            ],
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: chat.length,
            itemBuilder: (BuildContext context, int index) {
              var currentChat = chat[index];
              String otherEmail = currentChat.id.split('_').where((email) {
                return email != FirebaseAuth.instance.currentUser!.email;
              }).toList()[0];
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: otherEmail)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var otherUser = snapshot.data!.docs[0];
                    if ((snapshot.data! as dynamic)
                        .docs[0]['username']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase())) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => Chat(
                              chatRoomId: currentChat.id,
                              otherUser: otherUser,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: chatbox,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.only(
                            top: 3,
                            bottom: 3,
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
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      otherUser["image"],
                                    ),
                                    radius: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          otherUser["username"],
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: SizedBox(
                                          width: 180,
                                          child: Text(
                                            timeago.format(
                                                chat[index]['time'].toDate()),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } return Container();
                  });
            },
          ),
        );
      },
    );
  }

  Widget buildSearch() => search_item(
        text: query,
        onChanged: (val) {
          setState(() {
            query = val;
          });
        },
        hintText: "Search Messages",
      );
}
