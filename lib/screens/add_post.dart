import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sociafy/screens/profile.dart';
import 'package:sociafy/services/auth_service.dart';
import 'package:sociafy/services/firestore_service.dart';
import 'package:sociafy/services/storage_service.dart';

import '../color/colors.dart';
import '../provider/user_provider.dart';

//User can post an image
class AddPost extends StatefulWidget {
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //allows validation of form
  final form = GlobalKey<FormState>();

  final TextEditingController captionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  //the file that user pick from their device
  File? _file;

  // set initial loading page to false
  bool loading = false;

  //initialise picker as ImagePicker
  final ImagePicker picker = ImagePicker();

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

  //when user click on the share button to post the image
  Future postImage(String uid, String username, String image) async {

    if (_file == null) {
      Fluttertoast.showToast(msg: "Please add an image");
      return;
    }

    final post = File(_file!.path);
    try {
      // upload to storage and db
      String res = await FireStoreService().uploadPost(
        captionController.text,
        locationController.text,
        post,
        uid,
        username,
        image,
      );
      if (res == "success") {
        Fluttertoast.showToast(msg: "Posted");
        clearImage();
      } else {
        Fluttertoast.showToast(msg: res);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    Navigator.of(context).pop();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    captionController.dispose();
    locationController.dispose();
  }
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "New Post",
          style: TextStyle(fontFamily: 'Poppins', color: primary),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: StreamBuilder<User?>(
                    stream: authService.getAuthUser(),
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          postImage(
                            userProvider.getUser.uid,
                            userProvider.getUser.username,
                            userProvider.getUser.image,);
                        },
                        child: Text(
                          "Share",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: textbutton,
                          ),
                        ),
                      );
                    }
                  )))
        ],
      ),
      body: getBody(),
    );
  }

  //display of an image container and display users selected pic caption and location
  Widget getBody() {
    return loading
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 12,
          ),
          Text("Uploading...")
        ],
      ),
    )
        : ListView(
      children: [
        InkWell(
            onTap: () => selectphoto(context),
            child: SizedBox(
              height: 400,
              child: (_file != null)
                  ? Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: Image.file(File(_file!.path)).image,
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 5),
                      blurRadius: 8.0,
                    ),
                  ],
                  gradient: LinearGradient(colors: [
                    Color(0xFFD6B8DB),
                    Color(0xFFC4EFEE)
                  ]),
                ),
                height: 300,
                child: const Center(
                  child: Text(
                    "Tap to select an image",
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ),
              ),
            )),
        Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Write a caption",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontFamily: "Poppins"),
                  ),
                  controller: captionController,
                   onSaved: (value) {
                    captionController.text = value!;
                  },
                  style: TextStyle(
                    color: primary,
                    fontFamily: "poppins",
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Put in a location",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontFamily: "Poppins"),
                  ),
                  controller: locationController,
                  style: TextStyle(
                    color: primary,
                    fontFamily: "poppins",
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}