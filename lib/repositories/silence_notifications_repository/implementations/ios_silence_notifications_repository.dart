import 'package:run_my_lockdown/repositories/silence_notifications_repository/silence_notifications_repository.dart';

class IosSilenceNotificationsRepository extends SilenceNotificationsRepository {
  @override
  Future<void> disableSilence() async {
    // TODO: implement disableSilence
  }

  @override
  Future<void> enableSilence() async {
    // TODO: implement enableSilence
  }

  @override
  Future<bool> isDndActive() async {
    // TODO: implement isDndActive
    return false;
  }
}
