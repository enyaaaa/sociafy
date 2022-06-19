import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/myMedia.dart';
import 'package:sociafy/root_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: iconbutton,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<myPostList>(
            create: (ctx) => myPostList()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Rootpage(),
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: "Poppins",
          textTheme: Theme.of(context).textTheme.apply(bodyColor: primary),
        ),
      ),
    );
  }
}