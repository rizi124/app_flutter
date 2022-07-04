import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
String tok =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjIzYTQ4ZDljNzkxYTI4OTk0MTQ5M2VjODdlNmVjZjc2ZmUxNTk2ZjA1Nzk4MmFiZmYzN2E3ZDRiNGJjNTMzZmMwZjExM2NhYWMzMTBiZTMiLCJpYXQiOjE2NTI0NTY0NzAsIm5iZiI6MTY1MjQ1NjQ3MCwiZXhwIjoxNjgzOTkyNDcwLCJzdWIiOiIyOCIsInNjb3BlcyI6W119.eT7nfd5sKQPtSgNSCSVXsJghvISQvov1_alROeQCjyi9YtugA-pb8o275O999eDGDOfysETtmKNq5qv46_33_o7ynM4_nO34J-4tMUr7OypdbInzKFcVteuvUobBG24hYAUuM9Lzy9sMOrfPkiZQp82meTpRo_L1B30uxGU1N_MDeQnWkhs_U94txBQT_Il9z2iOKZgqpIe761QmPw5qWuo3icXhgZ5xaoBKBu-kXWSgZu9gH-CKQPOV_octrEs86HEPhw0UwHFaA3SuUDxIYDaqKXY7M7aa6o6VeNyWgsc1XQJuJfq5X799T2l1rJYkDhI5TyDlVqMVuvVe4yGDd-BjeOj8xb_DqG7YJsMclRt6NXH8F-Fjaf54rBO67F5za1rnXq1JPG3NEhwUEFZhMji96bsyZgYGKdONvBcNyGLpAG83G_GeeaOjtcGIseVFiBS4MaXoR3jHv0SXctD9Gg2QX4L9yls-8jiYL-U0FHxmdhxteMQlfYdCxPheCXFRdgaaiQXkks48_1ztikIRzLNuKR7GgMDpxWKLOTOGmwo5STDqxZGVDW76doN6ijxKYEPYumilj6WaGwT4HiUDYhTL4075cniTNz-5WEevAE5vw5mpYc9S7f1tj9X_W8dfV-H8RUAsbG1FoaaQYvSt88Ez5NKoifhYHSTRPw3VO_g';
   
class Service {
  Future<bool> addImage(Map<String, String> body, String filepath) async {
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
      ..files.add(await http.MultipartFile.fromPath('existing_solution_image', filepath));

    var response = await request.send();

    print(response.runtimeType);
    if (response.statusCode >=200 && response.statusCode<300) {
      SafeKeys(filepath);
      print('good');
      return true;
    } else {
      print('bad');
      return false;
    }
  }

   Future<bool> addVideo(Map<String, String> body, String filepath) async {
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
      ..files.add(await http.MultipartFile.fromPath('existing_solution_video', filepath));

    var response = await request.send();

    print(response.runtimeType);
    if (response.statusCode >=200 && response.statusCode<300) {
      SafeKeys(filepath);
      print('good');
      return true;
    } else {
      print('bad');
      return false;
    }
  }

  void SafeKeys(String image_url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('key_image', image_url);
  }
}
