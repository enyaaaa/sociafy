import 'package:flutter/material.dart';
import 'package:sociafy/models/stories.dart';
import 'package:sociafy/screens/view_story.dart';

class StoryItem extends StatelessWidget {
  StoryItem({Key? key, required this.stories,}) : super(key: key);

  Stories stories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.push(
                context, MaterialPageRoute(
                builder: (context)=> ViewStory())),
            child: Container(
              width: 59,
              height: 62,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(stories.image),
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
          ),
          SizedBox(height: 8,),
          SizedBox(
              width: 70,
              child: Text(stories.username,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12
                ),
              )
          )
        ],
      ),
    );
  }
}
