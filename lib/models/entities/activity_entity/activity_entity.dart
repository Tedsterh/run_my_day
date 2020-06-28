import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActivityEntity {
  final DateTime startTime;
  final DateTime endTime;
  final String iconName;
  final String eventName;
  final String description;
  final List<String> eventActions;
  final String eventID;
  final Duration duration;
  final LatLng eventLocation;

  ActivityEntity(
      this.startTime,
      this.endTime,
      this.iconName,
      this.eventName,
      this.description,
      this.eventActions,
      this.eventID,
      this.duration,
      this.eventLocation);

  @override
  int get hashCode =>
      startTime.hashCode ^
      endTime.hashCode ^
      iconName.hashCode ^
      eventName.hashCode ^
      description.hashCode ^
      eventActions.hashCode ^
      eventID.hashCode ^
      duration.hashCode ^
      eventLocation.hashCode;

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
          eventActions == other.eventActions &&
          eventID == other.eventID &&
          duration == other.duration &&
          eventLocation == other.eventLocation;

  Map<String, Object> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'iconName': iconName,
      'eventName': eventName,
      'description': description,
      'eventActions': eventActions,
      'eventID': eventID,
      'duration': duration,
      'eventLocation': eventLocation
    };
  }

  @override
  String toString() {
    return 'ActivityEntity { startTime: $startTime , endTime: $endTime , iconName: $iconName , eventName: $eventName , description: $description , eventActions: $eventActions , eventID: $eventID , duration: $duration , eventLocation: $eventLocation }';
  }

  static ActivityEntity fromSnapshot(DocumentSnapshot snap) {
    return ActivityEntity(
        snap.data['startTime'] != null ? snap.data['startTime'].toDate() : null,
        snap.data['endTime'] != null ? snap.data['endTime'].toDate() : null,
        snap.data['iconName'] != null ? snap.data['iconName'] as String : null,
        snap.data['eventName'] != null
            ? snap.data['eventName'] as String
            : null,
        snap.data['description'] != null
            ? snap.data['description'] as String
            : null,
        snap.data['eventActions'] != null
            ? List<String>.from(snap.data['eventActions'])
            : <String>[],
        snap.data['eventID'] != null ? snap.data['eventID'] as String : null,
        snap.data['duration'] != null
            ? Duration(seconds: snap.data['duration'])
            : null,
        snap.data['eventLocation'] != null
            ? LatLng(snap.data['eventLocation'].latitude,
                snap.data['eventLocation'].longitude)
            : null);
  }

  Map<String, Object> toDocument() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'iconName': iconName,
      'eventName': eventName,
      'eventActions': eventActions,
      'eventID': eventID,
      'description': description,
      'duration': duration.inSeconds,
      'eventLocation' : GeoPoint(eventLocation.latitude, eventLocation.longitude)
    };
  }
}
