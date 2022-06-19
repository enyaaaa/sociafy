import 'package:flutter/material.dart';
import 'package:sociafy/color/colors.dart';
import 'package:sociafy/models/messages.dart';
import 'package:sociafy/screens/chat.dart';

class message_item extends StatelessWidget {
  message_item({Key? key, required this.message}) : super(key: key);

  Messages message;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(Chat.route(message));
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: primary,
                  width: 0.2,
                )
            )
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(message.userprofilePic),
                      fit: BoxFit.cover
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(message.username,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(message.message,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    message.dateMessage.toLowerCase(),
                    style: TextStyle(
                      fontSize: 11,
                      color: primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: iconbutton,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('1',
                          style:TextStyle(
                            fontSize: 10,
                            color: primary,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}