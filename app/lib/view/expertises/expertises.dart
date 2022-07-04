import 'dart:convert';
import 'dart:io';
import 'package:app/view/expertises/allow_or_not.dart';
import 'package:http/http.dart' as http;
import 'package:app/view/proj_description.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../applications/projects.dart';

class Expertises extends StatefulWidget {
  static String id = '/proj';
  String token;
  int number;
  Expertises({Key? key, required this.token, required this.number})
      : super(key: key);

  @override
  State<Expertises> createState() => _ExpertisesState(token,number);
}

class _ExpertisesState extends State<Expertises> {
  String token;
  int number;

  _ExpertisesState(this.token, this.number);

  List<Data_of_user>? posts;

  List<String> list_title = [];
  List<String> list_theme = [];
  List<String> list_author = [];
  List<String> list_image = [];
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

  void getList_image() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_image.add(list[i].existing_solution_image.toString());
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
    print(token);
    // provid(1);
    getList_theme();
    getList_author();
    getList_title();
    getList_image();
    print("Hello Im ");
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
                    itemCount: list_title.length,
                    itemBuilder: (context, i) {
                      return Expanded(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Allow_or_not(
                                data_of_users: posts![i],
                                number: number=i,
                                token: token,
                              ),
                            ));
                          },
                          child: Card(
                            child: Container(
                              // color: Colors.red,
                              height: 124.0,
                              width: 336.0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    list[i].existing_solution_image != null
                                        ? Image.network(
                                            '${list_image[i]}',
                                            width: 92,
                                            height: 52,
                                          )
                                        : Image.asset('images/car.png'),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              // '${posts?[i].title}',
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
                                              '${list_author[i]}',
                                              // (posts?[i].author!['full_name'])
                                              //     .toString(),
                                              // provid(i),
                                              style: TextStyle(
                                                  color: Color(0xffA1A1A1)),
                                            ),
                                            Text(
                                                // '${posts?[i].topic_id}',
                                                '${list_theme[i]}',
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
    print("json ${json.runtimeType}");
    print(json);
    return json;
  }
}
