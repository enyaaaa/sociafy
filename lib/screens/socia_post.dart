import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../color/colors.dart';
import '../widgets/heart_animation.dart';
import '../widgets/post_item.dart';
import 'edit_post.dart';

class socia extends StatefulWidget {
  final String uid;
  const socia({Key? key, required this.uid}) : super(key: key);

  @override
  State<socia> createState() => _sociaState();
}

class _sociaState extends State<socia> {
  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {

    //displaying users post in a list form, if user does not have any post it will display "no post yet"
    return  FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: widget.uid)
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
        });
  }
}

//values of the menus displaying when user click on the more icon
enum MenuValues {
  edit,
  delete,
}
