import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../try/example_api/service.dart';

class Ample extends StatefulWidget {
  const Ample({Key? key}) : super(key: key);

  @override
  State<Ample> createState() => _AmpleState();
}

class _AmpleState extends State<Ample> {
  Service service = Service();
  final _addFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  File? _image;
  File? _video;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 130.0, bottom: 23.0),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5,
                  color: Colors.red,
                  child: Container(
                      height: 51.0,
                      width: 91.0,
                      child: Column(
                        children: [],
                      )
                      // child: video != null ? Video.file(video!, fit: BoxFit.cover,)
                      // : Container(height: 51.0,width: 91.0,),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Card(
                      elevation: 5,
                      color: Colors.amber,
                      child: Container(
                        height: 51.0,
                        width: 91.0,
                      )),
                ),
                IconButton(
                    onPressed: getImage,
                    icon: Icon(
                      Icons.photo,
                      size: 43.0,
                    )),
                IconButton(
                    onPressed: getVideo,
                    icon: Icon(
                      Icons.video_call,
                      size: 43.0,
                    )),
              ],
            ),
            FlatButton(
                onPressed: () {
                  if (_addFormKey.currentState!.validate()) {
                    _addFormKey.currentState!.save();
                    Map<String, String> body = {'title': "text"};
                    service.addImage(body, _image!.path);
                  }
                  if (_addFormKey.currentState!.validate()) {
                    _addFormKey.currentState!.save();
                    Map<String, String> body = {'title': "text"};
                    service.addImage(body, _video!.path);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('data'),
                ))
          ]),
        ),
      ),
    );
  }
}

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  Service service = Service();
  final _addFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                  child: Container(
                      height: 51.0,
                      width: 91.0,
                      child: Column(
                        children: [],
                      )
                      // child: video != null ? Video.file(video!, fit: BoxFit.cover,)
                      // : Container(height: 51.0,width: 91.0,),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Card(
                    elevation: 5,
                    color: Colors.amber,
                    child: Container(
                      height: 51,
                      width: 91,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: getImage,
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
      )),
    );
  }
}

class Part_for_video3 extends StatefulWidget {
  @override
  State<Part_for_video3> createState() => _Part_for_video3State();
}

class _Part_for_video3State extends State<Part_for_video3> {
  // File? image;
  // File? _video;
  // Future<PickedFile?>? _imageFile;
  // ImagePicker _imagePicker = ImagePicker();

  String fileNameimage = '';
  String fileNamevideo = '';

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: Container(
                  height: 51.0,
                  width: 91.0,
                  child: Column(
                    children: [],
                  )
                  // child: video != null ? Video.file(video!, fit: BoxFit.cover,)
                  // : Container(height: 51.0,width: 91.0,),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Card(
                elevation: 5,
                color: Colors.amber,
                child: Container(
                  height: 51.0,
                  width: 91.0,
                  child: fileNameimage != null
                      ? Image.file(
                          File(fileNameimage),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 51.0,
                          width: 91.0,
                        ),
                ),
              ),
            ),
            videoPicker(fileNamevideo, (file) async {
              setState(() {});
            }),
            imagePicker(fileNameimage, (file) async {
              setState(() {
                fileNameimage = file.path.toString();
                // print(fileNameimage);
                uploadImages(file);
                // print(file);
              });
            })
          ],
        ),
      ],
    );
  }

  Widget imagePicker(String fileName, Function onFilePicked) {
    Future<PickedFile?> _imageFile;
    ImagePicker _picker = ImagePicker();
    return Padding(
      padding: const EdgeInsets.only(right: 35.0, left: 11.0, bottom: 10.0),
      child: IconButton(
        onPressed: () {
          _imageFile = _picker.getImage(source: ImageSource.gallery);
          _imageFile.then((file) => {onFilePicked(file)});
        },
        icon: Icon(
          Icons.photo,
          size: 43.0,
        ),
      ),
    );
  }

  Widget videoPicker(String fileName, Function onFilePicked) {
    //String fileName, Function onFilePicked

    Future<PickedFile?> _videoFile;
    ImagePicker _picker = ImagePicker();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: IconButton(
        onPressed: () {
          _videoFile = _picker.getVideo(source: ImageSource.gallery);
          _videoFile.then((file) => {onFilePicked(file)});
        },
        icon: Icon(
          Icons.video_collection,
          size: 43.0,
        ),
      ),
    );
  }

  Future<bool> uploadImages(filePath) async {
    String tok =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $tok',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://msofter.com/rosseti/public/api/suggestions/store'),
    );

    request.headers.addAll(headers);

    request.fields['topic_id'] = '1';
    request.headers.addAll(headers);
    // final mi = Image.file(filePath.pathzzzz);

    //List<int> imageBytes = File(filePath.path).readAsBytesSync();

    var picture = http.MultipartFile.fromBytes(
        'image', (await rootBundle.load('images/car.png')).buffer.asInt8List(),
        filename: 'testimage.png');
    print("$picture and picture.runtype: ${picture.runtimeType}");

    request.files.add(picture);

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(response.statusCode);
    print(result);

    return response.statusCode == 201 ? true : false;
  }
}
