import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pando_app/post.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;

  Future<List> getPosts() async {
    String URL = 'https://jsonplaceholder.typicode.com/posts';
    print(URL);
    http.Response response = await http.get(URL);
    print(response.body);
    List ddd = jsonDecode(response.body);
    print(ddd);
    return ddd;
  }

  List<Post> posts = List<Post>();

  _getPosts() async {
    List list = await getPosts();
    setState(() {
      isLoading = true;
      for (int i = 0; i < list.length; i++) {
        Post p = Post.fromJson(list[i]);
        posts.add(p);
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            width: 300.0,
            height: 60.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Fetch Data",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                    fontFamily: 'Raleway',
                    fontSize: 25),
              ),
              onPressed: _getPosts,
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ID : ${posts[index].id}"),
                          Text("Title :${posts[index].title}"),
                        ],
                      ),
                      subtitle: Text("Body :${posts[index].body}"));
                }));
  }
}
