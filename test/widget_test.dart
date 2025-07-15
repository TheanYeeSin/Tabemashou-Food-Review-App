import "package:flutter_test/flutter_test.dart";

import "package:tabemashou/main.dart";

void main() {
  testWidgets("test", (final WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
  });
}
