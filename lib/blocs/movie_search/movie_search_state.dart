part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
}

class MovieSearchInitial extends MovieSearchState {
  @override
  List<Object> get props => [];
}

class FoundMatchingMovies extends MovieSearchState {
  const FoundMatchingMovies({@required this.matchingMovies});

  final List<MovieBase> matchingMovies;

  @override
  List<Object> get props => [ matchingMovies ];
}

class FoundMovie extends MovieSearchState {
  const FoundMovie({@required this.movie});

  final Movie movie;

  @override
  List<Object> get props => [ movie ];
}
