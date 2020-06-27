import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/repositories/user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninisialised();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    if (await _userRepository.isSignedIn()) {
      yield Authenticated(await _userRepository.getUserDetails());
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    if (await _userRepository.isSignedIn()) {
      yield Authenticated(await _userRepository.getUserDetails());
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut event) async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
