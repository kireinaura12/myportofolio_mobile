// Base URL of the Django REST Framework backend.
//
// Defaults to `http://10.0.2.2:8000` (IP address of your local development machine that can be called from Android emulator)
// Override with `--dart-define=API_BASE_URL=http://localhost:8000` if you are testing on Chrome/Web browser
import 'package:flutter/foundation.dart' show kIsWeb;

const String apiBaseUrl = kIsWeb
    ? 'http://localhost:8000'
    : 'http://10.0.2.2:8000';
