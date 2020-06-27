import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityEntity {
  final DateTime startTime;
  final DateTime endTime;
  final String iconName;
  final String eventName;
  final String description;
  final List<String> eventActions;

  ActivityEntity(this.startTime, this.endTime, this.iconName, this.eventName, this.description, this.eventActions);

  @override
  int get hashCode =>
    startTime.hashCode ^ endTime.hashCode ^ iconName.hashCode ^ eventName.hashCode ^ description.hashCode ^ eventActions.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is ActivityEntity &&
      runtimeType == other.runtimeType &&
      startTime == other.startTime &&
      endTime == other.endTime &&
      iconName == other.iconName &&
      eventName == other.eventName &&
      description == other.description &&
      eventActions == other.eventActions;

  Map<String, Object> toJson() {
    return {
      'startTime' : startTime,
      'endTime' : endTime,
      'iconName' : iconName,
      'eventName' : eventName,
      'description' : description,
      'eventActions' : eventActions
    };
  }

  @override
  String toString() {
    return 'ActivityEntity { startTime: $startTime , endTime: $endTime , iconName: $iconName , eventName: $eventName , description: $description , eventActions: $eventActions }';
  }

  static ActivityEntity fromSnapshot(DocumentSnapshot snap) {
    return ActivityEntity(
      snap.data['startTime'] != null ? snap.data['startTime'].toDate() : null,
      snap.data['endTime'] != null ? snap.data['endTime'].toDate() : null,
      snap.data['iconName'] != null ? snap.data['iconName'] as String : null,
      snap.data['usereventNameID'] != null ? snap.data['eventName'] as String : null,
      snap.data['description'] != null ? snap.data['description'] as String : null,
      snap.data['eventActions'] != null ? List<String>.from(snap.data['eventActions']) : <String>[]
    );
  }

  Map<String, Object> toDocument() {
    return {
      'startTime' : startTime,
      'endTime' : endTime,
      'iconName' : iconName,
      'eventName' : eventName,
      'eventActions' : eventActions
    };
  }
}