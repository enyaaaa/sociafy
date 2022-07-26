// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
//
// import '../models/myPost.dart';
//
// class media extends StatefulWidget {
//   const media({Key? key}) : super(key: key);
//
//   @override
//   State<media> createState() => _mediaState();
// }
//
// class _mediaState extends State<media> {
//   @override
//   Widget build(BuildContext context) {
//     //using a provider to read in the post that user has posted on their own account
//     myPostList myPosts = Provider.of<myPostList>(context);
//
//     //if user does not have any post it will display a "no post yet"
//     //when user post an image it will display as a grid view
//     return Scaffold(
//       body: myPosts.getmyPostList().length > 0
//           ? GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 2,
//                 mainAxisSpacing: 2,
//               ),
//               itemBuilder: (ctx, i) {
//                 myPost currentPost = myPosts.getmyPostList()[i];
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: Image.file(File(currentPost.image)).image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//               itemCount: myPosts.getmyPostList().length)
//           : Padding(
//               padding: const EdgeInsets.only(left: 140),
//               child: Column(
//                 children: [
//                   SizedBox(height: 50),
//                   SvgPicture.asset(
//                     "assets/icon/camera_icon.svg",
//                     width: 70,
//                   ),
//                   Text(
//                     'No Post Yet',
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
