import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/friends.dart';
import 'package:sociafy/providers/data.dart';
import 'package:sociafy/screens/view_user.dart';
import 'package:sociafy/widgets/search_item.dart';

class Search extends StatefulWidget {

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  late List<Friends> friend;

  @override
  void initState(){
    super.initState();

    friend = friends;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: Column(
        children: [
          buildSearch(),
          getFriends(),
        ],
      )
    );
  }
  Widget getAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        children: [
          Text( "Search",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget getFriends(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: ListView.builder(
            itemCount: friend.length,
            itemBuilder: (BuildContext context, int index) {
              Friends userfriends = friend[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewUser(
                          user: userfriends.user,
                        )
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(userfriends.user.image),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userfriends.user.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 13
                                ),
                              ),
                              Text(
                                "@" + userfriends.user.username,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: iconbutton),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: MaterialButton(
                          elevation: 0,
                          color: userfriends.isfollowedByMe
                              ? Colors.white
                              : iconbutton,
                          onPressed: () {
                            setState(() {
                              userfriends.isfollowedByMe =
                              !userfriends.isfollowedByMe;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            userfriends.isfollowedByMe ? "Follow" : "Following",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: primary
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
  Widget buildSearch() => search_item(
      text: query,
      onChanged: searchFriends,
      hintText: "Search Friends");
  void searchFriends(String query){
    final friend = friends.where((userfriends){
      final titleLower = userfriends.user.username.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.friend = friend;
    });
  }
}
