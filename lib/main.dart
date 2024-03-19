import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:univates_app/components/home/home_page.dart';
import 'package:univates_app/login.dart';
import 'package:univates_app/util/notification_controller.dart';

void main() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelGroupKey: "users_channel_group",
          channelKey: "users_channel",
          channelName: "Users Notification",
          channelDescription: "Users count notification")
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "users_channel_group",
          channelGroupName: "Users Group")
    ],
  );

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          "/login", //aqui ficam as rotas, quando o sistema inicia, inicia na initialRoute (posso empurrar a tela via rotas de qualquer lugar do código)
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => HomePage(
              route: "home",
            ),
      },
    );
  }
}
