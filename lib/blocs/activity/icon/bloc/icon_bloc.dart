import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'icon_event.dart';
part 'icon_state.dart';

class IconBloc extends Bloc<IconEvent, IconState> {
  @override
  IconState get initialState => IconInitial();

  @override
  Stream<IconState> mapEventToState(IconEvent event) async* {
    if (event is PickIcon) {
      yield* _mapPickIconToState(event);
    } else if (event is IconSelected) {
      yield ChosenIcon(event.icon);
    } else if (event is SetInitial) {
      yield IconInitial();
    }
  }

  Stream<IconState> _mapPickIconToState(PickIcon event) async* {
    var manifestContent = await DefaultAssetBundle.of(event.context).loadString('AssetManifest.json');
    var manifestMap = json.decode(manifestContent);

    List<String> imagePetPaths = List<String>.from(manifestMap.keys);
    imagePetPaths = imagePetPaths.where((key) => key.contains('assets/run_my_lockdown_icons/')).toList();

    List<String> images = [];
    imagePetPaths.forEach((element) {
      images.add(Uri.decodeFull(element));
    });

    yield ShowIconPicker(images);
  }
}
