import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../view/applications/projects.dart';

String token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGZhZTYxOTZlZTJmNjhiNDg3YjdlMTQxZDBjNDc3MWI0ZDIwOTEzMWRiNGI4NTllYjc4NzY5NjlhMjEwMTM2NWQ4MzI3NWQ3N2Q2MjUyYzgiLCJpYXQiOjE2NTM1NjczMTksIm5iZiI6MTY1MzU2NzMxOSwiZXhwIjoxNjg1MTAzMzE5LCJzdWIiOiIxMTgiLCJzY29wZXMiOltdfQ.Jsmx3DohloUrH_VTH-F7P-NAhFjiFsCHX2jxUXKtiL278WfnyBfngZBfEGpIblnRxcbYtb0Z9O9xGTKPAjKKHV_k_sSMiJU5VCTpwo6KB49kpXh8TPd2azJR8UutuOIVjAuyF6VDlXa6HS2ZW4Ir0LWblrtuojynexnjznm2q1GVIsopDJvbA1nbBkn3k78nv2RED1ui7Zy-DErh9GiNR9mJDt2XbUtFJdjnOpDNhoQ-15t34pzR71vHE-h_f7VBkTmkgYuuc_arCHVzRkCSZA9kV9Wpi9tpWhnjNxrXS3lGF7iKv9BM2ZMELQvTkKOHGSEzinjGdwnmXohvwpq3AcHa0znPafDy5HrOE-EoU8J2AvFnDOKJxZ4Xl_gQNtJ3dRLK42busbFOWMHYVHc-C3uD6rqqCeSCWuAGxj_Te8zrxOnAEo4SvklRxQwW0esxyCdeRze40HCUWXeE3Zq3PNfZILlv4-YqC9rXEtJRRo2CJ8LC-qz5ocAp-t5IzZtsKfNyvNIBPuBmPXJgX5fmFG2ZfEoqyxuj8CVRdLsLKrU_ccRzq6wKCOLXEti5PDqhW0hhnaQG7cmrc9EVkDKEExmJeRwCvF0SiUI3zWu4QEzy80CJZfO3-5xQjh_G2BAhS8Nl2Ke-NZRrGmNXaTQahyHWS8VT5y7bjtF2hWHQWXs';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  late Future<SuggestionsList> suggestionsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggestionsList = getsuggestionsList();
    print(suggestionsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<SuggestionsList>(
        future: suggestionsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.suggestions.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Image.network(
                          '${snapshot.data!.suggestions[i].existing_solution_image}'),
                      // isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SuggestionsList {
  List<Sug> suggestions;
  SuggestionsList({required this.suggestions});

  factory SuggestionsList.fromJson(Map<String, dynamic> json) {
    var suggestionsJson = json['suggestions'] as List;

    List<Sug> suggestionsList =
        suggestionsJson.map((i) => Sug.fromJson(i)).toList();

    return SuggestionsList(suggestions: suggestionsList);
  }
}

class Sug {
  final String existing_solution_image;
  Sug({required this.existing_solution_image});

  factory Sug.fromJson(Map<String, dynamic> json) {
    return Sug(
        existing_solution_image: json['existing_solution_image'] as String);
  }
}

Future<SuggestionsList> getsuggestionsList() async {
  var url =
      Uri.parse('http://msofter.com/rosseti/public/api/suggestions/index');
  final response = await http.get(url, headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token"
  });

  print(response.statusCode);
  print(SuggestionsList.fromJson(json.decode(response.body)));
  if (response.statusCode > 200 && response.statusCode < 300) {
    print(SuggestionsList.fromJson(json.decode(response.body)));
    return SuggestionsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

class Kol extends StatefulWidget {
  const Kol({Key? key}) : super(key: key);

  @override
  State<Kol> createState() => _KolState();
}

class _KolState extends State<Kol> {
  List<Data_of_user> listData = [];
 String? _image;
//

  Future<List<Data_of_user>> getData() async {
    String url = 'https://msofter.com/rosseti/public/api/suggestions/index';
    var apiresponse = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['suggestions'];

    for (int i = 0; i < data.length; i++) {
      listData.add(Data_of_user.fromJson(data[i]));
    }
    return listData;
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 150.0, top: 100),
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 100,
              width: 100,
              // child: Expanded(child: Image.file(File(_image.path))),
            ),
            SizedBox(
              height: 70,
            ),
            FlatButton(onPressed: () {}, child: Text('get data'))
          ],
        ),
      ),
    );
  }
}
