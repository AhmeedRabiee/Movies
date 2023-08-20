import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/MovieList.dart';
import 'package:flutter_application/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/Detail.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map> movies = [];

  @override
  void initState() {
    super.initState();
    getJson().then((data) {
      setState(() {
        movies = List<Map>.from(data['results']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
  return MaterialApp(
    title: 'Movies',
    routes: {
      '/': (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Discover",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, i) => MovieCard(movies[i]),
              ),
            ),
          ],
        ),
      ),
      '/detail': (context) => Detail(),
    },
  );
}
}

class MovieCard extends StatelessWidget {
  final Map movie;
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: InkWell(
         onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: {     
              'movie': movie
            });
          },
          child: Row(
            children: <Widget>[
              Container(
                  height: 180,
                  child: Image.network('https://image.tmdb.org/t/p/w500/${movie['poster_path']}')
              ),
              Expanded(
                child: Ink(
                  height: 180,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(movie['title'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height: 10),
                      Expanded(child: Text(movie['overview']))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var url =
      'http://api.themoviedb.org/3/discover/movie?api_key=d97e82df5a4d5b33df22852d6eecbffe';
  http.Response response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}
