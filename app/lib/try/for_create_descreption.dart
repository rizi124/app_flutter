import 'dart:convert';

import 'dart:io';

import 'package:app/view/create/parts_video/part_main_1.dart';
import 'package:app/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/btn_add.dart';
import '../../models/btn_enter.dart';
import '../../models/btn_route.dart';
import '../view/create/create_now.dart';





String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";


class st extends StatefulWidget {
  const st({ Key? key }) : super(key: key);

  @override
  State<st> createState() => _stState();
}

class _stState extends State<st> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}






























































class Create_Description2 extends StatefulWidget {
  static String id1 = '/create_description';

  @override
  State<Create_Description2> createState() => _Create_Description2State();
}

class _Create_Description2State extends State<Create_Description2> {
  String token = "";
  String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";

  TextEditingController _titleController = TextEditingController();
  TextEditingController _themeController = TextEditingController();

  List<Post_Api> list = [];
  List<String> list_title = [];

  @override
  void initState() {
    super.initState();
    // getToken();
    getListAp1();
  }

  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('key_token')!;
    });
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

  void getListAp1() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].title.toString());
      }

      setState(() {});
    });
  }

  List<String> getSuggestion(String query) {
    List<String> matches = [];

    matches.addAll(list_title);
    matches.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
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
              child: Btn_E(
                maxLength: 11,
                controller: _themeController,
                prefix: Text(''),
                onChanged: (value) {},
                text: "Тема проекта",
                type: TextInputType.text,
                // icon: Icon(Icons.change_history),
              ),
            ),
            wid(_titleController, "Название"),
  
            Padding(
              padding: const EdgeInsets.only(top: 183.0),
              child: Btn_R(
                  onPressed: () {
                    // getMyRequest();
                    Safekeys(_titleController.text, _themeController.text);
                  },
                  text: 'Далее'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Safekeys(String title, String theme) async {
    if (title.isNotEmpty && theme.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('key_title', title);
      await pref.setString('key_theme', theme);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => Create_Now(theme: '',token: '',))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполните строки')));
    }
  }

  Widget wid(TextEditingController controller, String text) {
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
          return getSuggestion(value);
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
}























  // Future<void> getMyRequest() async {
  //   if (_themeController.text.isNotEmpty && _titleController.text.isNotEmpty) {
  //     var response = await http.post(
  //         Uri.parse("https://msofter.com/rosseti/public/api/suggestions/store"),
  //         body: ({
  //           "title": _titleController.text,
  //           "topic_id": _themeController.text
  //         }),
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $tok',
  //         });

  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //       print(body);
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => Create_Now()),
  //           (route) => false);
  //     } else {
  //       print('Я не могу }{ create_descript');
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Black Field Not Allowed')));
  //   }
  // }

