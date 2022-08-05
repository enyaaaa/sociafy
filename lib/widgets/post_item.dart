import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/services/firestore_service.dart';
import 'package:sociafy/widgets/heart_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../screens/edit_post.dart';
import '../screens/view_post.dart';

class post_item extends StatefulWidget {
  final snap;
  final uid;

  const post_item({Key? key, required this.snap, required this.uid})
      : super(key: key);

  @override
  State<post_item> createState() => _post_itemState();
}

//post item displaying on the home page
class _post_itemState extends State<post_item> {
  bool isHeartAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getData();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      Fluttertoast.showToast(
          msg: err.toString(), backgroundColor: iconbutton, textColor: primary);
    }
  }

  deletePost(String postId) async {
    showDialog<Null>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete?'),
            backgroundColor: iconbutton,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await FireStoreService().deletePost(postId);
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
            ],
          );
        });
  }

  var userData = {};
  bool isLoading = false;

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            color: postItem,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.snap['image'].toString()),
                        radius: 16,
                      )),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["username"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 13),
                        ),
                        widget.snap["location"].toString() != ""
                            ? Text(
                                widget.snap["location"].toString(),
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 12),
                              )
                            : SizedBox.shrink(),
                        Text(
                          timeago.format(widget.snap["timeAgo"].toDate()),
                          style: TextStyle(fontFamily: "Poppins", fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  widget.snap['uid'].toString() == userData['uid']
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            PopupMenuButton<MenuValues>(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: primary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "edit",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  value: MenuValues.edit,
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete_outline_rounded,
                                        color: primary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "delete",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  value: MenuValues.delete,
                                ),
                              ],
                              child: Icon(
                                Icons.more_vert,
                                color: primary,
                              ),
                              onSelected: (value) {
                                switch (value) {
                                  case MenuValues.edit:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPost(
                                              postId: widget.snap['postId'],
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid),
                                        ));
                                    break;
                                  case MenuValues.delete:
                                    deletePost(
                                      widget.snap['postId'].toString(),
                                    );
                                }
                              },
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              widget.snap["caption"].toString() != ""
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        child: ReadMoreText(
                          widget.snap["caption"].toString(),
                          trimLines: 2,
                          textAlign: TextAlign.justify,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Show More ",
                          trimExpandedText: " Show Less ",
                          style: TextStyle(
                            fontSize: 14,
                            height: 2,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ))
                  : Padding(padding: EdgeInsets.only(left: 10, right: 15)),
              widget.snap["postUrl"] != ""
                  ? GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 0),
                            width: double.infinity,
                            height: 390.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: postbackground,
                                  offset: Offset(0, 1),
                                  blurRadius: 8.0,
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.snap["postUrl"].toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: isHeartAnimating ? 1 : 0,
                            child: HeartAnimation(
                              isAnimating: isHeartAnimating,
                              duration: Duration(milliseconds: 700),
                              child: SvgPicture.asset(
                                "assets/icon/like_active_icon.svg",
                                width: 60,
                              ),
                              onEnd: () => setState(
                                () => isHeartAnimating = false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onDoubleTap: () {
                        setState(() {
                          isHeartAnimating = true;
                        });
                        FireStoreService().likePost(
                          widget.snap['postId'].toString(),
                          userData['uid'],
                          widget.snap['likes'],
                        );
                      },
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => FireStoreService().likePost(
                              widget.snap['postId'].toString(),
                              userData['uid'],
                              widget.snap['likes'],
                            ),
                            icon: SvgPicture.asset(
                              widget.snap['likes'].contains(
                                userData['uid'],
                              )
                                  ? "assets/icon/like_active_icon.svg"
                                  : "assets/icon/like_icon.svg",
                              width: 27,
                            ),
                          ),
                          Text(
                            '${widget.snap['likes'].length}',
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 15),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPost(
                                        postId:
                                            widget.snap['postId'].toString(),
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid),
                                  ));
                            },
                            child: SvgPicture.asset(
                              "assets/icon/comment_icon.svg",
                              width: 27,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$commentLen',
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 15),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => FireStoreService().savePost(
                          widget.snap['postId'].toString(),
                          userData['uid'],
                          widget.snap['saved'],
                        ),
                        icon: SvgPicture.asset(
                          widget.snap['saved'].contains(
                            userData['uid'],
                          )
                              ? "assets/icon/save_active_icon.svg"
                              : "assets/icon/save_icon.svg",
                          width: 27,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

//values of the menus displaying when user click on the more icon
enum MenuValues {
  edit,
  delete,
}
