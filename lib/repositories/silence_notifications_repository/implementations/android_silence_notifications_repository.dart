import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:run_my_lockdown/repositories/silence_notifications_repository/silence_notifications_repository.dart';

class AndroidSilenceNotificationsRepository
    extends SilenceNotificationsRepository {
  @override
  Future<void> disableSilence() async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(FlutterDnd
          .INTERRUPTION_FILTER_ALL); // Turn on DND - All notifications are suppressed.
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  }

  @override
  Future<void> enableSilence() async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(FlutterDnd
          .INTERRUPTION_FILTER_ALARMS); // Turn on DND - All notifications are suppressed.
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  }

  @override
  Future<bool> isDndActive() async {
    return await FlutterDnd.getCurrentInterruptionFilter() == 3;
  }
}
