import 'dart:convert';
import 'package:flutter_application_1/modelMovieInfo.dart';
import 'package:http/http.dart' as http;

class MovieInfoApi {
  static Future<List<MovieInfo>> getMovieInfo(String query) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?apikey=8e5497c8&i=$query'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response);
      final data = json.decode(response.body);
      List<MovieInfo> moviesInfo = [];
      //  print(data);
      MovieInfo movieInfo = MovieInfo(
        actors: data['Actors'] ?? "",
        awards: data['Awards'] ?? "",
        boxOffice: data['BoxOffice'] ?? "",
        country: data['Country'] ?? "",
        dvd: data['DVD'] ?? "",
        plot: data['Plot'] ?? "",
      );

      moviesInfo.add(movieInfo);
      return moviesInfo;
      // for (var u in data) {
      //   MovieInfo movieInfo = MovieInfo(
      //
      //   moviesInfo.add(movieInfo);
      // }
      // print(movies);

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
      throw Exception('Failed to load album');
    }
  }
}
