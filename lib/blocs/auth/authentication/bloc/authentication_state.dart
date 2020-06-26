part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninisialised extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final CurrentUserModel currentUser;

  Authenticated(this.currentUser);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Authenticated { currentUser: $currentUser }';
}

class Unauthenticated extends AuthenticationState {}