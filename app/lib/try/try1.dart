import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Exp1 extends StatefulWidget {
  const Exp1({Key? key}) : super(key: key);

  @override
  State<Exp1> createState() => _Exp1State();
}

class _Exp1State extends State<Exp1> {
  String fileName = '';
  String status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            pickPicker(fileName, (file) async {
              setState(() {
                fileName = file.path.toString();
                print("Наименование файла : ${fileName}");
              });
              var response = await uploadImages(file);
              setState(() {
                status = response ? "Uploaded" : "Failed";
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  static Widget pickPicker(String fileName, Function onFilePicked) {
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
                  Icons.photo,
                ),
                onPressed: () {
                  _imageFile = _picker.getImage(source: ImageSource.gallery);
                  _imageFile.then((file) => {onFilePicked(file)});
                },
              ),
            ),
          ],
        ),
        fileName != null
            ? Image.file(
                File(fileName),
                width: 35,
                height: 35,
              )
            : Container()
      ],
    );
  }

//api -----  ------  ------- ------  -------

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

    List<int> imageBytes = File(filePath.path).readAsBytesSync();

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
// print(filePath.path.toString());
    return response.statusCode == 201 ? true : false;
  }

  // Future<bool> Api_uploadImage(filePath) async {
  //   String tok =
  //       'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
  //   Map<String, String> headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $tok',
  //   };

  //   List<int> imageBytes = File(filePath.path).readAsBytesSync();

  //   String url = 'https://msofter.com/rosseti/public/api/suggestions/store';

  //   var request = http.Request("POST", Uri.parse(url));
  //   request.headers.addAll(headers);

  //   // request.bodyFields["topic_id"]='1';

  //   request.bodyBytes = imageBytes;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   return response.statusCode == 201 ? true : false;
  // }
}
