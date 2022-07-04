import 'dart:convert';
import 'dart:io';

import 'package:app/models/btn_route.dart';
import 'package:app/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Status extends StatefulWidget {
  static String id_id = '/my_status';
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  String? token;
  String? value;

  dynamic data = {};
  final client = HttpClient();

  Future<dynamic> getPosts() async {
    data = await get('https://msofter.com/rosseti/public/api/user')
        as Map<String, dynamic>;
    print(data);
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

    return json;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getPosts();
  }

  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('key_token');
      value = pref.getString('key_value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 68.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              title(),
              Image.asset('images/crowns.png'),
              Text(
                ' Серебряный статус',
                style: TextStyle(
                  color: Color(0xff205692),
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 303,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Оценок',
                          style: TextStyle(
                            color: Color(0xff205692),
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          value!
                          // data['ratings_count'].toString()
                          ,
                          style: TextStyle(
                            color: Color(0xff205692),
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Комментариев',
                            style: TextStyle(
                              color: Color(0xff205692),
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            '${data['comments_count']}',
                            style: TextStyle(
                              color: Color(0xff205692),
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Предложений',
                            style: TextStyle(
                              color: Color(0xff205692),
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            '${data['proposals_count']}',
                            style: TextStyle(
                              color: Color(0xff205692),
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Одобрено',
                          style: TextStyle(
                            color: Color(0xff205692),
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          '${data['denied_proposals_count']}',
                          style: TextStyle(
                            color: Color(0xff205692),
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Итого ${data['ratings_count']} бонусов',
                      style: TextStyle(
                        color: Color(0xff205692),
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'До золотого статуса',
                      style: TextStyle(
                        color: Color(0xff205692),
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      'ещё 15 оценок или',
                      style: TextStyle(
                        color: Color(0xff205692),
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '6 комментариев или 1',
                      style: TextStyle(
                        color: Color(0xff205692),
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      'предложение',
                      style: TextStyle(
                        color: Color(0xff205692),
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Btn_R(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          },
                          text: 'Готово'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text(
            'Мой статус',
            style: TextStyle(
                fontFamily: 'ABeeZee',
                color: Color(0xff205692),
                fontSize: 36.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 22.0 - 17.0),
          child: Image.asset('images/icon.png'),
        )
      ],
    );
  }
}
