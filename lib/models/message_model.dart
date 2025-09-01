class MessageModel {
  final String message;
  final dynamic date;
  final String id;
  final String name;

  MessageModel({
    required this.message,
    required this.date,
    required this.id,
    required this.name,
  });

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      message: jsonData["message"],
      date: jsonData["date"],
      id: jsonData["id"],
      name: jsonData["name"],
    );
  }
}
