import 'package:flutter/services.dart';

class PlatformService {
  static const MethodChannel _channel =
      MethodChannel('com.example.attention/service');

  static Future<void> startService(int countdownDuration) async {
    try {
      await _channel
          .invokeMethod('startService', {'duration': countdownDuration});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> cancelTimer() async {
    try {
      await _channel.invokeMethod('cancelTimer');
    } catch (e) {
      print(e.toString());
    }
  }
}
