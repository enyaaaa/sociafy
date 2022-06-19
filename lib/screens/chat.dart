import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/chatmessage.dart';
import 'package:sociafy/models/messages.dart';

class Chat extends StatefulWidget {

  static route(Messages data)=> MaterialPageRoute(
    builder: (context)=> Chat(
      message: data,
    ),
  );

  Chat({Key? key, required this.message}) : super(key: key);

  Messages message;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:appBarTitle(
          message: widget.message,
        ),
        actions: [
          IconButton(
            onPressed:(){
            },
            icon: SvgPicture.asset("assets/icon/voice_call_icon.svg"),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed:(){

              },
              icon: SvgPicture.asset("assets/icon/video_call_icon.svg"),
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return Column(
      children: [
        Expanded(
          child: GroupedListView<Chatmessage, DateTime>(
          padding: EdgeInsets.all(8),
          reverse: true,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          floatingHeader: true,
          elements: chatmessages,
          groupBy: (chatmessage) => DateTime(
            chatmessage.date.year,
            chatmessage.date.month,
            chatmessage.date.day,
          ),
          groupHeaderBuilder: (Chatmessage chatmessage) => SizedBox(
            height: 40,
            child: Center(
              child: Card(
                color: primary,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    DateFormat.yMMMd().format(chatmessage.date),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          itemBuilder: (context, Chatmessage chatmessage) => Align(
            alignment: chatmessage.isSentByMe
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(chatmessage.text),
              ),
            ),
          ),
        ),),
        TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: "Type your message here...",
              hintStyle: TextStyle(
                  color: primary,
                  fontFamily: "poppins"
              ),
              border: InputBorder.none
          ),
          onSubmitted: (text){
            final chatmessage = Chatmessage(
                text: text,
                date: DateTime.now(),
                isSentByMe: true
            );
            setState(() => chatmessages.add(chatmessage));
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.send, color: white,),
            backgroundColor: iconbutton,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}

class appBarTitle extends StatelessWidget {
  appBarTitle({Key? key, required this.message}) : super(key: key);

  Messages message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(message.userprofilePic),
                fit: BoxFit.cover
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.username,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                Text(
                  "Active",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 10,
                      color: textbutton
                  ),
                )
              ],
            )
        ),
      ],
    );
  }
}


