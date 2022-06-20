import 'package:sociafy/models/user.dart';

class Stories{
  User user;

  Stories ({
    required this.user,
  });
}

List<Stories> stories = [
  Stories( user: currentUser ),
  Stories( user: seaveydaniel ),
  Stories( user: haileybieber ),
  Stories( user: oliviarodrigo ),
  Stories( user: harrystyles ),
  Stories( user: blakelively ),
];