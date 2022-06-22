import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/messages.dart';
import 'package:sociafy/models/user.dart';
import 'package:sociafy/providers/data.dart';

class ViewMessage extends StatefulWidget {
  User user;
  ViewMessage({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewMessage> createState() => _ViewMessageState();
}

class _ViewMessageState extends State<ViewMessage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }

  Widget getAppBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(widget.user.image),
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
                  widget.user.username,
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
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed:(){},
          icon: SvgPicture.asset("assets/icon/voice_call_icon.svg"),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed:(){},
            icon: SvgPicture.asset("assets/icon/video_call_icon.svg"),
          ),
        )
      ],
    );
  }
  Widget getBody(){
    return Column(
      children: [
        Expanded(
          child: GroupedListView<Messages, DateTime>(
            padding: EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (message) => DateTime(
              message.datetime.year,
              message.datetime.month,
              message.datetime.day,
            ),
            groupHeaderBuilder: (Messages messages) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: lightbackground,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      DateFormat.yMMMd().format(messages.datetime),
                      style: TextStyle(
                          fontSize: 10,
                          color: primary,
                          fontFamily: "poppins"
                      ),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Messages messages) => Align(
              alignment: messages.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                color: messages.isSentByMe ? background : iconbutton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        messages.text,
                        style: TextStyle(
                            color: primary,
                            fontFamily: "poppins"
                        ),
                      ),
                      Text(
                        DateFormat.jm().format(messages.datetime),
                        style: TextStyle(
                            fontSize: 10,
                            color: primary,
                            fontFamily: "poppins"
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Type your message here...",
                        hintStyle: TextStyle(
                            color: primary,
                            fontFamily: "poppins"
                        ),
                        border: InputBorder.none
                    ),
                    style: TextStyle(
                      color: primary,
                      fontFamily: "poppins",
                    ),
                    onSubmitted: (text){
                        final message = Messages(
                            sender: currentUser,
                            text: text,
                            datetime: DateTime.now(),
                            unread: true,
                            isSentByMe: true,
                        );
                        setState(() => messages.add(message));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: iconbutton,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.near_me,
                        size: 25,
                        color: primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}