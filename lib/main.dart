import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

import 'repositories/api_lot_repository.dart';
import 'services/lot_service.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Instantiate repository and service (now plugged with NestJS REST API)
  final repository = ApiLotRepository();
  final lotService = LotService(repository: repository);

  runApp(ZitouNetClientApp(lotService: lotService));
}

class ZitouNetClientApp extends StatelessWidget {
  final LotService lotService;

  const ZitouNetClientApp({super.key, required this.lotService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZitouNet Client',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: MainNavigationScreen(lotService: lotService),
    );
  }
}
