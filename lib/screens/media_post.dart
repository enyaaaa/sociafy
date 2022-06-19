import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/models/myMedia.dart';

class media extends StatefulWidget {
  const media({Key? key}) : super(key: key);

  @override
  State<media> createState() => _mediaState();
}

class _mediaState extends State<media> {

  @override
  Widget build(BuildContext context) {
    myPostList myPosts = Provider.of<myPostList>(context);

    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (ctx, i){
            myPost currentPost = myPosts.getmyPostList()[i];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: Image.file(File(currentPost.image)).image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          itemCount: myPosts.getmyPostList().length
      )
    );
  }
}
