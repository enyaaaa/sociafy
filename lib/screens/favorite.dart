import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/screens/view_post.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../models/post.dart';
import '../widgets/heart_animation.dart';
import '../widgets/post_item.dart';

class Favorite extends StatefulWidget {
  final String uid;
  const Favorite({Key? key, required this.uid}) : super(key: key);
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  //initial state to animating the heart icon to not displaying
  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      //creating a list builder
      //when user likes a post it will display on this page as a list view
      //when user unlike it will be remove from the page
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('posts')
              .where('likes', isEqualTo: widget.uid)
              .get(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => Container(
                        child: post_item(snap: snapshot.data!.docs[index].data(),),
                      )
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget getAppBar() {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Favorite",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        ));
  }
}
