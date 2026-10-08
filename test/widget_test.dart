import 'package:flutter_test/flutter_test.dart';
import 'package:zitounet_client/main.dart';
import 'package:zitounet_client/repositories/lot_repository.dart';
import 'package:zitounet_client/services/lot_service.dart';

void main() {
  testWidgets('ZitouNet Client App smoke test', (WidgetTester tester) async {
    final repo = MockLotRepository();
    final service = LotService(repository: repo);

    await tester.pumpWidget(ZitouNetClientApp(lotService: service));
    await tester.pumpAndSettle();

    expect(find.textContaining('ZitouNet'), findsWidgets);
  });
}
