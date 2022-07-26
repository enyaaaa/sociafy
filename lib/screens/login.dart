import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociafy/root_page.dart';
import 'package:sociafy/screens/signup.dart';

import '../color/colors.dart';
import '../services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var form = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.login(email, password).then((value) {
        Fluttertoast.showToast(msg: "Login successfully :D");
        Navigator.pushAndRemoveUntil(
            (context), MaterialPageRoute(builder: (context) => Rootpage()), (
            route) => false);
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
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
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 130,
                vertical: 30,
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
              height: 30,
            ),
            Center(
              child: Text(
                "Don't Have An Account?",
                style: TextStyle(
                    fontFamily: "Poppins", color: primary, fontSize: 15),
              ),
            ),
            InkWell(
              child: Center(
                child: Text(
                  "Sign Up Now :D",
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
                  MaterialPageRoute(builder: (context) => Signup()),
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
