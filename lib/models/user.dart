//models of user details
class User{
  String image;
  String username;
  String name;
  String bio;
  bool isFollowedbyMe;
  int totalFollower;
  int totalFollowing;

  User ({
    required this.image,
    required this.username,
    required this.name,
    required this.bio,
    required this.isFollowedbyMe,
    required this.totalFollower,
    required this.totalFollowing,
  });
}
