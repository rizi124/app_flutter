import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ8.eyJhdWQiOiIxIiwianRpIjoiMWM5MDJlYzQ1MzE4YWNlYmUyMmQzN2Y3OGRjNjRkY2EyMTQ0MzE0NDQ0Y2U2NTVkNDc2NDQyMjEyODA0YWYyY2M3NzMwODJjZDAxMzQ5ZmQiLCJpYXQiOjE2NTI1Mzc4MzEsIm5iZiI6MTY1MjUzNzgzMSwiZXhwIjoxNjg0MDczODMxLCJzdWIiOiIxMTMiLCJzY29wZXMiOltdfQ.JtHri4BsxF8sBi-58SscS9hhW74_IENGgm2QmFZIID1BJklq1pOMACsVFgOqrCA1zlGyPfh9Uf7u5a4QsrCoqH5a0y3BT3euQbbugihaWWfGJOUImma_cpqGbTetSVkV2JZNFgC8S3GZ8CHCsadWttdDCAwhHLSK_pyaPPwsN514JTmuMhi2A0w_xmug4fBigldiEyo0mXly-tTp0wVB1MRP12WI_6lVWA9P3kB2aCs6sL32fjqrmdK6kK-UDtjhPWk0jC1FMT-gIrJYVRAAdBMczk69JTTNsiPuVcrktiAO-stYTEUDeSQZuhBFXmjvFlq6ap9ZPdmi4LBQAGjwUNyNgvjbOj1UW-H62gfPdYuesRfzkcfZErxZwkLtYZyMzhZQUwQD-hViZMRadAGJ4PMw-cdP948-DCp_L8jHv3p3sGDuS9hivLddDkTtYZD1Ao-7Rrfwwno6izw1N1DDmoxt0jXc_uTON-PHL75dm_KjfNN2zSxch5kGw_i1-92GeLmJK-nQVfmRp5hX0nW7yDl4qm7FgzESFGRFn1h3haM7SgBM1Q5Z4MdBEcYICKL1mvgIUZ-1hSrJCeZBU_mv9HudkY5D5t4YGTTV0Tq7-KuHJHhNYYpf8TYVQ8Ovv9DwCKrvuKAFV27gEx6Cv4fmYZq0_yvn439FFq8BPj2SfgI';

class Hp extends StatefulWidget {
  const Hp({Key? key}) : super(key: key);

  @override
  State<Hp> createState() => _HpState();
}

class _HpState extends State<Hp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        FlatButton(
            onPressed: () {
              upload(jone.toString());
            },
            child: Text('data'))
      ],
    ));
  }

  String jone = 'images/cap.png';
  Widget pickPicker(String fileName, Function onFilePicked) {
    Future<PickedFile> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              upload(jone);
            },
          ),
        )
      ],
    );
  }

  Future<bool> upload(filePath) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    String url = 'https://msofter.com/rosseti/public/api/suggestions/store';

    List<int> imageBytes = File(filePath.path).readAsBytesSync();
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.bodyBytes = imageBytes;
    var res = await request.send();
    print(res.statusCode);
    return res.statusCode == 201 ? true : false;
  }
}
