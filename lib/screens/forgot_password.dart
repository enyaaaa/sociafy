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

  // key for validation of users input
  var form = GlobalKey<FormState>();

  // email and password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //function for forget password when user clicks on the reset password
  void ForgetPassword(String email) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.forgotPassword(email).then((value) {
        Fluttertoast.showToast(
            msg: "Please check your email for to reset your password :D",
            backgroundColor: iconbutton,
            textColor: primary);
        Navigator.of(context).pop();
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: e!.message, backgroundColor: iconbutton, textColor: primary);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  //getting the body of forget password form
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
              autovalidateMode: AutovalidateMode.always,
              child: buildTextField(
                "Email",
                "Email",
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
            InkWell(
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Don't have an account? ",
                    style:
                        TextStyle(fontFamily: "Poppins", color: Colors.black54),
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
  Widget buildTextField(String labelText, String placeholder, validator, controller, onsaved) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        onSaved: onsaved,
        decoration: InputDecoration(
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
