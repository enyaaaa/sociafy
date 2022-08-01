import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/screens/add_post.dart';
import 'package:sociafy/screens/search.dart';

import '../color/colors.dart';
import '../provider/user_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/post_item.dart';
import '../widgets/story_item.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: AppDrawer(),
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }

  //user can open drawer when they click on the profile icon
  //add a post when user click on the add icon on the right
  //search for other users adn view their profile
  Widget getAppBar() {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () {
            scaffoldkey.currentState?.openDrawer();
          },
          icon: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    width: 30.0,
                    height: 30.0,
                    image: NetworkImage(userProvider.getUser.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        ),
      ),
      title: SvgPicture.asset("assets/logo.svg"),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPost()),
            );
          },
          child: SvgPicture.asset("assets/icon/add_post_icon.svg"),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          },
          child: SvgPicture.asset("assets/icon/search_icon.svg"),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget getBody() {
    return Column(
      children: [
        //display stories that other users have posted
        story_item(),
        Divider(
          color: primary.withOpacity(0.5),
        ),
        //display post that other users have posted
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => Container(
                      child: post_item(snap: snapshot.data!.docs[index].data(),),
                    )
                ),
              );
            })
      ],
    );
  }
}
