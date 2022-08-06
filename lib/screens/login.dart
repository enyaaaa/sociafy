import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sociafy/root_page.dart';
import 'package:sociafy/screens/forgot_password.dart';
import 'package:sociafy/screens/signup.dart';

import '../color/colors.dart';
import '../services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // key for validation of users input
  var form = GlobalKey<FormState>();

  //controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //function for login when user press on the login button
  void login(String email, String password) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.login(email, password).then((value) {
        Fluttertoast.showToast(msg: "Login successfully :D", backgroundColor: iconbutton,  textColor: primary);
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => Rootpage()),
            (route) => false);
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message, backgroundColor: iconbutton, textColor: primary);
      });
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  //function for when user press the sign in button
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = auth.currentUser;
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      'email': googleUser.email,
      'uid': user.uid,
      'image': googleUser.photoUrl,
      'username': googleUser.email.replaceAll("@gmail.com", ""),
      'name': googleUser.displayName,
      'bio': "",
      'followers': [],
      'following': [],
    });
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Rootpage()),
            (route) => false);
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  //getting body of the login form
  Widget getBody() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
                height: 80,
                width: 80,
                child: SvgPicture.asset("assets/logo.svg")),
            Center(
              child: Text(
                "L O G I N",
                style: TextStyle(
                    fontFamily: "Poppins", color: primary, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Form(
              key: form,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  buildTextField(
                    "Email",
                    "Email",
                    false,
                    (value) {
                      if (value == null)
                        return "Please provide an email.";
                      else if (!value.contains('@'))
                        return "Please provide a valid email address.";
                      else
                        return null;
                    },
                    emailController,
                    (value) {
                      emailController.text = value;
                    },
                  ),
                  buildTextField(
                    "Password",
                    "Password",
                    true,
                    (value) {
                      if (value == null)
                        return 'Please provide a password.';
                      else if (value.length < 6)
                        return 'Password must be at least 6 characters.';
                      else
                        return null;
                    },
                    passwordController,
                    (value) {
                      passwordController.text = value;
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 210),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontFamily: "Poppins", color: primary, fontSize: 15),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgetPassword()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 130,
                vertical: 10,
              ),
              child: MaterialButton(
                color: iconbutton,
                elevation: 0,
                onPressed: () {
                  login(emailController.text, passwordController.text);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(fontFamily: "Poppins", color: primary),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "or sign in with",
                style: TextStyle(fontFamily: "Poppins", color: Colors.black26),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          InkWell(
            onTap: () {
              signInWithGoogle();
            },
            child: Container(
              padding: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: Container(
                height: 30,
                  width: 30,
                  child: Image.network("https://blog.capterra.com/wp-content/uploads/2021/04/Google-Workspace-Logo.png")
              )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(fontFamily: "Poppins", color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'SIGN UP :D',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //style of the text field for edit profile
  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, validator, controller, onsaved) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        onSaved: onsaved,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ))
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: primary,
            )),
        style: TextStyle(
          fontSize: 14,
          height: 2,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
