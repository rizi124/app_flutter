// import 'package:app/test/api_clien.dart';
// import 'package:app/test/entity/post.dart';
// import 'package:app/test/post.dart';
// import 'package:flutter/cupertino.dart';

// class ExampleWidgetModel extends ChangeNotifier {
//   final apiClient = ApiClient();

//   var _posts = <Post>[];
//   List<Post> get posts => _posts;

//   void reloadPosts() async {
//     final posts = await apiClient.getPosts();
//     _posts += !posts;
//     notifyListeners();
//   }

//   void createPost()async {
    
//   }
// }

// class ExampleModelProvider extends InheritedNotifier {
//   final ExampleWidgetModel model;

//   const ExampleModelProvider(
//       {Key? key, required this.model, required Widget child})
//       : super(key: key,notifier:model, child: child);

//   static ExampleModelProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
//   }

//   static ExampleModelProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
//         ?.widget;
//     return widget is ExampleModelProvider ? widget : null;
//   }
// }
