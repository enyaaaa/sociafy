import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/provider/user_provider.dart';
import 'package:sociafy/root_page.dart';
import 'package:sociafy/screens/login.dart';
import 'package:sociafy/services/auth_service.dart';

import 'color/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: iconbutton,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //navigate to the root page
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Rootpage();
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Login();
              }),
          theme: ThemeData(
            primarySwatch: Colors.grey,
            fontFamily: "Poppins",
            textTheme: Theme.of(context).textTheme.apply(bodyColor: primary),
          )),
    );
  }
}
