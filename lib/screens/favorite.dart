// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:readmore/readmore.dart';
// import 'package:sociafy/screens/view_post.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../color/colors.dart';
// import '../models/post.dart';
// import '../providers/data.dart';
// import '../widgets/heart_animation.dart';
//
// class Favorite extends StatefulWidget {
//   @override
//   State<Favorite> createState() => _FavoriteState();
// }
//
// class _FavoriteState extends State<Favorite> {
//   //initial state to animating the heart icon to not displaying
//   bool isHeartAnimating = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: getAppBar(),
//         preferredSize: Size.fromHeight(60),
//       ),
//       //creating a list builder
//       //when user likes a post it will display on this page as a list view
//       //when user unlike it will be remove from the page
//       body: Container(
//           child: ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Posts userpost = posts[index];
//                 return userpost.isliked
//                     ? Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 10.0),
//                           decoration: BoxDecoration(
//                               color: postItem,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Column(
//                             children: [
//                               Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 16),
//                                           child: Container(
//                                             width: 45,
//                                             height: 45,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                       userpost.user.image),
//                                                   fit: BoxFit.cover,
//                                                 )),
//                                           ),
//                                         ),
//                                         SizedBox(width: 10.0),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 userpost.user.username,
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: "Poppins",
//                                                     fontSize: 13),
//                                               ),
//                                               userpost.location != null
//                                                   ? Text(
//                                                       userpost.location!,
//                                                       style: TextStyle(
//                                                           fontFamily: "Poppins",
//                                                           fontSize: 12),
//                                                     )
//                                                   : SizedBox.shrink(),
//                                               Text(
//                                                 timeago
//                                                     .format(userpost.timeAgo),
//                                                 style: TextStyle(
//                                                     fontFamily: "Poppins",
//                                                     fontSize: 10),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             IconButton(
//                                               icon: Icon(Icons.more_vert),
//                                               color: primary,
//                                               onPressed: () => print('More'),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     userpost.caption != null
//                                         ? Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 16.0),
//                                             child: Container(
//                                               child: ReadMoreText(
//                                                 userpost.caption!,
//                                                 trimLines: 5,
//                                                 textAlign: TextAlign.justify,
//                                                 trimMode: TrimMode.Line,
//                                                 trimCollapsedText:
//                                                     " Show More ",
//                                                 trimExpandedText: " Show Less ",
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   height: 2,
//                                                   fontFamily: "Poppins",
//                                                 ),
//                                               ),
//                                             ))
//                                         : Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 10, right: 15)),
//                                     GestureDetector(
//                                       child: Stack(
//                                         alignment: Alignment.center,
//                                         children: [
//                                           Container(
//                                             margin: EdgeInsets.only(
//                                                 left: 10,
//                                                 right: 10,
//                                                 top: 10,
//                                                 bottom: 0),
//                                             width: double.infinity,
//                                             height: 390.0,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(25.0),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: postbackground,
//                                                   offset: Offset(0, 1),
//                                                   blurRadius: 8.0,
//                                                 ),
//                                               ],
//                                               image: DecorationImage(
//                                                 image:
//                                                     AssetImage(userpost.image),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                           Opacity(
//                                             opacity: isHeartAnimating ? 1 : 0,
//                                             child: HeartAnimation(
//                                               isAnimating: isHeartAnimating,
//                                               duration:
//                                                   Duration(milliseconds: 700),
//                                               child: SvgPicture.asset(
//                                                 "assets/icon/like_active_icon.svg",
//                                                 width: 60,
//                                               ),
//                                               onEnd: () => setState(
//                                                 () => isHeartAnimating = false,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       onDoubleTap: () {
//                                         setState(() {
//                                           isHeartAnimating = true;
//                                           userpost.isliked = true;
//                                         });
//                                       },
//                                     ),
//                                     Padding(
//                                       padding:
//                                           EdgeInsets.only(left: 10, top: 10),
//                                       child: Container(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 IconButton(
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       userpost.isliked =
//                                                           !userpost.isliked;
//                                                     });
//                                                   },
//                                                   icon: SvgPicture.asset(
//                                                     userpost.isliked
//                                                         ? "assets/icon/like_active_icon.svg"
//                                                         : "assets/icon/like_icon.svg",
//                                                     width: 27,
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               ViewPost(
//                                                                   post:
//                                                                       userpost)),
//                                                     );
//                                                   },
//                                                   child: SvgPicture.asset(
//                                                     "assets/icon/comment_icon.svg",
//                                                     width: 27,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             IconButton(
//                                               onPressed: () {
//                                                 setState(() {
//                                                   userpost.issaved =
//                                                       !userpost.issaved;
//                                                 });
//                                               },
//                                               icon: SvgPicture.asset(
//                                                 userpost.issaved
//                                                     ? "assets/icon/save_active_icon.svg"
//                                                     : "assets/icon/save_icon.svg",
//                                                 width: 27,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ]),
//                             ],
//                           ),
//                         ),
//                       )
//                     : SizedBox();
//               })),
//     );
//   }
//
//   Widget getAppBar() {
//     return AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Favorite",
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             color: primary,
//           ),
//         ));
//   }
// }
