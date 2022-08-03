import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociafy/screens/signup.dart';

import '../color/colors.dart';
import '../services/auth_service.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var form = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void ForgetPassword(String email) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.forgotPassword(email).then((value) {
        Fluttertoast.showToast(
            msg: "Please check your email for to reset your password :D", backgroundColor: iconbutton, textColor: primary);
        Navigator.of(context).pop();
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message, backgroundColor: iconbutton, textColor: primary);
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
                "F O R G E T  P A S S W O R D",
                style: TextStyle(
                    fontFamily: "Poppins", color: primary, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Form(
              key: form,
              child: buildTextField(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 30,
              ),
              child: MaterialButton(
                color: iconbutton,
                elevation: 0,
                onPressed: () {
                  ForgetPassword(emailController.text);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Reset Password",
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
