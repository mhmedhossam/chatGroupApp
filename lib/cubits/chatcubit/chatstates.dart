import 'package:chatapp/models/message_model.dart';

class Chatstates {}

class Initialstate extends Chatstates {}

class Loadingstate extends Chatstates {}

class LoadedMessagesstate extends Chatstates {
  List<MessageModel> listMessage;
  LoadedMessagesstate({required this.listMessage});
}

class Failureloadstate extends Chatstates {}

class Sendmessagestate extends Chatstates {}
