import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:run_my_lockdown/repositories/user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
    : assert(userRepository != null),
      _userRepository = userRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignInWithGoogle) {
      yield* _mapSignInWithGoogleToState(event);
    }
  }

  Stream<LoginState> _mapSignInWithGoogleToState(SignInWithGoogle event) async* {
    yield LoginLoading();
    try {
      await _userRepository.signInWithGoogle();
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailed();
    }
  }
}
