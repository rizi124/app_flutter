import 'dart:io';

import 'package:app/view/create/parts_video/part_main_1.dart';
import 'package:app/view/create/parts_video/part_main_2.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../models/btn_route.dart';
import 'create_need.dart';

class Create_Now extends StatefulWidget {
  static String id = '/create_now';
  String token;
  String theme = '2';
  Create_Now({Key? key, required this.token, required this.theme})
      : super(key: key);

  @override
  State<Create_Now> createState() => _Create_NowState(token, theme);
}

class _Create_NowState extends State<Create_Now> {
  String theme;
  String token;
  TextEditingController _controller_now_text = TextEditingController();
  _Create_NowState(this.token, this.theme);
  bool _validate = false;
  late Future<void> _initializeVideoPlayerFuture;
  final _addFormKey = GlobalKey<FormState>();
  File? _video;
  File? _image;
  final picker = ImagePicker();
  VideoPlayerController controller_now_video =
      VideoPlayerController.network('dataSource');

  // @override
  // void initState() {
  // TODO: implement initState
  //   super.initState();
  //   getToken();
  // }

  // void getToken() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     // token = pref.getString('key_token');
  //     theme = pref.getString('key_theme');
  //   });
  // }

  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);

        print('image ${image.path}');
        // print(_image.runtimeType);
        // print(' Image: $image');
        // print(' Image: $_image');
      } else {
        print('No image selected.');
      }
    });
  }

  Future getVideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (video != null) {
        _video = File(video.path);

        print(' video ${video.path}');
        controller_now_video = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
          });
        controller_now_video.play();
      } else {
        print('No video selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeVideoPlayerFuture = controller_now_video.initialize();
    controller_now_video.setLooping(true);
    print(theme);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller_now_video.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 68.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Part_for_video1(
                  text: 'Создать',
                ),
                Part_for_video2(
                  controller: _controller_now_text,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorText: _validate ? 'заполни его' : null,
                  ),
                  text: "сейчас",
                ),
                getWidget(), //временная замена Part_for_video3()
                SizedBox(
                  height: 31.0,
                ),
                Btn_R(
                    onPressed: () {
                      Safekeys(_controller_now_text.text, _image!.path,
                          _video!.path);
                      setState(() {
                        _controller_now_text.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        _controller_now_text.clear();
                      });
                      // if (_addFormKey.currentState!.validate()) {
                      //   _addFormKey.currentState!.save();
                      //   Map<String, String> body_image = {'title1': "image_now"};
                      //   Map<String, String> body_video = {'title2': "video_now"};
                      //   addImage(body_image, _image!.path, _video!.path);
                      // addVideo(body_video, _video!.path);
                      // }
                      // if (_addFormKey.currentState!.validate()) {
                      //   _addFormKey.currentState!.save();
                      //   Map<String, String> body = {'title': "video_now"};
                      //   addVideo(body, _video!.path);
                      // }
                    },
                    text: 'Дальше'),
                FlatButton(
                    onPressed: () {
                      print(_image!.path);
                      print(_video!.path);
                    },
                    child: Text('check'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Safekeys(
      String text_now, String image_now, String video_now) async {
    if (text_now.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('key_text_now', text_now);
      await pref.setString('key_image_now', image_now);
      await pref.setString('key_video_now', video_now);
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => Create_Need(
                token: token,
                theme: theme,
              ))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполните данные')));
    }
  }

  Widget getWidget() {
    return Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 17.0, bottom: 23.0),
                child: Text(
                  'Добавьте фото или видео',
                  style: TextStyle(
                    fontFamily: 'ABeeZee',
                    color: Color(0xFF205692),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Card(
                      elevation: 5,
                      color: Colors.red,
                      child: controller_now_video != null
                          ?

                          // _video != null &&
                          //         controller_now_video != null &&
                          //         controller_now_video.value.isInitialized
                          //     ? SizedBox(
                          //         height: 51.0,
                          //         width: 91.0,
                          //         child: AspectRatio(
                          //             aspectRatio: controller_now_video.value.aspectRatio,
                          //             child: VideoPlayer(controller_now_video)),
                          //       )
                          //     : const SizedBox(
                          //         height: 51.0,
                          //         width: 91.0,

                          //       ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  // If the video is playing, pause it.
                                  if (controller_now_video.value.isPlaying) {
                                    controller_now_video.pause();
                                  } else {
                                    // If the video is paused, play it.
                                    controller_now_video.play();
                                  }
                                });
                              },
                              child: Container(
                                width: 92,
                                height: 52,
                                child: FutureBuilder(
                                    future: _initializeVideoPlayerFuture,
                                    builder: ((context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        // If the VideoPlayerController has finished initialization, use
                                        // the data it provides to limit the aspect ratio of the video.
                                        return AspectRatio(
                                          aspectRatio: controller_now_video
                                              .value.aspectRatio,
                                          // Use the VideoPlayer widget to display the video.
                                          child:
                                              VideoPlayer(controller_now_video),
                                        );
                                      } else {
                                        // If the VideoPlayerController is still initializing, show a
                                        // loading spinner.
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })),
                              ),
                            )
                          : Container(
                              width: 92,
                              height: 52,
                              color: Colors.red,
                            )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Card(
                      elevation: 5,
                      color: Colors.amber,
                      child: _image != null
                          ? Container(
                              height: 51,
                              width: 91,
                              child: Expanded(
                                child: Image.file(
                                  _image!,
                                ),
                              ),
                            )
                          : Container(
                              height: 51,
                              width: 91,
                            ),
                    ),
                  ),
                  IconButton(
                    onPressed: getVideo,
                    icon: Icon(
                      Icons.video_collection,
                      size: 43,
                    ),
                  ),
                  IconButton(
                      onPressed: getImage,
                      icon: Icon(
                        Icons.photo,
                        size: 43,
                      )),
                ],
              )
            ],
          ),
        ));
  }

  // Future<bool> addImage(Map<String, String> body, String filepath_Image,
  //     String filepath_Video) async {
  //   Map<String, String> headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'multipart/form-data'
  //   };
  //   String addimageUrl =
  //       'https://msofter.com/rosseti/public/api/suggestions/store';

  //   var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
  //     ..fields['topic_id'] = theme
  //     ..headers.addAll(headers)
  //     ..files.add(await http.MultipartFile.fromPath(
  //         'existing_solution_image', filepath_Image))
  //     ..files.add(await http.MultipartFile.fromPath(
  //         'existing_solution_video', filepath_Video));

  //   var response = await request.send();

  //   print(response.runtimeType);
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     // SafeKeys_image(filepath);
  //     print('Image send good');
  //     return true;
  //   } else {
  //     print('bad');
  //     return false;
  //   }
  // }

  // Future<bool> addVideo(Map<String, String> body, String filepath) async {
  //   Map<String, String> headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'multipart/form-data'
  //   };
  //   String addvideoUrl =
  //       'https://msofter.com/rosseti/public/api/suggestions/store';

  //   var request = http.MultipartRequest('POST', Uri.parse(addvideoUrl))
  //     ..fields['topic_id'] = theme
  //     ..headers.addAll(headers)
  //     ..files.add(await http.MultipartFile.fromPath(
  //         'existing_solution_video', filepath));

  //   var response = await request.send();

  //   print(response.runtimeType);
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     SafeKeys_video(filepath);
  //     print('Video send good');
  //     return true;
  //   } else {
  //     print('bad');
  //     return false;
  //   }
  // }

  void SafeKeys_image(String image_url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('key_image_now', image_url);
  }

  void SafeKeys_video(String image_url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('key_video_now', image_url);
  }
}
