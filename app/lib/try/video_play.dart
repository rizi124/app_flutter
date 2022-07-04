import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Video_Play extends StatefulWidget {
  const Video_Play({Key? key}) : super(key: key);

  @override
  State<Video_Play> createState() => _Video_PlayState();
}

class _Video_PlayState extends State<Video_Play> {
  File? _video;
  File? _image;
  final picker = ImagePicker();

  VideoPlayerController? controller;
  final _addFormKey = GlobalKey<FormState>();

  Future getVideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (video != null) {
        _video = File(video.path);
        controller = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
          });
        controller!.play();
      } else {
        print('No video selected.');
      }
    });
  }
   Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [getWidget()]),
    );
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
                    child: _video != null &&
                            controller != null &&
                            controller!.value.isInitialized
                        ? SizedBox(
                            height: 51.0,
                            width: 91.0,
                            child: AspectRatio(
                                aspectRatio: controller!.value.aspectRatio,
                                child: VideoPlayer(controller!)),
                          )
                        : const SizedBox(
                            height: 51.0,
                            width: 91.0,
                          ),
                  ),
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
                    onPressed: () {
                      getVideo();
                    },
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
}




class VideoPlayerScreen extends StatefulWidget {
  

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}