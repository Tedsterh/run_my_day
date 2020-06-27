import 'package:bloc/bloc.dart';
import 'dart:developer' as developer;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    developer.log(event.toString(), name: 'BLOC_EVENT $bloc');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    developer.log(error.toString(), name: 'BLOC_ERROR $bloc', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    developer.log(transition.toString(), name: 'BLOC_TRANSITION $bloc');
    super.onTransition(bloc, transition);
  }
}