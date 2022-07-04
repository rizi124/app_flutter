import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class Service {
  Future<bool> addImage(Map<String, String> body, String filepath) async {
    String tok =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $tok',
      'Content-Type': 'multipart/form-data'
    };
    String addimageUrl =
        'https://msofter.com/rosseti/public/api/suggestions/store';
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields['topic_id'] = '1'
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));

    var response = await request.send();
    if (response.statusCode == 201) {
      print(response.statusCode);
      return true;
    } else {
      return false;
    }
  }
}

class ImageUpload1 extends StatefulWidget {
  const ImageUpload1({Key? key}) : super(key: key);
  // PostCreate();

  @override
  State<ImageUpload1> createState() => _ImageUpload1State();
}

class _ImageUpload1State extends State<ImageUpload1> {
  _ImageUpload1State();
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
        print('No image selected');
      }
    });
  }

  Widget _buildImage() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                              child: Column(
                            children: <Widget>[
                              Text('Image Title'),
                              TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Title'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter image title';
                                  }
                                  return null;
                                },
                              )
                            ],
                          )),
                          Container(
                            child: OutlinedButton(
                              onPressed: getImage,
                              child: _buildImage(),
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
                                        "title": _titleController.text
                                      };
                                      service.addImage(body, _image!.path);
                                    }
                                  },
                                  child: Text('Save'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
