import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // To check if running on web

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Don't initialize if on web, as it's not supported by this plugin version easily
    if (kIsWeb) {
      print("Local notifications not initialized for web.");
      return;
    }

    // Android initialization settings
    // Ensure you have an 'app_icon.png' (or similar, e.g. ic_launcher) in android/app/src/main/res/mipmap-<various_dpi>/
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher'); // Or your specific icon name without extension

    // iOS initialization settings
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // Handle foreground notification for older iOS versions (iOS < 10)
        // You can navigate or show an in-app alert here
        print("iOS foreground notification received: $title");
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
      macOS: darwinInitializationSettings, // Can use the same settings for macOS
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // Handle notification tap
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          print('Notification payload: $payload');
          // You can add navigation logic here based on the payload
        }
        // Example: selectNotificationSubject.add(payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Request permissions for iOS and Android 13+
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      // For Android 13 (API 33) and above, POST_NOTIFICATIONS permission is needed.
      // The plugin handles this if targetSdkVersion is 33+.
      // You might need to explicitly request it if your app targets older SDKs but runs on Android 13+.
      // This is generally handled by the plugin's initialization or when showing a notification.
      // For simplicity, we assume the plugin handles it or permissions are granted.
      // Consider adding a check here if issues arise: await androidImplementation?.requestPermission();
      // or more correctly: await androidImplementation?.requestNotificationsPermission();
      // For now, relying on plugin's default behavior.
       await androidImplementation?.createNotificationChannel(_androidChannel());

    }
  }

  AndroidNotificationChannel _androidChannel() => const AndroidNotificationChannel(
        'travenor_general_channel', // id
        'General Notifications', // title
        description: 'This channel is used for general app notifications.', // description
        importance: Importance.max,
        playSound: true,
      );


  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
     if (kIsWeb) {
      print("Skipping notification for web: $title");
      return;
    }
    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel().id, // Channel ID
        _androidChannel().name, // Channel Name
        channelDescription: _androidChannel().description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: 'ic_launcher', // Ensure this icon exists
        // other properties...
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      macOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Example: Welcome notification
  Future<void> showWelcomeNotification(String userName) async {
    await showNotification(
      id: 0,
      title: 'Welcome to Travenor, $userName!',
      body: 'We are excited to have you. Explore the world with us.',
      payload: 'welcome_payload',
    );
  }

    // Example: Mock Reminder (can be expanded to be scheduled)
  Future<void> showMockReminderNotification() async {
    await showNotification(
      id: 1,
      title: 'Friendly Reminder',
      body: 'Don\'t forget to check out the new destinations added this week!',
      payload: 'reminder_payload',
    );
  }
}

// Required for onDidReceiveBackgroundNotificationResponse
// This needs to be a top-level function or a static method.
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  print('Notification tapped in background with payload: ${notificationResponse.payload}');
  // IMPORTANT: To use navigator or other Flutter functionalities here, you might need
  // to set up communication with the main isolate or ensure your app is already running.
  // For simplicity, this example just prints.
}
