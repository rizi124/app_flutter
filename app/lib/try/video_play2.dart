import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ8.eyJhdWQiOiIxIiwianRpIjoiMWM5MDJlYzQ1MzE4YWNlYmUyMmQzN2Y3OGRjNjRkY2EyMTQ0MzE0NDQ0Y2U2NTVkNDc2NDQyMjEyODA0YWYyY2M3NzMwODJjZDAxMzQ5ZmQiLCJpYXQiOjE2NTI1Mzc4MzEsIm5iZiI6MTY1MjUzNzgzMSwiZXhwIjoxNjg0MDczODMxLCJzdWIiOiIxMTMiLCJzY29wZXMiOltdfQ.JtHri4BsxF8sBi-58SscS9hhW74_IENGgm2QmFZIID1BJklq1pOMACsVFgOqrCA1zlGyPfh9Uf7u5a4QsrCoqH5a0y3BT3euQbbugihaWWfGJOUImma_cpqGbTetSVkV2JZNFgC8S3GZ8CHCsadWttdDCAwhHLSK_pyaPPwsN514JTmuMhi2A0w_xmug4fBigldiEyo0mXly-tTp0wVB1MRP12WI_6lVWA9P3kB2aCs6sL32fjqrmdK6kK-UDtjhPWk0jC1FMT-gIrJYVRAAdBMczk69JTTNsiPuVcrktiAO-stYTEUDeSQZuhBFXmjvFlq6ap9ZPdmi4LBQAGjwUNyNgvjbOj1UW-H62gfPdYuesRfzkcfZErxZwkLtYZyMzhZQUwQD-hViZMRadAGJ4PMw-cdP948-DCp_L8jHv3p3sGDuS9hivLddDkTtYZD1Ao-7Rrfwwno6izw1N1DDmoxt0jXc_uTON-PHL75dm_KjfNN2zSxch5kGw_i1-92GeLmJK-nQVfmRp5hX0nW7yDl4qm7FgzESFGRFn1h3haM7SgBM1Q5Z4MdBEcYICKL1mvgIUZ-1hSrJCeZBU_mv9HudkY5D5t4YGTTV0Tq7-KuHJHhNYYpf8TYVQ8Ovv9DwCKrvuKAFV27gEx6Cv4fmYZq0_yvn439FFq8BPj2SfgI';

class Video_PLayer2 extends StatefulWidget {
  VideoPlayerController controller;
  Video_PLayer2({Key? key, required this.controller}) : super(key: key);

  @override
  State<Video_PLayer2> createState() => _Video_PLayer2State();
}

class _Video_PLayer2State extends State<Video_PLayer2> {
  VideoPlayerController controller =
      VideoPlayerController.network('dataSource');
  late Future<void> _initializeVideoPlayerFuture;

  File? _video;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    // controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = controller.initialize();

    // Use the controller to loop the video.
    controller.setLooping(true);
  }

  Future getVideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (video != null) {
        _video = File(video.path);
        controller = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
          });
        controller.play(); //!
        print(controller);
      } else {
        print('No video selected.');
      }
    });
  }

  Future<bool> addVideo(Map<String, String> body, String filepath) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    String addimageUrl =
        'https://msofter.com/rosseti/public/api/suggestions/store';

    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields['topic_id'] = '1'
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath(
          'existing_solution_video', filepath));

    var response = await request.send();

    print(response.statusCode);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      SafeKeys_video(filepath);
      print('good');
      return true;
    } else {
      print('bad');
      return false;
    }
  }

  void SafeKeys_video(String video_url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('key_video_now', video_url);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FlatButton(
              onPressed: () {
                Map<String, String> body_video = {'title': "video_now"};
                addVideo(body_video, _video!.path);
                print(_video!.path);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => Play(
                          controller: controller,
                          video: _video!,
                        ))));
              },
              child: Text('Send')),
          FlatButton(
              onPressed: () {
                getVideo();
              },
              child: Text('context')),
          FlatButton(
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
                    if (snapshot.connectionState == ConnectionState.done) {
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
          ),
        ],
      ),
    );
  }
}

class Play extends StatefulWidget {
  Play({Key? key, required this.video, required this.controller})
      : super(key: key);
  VideoPlayerController controller;
  File video;
  @override
  State<Play> createState() => _PlayState(controller, video);
}

class _PlayState extends State<Play> {
  File video;
  _PlayState(this.controller, this.video);
  VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;

  // Future getVideo() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     video = pref.getString('key_video_now');

  //     print('Video:  $video');
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getVideo();

    controller = controller;
    print(video.path);
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = controller.initialize();

    // Use the controller to loop the video.
    controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            FlatButton(
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
                      if (snapshot.connectionState == ConnectionState.done) {
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
            ),
          ],
        ));
  }
}

class JoH extends StatefulWidget {
  const JoH({Key? key}) : super(key: key);

  @override
  State<JoH> createState() => _JoHState();
}

class _JoHState extends State<JoH> {
  Future<bool> addImage(Map<String, String> body, String filepath) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    String addimageUrl =
        'https://msofter.com/rosseti/public/api/suggestions/store';

    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields['topic_id'] = '2'
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath(
          'existing_solution_image', filepath));

    var response = await request.send();

    print(response.runtimeType);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Image send good');
      return true;
    } else {
      print('bad');
      return false;
    }
  }

  uplod(String title, File file) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://msofter.com/rosseti/public/api/suggestions/store'))
      ..headers.addAll(headers)
      ..fields['topic_id'] = '2'
      ..files.add(await http.MultipartFile.fromBytes('existing_solution_image',
          (await rootBundle.load('images/car.png')).buffer.asUint8List(),
          filename: 'images/car.png'));
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: TextButton(
        onPressed: () {
          uplod('title', File('images/car.png'));
        },
        child: Text('data'),
      )),
    );
  }
}
