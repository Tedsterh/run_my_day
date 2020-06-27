
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/entities/activity_entity/activity_entity.dart';

@immutable
class ActivityModel {
  final DateTime startTime;
  final DateTime endTime;
  final String iconName;
  final String eventName;

  ActivityModel({this.startTime, this.endTime, this.iconName, this.eventName});

  ActivityModel copyWith({DateTime startTime, DateTime endTime, String iconName, String eventName}) {
    return ActivityModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      iconName: iconName ?? this.iconName,
      eventName: eventName ?? this.eventName
    );
  }

  @override
  int get hashCode =>
    startTime.hashCode ^ endTime.hashCode ^ iconName.hashCode ^ eventName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModel &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          iconName == other.iconName &&
          eventName == other.eventName;

  @override
  String toString() {
    return 'ActivityModel { startTime: $startTime , endTime: $endTime , iconName: $iconName , eventName: $eventName }';
  }

  ActivityEntity toEntity() {
    return ActivityEntity(startTime, endTime, iconName, eventName);
  }

  static ActivityModel fromEntity(ActivityEntity entity) {
    return ActivityModel(
      startTime: entity.startTime,
      eventName: entity.eventName,
      endTime: entity.endTime,
      iconName: entity.iconName
    );
  }

}