import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/explore.dart';
import 'package:sociafy/providers/data.dart';
import 'package:sociafy/widgets/search_item.dart';

class Explore extends StatefulWidget {

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String query = '';
  late List<SearchExplore> searchexplore;

  @override
  void initState(){
    super.initState();

    searchexplore = search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(5),
      ),
      body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
  Widget buildSearch() => search_item(
      text: query,
      onChanged: searchExplore,
      hintText: "Search"
  );
  void searchExplore(String query){
    final searchexplore = search.where((explore){
      final titleLower = explore.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.searchexplore = searchexplore;
    });
  }
  Widget getBody(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          buildSearch(),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (ctx, i) {
                    SearchExplore explore = searchexplore[i];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(explore.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  itemCount: searchexplore.length
              ),
            ),
          ),
        ],
      ),
    );
  }
}