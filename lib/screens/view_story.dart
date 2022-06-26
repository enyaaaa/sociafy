import 'package:flutter/material.dart';

import '../models/stories.dart';
import '../providers/data.dart';
import '../widgets/storyview_item.dart';

class ViewStory extends StatefulWidget {
  UserStories user;

  ViewStory({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  late PageController controller;

  @override
  void initState() {
    super.initState();

    //bringing user to the story that user have click on
    final initialPage = userstories.indexOf(widget.user);
    controller = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //displaying user stories
  @override
  Widget build(BuildContext context) => PageView(
        controller: controller,
        children: userstories
            .map((user) => storyview_item(
                  user: user,
                  controller: controller,
                ))
            .toList(),
      );
}
