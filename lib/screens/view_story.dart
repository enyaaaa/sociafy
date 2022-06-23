import 'package:flutter/material.dart';
import 'package:sociafy/models/stories.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/providers/data.dart';

class ViewStory extends StatefulWidget {
 User user;

  ViewStory({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {

  late PageController controller;

  @override
  void initState(){
    super.initState();

    // final initialPage = userstories.indexOf(widget.user.username);
    // controller = PageController(initialPage: initialPage);
}

  @override
  Widget build(BuildContext context) => PageView(
    controller: controller,
  );
}
