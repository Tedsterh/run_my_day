import 'package:run_my_lockdown/repositories/api_keys.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class TMDbRepository {
  TMDbRepository() {
    _service = TmdbService(tmdbApiKey);
  }

  TmdbService _service;

  Future<void> initialise() async {
    await _service.initConfiguration();
  }

  Future<List<MovieBase>> listMoviesByKeyword(String keyword) async {
    PagedResult<MovieBase> results = await _service.movie.search(keyword);

    List<MovieBase> movies = [];
    for (var movie in results.results) {
      movies.add(movie);
    }
    return movies;
  }

  Future<Movie> getMovieDetails(int movieId) async {
    Movie result = await _service.movie.getDetails(movieId);
    return result;
  }
}
