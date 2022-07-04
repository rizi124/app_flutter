import 'dart:convert';

import 'package:app/view/create/parts_video/part_main_1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// String token =
//     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs';

class Chat extends StatefulWidget {
  Chat({
    Key? key,
    required this.token,
    required this.author_id,
    required this.number,
  }) : super(key: key);
  String token;
  int author_id;
  int number;

  @override
  State<Chat> createState() => _ChatState(token, author_id, number);
}

class _ChatState extends State<Chat> {
  String token;
  int author_id;
  int number;

  List<Data_comments> listData = [];
  List<Data_comments> list = [];

  List<String> list_sugg_id = [];

  String number_position='';

  List<String> list_text = [];
  List<String> list_id = [];
  List<String> list_name = [];
  TextEditingController _textcontroller = TextEditingController();

  String check_text = 'Loading...';

  _ChatState(
    this.token,
    this.author_id,
    this.number,
  );

  Future<List<Data_comments>> getData() async {
    String url = 'https://msofter.com/rosseti/public/api/suggestions/index';
    var apiresponse = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data =
        (jsonObject as Map<String, dynamic>)['suggestions'][number]['comments'];

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
    getList_id();
    print("Token  $token");
    print("Author_id  $author_id");
    check();
    // getList_sugg_id();
    // create_number_position();
    // print(num);
  }


  


  void check() {
    if (list_text == null) {
      check_text = 'Data are null';
    } else {}
    setState(() {});
  }

  void getList_name() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_name.add(list[i].user!['full_name'].toString());
      }
      // print(list_name);
      setState(() {});
    });
  }

  // void getList_sugg_id() {
  //   getData().then((value) {
  //     list = value;
  //     for (int i = 0; i < list.length; i++) {
  //       list_sugg_id.add(list[i].suggestion_id.toString());
  //     }

  //     setState(() {});
  //   });
  // }

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

  void getList_id() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_id.add(list[i].user_id.toString());
      }
      print(list_id);
      setState(() {});
    });
  }

  // void create_number_position() {
  //   number_position = list_sugg_id[0].toString();
  // }

  Future<void> getMyRequest() async {
    if (_textcontroller.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              'https://msofter.com/rosseti/public/api/suggestions/comment/store'),
          body: ({'suggestion_id': '37', 'text': _textcontroller.text}),
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Part_for_video1(text: 'Обсуждение'),
            ),
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                          check_text,
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
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: list_id[i] == author_id.toString()
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 160,
                                height: 70,
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(30),
                                  color: list_id[i] == author_id.toString()
                                      ? Colors.blueAccent
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              list_id[i] == author_id.toString()
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              list_name[i].toString(),
                                              style: TextStyle(
                                                  color: list_id[i] ==
                                                          author_id.toString()
                                                      ? Colors.white
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              list_text[i].toString(),
                                              style: TextStyle(
                                                  color: list_id[i] ==
                                                          author_id.toString()
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ],
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
                },
              ),
            ),
            Container(color: Color.fromRGBO(158, 158, 158, 1), child: btn33()),
          ],
        ),
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

                      setState(() {});
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                    getMyRequest();
                    if (_textcontroller.text != null) {
                      list_text.add(_textcontroller.text);
                    }
                    _textcontroller.text = '';
                  },
                  child: Container(
                    width: 48,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(66),
                      color: Color.fromARGB(255, 45, 16, 162),
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
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



// Container(
//           alignment: Alignment.centerLeft,
//           child: Container(
//             width: 150,
//             height: 70,
//             child: Material(
//               elevation: 5,
//               borderRadius: BorderRadius.circular(30),
//               color: Colors.blueAccent,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'автор',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'привет',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),




// Container(
//                               alignment: list_id[i] == author_id.toString()
//                                   ? Alignment.centerRight
//                                   : Alignment.centerLeft,
//                               child: Column(
//                                 // crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   Text(
//                                     list_name[i].toString(),
//                                     style: TextStyle(
//                                         color: Colors.black54, fontSize: 12),
//                                   ),
//                                   Material(
//                                     borderRadius: BorderRadius.circular(30),
//                                     elevation: 5,
//                                     color: list_id[i] == author_id.toString()
//                                         ? Colors.lightBlueAccent
//                                         : Colors.grey,
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 20),
//                                       child: Text(
//                                         list[i].text.toString(),
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 15),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),