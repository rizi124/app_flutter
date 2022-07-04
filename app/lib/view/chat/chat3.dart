import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs';

class Chart3 extends StatefulWidget {
  const Chart3({Key? key}) : super(key: key);

  @override
  State<Chart3> createState() => _Chart3State();
}

class _Chart3State extends State<Chart3> {
  List<Data_comments> listData = [];
  List<Data_comments> list = [];
  List<String> list_text = [];
  List<String> list_name = [];
  TextEditingController _textcontroller = TextEditingController();

  Future<List<Data_comments>> getData() async {
    String url = 'https://msofter.com/rosseti/public/api/suggestions/index';
    var apiresponse = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data =
        (jsonObject as Map<String, dynamic>)['suggestions'][0]['comments'];

    for (int i = 0; i < data.length; i++) {
      listData.add(Data_comments.fromJson(data[i]));
    }

    return listData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList_name();
    getList_text();
  }

  void getList_name() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_name.add(list[i].user!['full_name'].toString());
      }
      print(list_name);
      setState(() {});
    });
  }

  void getList_text() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_text.add(list[i].text.toString());
      }
      // print(list_text);
      setState(() {});
    });
  }

  Future<void> getMyRequest() async {
    if (_textcontroller.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              'https://msofter.com/rosseti/public/api/suggestions/comment/store'),
          body: ({'suggestion_id': '24', 'text': _textcontroller.text}),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print(body['success']);
      } else {
        print('Z yt cjue');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
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
                      itemCount: list_text.length,
                      itemBuilder: ((context, i) {
                        return Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(list_text[i].toString()),
                            ));
                      }),
                    ),
                  );
                }
              },
            ),
          ),
          Container(color: Color.fromRGBO(158, 158, 158, 1), child: btn33()),
        ],
      ),
    );
  }

  Widget btn33() {
    return Container(
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ваше сообщение',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    onSubmitted: (text) {
                      getMyRequest();
                      setState(() {
                        
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      
                    });
                    getMyRequest();
                  },
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.grey[500],
                  ),
                )

                // FlatButton(onPressed: (){

                // }, child: Text('data'))
              ],
            ),
          ))
        ],
      ),
    );
  }
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
      you: json["you"]);
}
