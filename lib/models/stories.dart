import 'package:sociafy/models/user.dart';

class UserStories{
  final User userstory;
  final List<Stories> stories;

  UserStories({
    required this.userstory,
    required this.stories,
  });
}

enum MediaType{
  image,
  video,
}

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