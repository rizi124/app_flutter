import 'dart:io';

import 'package:app/models/btn_route.dart';
import 'package:app/view/create/parts_video/part_main_1.dart';
import 'package:app/view/expertises/expertises.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';

import '../applications/projects.dart';
import '../chat/main_chat.dart';

class Allow_or_not extends StatefulWidget {
  final Data_of_user data_of_users;
  int number;
  String token;
  Allow_or_not(
      {Key? key,
      required this.data_of_users,
      required this.number,
      required this.token})
      : super(key: key);

  @override
  State<Allow_or_not> createState() =>
      _Allow_or_notState(data_of_users, number, token);
}

class _Allow_or_notState extends State<Allow_or_not> {
  String filepath1 = '';
  String filepath2 = '';
  int number;
  String token;
  double rating = 0;
  int author_id = 0;

  final Data_of_user data_of_users;
  _Allow_or_notState(this.data_of_users, this.number, this.token);

  late Future<void> _initializeVideoPlayerFuture;
  late Future<void> _initializeVideoPlayerFuture2;

  File? video;

  VideoPlayerController controller = VideoPlayerController.asset('dataSource');
  VideoPlayerController controller2 = VideoPlayerController.asset('dataSource');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideo(data_of_users.existing_solution_video.toString());
    getVideo2(data_of_users.existing_solution_video.toString());
    print(" Image: ${data_of_users.existing_solution_image}");
    print('Video ${data_of_users.existing_solution_video}');
    _initializeVideoPlayerFuture = controller.initialize();
    _initializeVideoPlayerFuture2 = controller2.initialize();
    controller.setLooping(true);
    controller2.setLooping(true);
    author_id = data_of_users.author_id ?? 0;
    print(number);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();
    controller2.dispose();

    super.dispose();
  }

  void getVideo(String path) {
    controller = VideoPlayerController.network(path);
  }

  void getVideo2(String path) {
    controller2 = VideoPlayerController.network(path);
  }

  @override
  Widget build(BuildContext context) {
    rating = data_of_users.rating!.toDouble();
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 68.0),
            child: Part_for_video1(
              text: 'Создать',
            ),
          ),
          widget_now(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: widget_need(),
          ),
          widget_will(),
        ],
      )),
    );
  }

  Widget widget_now() {
    return Column(
      children: <Widget>[
        Text(
          'Сейчас так:',
          style: TextStyle(
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              color: Color(0xff205692),
              fontSize: 20.0),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              width: 305,
              height: 292,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                child: Text(
                  '${data_of_users.existing_solution_text}',
                  style: TextStyle(
                    fontFamily: 'ABeeZee',
                    color: Color(0xff12408c),
                  ),
                  maxLines: 100,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                  child: data_of_users.existing_solution_image != null
                      ? Image.network(
                          '${data_of_users.existing_solution_image}',
                          width: 92,
                        )
                      : Container(
                          height: 52,
                          width: 92,
                          color: Colors.red,
                        )),
              Card(
                  child: data_of_users.existing_solution_video != null
                      ? FlatButton(
                          onPressed: () {
                            setState(() {
                              // If the video is playing, pause it.
                              if (controller.value.isPlaying) {
                                controller.pause();
                              } else {
                                // If the video is paused, play it.
                                controller.play();
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
                                      aspectRatio: controller.value.aspectRatio,
                                      // Use the VideoPlayer widget to display the video.
                                      child: VideoPlayer(controller),
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
                          height: 52,
                          width: 92,
                          color: Colors.amber,
                        )),
            ],
          ),
        ),
      ],
    );
  }

  Widget widget_need() {
    return Column(
      children: <Widget>[
        Text(
          'Надо так:',
          style: TextStyle(
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              color: Color(0xff205692),
              fontSize: 20.0),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              width: 305,
              height: 292,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                child: Text(
                  '${data_of_users.proposed_solution_text}',
                  style: TextStyle(
                    fontFamily: 'ABeeZee',
                    color: Color(0xff12408c),
                  ),
                  maxLines: 100,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                  child: data_of_users.proposed_solution_image != null
                      ? Image.network(
                          data_of_users.proposed_solution_image.toString(),
                          width: 92,
                        )
                      : Container(
                          width: 92,
                          height: 52,
                          color: Colors.red,
                        )),
              Card(
                  child: data_of_users.proposed_solution_video != null
                      ? FlatButton(
                          onPressed: () {
                            setState(() {
                              // If the video is playing, pause it.
                              if (controller2.value.isPlaying) {
                                controller2.pause();
                              } else {
                                // If the video is paused, play it.
                                controller2.play();
                              }
                            });
                          },
                          child: Container(
                            width: 92,
                            height: 52,
                            child: FutureBuilder(
                                future: _initializeVideoPlayerFuture2,
                                builder: ((context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    // If the VideoPlayerController has finished initialization, use
                                    // the data it provides to limit the aspect ratio of the video.
                                    return AspectRatio(
                                      aspectRatio:
                                          controller2.value.aspectRatio,
                                      // Use the VideoPlayer widget to display the video.
                                      child: VideoPlayer(controller2),
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
                          height: 52,
                          width: 92,
                          color: Colors.amber,
                        )),
            ],
          ),
        ),
      ],
    );
  }

  Widget widget_will() {
    return Column(
      children: [
        Text(
          'И тогда будет так:',
          style: TextStyle(
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              color: Color(0xff205692),
              fontSize: 20.0),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              width: 305,
              height: 292,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                child: Text(
                  '${data_of_users.positive_effect}',
                  style: TextStyle(
                    fontFamily: 'ABeeZee',
                    color: Color(0xff12408c),
                  ),
                  maxLines: 100,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 140.0, bottom: 10),
              child: Text(
                'Оцените проект:',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            RatingBar.builder(
              itemSize: 46,
              itemPadding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              minRating: 1,
              updateOnDrag: true,
              onRatingUpdate: (rating) => setState(
                () {
                  this.rating = rating;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Btn_R(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Chat(
                          token: token, author_id: author_id, number: number)));
                },
                text: "Обсудить"),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  btn(
                      () {},
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 56,
                      ),
                      Color(0xff205692)),
                  btn(
                    () {},
                    Icon(
                      Icons.close,
                      color: Color(0xff205692),
                      size: 56,
                    ),
                    Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        )
      ],
    );
  }

  Widget btn(VoidCallback onPressed, Icon icon, Color color) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(24.0),
      child: MaterialButton(
          onPressed: onPressed, height: 58.0, minWidth: 150.0, child: icon),
    );
  }
}
