import 'dart:convert';

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Images extends StatefulWidget {
  const Images({Key? key}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  Future<File>? file;
  String status = '';
  String base64Image = '';
  File? tempFile;
  String error = 'Error';

  ImagePicker _picker = ImagePicker();

  choseImage() {
    setState(() {
      file = _picker.pickImage(source: ImageSource.gallery) as Future<File>;
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  uploading() {
    if (null == tempFile) {
      setStatus(error);
      return;
    }
    String fileName = tempFile!.path.split("/").last;
  }

  upload(String fileName) async {
    String tok =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';

    http.post(
        Uri.parse("https://msofter.com/rosseti/public/api/suggestions/store"),
        body: {"image": base64Image, "name": fileName}).then((result) {
      setStatus(result.statusCode == 200 ? result.body : error);
    });

    var response = await http.post(
        Uri.parse("https://msofter.com/rosseti/public/api/suggestions/store"),
        body: ({"existing_solution_image": base64Image}),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tok',
        }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : error);
    });

    var request = http.post(
      Uri.parse('https://msofter.com/rosseti/public/api/suggestions/store'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder<File>(
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  null != snapshot.data) {
                tempFile = snapshot.data;
                base64Image = base64Encode(snapshot.data!.readAsBytesSync());
                return Image.file(snapshot.data!);
              } else if (null != snapshot.error) {
                return Text("error");
              } else {
                return Container(
                  child: Material(
                    elevation: 3,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(child: Image.asset('images/car.png')),
                        InkWell(
                          onTap: () {
                            choseImage();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 10.0),
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
            // FlatButton(
            //     onPressed: choseImage,
            //     child: Text(
            //       'Btn',
            //       style: TextStyle(color: Colors.red, fontSize: 18),
            //     ))
            RaisedButton(
              onPressed: () {
                uploading();
              },
              child: Text('Upload Image'),
            )
          ],
        ),
      ),
    );
  }
}

// uploadVideos(String title, File file) async {
//   String tok =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
//   Map<String, String> headers = {
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $tok',
//   };
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse('https://msofter.com/rosseti/public/api/suggestions/store'),
//   );

//   request.headers.addAll(headers);
//   // var v = request.headers.addAll(headers);
//   request.fields['topic_id'] = '1';
//   request.headers.addAll(headers);

//   var picture = http.MultipartFile.fromBytes(
//       'image', (await rootBundle.load('images/car.png')).buffer.asInt8List(),
//       filename: 'testimage.png');

//   request.files.add(picture);

//   var response = await request.send();

//   var responseData = await response.stream.toBytes();
//   var result = String.fromCharCodes(responseData);
//   print(response.statusCode);
//   print(responseData);
//   print(result);
// }

uploadImages(String title, File file) async {
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
  // var v = request.headers.addAll(headers);
  request.fields['topic_id'] = '1';
  request.headers.addAll(headers);

  var picture = http.MultipartFile.fromBytes(
      'image', (await rootBundle.load('images/car.png')).buffer.asInt8List(),
      filename: 'testimage.png');

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();
  var result = String.fromCharCodes(responseData);
  print(response);
  print(responseData);
  print(result);
}

// class Images extends StatefulWidget {
//   const Images({Key? key}) : super(key: key);

//   @override
//   State<Images> createState() => _ImagesState();
// }

// class _ImagesState extends State<Images> {
//

//   File? image;
// final _picker = ImagePicker();
//   bool showSpinner = false;

//   Future getImage() async {
//     final pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

//     if (pickedFile != null) {
//       image = File(pickedFile.path);
//       setState(() {});
//     } else {
//       print("no image selected ");
//     }
//   }

//   Future<void> uploadImage() async {
//     setState(() {
//       showSpinner = true;
//     });
//     var stream = http.ByteStream(image!.openRead());
//     stream.cast();
//     var lenght = await image!.length();
//     var url =
//         Uri.parse('http://msofter.com/rosseti/public/api/suggestions/store');

// Map<String, String> headers = {
//   'Accept': 'application/json',
//   'Authorization': 'Bearer $tok',
// };

//     var request = http.MultipartRequest("POST", url);
//     request.headers.addAll(headers);
//     request.fields['title'] = 'Static title';

//     var multiport =
//         http.MultipartFile("existing_solution_image", stream, lenght);
//     request.files.add(multiport);
// //

//     var response = await request.send();
//     print(response.stream.toString());
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       setState(() {
//         showSpinner = false;
//       });
//       print('image upload');
//     } else {
//       print('failed');
//       setState(() {
//         showSpinner = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: showSpinner,
//       child: Scaffold(
//           body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               getImage();
//             },
//             child: Container(
//               child: image == null
//                   ? Center(
//                       child: Text('Pick Image'),
//                     )
//                   : Container(
//                       child: Center(
//                         child: Image.file(
//                           File(image!.path).absolute,
//                           height: 100,
//                           width: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//           SizedBox(height: 150.0),
//           GestureDetector(
//               onTap: (() {
//                 uploadImage();
//               }),
//               child: Container(
//                   height: 50, color: Colors.green, child: Text('Upload')))
//         ],
//       )),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Images extends StatefulWidget {
//   const Images({Key? key}) : super(key: key);

//   @override
//   State<Images> createState() => _ImagesState();
// }

// class _ImagesState extends State<Images> {
//   String fileName = '';
//   String status = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             picPicker(fileName, (file) async {
//               setState(() {
//                 fileName = file.path.toString();
//               });
//               var res = await getMyRequest(file);
//               setState(() {
//                 // status = res ? 'Uploaded' : 'Failed';
//               });
//             }),
//             SizedBox(
//               height: 10,
//             ),
//             Visibility(
//               child: CircularProgressIndicator(),
//               visible: status == '' && fileName != null,
//             ),
//             Text(
//               status.toUpperCase(),
//               style: TextStyle(color: Colors.red, fontSize: 18),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget picPicker(String fileName, Function onFilePicked) {
//     Future<PickedFile?> _imageFile;
//     ImagePicker _picker = ImagePicker();
//     return Column(children: <Widget>[
//       Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 35,
//                 width: 35,
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.image,
//                     size: 35,
//                   ),
//                   onPressed: () {
//                     _imageFile = _picker.getImage(source: ImageSource.gallery);
//                     _imageFile.then((file) => {onFilePicked(file)});
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 40.0,
//               ),
//               fileName != null
//                   ? Image.file(
//                       File(fileName),
//                       width: 35,
//                       height: 35,
//                     )
//                   : Container(),
//               Container(
//                 width: 50,
//               )
//             ],
//           ),
//         ],
//       ),
//     ]);
//   }

//   Future<bool> uploadImage(filePath) async {
// String tok =
//     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
//     String url = 'https://msofter.com/rosseti/public/api/suggestions/store';
//     String fileName = filePath.path.split("/").last;

// Map<String, String> headers = {
//   'Accept': 'application/json',
//   'Authorization': 'Bearer $tok',
// };

//     List<int> imageBytes = File(filePath.path).readAsBytesSync();
//     var request = http.Request('POST', Uri.parse(url));
//     request.headers.addAll(headers);
//     request.bodyBytes = imageBytes;
//     var res = await request.send();
//     print(res.statusCode);
//     return res.statusCode == "500" ? true : false;
//   }

//   Future<void> getMyRequest(filePath) async {
//     String tok =
//         'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';

//     if (filePath.toString() != null) {
//       var response = await http.post(
//           Uri.parse("https://msofter.com/rosseti/public/api/suggestions/store"),
//           body: ({
//             "existing_solution_image": filePath.toString(),
//           }),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $tok',
//           });
//       List<int> imageBytes = File(filePath.path).readAsBytesSync();
//      var v = response.bodyBytes = imageBytes;
//       print(response.statusCode);
//       print(filePath.toString());

//       if (response.statusCode == 200) {
//         final body = jsonDecode(response.body);
//         print(body['success']);
//       } else {
//         print('Я не могу }{ create_descript');
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Black Field Not Allowed')));
//     }
//   }
// }

// class Images extends StatefulWidget {
//   const Images({Key? key}) : super(key: key);

//   @override
//   State<Images> createState() => _ImagesState();
// }

// class _ImagesState extends State<Images> {
//   String tok = 'dkmcsodmcmamasp123123';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: Center(
//         child: Container(
//           child: TextButton(
//             onPressed: () {
//               uploadImage("image", File('images/car.png'));
//             },
//             child: Text('data'),
//           ),
//         ),
//       ),
//     ));
//   }

//   void uploadImage(String title, File file) async {
//     var url =
//         Uri.parse("https://msofter.com/rosseti/public/api/suggestions/store");
//     var request = http.MultipartRequest("POST", url);

//      var respon1se = await http.post(
//           url,
//           body: ({
//             "existing_solution_image": title,

//           }),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $tok',
//           });

//     request.fields['title'] = 'dummyImage';
//     request.headers['Authorization'] = '';
//     var picture = http.MultipartFile.fromBytes(
//         'image', (await rootBundle.load("images/car.png")).buffer.asUint8List(),
//         filename: 'img_car.png');
//     request.files.add(picture);
//     var response = await request.send();
//     var responseData = await response.stream.toBytes();
//     var result = String.fromCharCodes(responseData);

//     print(result);

//   }
// }

class Exp extends StatefulWidget {
  const Exp({Key? key}) : super(key: key);

  @override
  State<Exp> createState() => _ExpState();
}

class _ExpState extends State<Exp> {
  String fileName = '';
  String status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            pickPicker(fileName, (file) async {
              setState(() {
                fileName = file.path.toString();
                print(file);
              });
              var res = await uploadImages(
                file,
              );
              setState(() {
                status = res ? 'Upload' : 'Failed';
              });
            }),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: CircularProgressIndicator(),
              visible: status == "" && fileName != null,
            ),
            Text(
              status.toUpperCase(),
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget pickPicker(String fileName, Function onFilePicked) {
    Future<PickedFile?> _imageFile;
    ImagePicker _picker = ImagePicker();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35,
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.image,
                  size: 35,
                ),
                onPressed: () {
                  _imageFile = _picker.getImage(source: ImageSource.gallery);
                  _imageFile.then((file) => {onFilePicked(file)});
                },
              ),
            ),
            fileName != null
                ? Image.file(
                    File(fileName),
                    width: 35,
                    height: 35,
                  )
                : Container()
          ],
        )
      ],
    );
  }

  Future<bool> upIma2ge(filePath) async {
    String fileName = filePath.path.split('/').last;
    String tok =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $tok',
    };
    List<int> imageBytes = File(filePath.path).readAsBytesSync();
    var request = http.Request("POST",
        Uri.parse('https://msofter.com/rosseti/public/api/suggestions/store'));
    request.headers.addAll(headers);
    // request.fields['topic_id'] = '1';

    request.bodyBytes = imageBytes;
    var res = await request.send();
    print(res.statusCode);
    return res.statusCode == 201 ? true : false;

    // var req = http.MultipartRequest("POST",
    //     Uri.parse('https://msofter.com/rosseti/public/api/suggestions/store'));
    // request.headers.addAll(headers);
    // req.b
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

    // List<int> imageBytes = File(filePath.path).readAsBytesSync(); 

    var picture = http.MultipartFile.fromBytes(
        'image', (await rootBundle.load('images/car.png')).buffer.asInt8List(),
        filename: 'testimage.png');
    // print((rootBundle.load('images/car.png')).buffer.asInt8List());

    request.files.add(picture);
    // print(picture);

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(response.statusCode);
    print(result);

    return response.statusCode == 201 ? true : false;
  }
}
