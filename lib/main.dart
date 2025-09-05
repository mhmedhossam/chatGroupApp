import 'package:chatapp/cubits/chatcubit/chatcubit.dart';
import 'package:chatapp/cubits/logincubit/logincubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context) => BlocProvider(
          create: (context) => Logincubit(),
          child: LoginScreen(),
        ),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatPage.id: (context) =>
            BlocProvider(create: (context) => Chatcubit(), child: ChatPage()),
      },
      initialRoute: LoginScreen.id,
      // home: LoginScreen(),
    );
  }
}
