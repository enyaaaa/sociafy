import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sociafy/screens/profile.dart';

import '../color/colors.dart';
import '../models/myPost.dart';

//User can post an image
class AddPost extends StatefulWidget {
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //allows validation of form
  final _formKey = GlobalKey<FormState>();

  //the file that user pick from their device
  File? _pickedFile;

  // set initial loading page to false
  bool loading = false;

  //initialise picker as ImagePicker
  final ImagePicker picker = ImagePicker();

  //information on user when posting
  String username = "zendaya";
  String userprofilePic = "assets/users/zendaya.jpg";
  DateTime timeAgo = DateTime.now();
  String? image;
  String? caption;
  String? location;
  bool isliked = false;
  bool issaved = false;

  //user have the selection of camara or gallery
  Future selectphoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop();
                      pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Pick an image"),
                    onTap: () {
                      Navigator.of(context).pop();
                      pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              onClosing: () {},
            ));
  }

  //user to pick image and crop it
  Future pickImage(ImageSource source) async {
    final _pickedFile = await picker.pickImage(source: source);
    if (_pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: _pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    file = await compressImage(file.path, 35);
    final Image = File(file.path);
    setState(() => this._pickedFile = Image);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);

    return result!;
  }

  //when user click on the share button to post the image
  Future<void> postImage() async {
    //when user do not select an image there will be a snack bar to tell user to insert an image before sharing
    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select an image first'),
      ));
      return;
    }

    //set the loading screen to display
    _setLoading(true);

    //saving the users input in caption and location
    _formKey.currentState!.save();

    //the final selected image that user has picked out
    final image = _pickedFile!.path;

    //adding it into myPostList
    context.read<myPostList>().addPost(myPost(
          username: username,
          userprofilePic: userprofilePic,
          timeAgo: timeAgo,
          image: image,
          caption: caption,
          location: location,
          isliked: isliked,
          issaved: issaved,
        ));

    //pop to the profile page to display the post that the users has posted
    Navigator.pop(context);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Profile()));
  }

  //function of the loading
  void _setLoading(bool state, {bool shouldCallSetState = true}) {
    if (loading != state) {
      loading = state;
      if (shouldCallSetState) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  //display of the title add post and the share button
  Widget getAppBar() {
    return AppBar(
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
                child: GestureDetector(
              onTap: postImage,
              child: Text(
                "Share",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: textbutton,
                ),
              ),
            )))
      ],
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
                  onTap: () => selectphoto(),
                  child: SizedBox(
                    height: 400,
                    child: (_pickedFile != null)
                        ? Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                image:
                                    Image.file(File(_pickedFile!.path)).image,
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
                key: _formKey,
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
                        onSaved: (value) {
                          caption = value;
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
                        onSaved: (value) {
                          location = value;
                        },
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
