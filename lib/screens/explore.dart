import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/explore.dart';
import 'package:sociafy/widgets/search_item.dart';

class Explore extends StatefulWidget {

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            search_item(),
            SizedBox(height: 15,),
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