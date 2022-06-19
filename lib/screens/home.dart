import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sociafy/models/post.dart';
import 'package:sociafy/models/stories.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/screens/add_post.dart';
import 'package:sociafy/screens/search.dart';
import 'package:sociafy/widgets/drawer.dart';
import 'package:sociafy/widgets/post_item.dart';
import 'package:sociafy/widgets/story_item.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:scaffoldkey,
      drawer:AppDrawer(),
      appBar:PreferredSize(
          child: getAppBar(),
          preferredSize: Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () {
            scaffoldkey.currentState?.openDrawer();
          },
          icon: CircleAvatar(
            child: ClipOval(
              child: Image(
                width: 30.0,
                height: 30.0,
                image: AssetImage(currentUser.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      title: SvgPicture.asset("assets/logo.svg"),
      actions: [
        InkWell(
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPost()),
            );
          },
          child: SvgPicture.asset("assets/icon/add_post_icon.svg"),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          },
          child: SvgPicture.asset("assets/icon/search_icon.svg"),
        ),
        SizedBox(width: 10),
      ],
    );
  }
  Widget getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 10),
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
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(currentUser.image),
                                      fit: BoxFit.cover),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey,
                                      offset: Offset(0,2),
                                      blurRadius: 8.0,
                                    )
                                  ]
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primary
                                  ),
                                  child: Icon(Icons.add_circle,
                                    color: iconbutton,size: 20,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                          width: 70,
                          child: Text("Your story",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Row(children: List.generate(stories.length, (index){
                  return StoryItem(
                    stories: Stories(
                      image: stories[index].image,
                      username: stories[index].username,
                    ),
                  );
                })
                ),
              ],
            ),
          ),
          Divider(
            color: primary.withOpacity(0.5),
          ),
          Column(
            children: List.generate(posts.length, (index){
              return post_item(
                post: Post(
                  username: posts[index].username,
                  userprofilePic: posts[index].userprofilePic,
                  timeAgo: posts[index].timeAgo,
                  image: posts[index].image,
                  caption: posts[index].caption,
                  isliked: posts[index].isliked,
                  likecount: posts[index].likecount,
                  commentcount: posts[index].commentcount,
                  likedby: posts[index].likedby,
                  location: posts[index].location,
                  issaved: posts[index].issaved
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}