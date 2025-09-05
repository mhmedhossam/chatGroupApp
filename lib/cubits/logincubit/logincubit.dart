import 'package:chatapp/cubits/logincubit/loginstates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logincubit extends Cubit<LoginStates> {
  Logincubit() : super(Initialstate());

  Future<void> login({required String email, required String password}) async {
    emit(Loginloading());
    try {
      var auth = FirebaseAuth.instance;
      await auth.signOut();
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String name = user.user!.displayName!;
      emit(LoginSucceeded(name: name));
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
      emit(LoginFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(
        LoginFailure(errorMessage: "Something went wrong. Please try again."),
      );
    }
  }
}
