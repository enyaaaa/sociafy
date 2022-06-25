import 'package:flutter/material.dart';
import 'package:sociafy/models/stories.dart';
import 'package:timeago/timeago.dart' as timeago;

class storyprofile_item extends StatelessWidget {
  UserStories user;
  DateTime date;

  storyprofile_item({
    Key? key,
    required this.user,
    required this.date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 85),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(user.userstory.image),
              ),
              SizedBox(
                width: 13,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text(
                    user.userstory.username,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.white
                    ),
                  ),
                  Text(
                    timeago.format(date),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ],
              ))
            ],
          ),
        ),
      );
}
