import 'dart:convert';

import 'dart:io';

import 'package:app/view/create/parts_video/part_main_1.dart';
import 'package:app/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/btn_add.dart';
import '../models/btn_enter.dart';
import '../models/btn_route.dart';

import '../view/create/create_now.dart';

class Create_Description extends StatefulWidget {
  static String id1 = '/create_description';

  @override
  State<Create_Description> createState() => _Create_DescriptionState();
}

class _Create_DescriptionState extends State<Create_Description> {
  String token = "";
  // String tok =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";

  TextEditingController _titleController = TextEditingController();
  TextEditingController _themeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('key_token')!;
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
            Btn_E(
              maxLength: 80,
              controller: _titleController,
              prefix: Text(''),
              onChanged: (value) {},
              text: "Название",
              type: TextInputType.text,
            ),
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
      Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => Create_Now(token: '',theme: '',))));
               } else {
      ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Заполните строки')));
      
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
}
