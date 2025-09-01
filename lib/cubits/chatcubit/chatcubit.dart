import 'package:chatapp/constants.dart';
import 'package:chatapp/cubits/chatcubit/chatstates.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chatcubit extends Cubit<Chatstates> {
  Chatcubit() : super(Initialstate());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollection,
  );
  void chatpage() {
    emit(Loadingstate());

    try {
      messages
          .orderBy('date', descending: true)
          .snapshots()
          .listen(
            (snapshot) {
              List<MessageModel> listMessage = [];

              for (var doc in snapshot.docs) {
                listMessage.add(MessageModel.fromJson(doc));
              }
              emit(LoadedMessagesstate(listMessage: listMessage));
            },
            onError: (error) {
              emit(Failureloadstate());
            },
          );
    } catch (e) {
      emit(Failureloadstate());
    }
  }

  Future<void> sendmessage({
    required String message,
    required String email,
    required String name,
  }) async {
    final now = DateTime.now();

    await messages.add({
      "message": message,
      "date": now,
      "id": email,
      "name": name,
    });
  }
}
