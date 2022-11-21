import 'dart:convert';
import 'package:flutter_application_1/modelMovie.dart';
import 'package:http/http.dart' as http;

class MoviesApi {
  static Future<List<Movie>> getMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?apikey=8e5497c8&s=$query'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response);
      final List data = json.decode(response.body)['Search'];
      List<Movie> movies = [];
        //  print(data);
      for (var u in data) {
        Movie movie = Movie(
          imdbID: u['imdbID'],
          type: u['Type'],
          title: u['Title'],
          poster: u['Poster'],
          year: u['Year'],
        );
        movies.add(movie);
      }
      // print(movies);
      return movies;

      //    List movies = (jsonDecode(response.body) as Map<String,dynamic>)["Search"];
      // // List movies = (jsonDecode(response.body) as List<dynamic>);
      // // print(movies);
      // final list_ = [];
      // print(response.body);
      // for (movie in movies) {

      //     return movies.map<Movie>((map) => Movie.fromJson(map)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }




  // static Future<List<Movie>> getMovies(String query) async {
  //   final url = Uri.parse('https://www.omdbapi.com/?apikey=8e5497c8&s=$query');
  //         // print(url);

  //   final response = await http.get(url);
  //     // print(response);

  //   if (response.statusCode == 200) {
  //     // final List movies = json.decode(response.body);
  //      final json = response.body;
  // // print(response.body);

  //       List movies = (jsonDecode(json) as List<dynamic>) ;
  //  print(json);
  //     return movies.map<Movie>((map) => Movie.fromJson(map)).toList();

  // // final list_ = [];
  // print(response.body);
  // // for (movie in movies) {
  // //   list_.append(movie);
  // // }
  // // print(list_); // ["classid":"25510", "id":"2", "mad_key":"32835"]
  // return movies.map((json) => Movie.fromJson(json)).toList();
  // } else {
  //   throw Exception();
  // }

}
