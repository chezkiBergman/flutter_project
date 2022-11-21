class Movie {
  final String imdbID;
  final String title;
  final String poster;
  final String type;
  final String year;


  const Movie({
    required this.imdbID,
    required this.title,
    required this.poster,
    required this.type,
    required this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        imdbID: json['imdbID'],
        type: json['Type'],
        title: json['Title'],
        poster: json['Poster'],
         year: json['Year'],
      );

  Map<String, dynamic> toJson() => {
        'id': imdbID,
        'title': title,
        'type': type,
        'poster': poster,
        'year': year
      };
}
