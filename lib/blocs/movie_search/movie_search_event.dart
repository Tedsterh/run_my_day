part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class Initialise extends MovieSearchEvent {
  final String searchWord;

  Initialise(this.searchWord);

  @override
  List<Object> get props => [searchWord];
}

class FindMovies extends MovieSearchEvent {
  const FindMovies({@required this.searchKeyword});

  final String searchKeyword;

  @override
  List<Object> get props => [ searchKeyword ];
}

class GetMovieDetails extends MovieSearchEvent {
  const GetMovieDetails({@required this.movieId});

  final int movieId;

  @override
  List<Object> get props => [ movieId ];
}
