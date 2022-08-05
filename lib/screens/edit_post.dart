import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../color/colors.dart';
import '../models/post.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';

class EditPost extends StatefulWidget {
  final postId;
  final uid;

  EditPost({Key? key, required this.postId, required this.uid})
      : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {

  //user input
  String? caption;
  String? location;

  //creating a variable
  var userData = {};
  var userPost = {};

  //make loading default to false
  bool isLoading = false;

  //key for validation
  var form = GlobalKey<FormState>();

  //initialize data
  @override
  void initState() {
    super.initState();
    getData();
  }

  //get data from collection in firebase
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      var userpost = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postId)
          .get();

      userData = usersnap.data()!;
      userPost = userpost.data()!;
      caption = userPost["caption"];
      location = userPost["location"];
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: iconbutton, textColor: primary);
    }
    setState(() {
      isLoading = false;
    });
  }

  //file that user pick from device
  File? _file;

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

  //compress the selected image
  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);

    return result!;
  }

  //function for save post when user click on the save button
  savePost() async {
    form.currentState!.save();
    if (form.currentState!.validate() && !isLoading) {
      setState(() {
        isLoading = true;
      });
      String postImage = '';
      if (_file == null) {
        postImage = userPost["postUrl"];
      } else {
        postImage =
            await StorageService().uploadImageToStorage('posts', _file!, true);
      }
      Post user = Post(
          uid: widget.uid,
          username: userData['username'],
          image: userData['image'],
          postId: widget.postId,
          caption: caption!,
          location: location!,
          timeAgo: DateTime.now(),
          postUrl: postImage,
          likes: userPost['likes'],
          saved: userPost['saved']);

      FireStoreService().updatePostData(user);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Successfully Updated Post",
          backgroundColor: iconbutton,
          textColor: primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              child: getAppBar(),
              preferredSize: Size.fromHeight(60),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                          color: postItem,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => selectphoto(context),
                            child: (_file != null)
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 0),
                                    width: double.infinity,
                                    height: 390.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: postbackground,
                                          offset: Offset(0, 1),
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image:
                                            Image.file(File(_file!.path)).image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 0),
                                    width: double.infinity,
                                    height: 390.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: postbackground,
                                          offset: Offset(0, 1),
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(userPost['postUrl']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: form,
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue: caption,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Poppins",
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Add a caption"),
                                    onChanged: (val) {
                                      caption = val;
                                    },
                                  ),
                                  TextFormField(
                                      initialValue: location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Add a location"),
                                      onChanged: (val) {
                                        location = val;
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  //widget for the app bar
  Widget getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Edit Post",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: primary,
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: GestureDetector(
              onTap: () {
                savePost();
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: textbutton,
                ),
              ),
            )))
      ],
    );
  }
}
