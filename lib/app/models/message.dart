class Message {
  String id;
  String sender;
  String receiver;
  String content;
  DateTime time;
  String category;
  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.time,
    required this.category,
  });
}
