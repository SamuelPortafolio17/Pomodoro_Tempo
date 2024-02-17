import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future <void>initNotifications() async{
  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: darwinInitializationSettings
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future <void>notificacion() async{
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel id', 'your channel');

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails
  );

  await flutterLocalNotificationsPlugin.show(1, "PRUEBA DE NOTIS", "ESTO ES PARA PROBAR", notificationDetails);



}