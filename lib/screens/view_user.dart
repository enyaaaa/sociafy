import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../color/colors.dart';
import '../models/user.dart';

class ViewUser extends StatefulWidget {
  User user;

  ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ProfileHeader(),
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
              ],
            ),
          )),
    );
  }

  Widget getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        widget.user.username,
        style: TextStyle(
          color: primary,
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //displaying the selected user profile
  Widget ProfileHeader() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.only(left: 18, bottom: 10),
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(widget.user.image),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.user.username,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                widget.user.bio != ""
                    ? Padding(
                        padding: const EdgeInsets.only(right: 110),
                        child: ReadMoreText(
                          widget.user.bio,
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Show More ",
                          trimExpandedText: " Show Less ",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Poppins",
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "${widget.user.totalFollower}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Followers",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "${widget.user.totalFollowing}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Following",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: iconbutton),
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                        elevation: 0,
                        color: widget.user.isFollowedbyMe
                            ? iconbutton
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            widget.user.isFollowedbyMe =
                                !widget.user.isFollowedbyMe;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          widget.user.isFollowedbyMe ? "Following" : "Follow",
                          style:
                              TextStyle(fontFamily: "Poppins", color: primary),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: iconbutton),
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                        color: Colors.white,
                        elevation: 0,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Message",
                          style:
                              TextStyle(fontFamily: "Poppins", color: primary),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
        ));
  }
}
