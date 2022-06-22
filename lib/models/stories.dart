import 'package:sociafy/models/user.dart';

enum MediaType{
  image,
  video,
}

class Stories{
  User user;
  MediaType media;
  Duration duration;
  String url;

  Stories ({
    required this.user,
    required this.media,
    required this.duration,
    required this.url,
  });
}