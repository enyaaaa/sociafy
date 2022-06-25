import 'package:flutter/material.dart';
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
  isFollowedbyMe: true,
  totalFollower: 0,
  totalFollowing: 0,
);

User corbynbesson = User(
  image: 'assets/users/corbynbesson.jpg',
  username: 'corbynbesson',
  name: 'Corbyn 🛸',
  bio:
      'i’m in a band. we’re on tour this summer. “HOW DO YOU LOVE SOMEBODY” OUT NOW ❤️‍🔥',
  isFollowedbyMe: true,
  totalFollower: 453,
  totalFollowing: 323,
);

User harrystyles = User(
  image: 'assets/users/harrystyles.jpg',
  username: 'harrystyles',
  name: 'Harry Styles.',
  bio: '',
  isFollowedbyMe: true,
  totalFollower: 578,
  totalFollowing: 289,
);

User oliviarodrigo = User(
  image: 'assets/users/oliviarodrigo.jpg',
  username: 'oliviarodrigo',
  name: 'Olivia Rodrigo',
  bio: 'spicy pisces',
  isFollowedbyMe: true,
  totalFollower: 678,
  totalFollowing: 367,
);

User seaveydaniel = User(
  image: 'assets/users/seaveydaniel.jpg',
  username: 'seaveydaniel',
  name: 'Daniel',
  bio: '@whydontwemusic',
  isFollowedbyMe: true,
  totalFollower: 546,
  totalFollowing: 234,
);

User haileybieber = User(
  image: 'assets/users/haileybieber.jpg',
  username: 'haileybieber',
  name: 'Hailey Rhode Baldwin Bieber',
  bio: '@rhode',
  isFollowedbyMe: true,
  totalFollower: 678,
  totalFollowing: 237,
);

User emmawatson = User(
  image: 'assets/users/ammawatson.jpg',
  username: 'emmawatson',
  name: 'Emma Watson',
  bio: '',
  isFollowedbyMe: true,
  totalFollower: 786,
  totalFollowing: 256,
);

User tomholland2013 = User(
  image: 'assets/users/tomholland2013.jpg',
  username: 'tomholland2013',
  name: 'Tom Holland',
  bio: 'Life is good @thebrotherstrust',
  isFollowedbyMe: true,
  totalFollower: 867,
  totalFollowing: 276,
);

//users story info
List<UserStories> userstories = [
  UserStories(
    userstory: currentUser,
    stories: tomstories,
  ),
  UserStories(
    userstory: seaveydaniel,
    stories: danielstories,
  ),
  UserStories(
    userstory: oliviarodrigo,
    stories: oliviastories,
  ),
  UserStories(
    userstory: harrystyles,
    stories: harrystories,
  ),
  UserStories(
    userstory: haileybieber,
    stories: haileystories,
  ),
  UserStories(
    userstory: emmawatson,
    stories: emmastories,
  ),
  UserStories(
    userstory: tomholland2013,
    stories: tomstories,
  ),
];

//Stories
List<Stories> danielstories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url: 'https://i.pinimg.com/564x/ac/d5/25/acd5252414b37a0db415552058cd1bff.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 5)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
        'https://i.pinimg.com/564x/61/65/ef/6165ef2d8486fc1b72586ce33cbf5f3b.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 4)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://media4.giphy.com/media/463AvJ8VbvFkHKNgOT/giphy.gif?cid=ecf05e47v26115p7f6qg4wctikx9whce5qsga7uc41a7jo87&rid=giphy.gif&ct=g',
    datetime: DateTime.now().subtract(Duration(minutes: 40)),
  ),
];

List<Stories> oliviastories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/2b/44/1b/2b441b1c727a9fdc0718f9ad60ffd17c.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 1)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/51/8c/3a/518c3afc0b281f81673a89109f61e2f4.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 3)),
  ),
];

List<Stories> harrystories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
        'https://i.pinimg.com/564x/02/8b/53/028b535d88a4019ce686b825fb1a2d94.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 1)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
        'https://i.pinimg.com/564x/47/a8/76/47a8767b1847a64b1f52bcda22f2f9d9.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 3)),
  ),
];

List<Stories> haileystories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/69/ac/4d/69ac4d75c14e4ee8517f9b93fabc5d35.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 3)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/3d/8b/12/3d8b12498527ef99784fd343f112f2c4.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 3)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/9b/0e/e2/9b0ee2929997aa235b32168c5b52d0c2.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 3)),
  ),
];

List<Stories> emmastories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/67/5c/70/675c705c8062328f34e384a22d954870.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 1)),
  ),
];

List<Stories> tomstories = [
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/44/28/c9/4428c9ab7b1cc6a0f4430816672f8a32.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 1)),
  ),
  Stories(
    media: MediaType.image,
    duration: Duration(seconds: 5),
    url:
    'https://i.pinimg.com/564x/51/de/36/51de361a2b2e77d81f05bb786a92b7c9.jpg',
    datetime: DateTime.now().subtract(Duration(hours: 1)),
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
    user: emmawatson,
    timeAgo: DateTime.now().subtract(Duration(days: 3)),
    image: "assets/post/ammawatson_post.jpg",
    caption: null,
    location: null,
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
    isliked: false,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: oliviarodrigo,
    timeAgo: DateTime.now().subtract(Duration(hours: 5)),
    image: "assets/post/oliviarodrigo_post.jpg",
    caption: null,
    location: null,
    isliked: false,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: tomholland2013,
    timeAgo: DateTime.now().subtract(Duration(days: 1)),
    image: "assets/post/tomholland_post.jpg",
    caption: null,
    location: null,
    isliked: false,
    likedby: null,
    issaved: false,
  ),
];

//comments
List<Comments> comments = [
  Comments(
    user: tomholland2013,
    datetime: DateTime.now().subtract(Duration(hours: 3)),
    comment: "U’re so cool bro",
    isliked: false,
  ),
  Comments(
    user: emmawatson,
    datetime: DateTime.now().subtract(Duration(hours: 2)),
    comment: "Sooo cute!!!! 😍 love your hair btw",
    isliked: false,
  ),
  Comments(
    user: haileybieber,
    datetime: DateTime.now().subtract(Duration(minutes: 40)),
    comment: "❤️❤️❤️",
    isliked: false,
  ),
  Comments(
    user: harrystyles,
    datetime: DateTime.now().subtract(Duration(minutes: 40)),
    comment: "ICONIC🔥",
    isliked: false,
  ),
  Comments(
    user: tomholland2013,
    datetime: DateTime.now().subtract(Duration(minutes: 40)),
    comment: "looking good yalls❤️",
    isliked: false,
  ),
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
    text: "HAHAHAHAHHA",
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
    text: "Cute 🥰",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 4, minutes: 32)),
    text: "you must watch this show called stranger things its scary but you should definitely watch it",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 6, minutes: 24)),
    text: "when should we meet up its been so long",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 7, minutes: 10)),
    text: "okayy noice",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "have you eaten yet?",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "we should go out for lunch soon and catch up",
    unread: true,
    isSentByMe: false,
  ),
];

//friends
List<Friends> friends = [
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
    user: emmawatson,
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
    image: "assets/post/dubai_post.jpg",
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
    image: "assets/post/taylorswift_post.jpg",
  ),
  SearchExplore(
    name: "zendaya",
    image: "assets/post/zendaya_post.jpg",
  ),
];
