class MovieInfo{
  final String actors;
  final String awards;
  final String boxOffice;
  final String country;
  final String dvd;
  final String plot;


  const MovieInfo({
    required this.actors,
    required this.awards,
    required this.boxOffice,
    required this.country,
    required this.dvd,
    required this.plot,  

  });
  
  factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
        actors: json['Actors'],
        awards: json['Awards'],
        boxOffice: json['BoxOffice'],
        country: json['Country'],
         dvd: json['DVD'],
          plot: json['Plot'],
      );

  Map<String, dynamic> toJson() => {
        'actors': actors,
        'awards': awards,
        'boxOffice': boxOffice,
        'country': country,
        'dvd': dvd,
        'plot':plot
      };
}
