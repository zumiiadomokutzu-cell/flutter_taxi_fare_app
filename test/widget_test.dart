import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_taxi_fare_app/main.dart';

void main() {
  testWidgets('Splash screen shows app title', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterTaxiFareApp());
    expect(find.text('Taxi Fare Calculator'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });
}
