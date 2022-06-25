import 'package:flutter/material.dart';
import 'package:sociafy/models/stories.dart';
import 'package:sociafy/widgets/storyview_item.dart';

import '../providers/data.dart';

class ViewStory extends StatefulWidget {
  UserStories user;

  ViewStory({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {

  late PageController controller;

  @override
  void initState(){
    super.initState();

    final initialPage = userstories.indexOf(widget.user);
    controller = PageController(initialPage: initialPage);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView(
    controller: controller,
    children: userstories.map((user) => storyview_item(
        user: user,
        controller: controller,
      )).toList(),
  );
}
