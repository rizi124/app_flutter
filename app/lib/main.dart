import 'package:app/try/check_api.dart';
import 'package:app/try/something.dart';
import 'package:app/try/video_play.dart';
import 'package:app/try/video_play2.dart';

import 'package:app/view/chat/chat.dart';
import 'package:app/view/chat/chat3.dart';
import 'package:app/view/chat/list_data.dart';
import 'package:app/view/chat/model.dart';
import 'package:app/wardrobe/for_projects.dart';
import 'package:app/view/create/create_description.dart';
import 'package:app/try/for_create_descreption.dart';
import 'package:app/try/try0.dart';
import 'package:app/try/try2.dart';
import 'package:app/try/try3.dart';
import 'package:app/try/try4.dart';
import 'package:app/view/applications/projects.dart';
import 'package:app/wardrobe/for_create_descreption.dart';
import 'package:app/view/create/create_need.dart';
import 'package:app/view/create/create_now.dart';
import 'package:app/view/create/create_will.dart';
import 'package:app/view/create/parts_video/part_main_3.dart';
import 'package:app/view/expertises/expertises.dart';

import 'package:app/view/login.dart';
import 'package:app/view/main_page.dart';
import 'package:app/view/phone.dart';
import 'package:app/view/proj_description.dart';
import 'package:app/view/status/status.dart';
import 'package:app/view/applications/projects.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'try/example_api/image_upload.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  VideoPlayerController controller = VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: ImageUpload(),
      // home: Chart3(),
      // home: Video_PLayer2(controller:controller),
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Phone_Number1.id: (context) => Phone_Number1(),
        Phone_Number2.id: (context) => Phone_Number2(),
        MainPage.id: (context) => MainPage(),
        Goal1.id1: (context) => Goal(
              token: '',
            ),
        Create_Now.id: (context) => Create_Now(
              token: '',
              theme: "",
            ),
        Create_Need.id: (context) => Create_Need(
              token: '',
              theme: '',
            ),
        Create_Will.id: (context) => Create_Will(
              token: '',
              theme: '',
            ),
        Status.id_id: (context) => Status(),
        Expertises.id: (context) => Expertises(
              token: '',
              number: 0,
            ),
      },
    );
  }
}
