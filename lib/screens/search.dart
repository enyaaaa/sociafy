import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sociafy/screens/profile.dart';
import 'package:sociafy/screens/view_user.dart';

import '../color/colors.dart';
import '../models/friends.dart';
import '../widgets/search_item.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    //friend = friends;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: getAppBar(),
          preferredSize: Size.fromHeight(60),
        ),
        body: Column(
          children: [
            buildSearch(),
            getFriends(),
          ],
        ));
  }

  Widget getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        children: [
          Text(
            "Search",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget getFriends() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                child: ListView.builder(
                    itemCount: (snapshot.data as dynamic).docs.length,
                    itemBuilder: (context, int index) {
                      if ((snapshot.data! as dynamic)
                          .docs[index]['username']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Profile(
                                        uid: (snapshot.data! as dynamic)
                                            .docs[index]['uid'],
                                      )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        (snapshot.data! as dynamic).docs[index]
                                            ['image'],
                                      ),
                                      radius: 16,
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
                                            "@" +
                                                (snapshot.data! as dynamic)
                                                    .docs[index]['username'],
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                                fontSize: 13),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['name'],
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: "Poppins",
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // Container(
                                //   height: 40,
                                //   decoration: BoxDecoration(
                                //       border: Border.all(color: iconbutton),
                                //       borderRadius: BorderRadius.circular(20)),
                                //   child: MaterialButton(
                                //     elevation: 0,
                                //     color: userfriends.isfollowedByMe
                                //         ? iconbutton
                                //         : Colors.white,
                                //     onPressed: () {
                                //       //change the state of the button
                                //       setState(() {
                                //         userfriends.isfollowedByMe =
                                //             !userfriends.isfollowedByMe;
                                //       });
                                //     },
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(20)),
                                //     child: Text(
                                //       //if user is followed by me it will display following if not it will display follow
                                //       userfriends.isfollowedByMe ? "Following" : "Follow",
                                //       style: TextStyle(
                                //           fontFamily: "Poppins", color: primary),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    })));
      },
    );
  }

  //users can search for items base on users username
  Widget buildSearch() => search_item(
        text: query,
        onChanged: (val) {
          setState(() {
            query = val;
          });
        },
        hintText: "Search Friends",
      );
}
