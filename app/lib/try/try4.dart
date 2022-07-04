import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

String tok =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";

// List<Post_Api> posts = [];
// final client = HttpClient();

// Future<void> getPosts() async {
//   final json = await get('https://msofter.com/rosseti/public/api/topics')
//       as Map<String, dynamic>;

//   final data = json["topics"] as List<dynamic>;

//   posts = data
//       .map((dynamic e) => Post_Api.fromJson(e as Map<String, dynamic>))
//       .toList();
//   print(posts[0].title.runtimeType);
// }

// Future<dynamic> get(String ulr) async {
//   Uri url = Uri.parse(ulr);

//   final request = await client.getUrl(url);
//   request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
//   request.headers.add("Accept", "application/json");
//   request.headers.add("Authorization", "Bearer $tok");
//   final response = await request.close();

//   final jsonStrings = await response.transform(utf8.decoder).toList();
//   final jsonString = jsonStrings.join();

//   final dynamic json = jsonDecode(jsonString);

//   return json;
// }

class Post_Api {
  int? id;
  String? title;
  Post_Api({required this.id, required this.title});

  factory Post_Api.fromJson(Map<String, dynamic> json) =>
      _$Post_ApiFromJson(json);
}

Post_Api _$Post_ApiFromJson(Map<String, dynamic> json) {
  return Post_Api(id: json['id'] as int, title: json['title'] as String);
}

// Future<List<Post_Api>> getData() async {
//   String url = "https://msofter.com/rosseti/public/api/topics";
//   var apiresponse = await http.get(Uri.parse(url));

//   var jsonObject = json.decode(apiresponse.body);
//   List<dynamic> data = (jsonObject as Map<String, dynamic>)['topics'];

//   List<Post_Api> listData = [];

//   for (int i = 0; i < data.length; i++)
//     listData.add(Post_Api.fromJson(data[i]));
//   return listData;
// }

class Hom1 extends StatefulWidget {
  const Hom1({Key? key}) : super(key: key);

  @override
  State<Hom1> createState() => _Hom1State();
}

class _Hom1State extends State<Hom1> {
  List<Post_Api> list = [];
  List<String> list_title = [];

  void getListApi() {
    getData().then((value) {
      list = value;
      print(list.runtimeType);
      setState(() {});
    });
  }

  void getListAp1() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].title.toString());
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                getListAp1();
              },
              child: Text('data')),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(list_title[i]),
                    // subtitle: Text(list[i].id.toString()),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(list_title[i].toString()),
                      ));
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<List<Post_Api>> getData() async {
    String url = "https://msofter.com/rosseti/public/api/topics";
    var apiresponse = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tok",
      },
    );

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['topics'];

    List<Post_Api> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Post_Api.fromJson(data[i]));

    return listData;
  }
}
