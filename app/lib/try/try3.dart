import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../view/main_page.dart';

String tok =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGVhM2E5YTdmZTczMTU0ZmRjMjE5ZTk2NjNlMzk0MzhmYThiYjNhOTU4MWJlOWIyZmJmMDliMWVmMmE4ZDQ5YmY2ZjFjZDVlYzU0ZjFjMTIiLCJpYXQiOjE2NTI4NzgzNjIsIm5iZiI6MTY1Mjg3ODM2MiwiZXhwIjoxNjg0NDE0MzYyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.H6AoELeotOi3OQPVZpCEf4grfbv35coiFsXaPqSpso_m-l6d3WgeSkxnEnbs3t0vgTrJwb4_mfH_4O87Lda31N0InaHdeADCz-dlu1Q035IM7om_fpUscdGcKeRaEk36fsUjb4ntbaTWzKaGi0rq_UTQp-DzqcFvJdXqc1fUxP4VBmPm1-bbawG9rMoh5fRlK8xq0zL0rxGiQfX4fMJy2sngDZENQXjeeqpwquPDfMINLrP6feuGwhvMTVBdG6gkrER7fZLPelM0--7M9K1b0-23KJ9YLVjybmHnE9Sl9uByUkubjepK6h9miBPJzYWTfg34EgBaxc0Vs2aigU-_5yM24kSqapc9S7IuNZ5I6BylAcf-enI82vsZBsLSW4JU4fER4JQTaEW4KtnxrTo-SqN_0w3ALSj7aQ-TmGKvblvSSCYmluE_OMOlJPf9aFcOaGeDYighOd69OUPxPJNYBhH5xueTOGXJb3SYGHV7WwhplYZwe9X242Sb7TZwO-oWSCCsT2q1L3SKODt6vsxbMWVG3peeFdmUOdOTZuCwGw3hfgOCgbC-lW_Tw4BuLcUQDYAFRIMm0W1d31JzcYmrmTZaLLqGOuUhSJ545E9NtgGv2SjD2PdvGePctQGl1NKLYwOlqvERNz_4TSOhOUBROEArHvcmofprMa_iSEcaNOE";

// class StateService {
//   static final List<String> states = ['1', '2', "3", "45", "67"];
//   static List<String> getSuggestion(String query) {
//     List<String> matches = [];

//     matches.addAll(states);
//     matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
// }

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();

  String? userSelected;
  @override
  void initState() {
    getListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(right: 18.0, top: 8.0),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: TypeAheadField(
              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                  color: Colors.green,
                  elevation: 4.0,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              debounceDuration: Duration(milliseconds: 400),
              textFieldConfiguration: TextFieldConfiguration(
                  onChanged: (value) {},
                  controller: _searchController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Search',
                      contentPadding: EdgeInsets.only(top: 4, left: 10),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          )),
                      fillColor: Colors.white,
                      filled: true)),
              suggestionsCallback: (value) {
                return getSuggestion(value);
              },
              itemBuilder: (context, String suggestion) {
                return Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          suggestion,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              },
              onSuggestionSelected: (String suggestion) {
                setState(() {
                  userSelected = suggestion;
                  _searchController.text = suggestion;
                });
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              userSelected ?? "Search",
              style: const TextStyle(fontSize: 20),
            ),
            // Text(_searchController.text),
            FlatButton(
                onPressed: () {
                  print(_searchController.text);
                },
                child: Text("dcnskn"))
          ],
        ),
      ),
    );
  }

  final List<String> list_title = [];
// static final List<String> states = ['1', '2', "3", "45", "67"];
  List<String> getSuggestion(String query) {
    List<String> matches = [];

    matches.addAll(list_title);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<Post_Api> list = [];

  void getListApi() {
    getData().then((value) {
      list = value;
      for (int i = 0; i < list.length; i++) {
        list_title.add(list[i].id.toString());
      }

      setState(() {});
    });
  }

  Future<List<Post_Api>> getData() async {
    String url = "https://msofter.com/rosseti/public/api/topics";
    var apiresponse = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tok",
      },
    );

    var jsonObject = json.decode(apiresponse.body);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['topics'];

    List<Post_Api> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Post_Api.fromJson(data[i]));

    return listData;
  }
}
