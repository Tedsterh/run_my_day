import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity_actions/do_not_disturb/bloc/do_not_disturb_bloc.dart';
import 'package:run_my_lockdown/platform_specific_widgets/platform_aler_dialog.dart';
import 'package:run_my_lockdown/repositories/silence_notifications_repository/implementations/android_silence_notifications_repository.dart';
import 'package:run_my_lockdown/repositories/silence_notifications_repository/implementations/ios_silence_notifications_repository.dart';

class SilenceNotificationsButton extends StatelessWidget {
  const SilenceNotificationsButton({
    Key key,
  }) : super(key: key);

  static Widget create(context) {
    return BlocProvider<DoNotDisturbBloc>(
      create: (context) => DoNotDisturbBloc(
          notificationsRepository: Platform.isAndroid
              ? AndroidSilenceNotificationsRepository()
              : IosSilenceNotificationsRepository())
        ..add(CheckSilenceNotificationStatus()),
      child: SilenceNotificationsButton(),
    );
  }

  Future<void> silenceClicked(context, {@required DoNotDisturbState state}) async {
    if ((state is DoNotDisturbInitial && !state.isSilenced) || state is TurnedOffSilentNotifications) {
      bool shouldSilence = await PlatformAlertDialog(
        title: 'Silence Notifications',
        content: 'Are you sure you want to silence notifications?',
        defaultActionText: 'Yes',
        cancelActionText: 'No',
      ).show(context);
      if (shouldSilence) {
        BlocProvider.of<DoNotDisturbBloc>(context).add(SilenceNotifications());
      }
    } else if (state is SilencedNotifications) {
      BlocProvider.of<DoNotDisturbBloc>(context).add(TurnOffSilentNotificatins());
    } else if (state is DoNotDisturbInitial && state.isSilenced) {
      BlocProvider.of<DoNotDisturbBloc>(context).add(TurnOffSilentNotificatins());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoNotDisturbBloc, DoNotDisturbState>(
        builder: (context, state) {
      return Container(
        width: 160,
        child: Center(
            child: NeumorphicButton(
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20))),
                onPressed: () => silenceClicked(context, state: state),
                child: Text(
                  state is DoNotDisturbInitial
                      ? state.isSilenced
                          ? 'Enable Notifications'
                          : 'Silence Notifications'
                      : state is SilencedNotifications
                          ? 'Enable Notifications'
                          : 'Silence Notifications',
                  style: TextStyle(color: Color(0xFF7D9DFD), fontSize: 14),
                ))),
      );
    });
  }
}
