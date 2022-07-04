import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:app/test/api_clien.dart';
import 'package:app/view/chat/model.dart';
import 'package:flutter/material.dart';

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs';

class ListCard extends StatefulWidget {
  ListCard({Key? key}) : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  List<Projects> list = [];
  List<Projects> listData = [];

  Future<List<Projects>> getList() async {
    String url = 'https://msofter.com/rosseti/public/api/suggestions/index';
    var apiresponse = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['suggestions'];
    for (int i = 0; i < data.length; i++) {
      listData.add(Projects.fromJson(data[i]));
    }
    print(listData.length);
    return listData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
    // getListImage();
    getListTitle();
    getListTheme();

    // getListData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemExtent: 163,
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          // final proj = model.suggets[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                    )
                  ],
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                ),
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: [
                    SizedBox(
                      width: 14,
                    ),
                    list_image != null
                        ? Image.network(
                            list_image.toString(),
                            width: 34,
                          )
                        : Container(
                            width: 35,
                            height: 35,
                            color: Colors.red,
                          ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'list_title.toString()',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff205692),
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'proj.author ?? автор',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xffA1A1A1), fontSize: 14),
                          ),
                          Text(
                            'list_theme.toString()',
                            style: TextStyle(
                                color: Color(0xff205692), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    print('object');
                  },
                ),
              )
            ]),
          );
        },
      ),
    );
  }

  final client = HttpClient();

  List<Projects> posts = [];
  var path;

  Future<dynamic> get(String ulr) async {
    Uri url = Uri.parse(ulr);
    final request = await client.getUrl(url);
    request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
    request.headers.add("Accept", "application/json");
    request.headers.add("Authorization", "Bearer $token");
    final response = await request.close();
    print(response.statusCode);
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    var lol = json as Map<String, dynamic>;
    path = lol['suggestions'];
    // print(json);
    return json;
  }

  List<String> list_title = [];

  void getListTitle() {
    getListData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].title.toString());
      }
    });
  }

  List<String> list_theme = [];
  void getListTheme() {
    getListData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_theme.add(list[i].topic_id.toString());
      }
    });
  }

  List<String> list_image = [];
  void getListImage() {
    getListData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_image.add(list[i].image.toString());
      }
      list_image[0];
      print(list_image[0]);
    });
  }

  Future<List<Projects>> getListData() async {
    final json =
        await get('https://msofter.com/rosseti/public/api/suggestions/index')
            as Map<String, dynamic>;
    // print("json ${json.runtimeType}");

    final data = json["suggestions"] as List<dynamic>;
    print("data  $data");
    // print(data.runtimeType);

    posts = data
        .map((dynamic e) => Projects.fromJson(e as Map<String, dynamic>))
        .toList();
    print(posts.length);
    return posts;
    // print(posts?[0].topic_id);

    //  author_post = posts?[0].author;

    // print(author_post.runtimeType);

    // print(posts?[0].author!['full_name']);
  }
}

class Projects {
  String? title;
  int? topic_id;
  String? image;

  Projects({required this.image, required this.title, required this.topic_id});

  factory Projects.fromJson(Map<String, dynamic> json) => _$Projects(json);
}

Projects _$Projects(Map<String, dynamic> json) {
  return Projects(
      image: json['image'], title: json['title'], topic_id: json['topic_id']);
}



// // где находятся данные

// class Proj_in_suggestions {
//   final List<dynamic> suggestions;
//   final bool success;

//   Proj_in_suggestions({required this.success, required this.suggestions});

//   factory Proj_in_suggestions.fromJson(Map<String, dynamic> json) =>
//       _$Proj_in_suggestionsFromJSon(json);
// }

// Proj_in_suggestions _$Proj_in_suggestionsFromJSon(Map<String, dynamic> json) {
//   return Proj_in_suggestions(
//       success: json['success'] as bool,
//       suggestions: (json['suggestions'] as List<dynamic>)
//           .map((e) => Proj.fromJson(e as Map<String, dynamic>))
//           .toList());
// }

// // что мы получим

// class Proj {
//   final String? title;
//   final int? topic_id;
//   final String? existing_solution_image;

//   Proj(
//       {required this.existing_solution_image,
//       required this.title,
//       required this.topic_id});
//   factory Proj.fromJson(Map<String, dynamic> json) => _$ProjFromJson(json);
// }

// Proj _$ProjFromJson(Map<String, dynamic> json) {
//   return Proj(
//       existing_solution_image: json['existing_solution_image'] as String,
//       title: json['title'] as String,
//       topic_id: json['topic_id'] as int);
// }

// enum ApiClientExceptionType { Network, Auth, Other }

// class ApiClientException implements Exception {
//   final ApiClientException type;
//   ApiClientException(this.type);
// }

// class ApiClient {
//   final _client = HttpClient();
//   static const apiLey =
//       'https://msofter.com/rosseti/public/api/suggestions/index';

//   Future<String> makeToken() async {
//     final url = Uri.parse('uri');
//     final request = await _client.getUrl(url);
//     final resposne = await request.close();
//     print(resposne.statusCode);
//     final json = await resposne
//         .transform(utf8.decoder)
//         .toList()
//         .then((value) => value.join())
//         .then((v) => jsonDecode(v) as Map<String, dynamic>);
//     final token = json['reqest_token'] as String;
//     return token;
//   }
//   // Future<String> validateUser()async{
//   //   final url=Uri.parse('https://msofter.com/rosseti/public/api/user');

//   // }

//   Uri _makeUri([Map<String, dynamic>? parameters]) {
//     final uri =
//         Uri.parse('https://msofter.com/rosseti/public/api/suggestions/index');
//     if (parameters != null) {
//       return uri.replace(queryParameters: parameters);
//     } else {
//       return uri;
//     }
//   }

//   Future<T> _get<T>(T Function(dynamic json) parser,
//       [Map<String, dynamic>? parameters]) async {
//     final url = _makeUri(parameters);
//     final request = await _client.getUrl(url);
//     request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
//     request.headers.add("Accept", "application/json");
//     request.headers.add("Authorization", "Bearer $token");
//     final response = await request.close();
//     final dynamic json = (await response.jsonDecode());
//     final result = parser(json);
//     return result;
//   }

//   Future<dynamic> Suggestions() async {
//     final parser = (dynamic json) {
//       final jsonMap = json as Map<String, dynamic>;
//       final response = Proj_in_suggestions.fromJson(jsonMap);

//       return response;
//     };
//     final result = _get(parser, <String, dynamic>{});
//     return result;
//   }
// }

// extension HttpClientResponseJsonDecode on HttpClientResponse {
//   dynamic jsonDecode() {
//     return transform(utf8.decoder)
//         .toList()
//         .then((value) => value.join())
//         .then<dynamic>((v) => json.decode(v));
//   }
// }
