import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/main.dart';

class MovieList extends StatefulWidget {

  @override

  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
   var movies;
   
     get index => null; 
   void getData() async {      
    var data = await getJson();
    setState(() {
      movies = data['results'];
    });
    Future<void> getData() async {     
    try {
      var data = await getJson();
      setState(() {
        movies = data['results'];
      });
    }
    catch (error) { print(error);}
  }        
     }
     

  @override
  Widget build(BuildContext context) {
    getData();
    return Expanded(
      child: ListView.builder(
          itemCount: movies == null ? 0 : movies.length,      
          itemBuilder: (context, i) => MovieCard(movies[index])),   
    );
  }
}
