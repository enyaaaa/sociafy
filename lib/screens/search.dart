import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sociafy/screens/profile.dart';

import '../color/colors.dart';
import '../widgets/search_item.dart';

class Search extends StatefulWidget {
  final String uid;

  const Search({Key? key, required this.uid}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  //users input in search field
  String query = '';
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isNotEqualTo: widget.uid)
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, right: 15),
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
                                                      (snapshot.data!
                                                              as dynamic)
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
                              })));
                }),
          ],
        ));
  }

  //getting the app bar for search
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
