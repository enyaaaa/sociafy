import 'package:flutter/material.dart';
import 'package:sociafy/widgets/search_item.dart';

class Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          search_item(),
        ],
      ),
    );
  }
}
