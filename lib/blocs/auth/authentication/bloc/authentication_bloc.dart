import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/repositories/user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  StreamSubscription _userState;

  AuthenticationBloc({@required UserRepository userRepository})
    : assert(userRepository != null),
      _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Loading();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    _userState?.cancel();
    _userState = _userRepository.isSignedInStream().listen(
      (state) {
        if (state) {
          add(LoggedIn());
        } else {
          add(LoggedOut());
        }
      }
    );
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    yield Authenticated(
      await _userRepository.getUserDetails()
    );
  }

  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut event) async* {
    yield Unauthenticated();
  }

}
