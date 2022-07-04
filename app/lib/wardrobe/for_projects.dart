import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:app/view/proj_description.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

String tok =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE';

class Projects4 extends StatefulWidget {
  static String id = '/proj';
  const Projects4({Key? key}) : super(key: key);

  @override
  State<Projects4> createState() => _Projects4State();
}

class _Projects4State extends State<Projects4> {
  String? token;

  List<Data_of_user>? posts;

  List<Data_of_user> listData = [];

  Future getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('key_token')!;
    });
  }

  @override
  void initState() {
    super.initState();
    // getToken();
    // getData();
    getPosts();
    getList_title();
    getList_theme();
    getList_author();
  }

  // dynamic provid(int i)  {
  //   author_post = posts?[i].author;
  //   var author = author_post!['full_name'];
  //   return author ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Image.asset('images/icon.png'))
        ],
        elevation: 0,
        backgroundColor: Color(0xffFAFBFD),
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Image.asset('images/Vector.png')),
        title: Center(
          child: Text(
            'Проекты',
            style: TextStyle(
                fontFamily: 'Schyler',
                fontSize: 43.0,
                color: Color(0xff205692)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: ListView.builder(
            reverse: true,
            itemCount: list_title.length,
            itemBuilder: (context, i) {
              return Expanded(
                child: FlatButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => Proj_description(
                    // data_of_user: posts![i] ,
                    //   ),
                    // ));
                  },
                  child: Card(
                    child: Container(
                      // color: Colors.red,
                      height: 124.0,
                      width: 336.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset('images/car.png'),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '${list_title[i]}',
                                      overflow: TextOverflow.ellipsis,
                                      // softWrap: false,
                                      //  maxLines: 1,
                                      style: TextStyle(
                                          fontFamily: 'Schyler',
                                          color: Color(0xff205692),
                                          fontSize: 20),
                                    ),
                                    Container(
                                      height: 30,
                                    ),
                                    Text(
                                      (list_author[i]).toString(),
                                      // provid(i),
                                      style:
                                          TextStyle(color: Color(0xffA1A1A1)),
                                    ),
                                    Text('${list_theme[i]}',
                                        style: TextStyle(
                                            fontFamily: 'Schyler',
                                            color: Color(0xff205692),
                                            fontSize: 14.0)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  List<Data_of_user> list = [];
  List<String> list_title = [];
  List<String> list_theme = [];
  List<String> list_author = [];

  void getList_title() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].title.toString());
      }
      setState(() {});
    });
  }

  void getList_theme() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_theme.add(list[i].topic_id.toString());
      }
      setState(() {});
    });
  }

  void getList_author() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_author.add(list[i].author!['full_name'].toString());
      }
      setState(() {});
    });
  }

  Future<List<Data_of_user>> getData() async {
    String url = 'https://msofter.com/rosseti/public/api/suggestions/index';
    var apiresponse = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $tok",
    });

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['suggestions'];

    for (int i = 0; i < data.length; i++) {
      listData.add(Data_of_user.fromJson(data[i]));
    }
    return listData;
  }

  final client = HttpClient();

  Future<void> getPosts() async {
    final json =
        await get('https://msofter.com/rosseti/public/api/suggestions/index')
            as Map<String, dynamic>;
    // print("json ${json.runtimeType}");

    final data = json["suggestions"] as List<dynamic>;
    // print("data  $data");
    // print(data.runtimeType);

    posts = data
        .map((dynamic e) => Data_of_user.fromJson(e as Map<String, dynamic>))
        .toList();

    //  author_post = posts?[0].author;

    // print(author_post.runtimeType);

    // print(posts?[0].author!['full_name']);
  }

  Future<dynamic> get(String ulr) async {
    Uri url = Uri.parse(ulr);

    final request = await client.getUrl(url);
    request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
    request.headers.add("Accept", "application/json");
    request.headers.add("Authorization", "Bearer $token");
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final dynamic json = jsonDecode(jsonString);
    // print("json ${json.runtimeType}");
    return json;
  }
}

class Data_of_user {
  String? title;
  int? id;
  int? topic_id;
  int? author_id;
  Map<String, dynamic>? author;
  String? existing_solution_text;
  String? proposed_solution_text;
  String? positive_effect;
  int? rating;
  List<dynamic>? comments;

  Data_of_user(
      {required this.positive_effect,
      required this.proposed_solution_text,
      required this.existing_solution_text,
      required this.title,
      required this.author_id,
      required this.id,
      required this.topic_id,
      required this.author,
      required this.rating,
      required this.comments});

  factory Data_of_user.fromJson(Map<String, dynamic> json) =>
      _$Data_of_user(json);
}

Data_of_user _$Data_of_user(Map<String, dynamic> json) {
  return Data_of_user(
      comments: json['comments'],
      positive_effect: json['positive_effect'],
      rating: json['rating'],
      proposed_solution_text: json['proposed_solution_text'],
      existing_solution_text: json['existing_solution_text'],
      author: json["author"],
      title: json['title'],
      id: json['id'],
      author_id: json["author_id"],
      topic_id: json["topic_id"]);
}

class Data_comments {
  int? id;
  String? text;
  int? user_id;
  int? suggestion_id;

  int? you;
  Map? user;
  Data_comments(
      {required this.id,
      required this.suggestion_id,
      required this.text,
      required this.user,
      required this.user_id,
      required this.you});
      factory Data_comments.fromJson(Map<String, dynamic> json) =>
      _$Data_comments(json);

}
Data_comments _$Data_comments(Map<String, dynamic> json) {
  return Data_comments(
      id: json['id'],
      text: json['text'],
      suggestion_id: json['suggestion_id'],
      user: json['user'],
      user_id: json['user_id'],
      you: json["you"]
      );
}
