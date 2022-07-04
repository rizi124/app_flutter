import 'dart:convert';
import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/btn_enter.dart';
import '../models/btn_route.dart';
import 'main_page.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _msgController = TextEditingController();
  TextEditingController _countController = TextEditingController();

  bool click = false;
  String code = '';
  String text = "";
  String token = "";

  final Telephony telephony = Telephony.instance;
  final _formKey = GlobalKey<FormState>();

  getMobileFormWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 273.0),
            child: Btn_E(
              prefix: Text(''),
              controller: _phoneController,
              maxLength: 20,
              text: 'Телефон',
              onChanged: (value) {
                text = value;
              },
              type: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Btn_R(
                onPressed: () {
                  getCode_from_API();
                  setState(() {
                    path_phone(text);
                  });

                  _sendSMS(code);
                },
                text: 'Далее'),
          )
        ],
      ),
    );
  }

  getOtpFormWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 273.0),
            child: Btn_E(
              controller: _codeController,
              maxLength: 11,
              prefix: Text(''),
              text: 'Код из СМС ',
              onChanged: (value) {},
              type: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Btn_R(
                onPressed: ()  {
                  getToken_from_API();
                },
                text: 'Далее'),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCode();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("key_token");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false);
    }
  }

  void getCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      code = pref.getString("key_code")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
                child: click ? getOtpFormWidget() : getMobileFormWidget()),
          )),
    );
  }

  void path_phone(String text) {
    if (text.length > 11) {
      click = !click;
    }
  }

  Future<void> getToken_from_API() async {
    if (_phoneController.text.isNotEmpty && _codeController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('https://msofter.com/rosseti/public/api/auth/verify-code'),
          body: ({"phone": _phoneController.text, "code": _codeController.text}));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Token : ${body["token"]}');
        pageRoute(token);
      } else {
        print('Invalid Credentials');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Black Field Not Allowed')));
    }
  }

  Future<void> getCode_from_API() async {
    if (_phoneController.text.isNotEmpty ) {
      var response = await http.post(
          Uri.parse('https://msofter.com/rosseti/public/api/auth/phone'),
          body: ({"phone": _phoneController.text}));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print('Code : ${body["code"]}');
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('key_code', code);
      } else {
        print('Invalid Credentials');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Black Field Not Allowed')));
    }
  }

  void pageRoute(String token) async {
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    await pref2.setString('key_token', token);

    Navigator.push(context, MaterialPageRoute(builder: ((context) => MainPage())));
  }

  _sendSMS(String message) async {
    telephony.sendSms(to: _phoneController.text, message: message);
  }
}
