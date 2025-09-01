import 'package:chatapp/constants.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, password, name;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
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
                    "Register",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextfieldWidget(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " please enter your name";
                    }
                    return null;
                  },
                  onchanged: (value) {
                    name = value;
                  },
                  hint: "name",
                  label: "name",
                  obscure: false,
                ),
                const SizedBox(height: 10),
                CustomTextfieldWidget(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " please enter your Emaik";
                    } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return "please enter right email";
                    }
                    return null;
                  },
                  onchanged: (value) {
                    email = value;
                  },
                  hint: "Email",
                  label: "Email",
                  obscure: false,
                ),
                const SizedBox(height: 10),

                CustomTextfieldWidget(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " please enter your password";
                    } else if (passwordController.text == "1234567") {
                      return "please enter strong password";
                    } else if (value.length <= 6) {
                      return " please enter right password";
                    }
                    return null;
                  },
                  onchanged: (value) {
                    password = value;
                  },
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
                  hint: "password",
                  label: "password",
                  obscure: enablepass,
                ),
                const SizedBox(height: 20),

                CustomButton(
                  onpressed: () async {
                    if (formKey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        registerUser();
                        showSnackBar(context, "successfully");
                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: {'email': email, 'name': name},
                        );
                        emailController.clear();
                        passwordController.clear();
                        nameController.clear();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            "The password provided is too weak.",
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            "The account already exists for that email.",
                          );
                        } else {
                          showSnackBar(
                            context,
                            "An error occurred during registration : ${e.code}",
                          );
                        }
                      } catch (e) {
                        showSnackBar(
                          context,
                          "somethine wrong please try again.",
                        );
                      }
                      isloading = false;
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
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    User? username = user.user;

    if (username != null) {
      await username.updateDisplayName(name);
    }
  }
}
