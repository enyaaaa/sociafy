import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociafy/services/firestore_service.dart';

import '../color/colors.dart';
import '../widgets/comment_item.dart';

class ViewPost extends StatefulWidget {
  final postId;
  final uid;

  ViewPost({Key? key, required this.postId, required this.uid})
      : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final TextEditingController commentController = TextEditingController();

  void postComment(String uid, String name, String image) async {
    try {
      String res = await FireStoreService().postComment(
        widget.postId,
        commentController.text,
        uid,
        name,
        image,
      );

      if (res != 'success') {
        Fluttertoast.showToast(msg: res, backgroundColor: iconbutton, textColor: primary);
      }
      setState(() {
        commentController.text = "";
      });
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString(), backgroundColor: iconbutton, textColor: primary);
    }
  }

  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var usersnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .get();

    userData = usersnap.data()!;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.postId)
              .collection('comments')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) => comment_item(
                          snap: snapshot.data!.docs[index],
                          uid: FirebaseAuth.instance.currentUser!.uid),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(userData['image']),
                          ),
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(Icons.close, color: primary),
                                    onTap: () {
                                      commentController.clear();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText:
                                      "Comment as ${userData['username']}",
                                  hintStyle: TextStyle(
                                      color: postbackground,
                                      fontFamily: "poppins"),
                                  border: InputBorder.none),
                              style: TextStyle(
                                color: primary,
                                fontFamily: "poppins",
                              ),
                              onSubmitted: (text) {},
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
                                onPressed: () => postComment(userData['uid'],
                                    userData['username'], userData['image']),
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
            );
          }),
    );
  }

  Widget getAppBar() {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Comments",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        ));
  }
}
