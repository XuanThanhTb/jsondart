import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(MyApp(data: fetchPost()));

Future<Data> fetchPost() async {
  final reponse =
  await http.get('https://jsonplaceholder.typicode.com/posts/1');
  if (reponse.statusCode == 200) {
    return Data.fromJson(json.decode(reponse.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Data {
  final int userId;
  final int id;
  final String title;
  final String body;

  Data({this.userId, this.id, this.title, this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class MyApp extends StatelessWidget {
  final Future<Data> data;

  MyApp({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Request Data',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: FutureBuilder<Data>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Padding(
                      child: Text(snapshot.data.body, textAlign: TextAlign.center, style: TextStyle(color: Colors.greenAccent, fontSize: 24),),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    ),
                    Padding(
                      child: Text(snapshot.data.title, textAlign: TextAlign.center, style: TextStyle(color: Colors.greenAccent, fontSize: 24),),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    ),
              ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }),
        ),
      ),
    );
  }
}




