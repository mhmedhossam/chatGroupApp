import 'package:chatapp/core/constant/constants.dart';
import 'package:chatapp/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/features/auth/presentation/cubit/auth_cubit/auth_states.dart';
import 'package:chatapp/features/chat/presentation/view/chat_page.dart';
import 'package:chatapp/features/auth/presentation/view/register_screen.dart';
import 'package:chatapp/features/auth/presentation/widgets/custom_button.dart';
import 'package:chatapp/features/auth/presentation/widgets/custom_textfield_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSucceededState) {
          Navigator.pushNamed(
            context,
            ChatPage.id,
            arguments: {
              'email': cubit.emailController.text,
              'name': state.name,
            },
          );
        } else if (state is AuthFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: state is AuthLoadingState ? true : false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: cubit.formKey,

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
                      controller: cubit.emailController,
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

                      hint: "Email",
                      label: "Email",
                    ),
                    const SizedBox(height: 10),

                    CustomTextfieldWidget(
                      suffixIcon: IconButton(
                        onPressed: () {
                          enablePass = !enablePass;
                          setState(() {});
                        },
                        icon: enablePass
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.visibility_off),
                        color: Colors.white,
                      ),
                      controller: cubit.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field is required";
                        }
                        return null;
                      },

                      hint: "password",
                      label: "password",
                      obscure: enablePass,
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.login();
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
