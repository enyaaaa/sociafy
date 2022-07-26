import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/screens/edit_profile.dart';
import 'package:sociafy/screens/media_post.dart';
import 'package:sociafy/screens/socia_post.dart';

import '../color/colors.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}):super (key:key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var userData = {};

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async{
    try{
      var snap = await FirebaseFirestore.instance.collection("users").doc(widget.uid).get();
      userData = snap.data()!;
      setState(() {});
    } catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: profileBody(uid: FirebaseAuth.instance.currentUser!.uid),
    );
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

//displaying users information displaying on this profile page and 2 tab bars that users can navigate to
class profileBody extends StatefulWidget {
  final String uid;
  const profileBody({Key? key, required this.uid}) : super(key: key);

  @override
  State<profileBody> createState() => _profileBodyState();
}

class _profileBodyState extends State<profileBody> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async{
    try{
      var userSnap = await FirebaseFirestore.instance.collection("users").doc(widget.uid).get();
      var postSnap = await FirebaseFirestore.instance.collection("post").where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

      userData = userSnap.data()!;
      setState(() {});
    } catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    profileHeader(context),
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
              // Expanded(
              //     child: TabBarView(
              //       children: [
              //         media(),
              //         socia(),
              //       ],
              //     ))
            ],
          ),
        ));
  }

  //profile header display
  Widget profileHeader(BuildContext context) {
    return Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage()
                    ),
                    SizedBox(
                      width: 130,
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border.all(color: iconbutton),
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                        color: Colors.white,
                        elevation: 0,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => EditProfile()),
                          // );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Edit Profile",
                          style:
                          TextStyle(fontFamily: "Poppins", color: primary),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 45,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(color: iconbutton),
                      ),
                      child: Center(
                          child: Icon(
                            Icons.more_horiz,
                            color: primary,
                            size: 20,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
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
                userData["bio"] != "" ? Padding(
                  padding: const EdgeInsets.only(right: 110),
                  child: ReadMoreText(
                    userData["bio"],
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show More ",
                    trimExpandedText: " Show Less ",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Poppins",
                    ),
                  ),
                ): Padding(padding: EdgeInsets.only(right: 0)),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        // Text(
                        //   "${currentUser.totalFollower}",
                        //   style: TextStyle(
                        //     fontFamily: "Poppins",
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(width: 5),
                        Text(
                          "Followers",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        // Text(
                        //   "${currentUser.totalFollowing}",
                        //   style: TextStyle(
                        //     fontFamily: "Poppins",
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(width: 6),
                        Text(
                          "Following",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 12),
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