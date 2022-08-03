import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/screens/settings.dart';
import 'package:sociafy/services/firestore_service.dart';

import '../color/colors.dart';
import '../services/storage_service.dart';

class EditProfile extends StatefulWidget {
  final String uid;

  const EditProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var userData = {};
  String? name;
  String? username;
  String? bio;
  bool isLoading = false;
  var form = GlobalKey<FormState>();

  //the file that user pick from their device
  File? _file;

  //initialise picker as ImagePicker
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      userData = usersnap.data()!;
      name = userData["name"];
      username = userData["username"];
      bio = userData["bio"];
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: iconbutton,  textColor: primary  );
    }
    setState(() {
      isLoading = false;
    });
  }

  //user have the selection of camara or gallery
  selectphoto(BuildContext parentContext) async {
    await showDialog(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => SimpleDialog(
                children: [
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                      onTap: () async {
                        Navigator.of(context).pop();
                        pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Icon(Icons.filter),
                      title: Text("Pick an image"),
                      onTap: () async {
                        Navigator.of(context).pop();
                        pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                  SimpleDialogOption(
                    child: ListTile(
                      leading: Icon(Icons.close),
                      title: Text("Close"),
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              onClosing: () {},
            ));
  }

  //user to pick image and crop it
  Future pickImage(ImageSource source) async {
    final _file = await picker.pickImage(source: source);
    if (_file == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: _file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    file = await compressImage(file.path, 35);
    final Image = File(file.path);
    setState(() => this._file = Image);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);

    return result!;
  }

  saveProfile() async {
    print(name);
    print(username);
    print(bio);
    print(_file);

    form.currentState!.save();
    if (form.currentState!.validate() && !isLoading) {
      setState(() {
        isLoading = true;
      });
      String profilePic = '';
      if (_file == null) {
        profilePic = userData["image"];
      } else {
        profilePic = await StorageService()
            .uploadProfilePicture('profilePic', userData["image"], _file!);
      }
      UserModel user = UserModel(
          email: userData["email"],
          uid: widget.uid,
          image: profilePic,
          username: username!,
          name: name!,
          bio: bio!,
          followers: userData["followers"],
          following: userData["following"]);

      FireStoreService().updateUserData(user);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Successfully Updated Profile", backgroundColor: iconbutton, textColor: primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Edit Profile",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: primary,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    //navigate to the settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                  child: Icon(
                    Icons.settings,
                    color: primary,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            body: Container(
              padding: EdgeInsets.only(left: 15, top: 20, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          InkWell(
                              onTap: () => selectphoto(context),
                              child: (_file != null)
                                  ? Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.1))
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: Image.file(File(_file!.path))
                                                .image,
                                            fit: BoxFit.cover,
                                          )),
                                    )
                                  : Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.1))
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(userData["image"]),
                                            fit: BoxFit.cover,
                                          )),
                                    )),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  color: iconbutton),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Text(
                          userData["email"],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: primary,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Form(
                        key: form,
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: name,
                              validator: (value) {
                                if (value == "")
                                  return "Please provide a name.";
                                else
                                  return null;
                              },
                              onSaved: (value) {
                                name = value;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: primary,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "name",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: postbackground,
                                  )),
                              style: TextStyle(
                                fontSize: 14,
                                height: 2,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              initialValue: username,
                              validator: (value) {
                                if (value == "")
                                  return "Please provide a username.";
                                else if (!RegExp(r'^[a-zA-Z0-9]+$')
                                    .hasMatch(value!)) {
                                  return 'Please enter a valid username.';
                                } else
                                  return null;
                              },
                              onSaved: (value) {
                                username = value;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: primary,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "username",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: postbackground,
                                  )),
                              style: TextStyle(
                                fontSize: 14,
                                height: 2,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              initialValue: bio,
                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                bio = value;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Bio',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: primary,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "bio",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: postbackground,
                                  )),
                              style: TextStyle(
                                fontSize: 14,
                                height: 2,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: iconbutton),
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                              color: Colors.white,
                              elevation: 0,
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: "Poppins", color: primary),
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: iconbutton,
                            elevation: 0,
                            onPressed: saveProfile,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: primary),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
