import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

class comment_item extends StatefulWidget {
  final snap;
  const comment_item({Key? key, required this.snap}) : super(key: key);

  @override
  State<comment_item> createState() => _comment_itemState();
}

class _comment_itemState extends State<comment_item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.snap.data()['image'],),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      widget.snap.data()['username'],
                      style: TextStyle(
                          overflow:
                          TextOverflow.ellipsis,
                          fontWeight:
                          FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: ReadMoreText(
                      widget.snap.data()['comment'],
                      trimLines: 1,
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
                  ),
                  Row(
                    children: [
                      Text(
                        timeago.format(widget.snap["timeAgo"].toDate()),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 10),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "10 likes",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                //comment.isliked = !comment.isliked;
              });
            },
            icon: SvgPicture.asset(
              //comment.isliked
              //? "assets/icon/like_active_icon.svg"
              //:
              "assets/icon/like_icon.svg",
              width: 15,
            ),
          ),
        ],
      ),
    );
  }
}
