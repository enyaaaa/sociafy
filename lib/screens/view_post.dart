import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../models/post.dart';
import '../providers/data.dart';
import '../widgets/heart_animation.dart';

class ViewPost extends StatefulWidget {
  static route(
    Posts data,
  ) =>
      MaterialPageRoute(
        builder: (context) => ViewPost(
          post: data,
        ),
      );

  ViewPost({Key? key, required this.post}) : super(key: key);

  Posts post;

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: viewPostBody(
        post: widget.post,
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: "Type your message here...",
                  hintStyle: TextStyle(color: primary, fontFamily: "poppins"),
                  border: InputBorder.none),
              style: TextStyle(
                color: primary,
                fontFamily: "poppins",
              ),
              onSubmitted: (text) {
                final comment = Comments(
                  user: currentUser,
                  comment: text,
                  datetime: DateTime.now(),
                  isliked: false,
                );
                setState(() => comments.add(comment));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: iconbutton, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
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

class viewPostBody extends StatefulWidget {
  viewPostBody({Key? key, required this.post}) : super(key: key);

  Posts post;

  @override
  State<viewPostBody> createState() => _viewPostBodyState();
}

class _viewPostBodyState extends State<viewPostBody> {
  bool isHeartAnimating = false;

  //when user click into the comments of the post it will navigate to this scroll view displaying all the comments
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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
                                  image: AssetImage(widget.post.user.image),
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
                                widget.post.user.username,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 13),
                              ),
                              widget.post.location != null
                                  ? Text(
                                      widget.post.location!,
                                      style: TextStyle(
                                          fontFamily: "Poppins", fontSize: 12),
                                    )
                                  : SizedBox.shrink(),
                              Text(
                                timeago.format(widget.post.timeAgo),
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
                    widget.post.caption != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              child: ReadMoreText(
                                widget.post.caption!,
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
                        : Padding(
                            padding: EdgeInsets.only(left: 10, right: 15)),
                    GestureDetector(
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
                                image: AssetImage(widget.post.image),
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
                          widget.post.isliked = true;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.post.isliked =
                                          !widget.post.isliked;
                                    });
                                  },
                                  icon: SvgPicture.asset(
                                    widget.post.isliked
                                        ? "assets/icon/like_active_icon.svg"
                                        : "assets/icon/like_icon.svg",
                                    width: 27,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  "assets/icon/comment_icon.svg",
                                  width: 27,
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.post.issaved = !widget.post.issaved;
                                });
                              },
                              icon: SvgPicture.asset(
                                widget.post.issaved
                                    ? "assets/icon/save_active_icon.svg"
                                    : "assets/icon/save_icon.svg",
                                width: 27,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                    color: postItem,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 10, right: 15),
                        child: ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              Comments comment = comments[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.asset(
                                                  comment.user.image),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 180,
                                                child: Text(
                                                  comment.user.username,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                      fontSize: 13),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 180,
                                                child: Text(
                                                  comment.comment,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            comment.isliked = !comment.isliked;
                                          });
                                        },
                                        icon: SvgPicture.asset(
                                          comment.isliked
                                              ? "assets/icon/like_active_icon.svg"
                                              : "assets/icon/like_icon.svg",
                                          width: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
