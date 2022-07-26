// import 'package:flutter/material.dart';
// import 'package:sociafy/screens/settings.dart';
//
// import '../color/colors.dart';
// import '../providers/data.dart';
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);
//
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   // set initial password field to not show the password
//   bool showPassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Edit Profile",
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             color: primary,
//           ),
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               //navigate to the settings page
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Settings()),
//               );
//             },
//             child: Icon(
//               Icons.settings,
//               color: primary,
//             ),
//           ),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 15, top: 20, right: 15),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 color: Colors.black.withOpacity(0.1))
//                           ],
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: AssetImage(currentUser.image),
//                             fit: BoxFit.cover,
//                           )),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(width: 4, color: Colors.white),
//                             color: iconbutton),
//                         child: Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               buildTextField("Name", "Name", false,currentUser.name),
//               buildTextField("Username", "Username", false, currentUser.username),
//               buildTextField("Email", "Email", false, "zendaya@gmail.com"),
//               buildTextField("Password", "*******", true, "erterter"),
//               buildTextField("Bio", currentUser.bio, false, currentUser.bio),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 80),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 40,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: iconbutton),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: MaterialButton(
//                         color: Colors.white,
//                         elevation: 0,
//                         onPressed: () {},
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           "Cancel",
//                           style:
//                               TextStyle(fontFamily: "Poppins", color: primary),
//                         ),
//                       ),
//                     ),
//                     MaterialButton(
//                       color: iconbutton,
//                       elevation: 0,
//                       onPressed: () {},
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         "Save",
//                         style: TextStyle(fontFamily: "Poppins", color: primary),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //style of the text field for edit profile
//   Widget buildTextField(
//       String labelText, String placeholder, bool isPasswordTextField, String initialdetails) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
//       child: TextFormField(
//         initialValue: initialdetails,
//         obscureText: isPasswordTextField ? showPassword : false,
//         decoration: InputDecoration(
//             suffixIcon: isPasswordTextField
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         showPassword = !showPassword;
//                       });
//                     },
//                     icon: Icon(
//                       Icons.remove_red_eye,
//                       color: Colors.grey,
//                     ))
//                 : null,
//             contentPadding: EdgeInsets.only(bottom: 5),
//             labelText: labelText,
//             labelStyle: TextStyle(
//               fontFamily: 'Poppins',
//               color: primary,
//             ),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: TextStyle(
//               fontFamily: 'Poppins',
//               color: primary,
//             )),
//         style: TextStyle(
//           fontSize: 14,
//           height: 2,
//           fontFamily: "Poppins",
//         ),
//       ),
//     );
//   }
// }
