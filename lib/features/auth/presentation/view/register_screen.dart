import 'package:chatapp/core/constant/constants.dart';
import 'package:chatapp/core/dialogs/snack_bar.dart';
import 'package:chatapp/core/utils/app_font.dart';
import 'package:chatapp/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/features/auth/presentation/cubit/auth_cubit/auth_states.dart';
import 'package:chatapp/features/chat/presentation/view/chat_page.dart';
import 'package:chatapp/features/auth/presentation/widgets/custom_button.dart';
import 'package:chatapp/features/auth/presentation/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthCubit>(context);
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSucceededState) {
          showSnackBar(context, "successfully");
          Navigator.pushNamed(
            context,
            ChatPage.id,
            arguments: {
              'email': cubit.emailController.text,
              'name': cubit.nameController.text,
            },
          );
          cubit.emailController.clear();
          cubit.passwordController.clear();
          cubit.nameController.clear();
        } else if (state is AuthFailureState) {
          showSnackBar(context, state.errorMessage ?? "error please try again");
        }
      },
      child: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          var cubit = BlocProvider.of<AuthCubit>(context);

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
                          "Chat Group",
                          style: TextStyle(
                            fontFamily: AppFont.pacifico,
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextfieldWidget(
                        autovalidateMode: cubit.autovalidateMode,
                        controller: cubit.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return " please enter your name";
                          }
                          return null;
                        },

                        hint: "name",
                        label: "name",
                      ),
                      const SizedBox(height: 10),
                      CustomTextfieldWidget(
                        autovalidateMode: cubit.autovalidateMode,

                        controller: cubit.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return " please enter your Email";
                          } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                            return "please enter right email";
                          }
                          return null;
                        },

                        hint: "Email",
                        label: "Email",
                      ),
                      const SizedBox(height: 10),

                      CustomTextfieldWidget(
                        autovalidateMode: cubit.autovalidateMode,

                        controller: cubit.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return " please enter your password";
                          } else if (value.length <= 6) {
                            return " please enter Strong password";
                          }
                          return null;
                        },

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
                        hint: "password",
                        label: "password",
                        obscure: enablePass,
                      ),
                      const SizedBox(height: 20),

                      CustomButton(
                        onPressed: () async {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.register();
                          } else {
                            cubit.autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },

                        text: "Register",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already have an account ? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(EdgeInsets.zero),

                              minimumSize: WidgetStateProperty.all(Size(0, 0)),
                            ),
                            child: Text(
                              "Login",
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
      ),
    );
  }
}
