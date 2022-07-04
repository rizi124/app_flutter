// import "dart:convert";

// import 'dart:io';

// import 'package:app/test/entity/example_model.dart';
// import 'package:app/test/entity/post.dart';
// import 'package:app/test/post.dart';

// import 'package:flutter/material.dart';

// class Example extends StatefulWidget {
//   const Example({Key? key}) : super(key: key);

//   @override
//   State<Example> createState() => _ExampleState();
// }

// class _ExampleState extends State<Example> {
//   final model = ExampleWidgetModel();
   
//   // String tok =
//   //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";
//   final client = HttpClient();//https://jsonplaceholder.typicode.com/posts

//   Future<void> getPosts() async {
//     // final json = await get('https://msofter.com/rosseti/public/api/topics')
//     //     as List<dynamic>;
//        final json = await get('https://jsonplaceholder.typicode.com/posts')
//         as List<dynamic>;

//     final posts = json
//         .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<dynamic> get(String ulr) async {
//     Uri url = Uri.parse(ulr);

//     final request = await client.getUrl(url);
//     // request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
//     // request.headers.add("Accept", "application/json");
//     // request.headers.add("Authorization", "Bearer $tok");
//     final response = await request.close();

//     final jsonStrings = await response.transform(utf8.decoder).toList();
//     final jsonString = jsonStrings.join();

//     final dynamic json = jsonDecode(jsonString);
//     return json;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
    
//     // getPosts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: ExampleModelProvider(
//         model: model,
//         child: Column(
//           children: [
//             const _ReloadButton(),
//             const _CreateButton(),
//             const Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: _PostsWidget(),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

// class _ReloadButton extends StatelessWidget {
//   const _ReloadButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () =>
//             ExampleModelProvider.read(context)?.model.reloadPosts(),
//         child: const Text('обноить посты'));
//   }
// }

// class _CreateButton extends StatelessWidget {
//   const _CreateButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () => ExampleModelProvider.read(context)?.model.createPost(),
//         child: const Text('Создать пост'));
//   }
// }

// class _PostsWidget extends StatelessWidget {
//   const  _PostsWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: ExampleModelProvider.watch(context)?.model.posts.length ?? 0,
//       itemBuilder: (BuildContext context, int index) {
//         return _PostsRowWidget(index: index);
//       },
//     );
//   }
// }

// class _PostsRowWidget extends StatelessWidget {
//   final int index;
//   const _PostsRowWidget({Key? key, required this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final post = ExampleModelProvider.read(context)!.model.posts[index];
//     return Column(crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(post..toString()),
// const SizedBox(height: 10.0,),
//         Text(post.title),
//         const SizedBox(height: 40.0,),
//     ],);
//   }
// }
