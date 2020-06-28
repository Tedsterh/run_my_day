import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/repositories/tmdb_repository/tmdb_repository.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc({@required TMDbRepository tmdbRepository})
      : assert(tmdbRepository != null),
        _tmdbRepository = tmdbRepository;

  TMDbRepository _tmdbRepository;

  @override
  MovieSearchState get initialState => MovieSearchInitial();

  @override
  Stream<MovieSearchState> mapEventToState(
    MovieSearchEvent event,
  ) async* {
    if (event is FindMovies) {
      yield FoundMatchingMovies(
        matchingMovies: await _tmdbRepository.listMoviesByKeyword(event.searchKeyword),
      );
    }
    if (event is GetMovieDetails) {
      yield FoundMovie(
        movie: await _tmdbRepository.getMovieDetails(event.movieId),
      );
    }
    if (event is Initialise) {
      yield* _mapInitialiseToState(event);
    }
  }

  Stream<MovieSearchState> _mapInitialiseToState(Initialise event) async* {
    await _tmdbRepository.initialise();
    add(FindMovies(searchKeyword: event.searchWord));
  }
}
