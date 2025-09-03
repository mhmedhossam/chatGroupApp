import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password, name;

  bool isloading = false;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  onpressed: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        var auth = FirebaseAuth.instance;
                        await auth.signOut();
                        UserCredential user = await auth
                            .signInWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            );
                        name = user.user!.displayName;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("login successfully")),
                        );
                        emailController.clear();
                        passwordController.clear();
                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: {'email': email, 'name': name},
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No user found for that email."),
                            ),
                          );
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Wrong password provided for that user.",
                              ),
                            ),
                          );
                        } else if (e.code == "channel-error") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("please enter email and password"),
                            ),
                          );
                        } else if (e.code == "invalid-email") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "please enter right email example : abcd@gmail.com",
                              ),
                            ),
                          );
                        } else if (e.code == "invalid-credential") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "please enter right email and password ",
                              ),
                            ),
                          );
                        } else {
                          print(e.code);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("somethine wrong please try again."),
                          ),
                        );
                      }
                      isloading = false;
                      setState(() {});
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
  }
}
