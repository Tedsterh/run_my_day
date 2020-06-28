import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:run_my_lockdown/models/entities/activity_entity/activity_entity.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/repositories/activities_repository/activities_repository.dart';
import 'package:intl/intl.dart';

class FirebaseActivitiesRepository extends ActivitiesRepository {
  final String userID;

  FirebaseActivitiesRepository(this.userID);

  var activityCollection = Firestore.instance;

  @override
  Future<void> addNewActivity(
      {ActivityModel activityModel, DateTime currentDate}) {
    String date = DateFormat('yyyy-MM-dd').format(currentDate);
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .document(activityModel.eventID)
        .setData(activityModel.toEntity().toDocument());
  }

  @override
  Stream<List<ActivityModel>> getAvailableActivities({DateTime currentDate}) {
    String date = DateFormat('yyyy-MM-dd').format(currentDate);
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .orderBy('startTime', descending: true)
        .snapshots()
        .map((snapshots) {
      List<ActivityModel> list = [];
      for (var i = 0; i < snapshots.documents.length; i++) {
        var activity = ActivityModel.fromEntity(
            ActivityEntity.fromSnapshot(snapshots.documents[i]));
        if (activity.startTime == null) {
          list.add(activity);
        }
      }
      return list;
    });
  }

  @override
  Future<void> defereTillTomorrow(
      {String activityID, DateTime currentDate}) async {
    String date = DateFormat('yyyy-MM-dd').format(currentDate);
    var activity = await activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .document(activityID)
        .get();
    await activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .document(activityID)
        .delete();
    String newDate =
        DateFormat('yyyy-MM-dd').format(currentDate.add(Duration(days: 1)));
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(newDate)
        .document(activityID)
        .setData(activity.data);
  }

  @override
  Future<void> startInAnHour(
      {String activityID, DateTime startTime, DateTime endTime}) {
    String date = DateFormat('yyyy-MM-dd').format(startTime);
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .document(activityID)
        .updateData({'startTime': startTime, 'endTime': endTime});
  }

  @override
  Future<void> startNow(
      {String activityID, DateTime startTime, DateTime endTime}) {
    String date = DateFormat('yyyy-MM-dd').format(startTime);
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .document(activityID)
        .updateData({'startTime': startTime, 'endTime': endTime});
  }

  @override
  Stream<List<ActivityModel>> getCurrentActiveActivities({DateTime currentDate}) {
    String date = DateFormat('yyyy-MM-dd').format(currentDate);
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .orderBy('startTime', descending: true)
        .snapshots()
        .map((snapshots) {
      List<ActivityModel> list = [];
      for (var i = 0; i < snapshots.documents.length; i++) {
        var activity = ActivityModel.fromEntity(
            ActivityEntity.fromSnapshot(snapshots.documents[i]));
        if (activity.endTime != null && activity.endTime.isAfter(currentDate)) {
          list.add(activity);
        }
      }
      return list;
    });
  }
}
