import 'package:chatapp/features/auth/presentation/cubit/auth_cubit/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthCubit() : super(InitialState());
  var auth = FirebaseAuth.instance;
  late UserCredential user;
  Future<void> login() async {
    emit(AuthLoadingState());
    try {
      await auth.signOut();
      user = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      String name = user.user!.displayName!;
      emit(AuthSucceededState(name: name));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided for that user.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Please enter a valid email address.";
      } else {
        errorMessage = "An unexpected error occurred. Please try again.";
      }
      emit(AuthFailureState(errorMessage: errorMessage));
    } catch (e) {
      emit(
        AuthFailureState(
          errorMessage: "Something went wrong. Please try again.",
        ),
      );
    }
  }

  Future<void> register() async {
    emit(AuthLoadingState());
    try {
      user = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? username = user.user;

      if (username != null) {
        await username.updateDisplayName(nameController.text);
      }
      emit(AuthSucceededState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState(errorMessage: e.toString()));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState(errorMessage: e.toString()));
      } else {
        emit(AuthFailureState(errorMessage: e.toString()));
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: "some thing wrong please try again"));
    }
  }
}
