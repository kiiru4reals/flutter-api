import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCalls extends StatefulWidget {
  const ApiCalls({Key? key}) : super(key: key);

  @override
  _ApiCallsState createState() => _ApiCallsState();
}

class _ApiCallsState extends State<ApiCalls> {
  // String? stringResponse;
  // late List listResponse;
  late Map mapResponse;
  late List listOfFacts;

  Future fetchData() async{
    http.Response response;
    response = await http.get(Uri.parse("https://thegrowingdeveloper.org/apiview?id=2"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        mapResponse = jsonDecode(response.body);
        listOfFacts = mapResponse['facts'];
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load content');
    }

  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("API Testing"),
        ),
        body: mapResponse == null ? Container() :ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index){
            return Container(
              child: Column(
                children: <Widget>[
                  Image.network(listOfFacts[index]['image_url']),
                  Text(listOfFacts[index]['title'].toString()),
                  Text(listOfFacts[index]['description'].toString())
                ],
              ),

            );

          },
          itemCount: listOfFacts==null ? 0 : listOfFacts.length,
        )
    );
  }
}
