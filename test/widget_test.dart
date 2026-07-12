import 'package:flutter_test/flutter_test.dart';
import 'package:amigo/main.dart';

void main() {
  testWidgets('Amigo app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const AmigoApp());

    expect(find.byType(AmigoApp), findsOneWidget);
  });
}