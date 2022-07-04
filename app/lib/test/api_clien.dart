import 'dart:convert';
import 'dart:io';

import 'package:app/models/model_get.dart';

import 'entity/post.dart';

class ApiClient {
  String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";
  final client = HttpClient();

  Future<List<Api>> getPosts() async {
    final json = await get('https://msofter.com/rosseti/public/api/topics')
        as Map<String, dynamic>;

    // final json = await get('https://jsonplaceholder.typicode.com/posts')
    //     as List<dynamic>;

    final data = json["topics"];
    // final posts = json.map((String, dynamic) => Api.fromJson(topics as List<Map<String,dynamic>>)) as Map<String,dynamic>;
    print(data);
    print(data.runtimeType);
    return data;
  }

  Future<dynamic> get(String ulr) async {
    Uri url = Uri.parse(ulr);

    final request = await client.getUrl(url);
    request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
    request.headers.add("Accept", "application/json");
    request.headers.add("Authorization", "Bearer $tok");
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final dynamic json = jsonDecode(jsonString);
    return json;
  }
}

// class Example_M extends StatefulWidget {
//   const Example_M({Key? key}) : super(key: key);

//   @override
//   State<Example_M> createState() => _Example_MState();
// }

// class _Example_MState extends State<Example_M> {
//   List<Post>? posts;
//   var isLoaded = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     getData();
//   }

//   getData() async {
//     final posts = await RemoteService().getPosts();
//     if (posts != null) {
//       setState(() {
//         isLoaded = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Visibility(
//         visible: isLoaded,
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             return Container(
//               child: FlatButton(
//                   onPressed: () {
//                     print(posts![index].topics);
//                   },
//                   child: Text("datta")),
//             );
//           },
//           itemCount: posts?.length,
//         ),
//         replacement: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
