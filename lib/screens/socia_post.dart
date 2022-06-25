import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/myPost.dart';
import 'package:sociafy/providers/data.dart';
import 'package:sociafy/widgets/heart_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

class socia extends StatefulWidget {
  const socia({Key? key}) : super(key: key);

  @override
  State<socia> createState() => _sociaState();
}

class _sociaState extends State<socia> {

  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    myPostList myPosts = Provider.of<myPostList>(context);

    void removePhoto(i){
      showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: Text('Are you sure you want to delete?'),
              backgroundColor: iconbutton,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              actions: [
                TextButton(onPressed: (){
                  setState(() {
                    myPosts.getmyPostList().removeAt(i);
                  });
                  Navigator.of(context).pop();
                }, child: Text('Yes')),
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('No')),
              ],
            );
          });
    }

    return  Container(
        child: myPosts.getmyPostList().length > 0 ? ListView.builder(
            itemCount: myPosts.getmyPostList().length,
            itemBuilder: (ctx, i){
              myPost mypost = myPosts.getmyPostList()[i];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      color: postItem,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(currentUser.image),
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentUser.username,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                              fontSize: 13
                                          ),
                                        ),
                                        mypost.location != ""
                                            ? Text(mypost.location!,
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12
                                          ),
                                        ): SizedBox.shrink(),
                                        Text(
                                          timeago.format(mypost.timeAgo),
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 10
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      PopupMenuButton<MenuValues>(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                                        ),
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit, color: primary,),
                                                SizedBox(width: 5,),
                                                Text("edit",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12
                                                ),),
                                              ],
                                            ),value: MenuValues.edit,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_outline_rounded, color: primary,),
                                                SizedBox(width: 5,),
                                                Text("delete",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12
                                                  ),),
                                              ],
                                            ),value: MenuValues.delete,
                                          ),
                                        ],
                                        child: Icon(
                                          Icons.more_vert,
                                          color: primary,
                                        ),
                                        onSelected: (value){
                                          switch (value){
                                            case MenuValues.edit:
                                              break;
                                            case MenuValues.delete:
                                              removePhoto(i);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            mypost.caption != ""
                                ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  child: ReadMoreText(mypost.caption!,
                                    trimLines: 5,
                                    textAlign: TextAlign.justify,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: " Show More ",
                                    trimExpandedText: " Show Less ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 2,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                )
                            ): Padding(padding: EdgeInsets.only(left: 10, right: 15)),
                            GestureDetector(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 10 ,bottom: 0),
                                    width: double.infinity,
                                    height: 390.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: postbackground,
                                          offset: Offset(0, 1),
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: Image.file(File(mypost.image)).image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: isHeartAnimating ? 1 : 0,
                                    child: HeartAnimation(
                                      isAnimating: isHeartAnimating,
                                      duration: Duration(milliseconds: 700),
                                      child: SvgPicture.asset("assets/icon/like_active_icon.svg", width: 60,),
                                      onEnd: () => setState(() => isHeartAnimating = false,
                                      ),
                                    ),),
                                ],
                              ),
                              onDoubleTap: (){
                                setState(() {
                                  isHeartAnimating = true;
                                  mypost.isliked = true;
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              mypost.isliked =
                                              !mypost.isliked;
                                            });
                                          },
                                          icon: SvgPicture.asset(mypost.isliked ?"assets/icon/like_active_icon.svg" : "assets/icon/like_icon.svg" ,
                                            width: 27,),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          // onTap: (){
                                          //   Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(builder: (context) => ViewPost(post: mypost)),
                                          //   );},
                                          child: SvgPicture.asset("assets/icon/comment_icon.svg", width: 27,),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          mypost.issaved =
                                          !mypost.issaved;
                                        });
                                      },
                                      icon: SvgPicture.asset(mypost.issaved ? "assets/icon/save_active_icon.svg" : "assets/icon/save_icon.svg",
                                        width: 27,),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]
                      ),
                    ],
                  ),
                ),
              );
            }
        ):
        Column(
          children: [
            SizedBox(height: 80,),
            SvgPicture.asset("assets/icon/camera_icon.svg", width: 70,),
            Text('No Post Yet',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
          ],
        ),
    );
  }
}

enum MenuValues{
  edit,
  delete,
}
