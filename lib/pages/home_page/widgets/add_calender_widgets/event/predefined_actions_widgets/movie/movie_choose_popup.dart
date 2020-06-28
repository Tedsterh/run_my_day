import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/movie_search/movie_search_bloc.dart';
import 'package:run_my_lockdown/repositories/tmdb_repository/tmdb_repository.dart';

class MovieTimePopup extends StatelessWidget {
  MovieTimePopup({Key key}) : super(key: key);

  static Widget create(context) {
    return BlocProvider<MovieSearchBloc>(
      create: (context) => MovieSearchBloc(tmdbRepository: TMDbRepository())
        ..add(Initialise('Flutter')),
      child: MovieTimePopup(),
    );
  }

  final ValueNotifier<int> movieID = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      content: Builder(
        builder: (context) {
          var width = MediaQuery.of(context).size.width - 25;
          var height = MediaQuery.of(context).size.height - 200;
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            depth: -30,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(30))),
                        child: TextFormField(
                          cursorColor: Color(0xFF7D9DFD),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF7D9DFD),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Search for movie',
                              hintStyle: TextStyle(color: Color(0xFF7D9DFD))),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<MovieSearchBloc>(context)
                                  .add(FindMovies(searchKeyword: value));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                          builder: (context, state) {
                        if (state is FoundMatchingMovies) {
                          return ValueListenableBuilder<int>(
                              valueListenable: movieID,
                              builder: (context, movie, child) {
                                return ListView.builder(
                                  itemCount: state.matchingMovies.length,
                                  itemBuilder: (BuildContext context, index) {
                                    if (state
                                            .matchingMovies[index].posterPath !=
                                        null) {
                                      if (movie ==
                                          state.matchingMovies[index].id) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFF7D9DFD),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ListTile(
                                                onTap: () {
                                                  movieID.value = state
                                                      .matchingMovies[index].id;
                                                },
                                                title: Text(
                                                  state.matchingMovies[index]
                                                      .title,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Container(
                                                    height: 50,
                                                    child: Image.network(
                                                      state
                                                          .matchingMovies[index]
                                                          .posterPath,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ListTile(
                                              onTap: () {
                                                movieID.value = state
                                                    .matchingMovies[index].id;
                                              },
                                              title: Text(state
                                                  .matchingMovies[index].title),
                                              trailing: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Container(
                                                  height: 50,
                                                  child: Image.network(
                                                    state.matchingMovies[index]
                                                        .posterPath,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    return Container();
                                  },
                                );
                              });
                        }
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(movieID.value);
                            },
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  color: Color(0xFF7D9DFD), fontSize: 18),
                            )),
                      ],
                    )
                  ],
                ))
              ],
            ),
          );
        },
      ),
    ));
  }
}
