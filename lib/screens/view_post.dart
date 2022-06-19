import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/post.dart';
import 'package:sociafy/screens/home.dart';
import 'package:sociafy/widgets/post_item.dart';

class ViewPost extends StatelessWidget {

  static route(Post data)=> MaterialPageRoute(
    builder: (context)=> ViewPost(
      post: data,
    ),
  );

  ViewPost({Key? key, required this.post}) : super(key: key);

  Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: viewPostBody(
        post: post,
      )
    );
  }
  Widget getAppBar(){
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text( "Comments",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: primary,
          ),
        )
    );
  }
}

class viewPostBody extends StatelessWidget {
  viewPostBody({Key? key, required this.post}) : super(key: key);

  Post post;

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(post.userprofilePic),
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
                              post.username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                  fontSize: 13
                              ),
                            ),
                            post.location != null
                                ? Text(post.location!,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12
                              ),
                            ): SizedBox.shrink(),
                            Text(
                              post.timeAgo,
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
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            color: primary,
                            onPressed: () => print('More'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  post.caption != null
                      ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        child: ReadMoreText(post.caption!,
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
                  post.image != null
                      ? Container(
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
                        image: AssetImage(post.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ): Padding(padding: EdgeInsets.only(left: 10, right: 15, top: 5)),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => print('Liked'),
                                icon: SvgPicture.asset(post.isliked ?"assets/icon/like_active_icon.svg" : "assets/icon/like_icon.svg" ,
                                  width: 27,),
                              ),
                              Text("${post.likecount}"),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(ViewPost.route(post));
                                }, child: SvgPicture.asset("assets/icon/comment_icon.svg", width: 27,),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("${post.likecount}"),
                            ],
                          ),
                          IconButton(
                            onPressed: () => print('Saved'),
                            icon: SvgPicture.asset(post.isliked ? "assets/icon/save_active_icon.svg" : "assets/icon/save_icon.svg",
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
}

