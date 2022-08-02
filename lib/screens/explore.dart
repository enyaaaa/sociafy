import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sociafy/screens/profile.dart';

import '../color/colors.dart';
import '../models/explore.dart';
import '../widgets/search_item.dart';

class Explore extends StatefulWidget {
  const Explore({
    Key? key,
  }) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  //set search input as an empty string
  String query = '';
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: isShowUsers
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, top: 10, right: 15),
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => Profile(
                                                        uid: (snapshot.data!
                                                                as dynamic)
                                                            .docs[index]['uid'],
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    (snapshot.data! as dynamic)
                                                        .docs[index]['image'],
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
                                                            (snapshot.data!
                                                                        as dynamic)
                                                                    .docs[index]
                                                                ['username'],
                                                        style: TextStyle(
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontFamily: "Poppins",
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                }))),
                  ],
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("posts").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: buildSearch(),
    );
  }

  //the search function to filter out users request
  Widget buildSearch() => search_item(
        text: query,
        onChanged: (val) {
          setState(() {
            query = val;
            isShowUsers = true;
          });
        },
        hintText: "Search",
      );
}
