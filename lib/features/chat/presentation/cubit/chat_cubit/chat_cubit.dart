import 'package:chatapp/core/constant/constants.dart';
import 'package:chatapp/features/chat/presentation/cubit/chat_cubit/chat_states.dart';
import 'package:chatapp/features/chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialState());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollection,
  );
  void chatPage() {
    emit(LoadingState());

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
              emit(LoadedMessagesState(listMessage: listMessage));
            },
            onError: (error) {
              emit(FailureLoadState());
            },
          );
    } catch (e) {
      emit(FailureLoadState());
    }
  }

  Future<void> sendMessage({
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
