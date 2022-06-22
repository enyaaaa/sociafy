import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/providers/data.dart';


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
      body: Column(
        children: [
          ProfileHeader(),
        ],
      ),
    );
  }
  Widget getAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(widget.user.username,
        style: TextStyle(
            color: primary,
            fontFamily: "Poppins",
            fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget ProfileHeader(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 8,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(widget.user.image),
                ),
                SizedBox(width: 130,),
                Container(
                  width: 100,
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: iconbutton),
                  ),
                ),
                SizedBox(height: 8,),
                Text(widget.user.username,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(right: 110),
                  child: ReadMoreText(widget.user.bio,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show More ",
                    trimExpandedText: " Show Less ",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("${currentUser.totalFollower}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text("Followers",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15,),
                    Row(
                      children: [
                        Text("${currentUser.totalFollowing}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text("Following",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12
                          ),
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
    );
  }
}
