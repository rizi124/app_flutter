import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../status/status.dart';






class ConvarsationScreen extends StatefulWidget {
  ConvarsationScreen({Key? key, required this.postData}) : super(key: key);
  final postData;

  @override
  State<ConvarsationScreen> createState() => _ConvarsationScreenState();
}

class _ConvarsationScreenState extends State<ConvarsationScreen> {
  @override
  void initState() {
    super.initState();
    getComments();
  }

  var comments = [];
  var id = 0;
  var _postsJson = {};
  var dataComents = {};

  void getComments() async {
    try {
      final token =
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs';
      final response = await http.get(
          Uri.parse('http://msofter.com/rosseti/public/api/user'),
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
            'Content-Type': 'multipart/form-data'
          });
      final jsonData = jsonDecode(response.body);
      _postsJson = jsonData;
      id = _postsJson['id'];
      final data = widget.postData;
      dataComents = data;
      final commentsData = data['comments'];
      setState(() {
        comments = commentsData;
      });
    } catch (error) {
      debugPrint('$error');
    }
  }

  addComent(text) async {
    try {
      final response = await http.post(
          Uri.parse(
              'http://msofter.com/rosseti/public/api/suggestions/comment/store'),
          headers: {
            'Accept': 'application/json',
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs',
          },
          body: {
            'suggestion_id': '${dataComents['id']}',
            'text': text
          });
      if (response.statusCode == 200) {
        final newComents = jsonDecode(response.body);
        setState(() {
          comments = newComents['comments'];
        });
      } else {
        debugPrint('error: ${response.statusCode}');
      }
    } catch (er) {
      debugPrint('$er');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final controller = TextEditingController();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              width: width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Image.asset('images/Vector.svg'),
                        splashRadius: 22,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Обсуждение',
                        style: TextStyle(
                            color: Color(0xff205692),
                            fontSize: 36,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 0),
                      FlatButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Status())),
                        child: Image.asset('images/icon.png'),
                      ),
                      SizedBox(
                        width: 17,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ConversationContainer(
                          count: index,
                          postData: comments,
                          id: id,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 323,
                    height: 58,
                    padding: EdgeInsets.only(left: 14, right: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(66),
                        border: Border.all(color: Colors.green, width: 1.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          width: 230,
                          child: TextField(
                            controller: controller,
                            cursorColor: Colors.blue,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Ваше сообщение',
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Colors.black38),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: 48,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              addComent(controller.text);
                              controller.text = '';
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(66),
                                ),
                              ),
                            ),
                            child: Image.asset('assets/svg/vector_button.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}














class ConversationContainer extends StatefulWidget {
  ConversationContainer(
      {Key? key, required this.count, required this.postData, required this.id})
      : super(key: key);
  final postData;
  final count;
  final id;

  @override
  State<ConversationContainer> createState() => _ConversationContainerState();
}

class _ConversationContainerState extends State<ConversationContainer> {
  @override
  void initState() {
    super.initState();
    createComentData();
  }

  var data = {};
  var id = 0;
  var user = {};
  void createComentData() {
    final postData = widget.postData;
    setState(() {
      data = postData[widget.count];
      user = data['user'];
      id = widget.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data['user_id'] == id) {
      return Container(
        margin: EdgeInsets.only(left: 60, bottom: 15),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(8), bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Вы', style: TextStyle(color: Colors.white, fontSize: 14),),
              ],
            ),
            SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(data['text'], maxLines: 6, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 60, bottom: 15),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFEEF0F2), width: 1),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(8), bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(user['full_name'], style: TextStyle(color: Colors.black, fontSize: 14),),
              ],
            ),
            SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(data['text']!=null?data['text']:'null', maxLines: 6, textAlign: TextAlign.start, style: TextStyle(color: Colors.black, fontSize: 18),),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
