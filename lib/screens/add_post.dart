import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sociafy/color/colors.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sociafy/models/myMedia.dart';
import 'package:sociafy/screens/profile.dart';

class AddPost extends StatefulWidget {

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final _formKey = GlobalKey<FormState>();
  final caption = TextEditingController();

  File? _pickedFile;
  bool loading = false;

  final ImagePicker picker = ImagePicker();

  String username = "zendaya";
  String userprofilePic = "assets/users/zendaya.jpg";
  DateTime timeAgo = DateTime.now();
  String? image;
  String location = "";
  bool isliked = false;
  int likecount = 0;
  int commentcount = 0;

  Future selectphoto() async{
    await showModalBottomSheet(context: context, builder: (context)=> BottomSheet(
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: (){
              Navigator.of(context).pop();
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.filter),
            title: Text("Pick an image"),
            onTap: (){
              Navigator.of(context).pop();
              pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
      onClosing: () {},
    ));
  }

  Future pickImage(ImageSource source) async{
    final _pickedFile = await picker.pickImage(source: source);
    if(_pickedFile == null){
      return;
    }

    var file = await ImageCropper().cropImage(sourcePath: _pickedFile.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null){
      return;
    }

    file = await compressImage(file.path, 35);
    final Image = File(file.path);
    setState(() => this._pickedFile = Image);
  }

  Future<File>compressImage(String path, int quality) async{
    final newPath  = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
        path,
        newPath,
        quality: quality
    );

    return result!;
  }

  Future<void>postImage()async{
    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image first'),));
      return;
    }

    print(caption);
    print(_pickedFile);

    _setLoading(true);

    final image = _pickedFile!.path;

    context.read<myPostList>().addPost(myPost(
        username: username,
        userprofilePic: userprofilePic,
        timeAgo: timeAgo,
        image: image,
        caption: caption.text,
        location: location,
        isliked: isliked,
        likecount: likecount,
        commentcount: commentcount
    )
    );

    Navigator.pop(context);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Profile()
    ));
  }

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
      appBar: PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  Widget getAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text( "New Post", style: TextStyle(
          fontFamily: 'Poppins',
          color: primary),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child:Center(
                child: GestureDetector(
                  onTap: postImage,
                  child:
                  Text( "Share", style: TextStyle(
                    fontFamily: 'Poppins',
                    color: textbutton,
                  ),
                  ),
                )
            ))
      ],
    );
  }
  Widget getBody(){
    return loading ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12,),
          Text("Uploading...")
        ],
      ),
    ) :ListView(
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
                    image: Image.file(File(_pickedFile!.path)).image,
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
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFD6B8DB),
                        Color(0xFFC4EFEE)
                      ]
                  ),
                ),
                height: 300,
                child: const Center(
                  child: Text(
                    "Tap to select an image",
                    style: TextStyle(
                        fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),
            )
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: caption,
              decoration: InputDecoration(
                hintText: "Write a caption",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontFamily: "Poppins"
                ),
              ),
              validator: (caption) {
                if (caption == null || caption.isEmpty) {
                  return 'Caption is empty';
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }
}