import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class media extends StatefulWidget {
  final String uid;

  const media({Key? key, required this.uid}) : super(key: key);

  @override
  State<media> createState() => _mediaState();
}

class _mediaState extends State<media> {
  @override
  Widget build(BuildContext context) {
    //if user does not have any post it will display a "no post yet"
    //when user post an image it will display as a grid view
    return Scaffold(
        body: FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return (snapshot.data! as dynamic).docs.length > 0
            ? GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      },
    ));
  }
}
