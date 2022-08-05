import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/post_item.dart';

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
    return FutureBuilder(
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
          return snapshot.data!.docs.length > 0
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => Container(
                                child: post_item(
                                    snap: snapshot.data!.docs[index].data(),
                                    uid:
                                        FirebaseAuth.instance.currentUser!.uid),
                              )),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      SvgPicture.asset(
                        "assets/icon/camera_icon.svg",
                        width: 70,
                      ),
                      Text(
                        'No Post Yet',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
        });
  }
}

//values of the menus displaying when user click on the more icon
enum MenuValues {
  edit,
  delete,
}
