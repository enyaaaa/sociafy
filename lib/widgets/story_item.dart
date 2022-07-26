import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color/colors.dart';
import '../models/stories.dart';
import '../screens/view_story.dart';

//a list view of story item displaying horizontally on the home page
class story_item extends StatefulWidget {
  const story_item({Key? key}) : super(key: key);

  @override
  State<story_item> createState() => _story_itemState();
}

class _story_itemState extends State<story_item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          //itemCount: userstories.length,
          itemBuilder: (BuildContext context, int index) {
            //UserStories story = userstories[index];
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, bottom: 10, top: 10),
                child: Column(
                  children: [
                    Container(
                      width: 59,
                      height: 62,
                      child: Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // decoration: BoxDecoration(
                            //     shape: BoxShape.rectangle,
                            //     color: Colors.blueGrey,
                            //     borderRadius: BorderRadius.circular(10),
                            //     image: DecorationImage(
                            //         image: AssetImage(currentUser.image),
                            //         fit: BoxFit.cover),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.blueGrey,
                            //         offset: Offset(0, 2),
                            //         blurRadius: 8.0,
                            //       )
                            //     ]),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: primary),
                                child: Icon(
                                  Icons.add_circle,
                                  color: iconbutton,
                                  size: 20,
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                        width: 70,
                        child: Text(
                          "Your story",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                        ))
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => ViewStory(user: story)),
                      // );
                    },
                    child: Container(
                      width: 59,
                      height: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                          // image: DecorationImage(
                          //     image: AssetImage(story.userstory.image),
                          //     fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              offset: Offset(0, 2),
                              blurRadius: 8.0,
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // SizedBox(
                  //     width: 70,
                  //     child: Text(
                  //       story.userstory.username,
                  //       textAlign: TextAlign.center,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  //     ))
                ],
              ),
            );
          }),
    );
  }
}
