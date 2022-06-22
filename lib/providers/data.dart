import 'package:sociafy/models/friends.dart';
import 'package:sociafy/models/messages.dart';
import 'package:sociafy/models/post.dart';
import 'package:sociafy/models/stories.dart';
import 'package:sociafy/models/user.dart';

//users
User currentUser = User(
  image: 'assets/users/zendaya.jpg',
  username: 'zendaya',
  name: '😂😱😩',
  bio:
  'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User corbynbesson = User(
  image: 'assets/users/corbynbesson.jpg',
  username: 'corbynbesson',
  name: 'Corbyn 🛸',
  bio:
  'i’m in a band. we’re on tour this summer. “HOW DO YOU LOVE SOMEBODY” OUT NOW ❤️‍🔥',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User harrystyles = User(
  image: 'assets/users/harrystyles.jpg',
  username: 'harrystyles',
  name: 'Harry Styles.',
  bio: '',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User oliviarodrigo = User(
  image: 'assets/users/oliviarodrigo.jpg',
  username: 'oliviarodrigo',
  name: 'Olivia Rodrigo',
  bio: 'spicy pisces',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User seaveydaniel = User(
  image: 'assets/users/seaveydaniel.jpg',
  username: 'seaveydaniel',
  name: 'Daniel',
  bio: '@whydontwemusic',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User haileybieber = User(
  image: 'assets/users/haileybieber.jpg',
  username: 'haileybieber',
  name: 'Hailey Rhode Baldwin Bieber',
  bio: '@rhode',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User blakelively = User(
  image: 'assets/users/blakelively.jpg',
  username: 'blakelively',
  name: 'Blake Lively',
  bio: '',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

User tomholland2013 = User(
  image: 'assets/users/tomholland2013.jpg',
  username: 'tomholland2013',
  name: 'Tom Holland',
  bio: 'Life is good @thebrotherstrust',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
);

//Stories
List<Stories> stories = [
  Stories(
    user: currentUser,
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  Stories(
    user: seaveydaniel,
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  Stories(
    user: haileybieber,
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  Stories(
    user: oliviarodrigo,
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  Stories(
    user: harrystyles,
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  Stories(
    user: blakelively,
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

//post
List<Posts> posts = [
  Posts(
    user: corbynbesson,
    timeAgo: "10 min",
    image: "assets/post/corbynbesson_post.jpg",
    caption: "I'm flying",
    location: "Coachella, California",
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: seaveydaniel,
    timeAgo: "2h",
    image: "assets/post/seaveydaniel_post.jpg",
    caption: null,
    location: "californa",
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: seaveydaniel,
    timeAgo: "2h",
    image: "assets/post/seaveydaniel_post.jpg",
    caption: null,
    location: null,
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  ),
];

//comments
List<Posts> comments = [
  Posts(
    user: seaveydaniel,
    timeAgo: "2h",
    image: "assets/post/seaveydaniel_post.jpg",
    caption: "wow",
    location: null,
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  )
];

//chats
List<Messages> chats = [
  Messages(
    sender: corbynbesson,
    datetime: DateTime.now().subtract(Duration(minutes: 5)),
    text: "hello!",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: harrystyles,
    datetime: DateTime.now().subtract(Duration(hours: 5)),
    text: "hello!",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "hello!",
    unread: false,
    isSentByMe: false,
  ),
];

//messages
List<Messages> messages = [
  Messages(
    sender: corbynbesson,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "whatsup",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: corbynbesson,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "i am so happy",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: currentUser,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 2)),
    text: "what you doing",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 44)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: currentUser,
    datetime: DateTime.now().subtract(Duration(days: 4, minutes: 32)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 6, minutes: 24)),
    text: "woo hoo",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: currentUser,
    datetime: DateTime.now().subtract(Duration(days: 7, minutes: 10)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: currentUser,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "woo hoo",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: currentUser,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "woo hoo",
    unread: true,
    isSentByMe: false,
  ),
];

//friends
List <Friends> friends = [
  Friends(
    user: corbynbesson,
    isfollowedByMe: false,
  ),
  Friends(
    user: seaveydaniel,
    isfollowedByMe: true,
  ),
  Friends(
    user: harrystyles,
    isfollowedByMe: false,
  ),
  Friends(
    user: oliviarodrigo,
    isfollowedByMe: true,
  ),
  Friends(
    user: haileybieber,
    isfollowedByMe: false,
  ),
  Friends(
    user: blakelively,
    isfollowedByMe: true,
  ),
  Friends(
    user: tomholland2013,
    isfollowedByMe: false,
  ),
];

List searchCategories = [
  "Trending",
  "Hacks",
  "Decor",
  "Food",
  "Dog",
  "Travel",
  "Art"
];

List searchImages = [
  "assets/post/ammachamberlain_post.jpg",
  "assets/post/arianagrande_post.jpg",
  "assets/post/italy_post.jpg",
  "assets/post/ballet_post.jpg",
  "assets/post/billieeilish_post.jpg",
  "assets/post/corbynbesson_post.jpg",
  "assets/post/germany_post.jpg",
  "assets/post/corndogs_post.jpg",
  "assets/post/doggie_post.jpg",
  "assets/post/japan_post.jpg",
  "assets/post/johnnyorlando_post.jpg",
  "assets/post/justinbieber_post.jpg",
  "assets/post/dubai_post.jpg",
  "assets/post/lillyk_post.jpg",
  "assets/post/oliviarodrigo_post.jpg",
  "assets/post/pointe_post.jpg",
  "assets/post/portugal_post.jpg",
  "assets/post/sabrinacarpenter_post.jpg",
  "assets/post/scotland_post.jpg",
  "assets/post/seaveydaniel_post.jpg",
  "assets/post/shawnmendes_post.jpg",
  "assets/post/greece_post.jpg",
  "assets/post/sofiedossi_post.jpg",
  "assets/post/taylorswift_post.jpg",
  "assets/post/zendaya_post.jpg",
];

