import 'package:sociafy/models/friends.dart';
import 'package:sociafy/models/messages.dart';
import 'package:sociafy/models/post.dart';
import 'package:sociafy/models/explore.dart';
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

List<UserStories> userstories = [
  UserStories(
    userstory: currentUser,
    stories: danielstories,
  ),
  UserStories(
    userstory: seaveydaniel,
    stories: harrystories,
  ),
  UserStories(
    userstory: oliviarodrigo,
    stories: danielstories,
  ),
  UserStories(
    userstory: harrystyles,
    stories: harrystories,
  ),
  UserStories(
    userstory: haileybieber,
    stories: danielstories,
  ),
  UserStories(
    userstory: blakelively,
    stories: harrystories,
  ),
  UserStories(
    userstory: tomholland2013,
    stories: danielstories,
  ),
];

//Stories
List<Stories> danielstories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    datetime: DateTime.now().subtract(Duration(hours: 5)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    datetime: DateTime.now().subtract(Duration(hours: 4)),
  ),
];

List<Stories> harrystories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    datetime: DateTime.now().subtract(Duration(hours: 1)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    datetime: DateTime.now().subtract(Duration(hours: 3)),
  ),
];

//post
List<Posts> posts = [
  Posts(
    user: corbynbesson,
    timeAgo: DateTime.now().subtract(Duration(hours: 4)),
    image: "assets/post/corbynbesson_post.jpg",
    caption: "I'm flying",
    location: "Coachella, California",
    isliked: false,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: seaveydaniel,
    timeAgo: DateTime.now().subtract(Duration(minutes: 7)),
    image: "assets/post/seaveydaniel_post.jpg",
    caption: null,
    location: "californa",
    isliked: true,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: oliviarodrigo,
    timeAgo: DateTime.now().subtract(Duration(days: 3)),
    image: "assets/post/oliviarodrigo_post.jpg",
    caption: null,
    location: null,
    isliked: false,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: tomholland2013,
    timeAgo: DateTime.now().subtract(Duration(days: 3)),
    image: "assets/post/doggie_post.jpg",
    caption: null,
    location: null,
    isliked: false,
    likedby: null,
    issaved: false,
  ),
];

//comments
List<Posts> comments = [
  Posts(
    user: seaveydaniel,
    timeAgo: DateTime.now().subtract(Duration(minutes: 5)),
    image: "assets/post/seaveydaniel_post.jpg",
    caption: "wow",
    location: null,
    isliked: false,
    likedby: null,
    issaved: false,
  )
];

//chats
List<UserChats> chats = [
  UserChats(
    userchats: corbynbesson,
    datetime: DateTime.now().subtract(Duration(minutes: 5)),
    text: "hello!",
    unread: true,
  ),
  UserChats(
    userchats: harrystyles,
    datetime: DateTime.now().subtract(Duration(minutes: 20)),
    text: "What you are up to",
    unread: true,
  ),
  UserChats(
    userchats: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(hours: 7)),
    text: "okay",
    unread: false,
  ),
  UserChats(
    userchats: tomholland2013,
    datetime: DateTime.now().subtract(Duration(hours: 5)),
    text: "whatsup!",
    unread: true,
  ),
];

//messages
List<Messages> messages = [
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "whatsup",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "i am so happy",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 2)),
    text: "what you doing",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 44)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 4, minutes: 32)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 6, minutes: 24)),
    text: "woo hoo",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 7, minutes: 10)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
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
    isfollowedByMe: true,
  ),
  Friends(
    user: seaveydaniel,
    isfollowedByMe: true,
  ),
  Friends(
    user: harrystyles,
    isfollowedByMe: true,
  ),
  Friends(
    user: oliviarodrigo,
    isfollowedByMe: true,
  ),
  Friends(
    user: haileybieber,
    isfollowedByMe: true,
  ),
  Friends(
    user: blakelively,
    isfollowedByMe: true,
  ),
  Friends(
    user: tomholland2013,
    isfollowedByMe: true,
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

List<SearchExplore> search = [
  SearchExplore(
    name: "ammachamberlain",
    image: "assets/post/ammachamberlain_post.jpg",
  ),
  SearchExplore(
    name: "arianagrande",
    image: "assets/post/arianagrande_post.jpg",
  ),
  SearchExplore(
    name: "italy",
    image: "assets/post/italy_post.jpg",
  ),
  SearchExplore(
    name: "ballet",
    image: "assets/post/ballet_post.jpg",
  ),
  SearchExplore(
    name: "billieeilish",
    image: "assets/post/billieeilish_post.jpg",
  ),
  SearchExplore(
    name: "corbynbesson",
    image: "assets/post/corbynbesson_post.jpg",
  ),
  SearchExplore(
    name: "germany",
    image: "assets/post/germany_post.jpg",
  ),
  SearchExplore(
    name: "corndogs",
    image: "assets/post/corndogs_post.jpg",
  ),
  SearchExplore(
    name: "doggie",
    image: "assets/post/doggie_post.jpg",
  ),
  SearchExplore(
    name: "japan",
    image: "assets/post/japan_post.jpg",
  ),
  SearchExplore(
    name: "johnnyorlando",
    image: "assets/post/johnnyorlando_post.jpg",
  ),
  SearchExplore(
    name: "justinbieber",
    image: "assets/post/justinbieber_post.jpg",
  ),
  SearchExplore(
    name: "dubai",
    image:  "assets/post/dubai_post.jpg",
  ),
  SearchExplore(
    name: "lillyk",
    image: "assets/post/lillyk_post.jpg",
  ),
  SearchExplore(
    name: "oliviarodrigo",
    image: "assets/post/oliviarodrigo_post.jpg",
  ),
  SearchExplore(
    name: "pointe",
    image: "assets/post/pointe_post.jpg",
  ),
  SearchExplore(
    name: "portugal",
    image: "assets/post/portugal_post.jpg",
  ),
  SearchExplore(
    name: "sabrinacarpenter",
    image: "assets/post/sabrinacarpenter_post.jpg",
  ),
  SearchExplore(
    name: "scotland",
    image: "assets/post/scotland_post.jpg",
  ),
  SearchExplore(
    name: "seaveydaniel",
    image: "assets/post/seaveydaniel_post.jpg",
  ),
  SearchExplore(
    name: "shawnmendes",
    image: "assets/post/shawnmendes_post.jpg",
  ),
  SearchExplore(
    name: "greece",
    image: "assets/post/greece_post.jpg",
  ),
  SearchExplore(
    name: "sofiedossi",
    image: "assets/post/sofiedossi_post.jpg",
  ),
  SearchExplore(
    name: "taylorswift",
    image:  "assets/post/taylorswift_post.jpg",
  ),
  SearchExplore(
    name: "zendaya",
    image: "assets/post/zendaya_post.jpg",
  ),
];

