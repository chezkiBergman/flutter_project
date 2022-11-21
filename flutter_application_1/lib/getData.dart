import 'dart:async';
import 'package:flutter_application_1/modelMovie.dart';
import 'package:flutter_application_1/modelMovieInfo.dart';
import 'package:flutter_application_1/movieInfoApi.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/searchMovies.dart';
import 'package:flutter/material.dart';

class FilterMoviesByName extends StatefulWidget {
  @override
  FilterMoviesByNameState createState() => FilterMoviesByNameState();
}

class FilterMoviesByNameState extends State<FilterMoviesByName> {
  List<Movie> movies = [];
  List<MovieInfo> infoMovie = [];

  bool showInfo = false;

  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final movies = await MoviesApi.getMovies(query);
    // print(movies);
    setState(() => this.movies = movies);
  }

  Future getInfo(String query) async => debounce(() async {
        final infoMovie = await MovieInfoApi.getMovieInfo(query);

        if (!mounted) return;
        setState(() {
          this.query = query;
          this.infoMovie = infoMovie;
          showInfo = true;
        });
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('my first app flutter'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: showInfo
                  ? ListView.builder(
                      itemCount: infoMovie.length,
                      itemBuilder: (context, index) {
                        final info = infoMovie[index];

                        return buildInfoMovie(info);
                      },
                    )
                  : ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return buildMovie(movie);
                      },
                    ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchMovie,
      );

  Future searchMovie(String query) async => debounce(() async {
        final movies = await MoviesApi.getMovies(query);

        if (!mounted) return;

        setState(() {
          showInfo = false;
          this.query = query;
          this.movies = movies;
        });
      });

  Widget buildMovie(Movie movie) => Card(
          child: ListTile(
        leading: Image.network(
          movie.poster,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        title: Text(movie.title),
        subtitle: Text('type: ${movie.type} , year: ${movie.year}.'),
        trailing: IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            getInfo(movie.imdbID);
          },
        ),
      ));

  Widget buildInfoMovie(MovieInfo info) => Card(
          child: ListTile(
        title: Text(
          'plot: ${info.plot}',
          style: TextStyle(color: Colors.blue),
        ),
        subtitle: Text(
          'actors: ${info.actors} , country: ${info.country} , box office: ${info.boxOffice} .',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
}
