import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  /// Base URL of the API depending on the platform
  static String get baseUrl {
    if (kIsWeb) {
      if (kReleaseMode) {
        // Web production -> URL HTTPS du futur backend
        // Actuellement, aucun backend public n'existe, donc on pointe vers une adresse temporaire ou localhost.
        // À modifier lorsque le backend de production sera déployé.
        return 'http://127.0.0.1:3000/api';
      }
      return 'http://127.0.0.1:3000/api';
    } else if (Platform.isAndroid) {
      // Android emulator refers to the host machine as 10.0.2.2
      return 'http://10.0.2.2:3000/api';
    } else {
      // iOS Simulator and Desktop (Windows/Linux/macOS) refer to localhost
      return 'http://127.0.0.1:3000/api';
    }
  }
}
