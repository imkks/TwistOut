import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twist_out/main.dart';

void main() {
  testWidgets('Twist Out UI boots home screen and starts level 1',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TwistOutApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Home screen UI
    expect(find.text('TWIST OUT'), findsOneWidget);
    expect(find.text('PLAY LEVEL 1'), findsOneWidget);

    // Tap PLAY LEVEL 1
    await tester.tap(find.text('PLAY LEVEL 1'));
    await tester.pumpAndSettle();

    // Verify Game screen UI elements
    expect(find.text('Level 1'), findsOneWidget);
    expect(find.text('Slot'), findsOneWidget);
    expect(find.text('Magnet'), findsOneWidget);
    expect(find.text('Smash'), findsOneWidget);
  });
}
