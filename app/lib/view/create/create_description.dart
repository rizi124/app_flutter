import 'dart:convert';

import 'package:app/models/btn_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'create_now.dart';
import 'parts_video/part_main_1.dart';

class Goal extends StatefulWidget {
  static String id1 = '/create_description';
  String token;

  Goal({Key? key, required this.token}) : super(key: key);

  @override
  State<Goal> createState() => _GoalState(token);
}

class _GoalState extends State<Goal> {
  String token;

  _GoalState(this.token);

  // String tok =
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _themeController = TextEditingController();

  List<Post_Api> list = [];
  List<String> list_title = [];
  List<String> list_theme = [];

  //get token

  // void getToken() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = pref.getString('key_token')!;
  //   });
  // }

  Future<List<Post_Api>> getData() async {
    String url = "https://msofter.com/rosseti/public/api/topics";
    var apiresponse = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['topics'];

    List<Post_Api> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Post_Api.fromJson(data[i]));

    return listData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListTheme();
    getListTitle();
    print(token);
  }

// for btn_title

  void getListTitle() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].title.toString());
      }

      setState(() {});
    });
  }

  List<String> getSuggestion_of_titles(String query) {
    List<String> titles = [];

    titles.addAll(list_title);
    titles.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return titles;
  }

// for btn_theme

  void getListTheme() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_theme.add(list[i].id.toString());
      }
      setState(() {});
    });
  }

  List<String> getSuggestion_of_themes(String query) {
    List<String> themes = [];

    themes.addAll(list_theme);
    themes.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return themes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 68.0),
              child: Part_for_video1(
                text: 'Создать',
              )),
          Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Text(
              'Расскажите о предложении',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff205692),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: Text(
              'Выберите тему и название',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff205692),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34.0),
            child: btn_theme(_themeController, "Тема проекта"),
          ),
          btn_title(_titleController, 'Название'),
          Padding(
            padding: const EdgeInsets.only(top: 183.0),
            child: Btn_R(
                onPressed: () {
                  Safekeys(_titleController.text, _themeController.text);
                },
                text: 'Далее'),
          )
        ],
      )),
    );
  }

  Widget btn_theme(TextEditingController controller, String text) {
    return SizedBox(
      width: 305,
      height: 78.0,
      child: TypeAheadField(
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          color: Colors.white,
          elevation: 5.0,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        debounceDuration: Duration(microseconds: 400),
        textFieldConfiguration: TextFieldConfiguration(
            onChanged: ((value) {}),
            controller: controller,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff205692), width: 2),
                    borderRadius: BorderRadius.circular(24.0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: Color(0xff205692), width: 2)),
                hintText: text,
                contentPadding: EdgeInsets.all(18),
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                //dckdmckdmcmd
                fillColor: Colors.white,
                filled: true)),
        suggestionsCallback: (value) {
          return getSuggestion_of_themes(value);
        },
        itemBuilder: (context, String suggestion) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    suggestion,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
        onSuggestionSelected: (String suggestion) {
          setState(() {
            controller.text = suggestion;
          });
        },
      ),
    );
  }

  Widget btn_title(TextEditingController controller, String text) {
    return SizedBox(
      width: 305,
      height: 78.0,
      child: TypeAheadField(
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          color: Colors.white,
          elevation: 5.0,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        debounceDuration: Duration(microseconds: 400),
        textFieldConfiguration: TextFieldConfiguration(
            onChanged: ((value) {}),
            controller: controller,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff205692), width: 2),
                    borderRadius: BorderRadius.circular(24.0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: Color(0xff205692), width: 2)),
                hintText: text,
                contentPadding: EdgeInsets.all(18),
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                //dckdmckdmcmd
                fillColor: Colors.white,
                filled: true)),
        suggestionsCallback: (value) {
          return getSuggestion_of_titles(value);
        },
        itemBuilder: (context, String suggestion) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    suggestion,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
        onSuggestionSelected: (String suggestion) {
          setState(() {
            controller.text = suggestion;
          });
        },
      ),
    );
  }

  // Safe keys for theme and titles

  Future<void> Safekeys(String title, String theme) async {
    if (title.isNotEmpty && theme.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('key_title', title);
      await pref.setString('key_theme', theme);
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => Create_Now(token: token, theme: theme))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполните строки')));
    }
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



// fixed      that's correct

class Goal1 extends StatefulWidget {
  static String id1 = '/create_description';
  String token;

  Goal1({Key? key, required this.token}) : super(key: key);

  @override
  State<Goal1> createState() => _Goal1State(token);
}

class _Goal1State extends State<Goal1> {
  String token;

  _Goal1State(this.token);

  // String tok =
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _themeController = TextEditingController();

  List<Post_Api> list = [];
  List<String> list_title = [];
  List<String> list_theme = [];


  Future<List<Post_Api>> getData() async {
    String url = "https://msofter.com/rosseti/public/api/topics";
    var apiresponse = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['topics'];

    List<Post_Api> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Post_Api.fromJson(data[i]));

    return listData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListTheme();
    getListTitle();
    print(token);
  }

// for btn_title

  void getListTitle() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].title.toString());
      }

      setState(() {});
    });
  }


  void getListTheme() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_theme.add(list[i].id.toString());
      }
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 68.0),
              child: Part_for_video1(
                text: 'Создать',
              )),
          Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Text(
              'Расскажите о предложении',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff205692),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: Text(
              'Выберите тему и название',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff205692),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34.0),
            child: themes( "Тема проекта"),
          ),
          titles( 'Название'),
          Padding(
            padding: const EdgeInsets.only(top: 183.0),
            child: Btn_R(
                onPressed: () {
                  Safekeys(title!, theme!);
                },
                text: 'Далее'),
          )
        ],
      )),
    );
  }

  String? title;
  Widget titles(String text) {
    return Container(
      width: 305,
      height: 58,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff205692), width: 2),
          borderRadius: BorderRadius.circular(24.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(text),
          items: list_title.map(buildMenuItem).toList(),
          value: title,
          isExpanded: true,
          icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
          onChanged: (value) {
            setState(() {
              title = value;
            });
          },
        ),
      ),
    );
  }

  String? theme;
  Widget themes(String text) {
    return Container(
      width: 305,
      height: 58,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff205692), width: 2),
          borderRadius: BorderRadius.circular(24.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(text),
          items: list_theme.map(buildMenuItem).toList(),
          value: theme,
          isExpanded: true,
          icon: Image.asset('images/lists.png'),
          onChanged: (value) {
            setState(() {
              theme = value;
            });
          },
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: Colors.red),
      ));


  Future<void> Safekeys(String title, String theme) async {
    if (title.isNotEmpty && theme.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('key_title', title);
      await pref.setString('key_theme', theme);
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => Create_Now(token: token, theme: theme))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполните строки')));
    }
  }
}
