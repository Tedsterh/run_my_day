import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityEntity {
  final DateTime startTime;
  final DateTime endTime;
  final String iconName;
  final String eventName;

  ActivityEntity(this.startTime, this.endTime, this.iconName, this.eventName);

  @override
  int get hashCode =>
    startTime.hashCode ^ endTime.hashCode ^ iconName.hashCode ^ eventName.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is ActivityEntity &&
      runtimeType == other.runtimeType &&
      startTime == other.startTime &&
      endTime == other.endTime &&
      iconName == other.iconName &&
      eventName == other.eventName;

  Map<String, Object> toJson() {
    return {
      'startTime' : startTime,
      'endTime' : endTime,
      'iconName' : iconName,
      'eventName' : eventName
    };
  }

  @override
  String toString() {
    return 'ActivityEntity { startTime: $startTime , endTime: $endTime , iconName: $iconName , eventName: $eventName }';
  }

  static ActivityEntity fromSnapshot(DocumentSnapshot snap) {
    return ActivityEntity(
      snap.data['startTime'] != null ? snap.data['startTime'].toDate() : null,
      snap.data['endTime'] != null ? snap.data['endTime'].toDate() : null,
      snap.data['iconName'] != null ? snap.data['iconName'] as String : null,
      snap.data['usereventNameID'] != null ? snap.data['eventName'] as String : null
    );
  }

  Map<String, Object> toDocument() {
    return {
      'startTime' : startTime,
      'endTime' : endTime,
      'iconName' : iconName,
      'eventName' : eventName
    };
  }
}