import 'package:chatapp/core/constant/constants.dart';
import 'package:chatapp/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/features/chat/presentation/cubit/chat_cubit/chat_states.dart';
import 'package:chatapp/features/auth/presentation/view/login_screen.dart';
import 'package:chatapp/features/chat/presentation/widgets/chat_bubble_reveiver.dart';
import 'package:chatapp/features/chat/presentation/widgets/chat_buble_sender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  static String id = "chatpage";
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String valuee;
  final listController = ScrollController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    var email;
    var name;
    if (args is Map) {
      email = args['email'];
      name = args['name'];
      name ??= "";
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.id,
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/scholar.png", height: 50, width: 50),
            Text("Whatsapp Group", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatStates>(
                listener: (context, state) {
                  if (state is LoadedMessagesState) {
                    if (listController.hasClients) {
                      listController.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is LoadedMessagesState) {
                    var listMessage = state.listMessage;
                    return ListView.builder(
                      reverse: true,
                      controller: listController,
                      itemCount: listMessage.length,
                      itemBuilder: (context, index) =>
                          listMessage[index].id == email
                          ? ChatBubleSender(
                              message: listMessage[index].message,
                              nameSender: listMessage[index].name,
                            )
                          : ChatBubleReceiver(
                              message: listMessage[index].message,
                              nameReceive: listMessage[index].name,
                              // FirebaseAuth.instance.currentUser.displayName,
                            ),
                    );
                  } else if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FailureLoadState) {
                    return Center(child: Text("there is an error"));
                  } else {
                    return const Center(child: Text('Start chatting!'));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: messageController,
                onChanged: (value) {
                  valuee = value;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "enter your message",
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (valuee.isNotEmpty) {
                        BlocProvider.of<ChatCubit>(context).sendMessage(
                          email: email,
                          name: name,
                          message: valuee,
                        );

                        messageController.clear();
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//class
