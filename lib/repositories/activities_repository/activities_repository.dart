import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';

abstract class ActivitiesRepository {
  Future<void> addNewActivity(
      {@required ActivityModel activityModel, @required DateTime currentDate});

  Future<void> startNow(
      {@required String activityID,
      @required DateTime startTime,
      @required DateTime endTime});

  Future<void> endEarly(
      {@required String activityID, @required DateTime endTime});

  Future<void> startInAnHour(
      {@required String activityID,
      @required DateTime startTime,
      @required DateTime endTime});

  Future<void> defereTillTomorrow(
      {@required String activityID, @required DateTime currentDate});

  Future<void> addAgainTomorrow(
      {@required String activityID, @required DateTime currentDate});

  Stream<List<ActivityModel>> getAvailableActivities(
      {@required DateTime currentDate});

  Stream<List<ActivityModel>> getCurrentActiveActivities(
      {@required DateTime currentDate});

  Stream<List<ActivityModel>> getCompletedActivities(
      {@required DateTime currentDate});
}
