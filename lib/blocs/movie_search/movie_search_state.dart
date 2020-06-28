part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class FoundMatchingMovies extends MovieSearchState {
  const FoundMatchingMovies({@required this.matchingMovies});

  final List<MovieBase> matchingMovies;

  @override
  List<Object> get props => [matchingMovies];

  @override
  String toString() =>
      'FoundMatchingMovies { matchingMovies: $matchingMovies }';
}

class FoundMovie extends MovieSearchState {
  const FoundMovie({@required this.movie});

  final Movie movie;

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'FoundMovie { movie: $movie }';
}
