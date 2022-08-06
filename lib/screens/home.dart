import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociafy/screens/add_post.dart';
import 'package:sociafy/screens/search.dart';

import '../color/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/post_item.dart';

class Home extends StatefulWidget {
  final String uid;

  const Home({Key? key, required this.uid}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // key for validation of users input
  var key = GlobalKey<ScaffoldState>();

  //creating a variable
  var userData = {};

  //set initial loading to false
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  //getting current user
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: AppDrawer(uid: FirebaseAuth.instance.currentUser!.uid),
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }

  //user can open drawer when they click on the profile icon
  //add a post when user click on the add icon on the right
  //search for other users adn view their profile
  Widget getAppBar() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: () {
                  key.currentState?.openDrawer();
                },
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(userData['image']),
                  radius: 16,
                ),
              ),
            ),
            title: SvgPicture.asset("assets/logo.svg"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPost(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                            )),
                  );
                },
                child: SvgPicture.asset("assets/icon/add_post_icon.svg"),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search(
                            uid: FirebaseAuth.instance.currentUser!.uid)),
                  );
                },
                child: SvgPicture.asset("assets/icon/search_icon.svg"),
              ),
              SizedBox(width: 10),
            ],
          );
  }

  Widget getBody() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              //display stories that other users have posted
              //story_item(),
              Divider(
                color: primary.withOpacity(0.5),
              ),
              //display post that other users have posted
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(
                        FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List followingList = userSnapshot.data!["following"];
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var posts = snapshot.data!.docs.where((element) {
                          return followingList.contains(element["uid"]);
                        }).toList();

                        if (posts.isEmpty) {
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
                                'Start following your friends',
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
                                      builder: (context) => Search(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid)));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Search Friends",
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: primary),
                                ),
                              ),
                            ],
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) => Container(
                              child: post_item(
                                  snap: posts[index].data(),
                                  uid: FirebaseAuth.instance.currentUser!.uid),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ],
          );
  }
}
