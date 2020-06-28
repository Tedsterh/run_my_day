import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:run_my_lockdown/main.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';

class NotificationRepository {
  
  Future<void> scheduleNotification(
      {@required DateTime dateTime,
      @required ActivityModel activityModel}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '2468',
        'Activities Started',
        'Notifications about activities that are about to start');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        activityModel.eventName,
        activityModel.description,
        dateTime.subtract(Duration(minutes: 10)),
        platformChannelSpecifics);
  }

  Future<void> setupDailyNotification({@required DateTime dateTime}) async {
    var time = Time(dateTime.hour, dateTime.minute, dateTime.second);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '46810',
        'Daily Activiy Setup',
        'Notifications about setting up your daily routine');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Setup your day',
        'Tap to setup your day and stay active',
        time,
        platformChannelSpecifics);
  }
}
