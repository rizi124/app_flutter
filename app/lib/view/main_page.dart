import 'dart:convert';
import 'dart:io';

import 'package:app/wardrobe/for_projects.dart';
import 'package:app/view/create/create_description.dart';
import 'package:app/view/expertises/expertises.dart';
import 'package:app/view/status/status.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/sections_action.dart';
import 'applications/projects.dart';
import '../wardrobe/for_create_descreption.dart';

class MainPage extends StatefulWidget {
  static String id = '/mainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final storage = SharedPreferences.getInstance();
  String? text_will;
  String token = '';
  // String tok =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";
  List<Post_Api> posts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getPosts();
    delete_Keys();
  }

  Future getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('key_token')!;
      text_will = pref.getString('key_text_will');
    });
  }

  Future getKeys() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getKeys());
  }

  Future delete_Keys() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (text_will == null) {
      setState(() {
        
      });
      print('text_key is empty');
       pref.remove(
          'key_text_will',
        );
        pref.remove(
          'key_video_now',
        );
        pref.remove(
          'key_image',
        );
        pref.remove(
          'key_code',
        );
        pref.remove(
          'key_text_now',
        );

        pref.remove(
          'key_theme',
        );
        pref.remove(
          'key_image_now',
        );
        pref.remove(
          'key_title',
        );

        pref.remove(
          'key_text_need',
        );
        pref.remove(
          'key_image_need',
        );
        pref.remove(
          'key_video_need',
        );
    } else {
      setState(() {
        // print(pref.getKeys());
        pref.remove(
          'key_text_will',
        );
        pref.remove(
          'key_video_now',
        );
        pref.remove(
          'key_image',
        );
        pref.remove(
          'key_code',
        );
        pref.remove(
          'key_text_now',
        );

        pref.remove(
          'key_theme',
        );
        pref.remove(
          'key_image_now',
        );
        pref.remove(
          'key_title',
        );

        pref.remove(
          'key_text_need',
        );
        pref.remove(
          'key_image_need',
        );
        pref.remove(
          'key_video_need',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 68.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 121.0),
                      child: Text(
                        'seti.inno',
                        style:
                            TextStyle(fontSize: 36.0, color: Color(0xff205692)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => Status())));
                          },
                          child: Image.asset('images/icon.png')),
                    )
                  ],
                ),
              ),
              Sections_action(
                image: 'images/create.png',
                word_1: 'Создать',
                word_2: 'предложение',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => Goal1(
                            token: token,
                          ))));
                  setState(() {
                    getPosts();
                    getKeys();
                  });
                },
              ),
              Sections_action(
                image: 'images/idea.png',
                word_1: 'Заявки',
                word_2: '',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => Projects(token: token, number: 0,))));
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: ((context) => Projects4( token: token,))));
                },
              ),
              Sections_action(
                image: 'images/skills.png',
                word_1: 'Экспертизы',
                word_2: '',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => Expertises(
                            token: token,
                            number: 0,
                          ))));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final client = HttpClient();

  Future<void> getPosts() async {
    final json = await get('https://msofter.com/rosseti/public/api/topics')
        as Map<String, dynamic>;

    final data = json["topics"] as List<dynamic>;

    posts = data
        .map((dynamic e) => Post_Api.fromJson(e as Map<String, dynamic>))
        .toList();
    print(posts[0].title.runtimeType);
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
}

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
