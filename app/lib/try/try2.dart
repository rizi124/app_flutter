import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../view/applications/projects.dart';

class POP extends StatefulWidget {
  const POP({Key? key}) : super(key: key);

  @override
  State<POP> createState() => _POPState();
}

class _POPState extends State<POP> {
  List<Data_of_user>? posts;
  String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  Future<int> getCount(count) async {
    count = await posts?.length;
    return count as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: posts?.length =posts!.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // color: Colors.red,
                  height: 127,
                  width: 336,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('images/car.png'),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 50.0, bottom: 20.0),
                            child: Text(
                              '${posts?[i].title}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: Text("${posts?[i].author!["full_name"]}")),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, top: 10),
                            child: Text('data'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  final client = HttpClient();

  Future<List<Data_of_user>> getPosts() async {
    final json =
        await get('https://msofter.com/rosseti/public/api/suggestions/index')
            as Map<String, dynamic>;
    // print("json ${json.runtimeType}");

    final data = json["suggestions"] as List<dynamic>;
    // print("data  $data");
    // print(data.runtimeType);

    posts = data
        .map((dynamic e) => Data_of_user.fromJson(e as Map<String, dynamic>))
        .toList();

    //  author_post = posts?[0].author;

    // print(author_post.runtimeType);

    // print(posts?[0].author!['full_name']);
    return posts as List<Data_of_user>;
  }

  Future<dynamic> get(String ulr) async {
    Uri url = Uri.parse(ulr);

    final request = await client.getUrl(url);
    request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
    request.headers.add("Accept", "application/json");
    request.headers.add("Authorization", "Bearer $tok");
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final dynamic json = jsonDecode(jsonString);
    // print("json ${json.runtimeType}");
    return json;
  }
}

class Ex2 extends StatefulWidget {
  const Ex2({Key? key}) : super(key: key);

  @override
  State<Ex2> createState() => _Ex2State();
}

class _Ex2State extends State<Ex2> {
  List<Data_of_user>? posts;
  String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";
  @override
  void initState() {
    // TODO: implement initState
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Material(
        elevation: 5,
        child: Container(
          color: Colors.red,
          width: 336,
          height: 126,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('images/car.png'),
              Column(
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 30,
                    color: Colors.green,
                    child: Stack(
                      children: [],
                    ),
                  ),
                  Text("data"),
                  Text("data")
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  final client = HttpClient();

  Future<void> getPosts() async {
    final json =
        await get('https://msofter.com/rosseti/public/api/suggestions/index')
            as Map<String, dynamic>;
    // print("json ${json.runtimeType}");

    final data = json["suggestions"] as List<dynamic>;
    // print("data  $data");
    // print(data.runtimeType);

    posts = data
        .map((dynamic e) => Data_of_user.fromJson(e as Map<String, dynamic>))
        .toList();

    //  author_post = posts?[0].author;

    // print(author_post.runtimeType);

    // print(posts?[0].author!['full_name']);
  }

  Future<dynamic> get(String ulr) async {
    Uri url = Uri.parse(ulr);

    final request = await client.getUrl(url);
    request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
    request.headers.add("Accept", "application/json");
    request.headers.add("Authorization", "Bearer $tok");
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final dynamic json = jsonDecode(jsonString);
    // print("json ${json.runtimeType}");
    return json;
  }
}

class Pro extends StatefulWidget {
  const Pro({Key? key}) : super(key: key);

  @override
  State<Pro> createState() => _ProState();
}

class _ProState extends State<Pro> {
  List<Data_of_user>? posts;
  String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (BuildContext context, i) {
            return Center(
                child: Material(
              elevation: 5,
              child: Container(
                width: 336,
                height: 126,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 40,
                      left: 10,
                      child: Image.asset('images/car.png'),
                    ),
                    Positioned(
                      top: 30,
                      left: 230,
                      child: Container(
                        // padding: EdgeInsets.all(10),
                        // color: Colors.red,
                        // width: MediaQuery.of(context).size.width,
                        height: 30,
                        width: 90,
                        padding: EdgeInsets.only(
                          right: 28,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  '${posts?[i].title}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),
    );
  }

  final client = HttpClient();

  Future<void> getPosts() async {
    final json =
        await get('https://msofter.com/rosseti/public/api/suggestions/index')
            as Map<String, dynamic>;
    // print("json ${json.runtimeType}");

    final data = json["suggestions"] as List<dynamic>;
    // print("data  $data");
    // print(data.runtimeType);

    posts = data
        .map((dynamic e) => Data_of_user.fromJson(e as Map<String, dynamic>))
        .toList();

    //  author_post = posts?[0].author;

    // print(author_post.runtimeType);

    // print(posts?[0].author!['full_name']);
  }

  Future<dynamic> get(String ulr) async {
    Uri url = Uri.parse(ulr);

    final request = await client.getUrl(url);
    request.headers.removeAll(HttpHeaders.acceptEncodingHeader);
    request.headers.add("Accept", "application/json");
    request.headers.add("Authorization", "Bearer $tok");
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final dynamic json = jsonDecode(jsonString);
    // print("json ${json.runtimeType}");
    return json;
  }
}
// Text(
//                                     '${posts?[i].title}',
//                                     style: TextStyle(
//                                         fontFamily: 'Schyler',
//                                         color: Color(0xff205692),
//                                         fontSize: 20),
//                                   ),
