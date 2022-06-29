import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sociafy/models/myPost.dart';
import 'package:sociafy/providers/data.dart';
import 'package:sociafy/screens/profile.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';

class EditPost extends StatefulWidget {
  int i;
  Function socialScreenSetState;

  EditPost(
      {Key? key,
      required this.mypost,
      required this.i,
      required this.socialScreenSetState})
      : super(key: key);

  myPost mypost;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String caption = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    color: postItem,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      AssetImage(widget.mypost.userprofilePic),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.mypost.username,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 13),
                              ),
                              widget.mypost.location != ""
                                  ? Text(
                                widget.mypost.location!,
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 12),
                              )
                                  : SizedBox.shrink(),
                              Text(
                                timeago.format(widget.mypost.timeAgo),
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              color: primary,
                              onPressed: () => print('More'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    widget.mypost.caption != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              child: TextFormField(
                                initialValue: widget.mypost.caption!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add a caption"),
                                onChanged: (val) {
                                  caption = val;
                                },
                              ),
                            ))
                        : Padding(padding: EdgeInsets.only(top: 10)),
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
                          image: Image.file(File(widget.mypost.image)).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Edit Post",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: primary,
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: GestureDetector(
              onTap: () {
                myPostList().editPost(
                    myPost(
                        timeAgo: DateTime.now(),
                        caption: caption,
                        userprofilePic: widget.mypost.userprofilePic,
                        image: widget.mypost.image,
                        location: widget.mypost.location,
                        username: widget.mypost.username),
                    widget.i);
                widget.socialScreenSetState(() {});
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: textbutton,
                ),
              ),
            )))
      ],
    );
  }
}
