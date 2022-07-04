import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:app/view/proj_description.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs';

class Projects5 extends StatefulWidget {
  static String id = '/proj';
  String token;
  Projects5({Key? key, required this.token}) : super(key: key);

  @override
  State<Projects5> createState() => _Projects5State(token);
}

class _Projects5State extends State<Projects5> {
  String token;

  _Projects5State(this.token);

  List<Data_of_user>? posts;

  List<String> list_title = [];
  List<String> list_theme = [];
  List<String> list_author = [];
  List<Data_of_user> listData = [];
  List<Data_of_user> list = [];

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
      "Authorization": "Bearer $token",
    });

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['suggestions'];

    for (int i = 0; i < data.length; i++) {
      listData.add(Data_of_user.fromJson(data[i]));
    }
    return listData;
  }

  // Future getToken() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = pref.getString('key_token')!;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getToken();
    getPosts();
    // provid(1);
    getList_theme();
    getList_author();
    getList_title();
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
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ListView.builder(
                    itemExtent: 163,
                    reverse: true,
                    itemCount: list_title.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 2),
                                )
                              ],
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 14,
                                ),
                                Image.asset('images/car.png'),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        '${list_title[i]}',
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
                                        '${list_author[i]}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xffA1A1A1),
                                            fontSize: 14),
                                      ),
                                      Text(
                                        list_theme[i],
                                        style: TextStyle(
                                            color: Color(0xff205692),
                                            fontSize: 14),
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
                                //     Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => Proj_description(
                                //     data_of_user: posts![i],
                                //   ),
                                // ));
                              },
                            ),
                          )
                        ]),
                      );
                    }),
              );
            }
          }),
    );
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
  String? existing_solution_video;
  String? existing_solution_image;

  int? id;
  int? topic_id;
  int? author_id;
  Map<String, dynamic>? author;
  String? existing_solution_text;
  String? proposed_solution_text;
  String? positive_effect;
  int? rating;

  Data_of_user(
      {required this.positive_effect,
      required this.existing_solution_video,
      required this.existing_solution_image,
      required this.proposed_solution_text,
      required this.existing_solution_text,
      required this.title,
      required this.author_id,
      required this.id,
      required this.topic_id,
      required this.author,
      required this.rating});

  factory Data_of_user.fromJson(Map<String, dynamic> json) =>
      _$Data_of_user(json);
}

Data_of_user _$Data_of_user(Map<String, dynamic> json) {
  return Data_of_user(
      existing_solution_video: json['existing_solution_video'],
      positive_effect: json['positive_effect'],
      existing_solution_image: json['existing_solution_image'],
      rating: json['rating'],
      proposed_solution_text: json['proposed_solution_text'],
      existing_solution_text: json['existing_solution_text'],
      author: json["author"],
      title: json['title'],
      id: json['id'],
      author_id: json["author_id"],
      topic_id: json["topic_id"]);
}
