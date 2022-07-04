import 'package:app/view/chat/user_model.dart';

class Message {
  final User sender;

  final String text;
  final bool unread;
  final bool isLiked;

  Message(
      {required this.text,
      required this.unread,
      required this.isLiked,
      required this.sender});
}

// My data

final User currentUser = User(id: 0, name: 'Tom');

// Data for Users

final User greg = User(id: 1, name: 'Greg');
final User tony = User(id: 1, name: 'Tony');
final User siry = User(id: 1, name: 'Siry');
final User holly = User(id: 1, name: 'Holly');

List<User> favorites = [greg, tony, siry, holly];

List<Message> chats = [
  Message(text: 'Привет, Tony!', unread: true, isLiked: false, sender: greg),
  Message(text: 'Привет, Greg!', unread: true, isLiked: false, sender: tony),
  Message(text: 'Привет, Siry', unread: true, isLiked: false, sender: holly),
  Message(text: 'Привет, Holly', unread: true, isLiked: false, sender: siry)
];

List<Message> messages = [
  Message(text: 'Привет, Tony!', unread: true, isLiked: false, sender: greg),
  Message(text: 'Привет, Greg!', unread: true, isLiked: false, sender: tony),
  Message(text: 'Привет, Siry', unread: true, isLiked: false, sender: holly),
  Message(text: 'Привет, Holly', unread: true, isLiked: false, sender: siry),
  Message(text: 'Пока ребят', unread: true, isLiked: false, sender: currentUser)];
