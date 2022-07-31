import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/screens/login.dart';

import '../color/colors.dart';
import '../root_page.dart';
import '../services/auth_service.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var form = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
  }

  void signup(String email, String password) async {
    if (form.currentState!.validate()) {
      AuthService authService = AuthService();
      return authService.register(email, password).then((value) {
        postDetailsToFirestore();
        // navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Rootpage(),
          ),
        );
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel(
        email: emailController.text,
        uid: user!.uid,
        image: "https://i.pinimg.com/280x280_RS/2e/45/66/2e4566fd829bcf9eb11ccdb5f252b02f.jpg",
        username: usernameController.text,
        name: nameController.text,
        bio: "",
        followers: [],
        following: []
    );

    // adding user in our database
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
    Fluttertoast.showToast(msg: "Account created successfully :D");
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

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
              height: 10,
            ),
            Container(
                height: 80,
                width: 80,
                child: SvgPicture.asset("assets/logo.svg")),
            Center(
              child: Text(
                "S I G N U P",
                style: TextStyle(
                    fontFamily: "Poppins", color: primary, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: form,
              child: Column(
                children: [
                  buildTextField(
                  "Email",
                  "Email",
                  false,
                      (value) {
                    if (value == "")
                      return "Please provide an email address.";
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
                    "Name",
                    "Name",
                    false,
                        (value) {
                      if (value == "")
                        return "Please provide a name.";
                      else
                        return null;
                    },
                    nameController,
                        (value) {
                      nameController.text = value;
                    },
                  ),
                  buildTextField(
                    "Username",
                    "Username",
                    false,
                        (value) {
                      if (value == "")
                        return "Please provide a username.";
                      else if (!RegExp(
                          r'^[a-zA-Z0-9]+$')
                          .hasMatch(value)){
                        return 'Please enter a valid username.';
                      }
                      else
                        return null;
                    },
                    usernameController,
                        (value) {
                      usernameController.text = value;
                    },
                  ),
                  buildTextField(
                    "Password",
                    "Password",
                    true,
                        (value) {
                      if (value == "")
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
                  buildTextField(
                    "Confirm Password",
                    "Confirm Password",
                    true,
                        (value) {
                      if (value == "")
                        return 'Please provide a password.';
                      else if (value.length < 6)
                        return 'Password must be at least 6 characters.';
                      else if (passwordController.text !=
                          confirmPasswordController.text)
                        return "Password don't match";
                      else
                        return null;
                    },
                    confirmPasswordController,
                        (value) {
                      confirmPasswordController.text = value;
                    },
                  ),
                ],
              ),
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
                  signup(emailController.text, passwordController.text);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Signup",
                  style: TextStyle(fontFamily: "Poppins", color: primary),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Already Have An Account?",
                style: TextStyle(
                    fontFamily: "Poppins", color: primary, fontSize: 15),
              ),
            ),
            InkWell(
              child: Center(
                child: Text(
                  "Login Now :D",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
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
