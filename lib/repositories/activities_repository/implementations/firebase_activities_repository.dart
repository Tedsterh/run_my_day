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
        .setData(
          activityModel.toEntity().toDocument()
        );
  }

  @override
  Stream<List<ActivityModel>> getActivities({DateTime currentDate}) {
    String date = DateFormat('yyyy-MM-dd').format(currentDate);
    return activityCollection
        .collection('users')
        .document(userID)
        .collection(date)
        .orderBy('startTime', descending: true)
        .snapshots()
        .map((snapshots) {
      return snapshots.documents
          .map((doc) =>
              ActivityModel.fromEntity(ActivityEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
