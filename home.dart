import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {

  @override

  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(                    
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Discover",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            MovieList(),                 
          ],
        )
    );
  }
}



class MovieList extends StatefulWidget {

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var movies;     

  Future<void> getData() async {    
    try {
      var data = await getJson();
      setState(() {
        movies = data['results'];
      });
    }
    catch (error) { print(error);}
  }                        

  @override
  Widget build(BuildContext context) {
    getData();
    return Expanded(
      child: ListView.builder(
          itemCount: movies == null ? 0 : movies.length,      
          itemBuilder: (context, i) => MovieCard(movies[i])),   
    );
  }
}


class MovieCard extends StatelessWidget {
  final movie;  
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {},
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
      'http://api.themoviedb.org/3/discover/movie?api_key=20a3f47c1f9a22b518bf93d335169cca';
  http.Response response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}
