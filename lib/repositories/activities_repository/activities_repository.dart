import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';

abstract class ActivitiesRepository {

  Future<void> addNewActivity({@required ActivityModel activityModel, @required DateTime currentDate});

  Stream<List<ActivityModel>> getActivities({@required DateTime currentDate});

}