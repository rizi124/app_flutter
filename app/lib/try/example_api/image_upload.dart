import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'service.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  Service service = Service();
  final _addFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _title2Controller = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  File? _video;

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
      appBar: AppBar(
        title: Text('Add Images'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            child: Card(
                child: Container(
                    child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('Image Title'),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Title',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: OutlineButton(
                    onPressed: getVideo,
                    child: _buildVideo(),
                  ),
                ),
                Container(
                    child: OutlineButton(
                        onPressed: getImage, child: _buildImage())),
                Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          if (_addFormKey.currentState!.validate()) {
                            _addFormKey.currentState!.save();
                            Map<String, String> body = {
                              'title': _titleController.text
                            };
                            service.addImage(body, _image!.path);
                            service.addVideo(body, _video!.path);
                          }
                        },
                        child: Text('Save'),
                      ),
                      FlatButton(
                        onPressed: () {
                          print("IM: $_image");
                          print('V $_video');
                        },
                        child: Text('data'),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          if (_addFormKey.currentState!.validate()) {
                            _addFormKey.currentState!.save();
                            Map<String, String> body = {
                              'titl2': '_title2Controller.text'
                            };
                            service.addVideo(body, _video!.path);
                          }
                        },
                        child: Text('Save2'),
                      ),
                    ],
                  ),
                ),
              ],
            ))),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (_image == null) {
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }

  Widget _buildVideo() {
    if (_video == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Icon(
          Icons.add_a_photo,
          color: Colors.red,
        ),
      );
    } else {
      return Text(_video!.path);
    }
  }
}
