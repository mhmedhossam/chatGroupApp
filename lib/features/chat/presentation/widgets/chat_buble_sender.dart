import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatBubleSender extends StatelessWidget {
  String? message;
  final String nameSender;
  ChatBubleSender({super.key, this.message, required this.nameSender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Align(
        alignment: Alignment.centerRight,

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  color: const Color.fromARGB(255, 184, 183, 183),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      nameSender,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Pacifico",
                      ),
                    ),
                    Text(message!, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              // child: Center(
              //   child: Text(
              //     nameSender,
              //     style: TextStyle(
              //       fontSize: 10,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: "Pacifico",
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
