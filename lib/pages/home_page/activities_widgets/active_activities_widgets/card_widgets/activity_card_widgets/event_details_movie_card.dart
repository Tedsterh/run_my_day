import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/movie_search/movie_search_bloc.dart';
import 'package:run_my_lockdown/repositories/tmdb_repository/tmdb_repository.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EventMovieDetails extends StatelessWidget {
  EventMovieDetails({Key key, @required this.movieID}) : super(key: key);
  final String movieID;

  static Widget create(context, {@required String movieID}) {
    return BlocProvider<MovieSearchBloc>(
      create: (context) => MovieSearchBloc(tmdbRepository: TMDbRepository())
        ..add(GetMovieDetails(movieId: int.tryParse(movieID))),
      child: EventMovieDetails(
        movieID: movieID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
            intensity: 0.0,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
        child: Container(
          height: 160,
          child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
            builder: (BuildContext context, state) {
              if (state is FoundMovie) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            state.movie.posterPath,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Text(
                        state.movie.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothStarRating(
                          starCount: 5,
                          rating: ((state.movie.voteAverage * 10) / 100) * 5,
                          size: 15.0,
                          isReadOnly: true,
                          color: Colors.orange,
                          borderColor: Colors.orange,
                          spacing: 0.0),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
