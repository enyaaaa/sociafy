import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';

class search_item extends StatelessWidget {
  const search_item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
              width: 360,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: background
              ),
              child: TextField(
                cursorColor: primary,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                    ),
                    prefixIcon: Icon(Icons.search,color: primary,)
                ),
                style: TextStyle(
                  color: primary,
                  fontFamily: "poppins",
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
