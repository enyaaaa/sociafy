import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/messages.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../screens/chat.dart';

class message_item extends StatelessWidget {
  const message_item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index){
              Messages chat = chats[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Chat(
                        user: chat.sender,
                      )
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right:20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                    chat.sender.image,
                                    fit: BoxFit.cover
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat.sender.username,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  child: Text(
                                    chat.text,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13,),),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              timeago.format(chat.datetime),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 9,
                              ),
                            ),
                            SizedBox(height: 10,),
                            chat.unread? CircleAvatar(
                              backgroundColor: iconbutton,
                              radius: 10,
                              child: Text("1", style: TextStyle(
                                color: primary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),),
                            ): Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
    );
  }
}
