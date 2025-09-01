import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatBubleReceiver extends StatelessWidget {
  String? message;
  final String nameReceive;

  ChatBubleReceiver({super.key, this.message, required this.nameReceive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Align(
        alignment: Alignment.centerLeft,

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: Icon(Icons.account_circle_sharp, size: 40),
                // child: Text(
                //   nameReceive,
                //   style: TextStyle(fontSize: 10, fontFamily: "Pacifico"),
                // ),
              ),
            ),

            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                  right: 10,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff5886fe),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameReceive,
                      style: TextStyle(fontSize: 10, fontFamily: "Pacifico"),
                    ),
                    Text(message!, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
