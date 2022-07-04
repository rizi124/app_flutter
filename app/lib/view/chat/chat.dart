import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart' as http;
import '../../models/btn_enter.dart';
import '../../wardrobe/for_projects.dart';

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODM4OGM5NWE1ZDdhMzQxNTgzYTJmMWMyYzMyYTlmNjMwNjZlYjQ3Zjc0OGIxNWRmOTE4MGE5MDllZWJmZDlhZDQzYzc4NGRjMjE4YTk2MGEiLCJpYXQiOjE2NTI0MzMyMjIsIm5iZiI6MTY1MjQzMzIyMiwiZXhwIjoxNjgzOTY5MjIyLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.ravIuhQYLzzMbvBe9suvgcYOshDCvLSCFVorArWFjqpZdV2g-z8eyN6sk3LjNjwnOhsqaXHvtFjnE85Mc95FGmAsOlY21nLfFxVZ3OT-2QCp2Ev8rg44x1pbWBcMIwZ4C1DX08M9mz_gDMXiLnthmLz7B5T8mO8M27dDVnEwyxHGmVBCpN5tl4LT_wK7NcNMl-V0MoX5dCbr8jwdtwDAUUxndUmnkM2QZo1FnU3ssgWO2dPDFxNXO72jr3outZA9arErDtSX8W_Iv-k3JK3Cka6YuFz8Dz9G39cXA9YHEDOQt1PEPj9sQcIAiExDhT9wTTq2FnpqnKjffKCcz489ry4K2wPPsysE3p6iixPY4pRoLXBzRYlJwqJWcQ9GgWa9PdvWcLlt9XrkWP7Un8b5jDvK1R7GXA_vBMqgOJrI5eV8vzYef6XynKdV8vfiUbdzROV_S7Qh1IW9G5p5NaZyD5rZp5ZPcSUENi1wxheuwvN4HxJaG3uAo52bnwhPq0DaGTI77yjk60CCjxSJVOUBBs53HbjroVD-IYEZczdp4O1cAq6A2OWd3pHQ6IVIBTKbOP717J2Ejjln_t-cPekvfcR9HOT8fhDzKNUQt44eDnvkuT1V5gl0FTzGBmOjVBDxfTcEPpPQ1Tzxx1jCFiAoGLMUkxNRZNie23izXIzBtwI';

class Chat1 extends StatefulWidget {
  const Chat1({Key? key}) : super(key: key);

  @override
  State<Chat1> createState() => _Chat1State();
}

class _Chat1State extends State<Chat1> {
  TextEditingController _textcontroller = TextEditingController();

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

  List<Data_comments> listData = [];

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

    print(listData.runtimeType);
    return listData;
  }

  List<Data_comments> list = [];
  List<String> list_text = [];
  List<String> list_name = [];

  void getList_text() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_text.add(list[i].text.toString());
      }
      print(list_text);
      setState(() {});
    });
  }

  void getList_name() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_name.add(list[i].user!['full_name'].toString());
      }
      print(list_text);
      setState(() {});
    });
  }

  //

  List<Message> messages = [
    Message(
      isSentByMe: false,
      author: 'Tom',
      text: 'Hello everyone !',
    ),
    Message(
      isSentByMe: false,
      author: 'Jone',
      text: 'Hi !',
    ),
    Message(
      isSentByMe: false,
      author: 'Jony',
      text: 'hello !',
    ),
    Message(
      isSentByMe: false,
      author: 'Jone',
      text: 'привет !',
    ),
    Message(
      isSentByMe: false,
      author: 'Moan',
      text: 'Вот это да !',
    ),
    Message(
      isSentByMe: true,
      author: 'Holly',
      text: 'ДА!',
    ),
    Message(
      isSentByMe: false,
      author: 'Alica',
      text: 'Where s Mia ?',
    ),
    Message(
      isSentByMe: false,
      author: 'Wheteete',
      text: 'Where?',
    ),
    Message(
      isSentByMe: true,
      author: 'T',
      text: 'Hello everyone !',
    ),
    Message(
      isSentByMe: false,
      author: 'J',
      text: 'Hi !',
    ),
    Message(
      isSentByMe: true,
      author: 'Gony',
      text: 'hello !',
    ),
    Message(
      isSentByMe: false,
      author: 'JF',
      text: 'привет !',
    ),
    Message(
      isSentByMe: false,
      author: 'MN',
      text: 'Вот это да !',
    ),
    Message(
      isSentByMe: false,
      author: 'H',
      text: 'ДА!',
    ),
    Message(
      isSentByMe: false,
      author: 'A',
      text: 'Where s Mia ?',
    ),
    Message(
      isSentByMe: false,
      author: 'W',
      text: 'Where?',
    ),
  ].reversed.toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getList_text();
    getList_name();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
              child: GroupedListView<Message, DateTime>(
            reverse: true,
            order: GroupedListOrder.DESC,
            padding: EdgeInsets.all(8),
            elements: messages,
            groupBy: (message) => DateTime(2022),
            groupHeaderBuilder: (Message message) => SizedBox(),
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(message.text),
                  // child: Text(list_text.toString()),
                ),
              ),
            ),
          )),
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
                      final message =
                          Message(isSentByMe: true, author: 'My', text: text);
                      setState(() {
                        messages.add(message);
                        _textcontroller.clear();
                      });
                    },
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                    // getMyRequest();
                    // get_listObject();
                //   },
                //   child: Icon(
                //     Icons.arrow_upward,
                //     color: Colors.grey[500],
                //   ),
                // )
              
              FlatButton(onPressed: (){

              }, child: Text('data'))
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget icon_Btn() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 14),
            // margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ваше сообщение',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                )),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.arrow_upward,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget NewTextFieldWidget() {
    return Material(
      child: TextField(
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        onChanged: ((value) {}),
        controller: _textcontroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: 'Ваше собщение',
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              //  color: Color(0xff205692)
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              //  color: Color(0xff205692)
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Color(0xff205692),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onSubmitted: (text) {
          final message = Message(isSentByMe: true, author: "My", text: text);
          setState(() {
            messages.add(message);
            _textcontroller.clear();
          });
        },
      ),
    );
  }

  // List<Message>? list_messages;

  // void get_listObject() {
  //   for (int i = 0; i < list_text.length; i++) {
  //     for (int i = 0; i < list_name.length; i++) {
  //       for (int? number; i < list_text.length; i++) {
  //         dynamic title = "nuk" + number.toString();

  //         title = Message(
  //             isSentByMe: false,
  //             author: list_name.toString(),
  //             text: list_text.toString());
  //         list_messages!.add(title);
  //       }
  //     } print(list_messages);
  //   }
   
  // }
}

// var num_message'$number' = Message(
//               isSentByMe: false,
//               author: list_name.toString(),
//               text: list_text.toString());
//           list_messages.add(num_message);

class Message {
  String text;
  String author;

  final bool isSentByMe;
  Message({
    required this.isSentByMe,
    required this.author,
    required this.text,
  });
}
