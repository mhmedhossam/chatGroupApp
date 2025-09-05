import 'package:chatapp/constants.dart';
import 'package:chatapp/cubits/logincubit/logincubit.dart';
import 'package:chatapp/cubits/logincubit/loginstates.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  bool isloading = false;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Logincubit, LoginStates>(
      listener: (context, state) {
        if (state is Loginloading) {
          isloading = true;
          setState(() {});
        } else if (state is LoginSucceeded) {
          isloading = false;
          setState(() {});
          emailController.clear();
          passwordController.clear();
          Navigator.pushNamed(
            context,
            ChatPage.id,
            arguments: {'email': email, 'name': state.name},
          );
        } else if (state is LoginFailure) {
          isloading = false;
          setState(() {});
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: isloading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formkey,

                child: ListView(
                  children: [
                    SizedBox(height: 100),
                    Image.asset("assets/images/scholar.png", height: 100),
                    Center(
                      child: Text(
                        "Welcome Chat",
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: "Pacifico",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "sign in",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextfieldWidget(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "field is required";
                        } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return "please enter valid email";
                        }

                        return null;
                      },

                      onchanged: (value) {
                        email = value;
                      },
                      hint: "Email",
                      label: "Email",
                    ),
                    const SizedBox(height: 10),

                    CustomTextfieldWidget(
                      suffixIcon: IconButton(
                        onPressed: () {
                          enablepass = !enablepass;
                          setState(() {});
                        },
                        icon: enablepass
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.visibility_off),
                        color: Colors.white,
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field is required";
                        }
                        return null;
                      },
                      onchanged: (value) {
                        password = value;
                      },
                      hint: "password",
                      label: "password",
                      obscure: enablepass,
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<Logincubit>(
                            context,
                          ).login(email: email!, password: password!);
                        }
                      },
                      text: "Login",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "donot have an account ? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),

                            minimumSize: WidgetStateProperty.all(Size(0, 0)),
                          ),
                          child: Text(
                            "register",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
