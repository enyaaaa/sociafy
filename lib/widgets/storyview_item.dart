import 'package:flutter/material.dart';
import 'package:sociafy/widgets/storyprofile_item.dart';
import 'package:story_view/story_view.dart';

import '../models/stories.dart';
import '../providers/data.dart';

//the immages that other users have posted on their story
class storyview_item extends StatefulWidget {
  UserStories user;
  PageController controller;

  storyview_item({Key? key, required this.user, required this.controller})
      : super(key: key);

  @override
  State<storyview_item> createState() => _storyview_itemState();
}

class _storyview_itemState extends State<storyview_item> {
  final storyItems = <StoryItem>[];
  late StoryController controller;
  DateTime date = DateTime.now();

  void addStoryItems() {
    for (final story in widget.user.stories) {
      switch (story.media) {
        case MediaType.image:
          storyItems.add(StoryItem.pageImage(
              url: story.url,
              controller: controller,
              duration: Duration(
                milliseconds: story.duration.inMilliseconds,
              )));
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    controller = StoryController();
    addStoryItems();
    date = widget.user.stories[0].datetime;
  }

  void handleCompleted() {
    widget.controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex = userstories.indexOf(widget.user);
    final isLastPage = userstories.length - 1 == currentIndex;

    if (isLastPage) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Material(
            type: MaterialType.transparency,
            child: StoryView(
              storyItems: storyItems,
              controller: controller,
              onComplete: handleCompleted,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
              onStoryShow: (storyItem) {
                final index = storyItems.indexOf(storyItem);

                if (index > 0) {
                  setState(() {
                    date = widget.user.stories[index].datetime;
                  });
                }
              },
            ),
          ),
          storyprofile_item(
            user: widget.user,
            date: date,
          ),
        ],
      );
}
