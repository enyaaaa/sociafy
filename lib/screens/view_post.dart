import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/services/firestore_service.dart';
import 'package:sociafy/widgets/post_item.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../models/post.dart';
import '../provider/user_provider.dart';
import '../widgets/comment_item.dart';
import '../widgets/heart_animation.dart';

class ViewPost extends StatefulWidget {
  final postId;
  ViewPost({Key? key, required this.postId}) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final TextEditingController commentController = TextEditingController();
  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await FireStoreService().postComment(
        widget.postId,
        commentController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        Fluttertoast.showToast(msg: res);
      }
      setState(() {
        commentController.text = "";
      });
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
                      ),
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
                            backgroundImage:
                                NetworkImage(userProvider.getUser.image),
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
                                      "Comment as ${userProvider.getUser.username}",
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
                                onPressed: () => postComment(
                                      userProvider.getUser.uid,
                                      userProvider.getUser.username,
                                      userProvider.getUser.image
                                ),
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
