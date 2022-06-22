import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/providers/data.dart';
import 'package:sociafy/widgets/search_item.dart';

class Explore extends StatefulWidget {

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: buildSearch()
    );
  }
  Widget buildSearch() => search_item(
      text: query,
      onChanged: searchExplore,
      hintText: "Search"
  );
  void searchExplore(String query){
    // final friend = friends.where((userfriends){
    //   final titleLower = userfriends.user.username.toLowerCase();
    //   final searchLower = query.toLowerCase();
    //
    //   return titleLower.contains(searchLower);
    // }).toList();
    //
    // setState(() {
    //   this.query = query;
    //   this.friend = friend;
    // });
  }
  Widget getBody(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children:
                    List.generate(searchCategories.length, (index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: iconbutton
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                            child: Text(searchCategories[index],
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                ),
              ),
            ),
            SizedBox(height: 20,),
            Wrap(
                spacing: 3,
                runSpacing: 3,
                children: List.generate(searchImages.length, (index){
                  return Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(searchImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },)
            ),
          ],
        ),
      ),
    );
  }
}