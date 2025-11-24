import 'package:chatapp/features/chat/data/models/message_model.dart';

class ChatStates {}

class InitialState extends ChatStates {}

class LoadingState extends ChatStates {}

class LoadedMessagesState extends ChatStates {
  List<MessageModel> listMessage;
  LoadedMessagesState({required this.listMessage});
}

class FailureLoadState extends ChatStates {}
