import 'package:sociafy/models/user.dart';

//models for user stories
class UserStories{
  UserModel userstory;
  List<Stories> stories;

  UserStories({
    required this.userstory,
    required this.stories,
  });
}

//type of media
enum MediaType{
  image,
  video,
}

//the details on the story that users have posted
class Stories{
  MediaType media;
  Duration duration;
  String url;
  DateTime datetime;

  Stories({
    required this.media,
    required this.duration,
    required this.url,
    required this.datetime,
  });
}