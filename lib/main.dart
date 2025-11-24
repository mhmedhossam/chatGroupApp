import 'package:chatapp/core/utils/app_font.dart';
import 'package:chatapp/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/features/splash_screen/splash_screen.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/features/chat/presentation/view/chat_page.dart';
import 'package:chatapp/features/auth/presentation/view/login_screen.dart';
import 'package:chatapp/features/auth/presentation/view/register_screen.dart';
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
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
        RegisterScreen.id: (context) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
        ChatPage.id: (context) => BlocProvider(
          create: (context) => ChatCubit()..chatPage(),
          child: ChatPage(),
        ),

        SplashScreen.id: (context) => SplashScreen(),
      },
      initialRoute: SplashScreen.id,
      // home: LoginScreen(),
    );
  }
}
